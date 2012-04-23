From: Felix Homann <linuxaudio@showlabor.de>
Subject: [PATCH 3/7] Add TLV to M-Audio Fast Track Ultra
	controls
Date: Mon, 23 Apr 2012 16:37:33 +0200
Message-ID: <1335191857-6725-4-git-send-email-linuxaudio@showlabor.de>
References: <1335191857-6725-1-git-send-email-linuxaudio@showlabor.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1335191857-6725-1-git-send-email-linuxaudio@showlabor.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: alsa-devel@alsa-project.org, Felix Homann <linuxaudio@showlabor.de>, mark@pogo.org.uk
List-Id: alsa-devel@alsa-project.org

This adds db gain information to M-Audio Fast Track Ultra (8R) devices.

Signed-off-by: Felix Homann <linuxaudio@showlabor.de>

diff --git a/sound/usb/mixer_quirks.c b/sound/usb/mixer_quirks.c
index 22a1f7b..afb5cdb 100644
--- a/sound/usb/mixer_quirks.c
+++ b/sound/usb/mixer_quirks.c
@@ -594,7 +594,7 @@ static int snd_maudio_ftu_create_volume_ctls(struct usb_mixer_interface *mixer)
 				in  + 1, out + 1);
 			err = snd_create_std_mono_ctl(mixer, id, control,
 							cmask, val_type, name,
-							NULL);
+							&snd_usb_mixer_vol_tlv);
 			if (err < 0)
 				return err;
 		}
@@ -605,7 +605,7 @@ static int snd_maudio_ftu_create_volume_ctls(struct usb_mixer_interface *mixer)
 				in - 7, out + 1);
 			err = snd_create_std_mono_ctl(mixer, id, control,
 							cmask, val_type, name,
-							NULL);
+							&snd_usb_mixer_vol_tlv);
 			if (err < 0)
 				return err;
 		}
-- 
1.7.5.4
