From: Clemens Ladisch <clemens-P6GI/4k7KOmELgA04lAiVw@public.gmane.org>
Subject: ALSA: usb-audio: fix oops due to cleanup race when disconnecting
Date: Tue, 22 Feb 2011 10:21:18 +0100
Message-ID: <4D63800E.30509@ladisch.de>
References: <Pine.LNX.4.44L0.1102111737280.13739-100000@netrider.rowland.org>	<4D58EDA9.2020805@ladisch.de> <s5hoc6ejz2j.wl%tiwai@suse.de>	<20110216235422.GB6375@xanatos> <s5hk4gyy9m1.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <s5hk4gyy9m1.wl%tiwai-l3A5Bk7waGM@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>
Cc: Sarah Sharp <sarah.a.sharp-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bossart.nospam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Pierre-Louis Bossart <pierre-louis.bossart-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

From: Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>

When a USB audio device is disconnected, snd_usb_audio_disconnect()
kills all audio URBs.  At the same time, the application, after being
notified of the disconnection, might close the device, in which case
ALSA calls the .hw_free callback, which should free the URBs too.

Commit de1b8b93a0ba prevented snd_usb_hw_free() from freeing the URBs to
avoid a hang that resulted from this race, but this introduced another
race because the URB callbacks could now be executed after
snd_usb_hw_free() has returned, and try to access already freed data.

Fix the first race by introducing a mutex to serialize the disconnect
callback and all PCM callbacks that manage URBs (hw_free and hw_params).

Reported-by: Pierre-Louis Bossart <pierre-louis.bossart-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
[CL: also serialize hw_params callback]
Signed-off-by: Clemens Ladisch <clemens-P6GI/4k7KOmELgA04lAiVw@public.gmane.org>

diff --git a/sound/usb/card.c b/sound/usb/card.c
index 800f7cb..c0f8270 100644
--- a/sound/usb/card.c
+++ b/sound/usb/card.c
@@ -323,6 +323,7 @@ static int snd_usb_audio_create(struct usb_device *dev, int idx,
 		return -ENOMEM;
 	}
 
+	mutex_init(&chip->shutdown_mutex);
 	chip->index = idx;
 	chip->dev = dev;
 	chip->card = card;
@@ -531,6 +532,7 @@ static void snd_usb_audio_disconnect(struct usb_device *dev, void *ptr)
 	chip = ptr;
 	card = chip->card;
 	mutex_lock(&register_mutex);
+	mutex_lock(&chip->shutdown_mutex);
 	chip->shutdown = 1;
 	chip->num_interfaces--;
 	if (chip->num_interfaces <= 0) {
@@ -548,9 +550,11 @@ static void snd_usb_audio_disconnect(struct usb_device *dev, void *ptr)
 			snd_usb_mixer_disconnect(p);
 		}
 		usb_chip[chip->index] = NULL;
+		mutex_unlock(&chip->shutdown_mutex);
 		mutex_unlock(&register_mutex);
 		snd_card_free_when_closed(card);
 	} else {
+		mutex_unlock(&chip->shutdown_mutex);
 		mutex_unlock(&register_mutex);
 	}
 }
diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index 4132522..e3f6805 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -361,6 +361,7 @@ static int snd_usb_hw_params(struct snd_pcm_substream *substream,
 	}
 
 	if (changed) {
+		mutex_lock(&subs->stream->chip->shutdown_mutex);
 		/* format changed */
 		snd_usb_release_substream_urbs(subs, 0);
 		/* influenced: period_bytes, channels, rate, format, */
@@ -368,6 +369,7 @@ static int snd_usb_hw_params(struct snd_pcm_substream *substream,
 						  params_rate(hw_params),
 						  snd_pcm_format_physical_width(params_format(hw_params)) *
 							params_channels(hw_params));
+		mutex_unlock(&subs->stream->chip->shutdown_mutex);
 	}
 
 	return ret;
@@ -385,8 +387,9 @@ static int snd_usb_hw_free(struct snd_pcm_substream *substream)
 	subs->cur_audiofmt = NULL;
 	subs->cur_rate = 0;
 	subs->period_bytes = 0;
-	if (!subs->stream->chip->shutdown)
-		snd_usb_release_substream_urbs(subs, 0);
+	mutex_lock(&subs->stream->chip->shutdown_mutex);
+	snd_usb_release_substream_urbs(subs, 0);
+	mutex_unlock(&subs->stream->chip->shutdown_mutex);
 	return snd_pcm_lib_free_vmalloc_buffer(substream);
 }
 
diff --git a/sound/usb/usbaudio.h b/sound/usb/usbaudio.h
index db3eb21..6e66fff 100644
--- a/sound/usb/usbaudio.h
+++ b/sound/usb/usbaudio.h
@@ -36,6 +36,7 @@ struct snd_usb_audio {
 	struct snd_card *card;
 	u32 usb_id;
 	int shutdown;
+	struct mutex shutdown_mutex;
 	unsigned int txfr_quirk:1; /* Subframe boundaries on transfers */
 	int num_interfaces;
 	int num_suspended_intf;
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
