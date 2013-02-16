From: Anssi Hannula <anssi.hannula@iki.fi>
Subject: HDMI regression on close (was: ALSA: hda - Always turn
 on pins for HDMI/DP)
Date: Sat, 16 Feb 2013 04:23:44 +0200
Message-ID: <511EEDB0.6010603@iki.fi>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------060002000806050702000902"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gw-out1.cc.tut.fi (mail-gw-out1.cc.tut.fi [130.230.160.32])
 by alsa0.perex.cz (Postfix) with ESMTP id 9D3A52607C3
 for <alsa-devel@alsa-project.org>; Sat, 16 Feb 2013 03:23:45 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------060002000806050702000902
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi!

> From: Takashi Iwai <tiwai@suse.de>
> Date: Fri, 14 Dec 2012 09:22:35 +0000 (+0100)
> Subject: ALSA: hda - Always turn on pins for HDMI/DP
> X-Git-Tag: v3.8-rc1~29^2~7
> X-Git-Url: http://git.kernel.org/?p=linux%2Fkernel%2Fgit%2Fstable%2Flinux-stable.git;a=commitdiff_plain;h=6169b673618bf0b2518ce413b54925782a603f06
> 
> ALSA: hda - Always turn on pins for HDMI/DP
> 
> We've seen the broken HDMI *video* output on some machines with GM965,
> and the debugging session pointed that the culprit is the disabled
> audio output pins.  Toggling these pins dynamically on demand caused
> flickering of HDMI TV.
> 
> This patch changes the behavior to keep the pin ON constantly.

Unfortunately this seems to cause a regression on at least some "NVIDIA
ION2" systems.

When running snd_pcm_open() and snd_pcm_close() on an hdmi device on an
affected system, the HDMI port seemingly continues to transmit an empty
audio stream.

However, when hw_params have been set and snd_pcm_prepare() called
before closing the device (and optionally audio has been output), the
HDMI port stops transmitting at snd_pcm_close() time.

(I use "transmitting" here to mean that the HDMI sink/receiver
receives/shows a an active audio stream)

On systems _not_ affected by the issue, the HDMI port never starts
transmitting if just snd_pcm_open()+snd_pcm_close() have been called
(but note [1]).

HDMI port continuing transmitting has the unfortunate effect that when
the user has connected the system to an amplifier via HDMI (for video
playback purposes), the amplifier may continue to play back empty audio
from HDMI even when there is actual audio data on its S/PDIF input.
An snd_pcm_open()+snd_pcm_close() sequence can be caused by e.g. device
probing by an application.

Several OpenELEC users have reported this issue on stable 3.7.x, here's
some alsainfo:
http://onse.fi/files/ion-regression-alsainfo-1.txt
http://onse.fi/files/ion-regression-alsainfo-2.txt
Both of these have the Nvidia GPU 0b HDMI/DP codecs:
Vendor Id: 0x10de000b
Subsystem Id: 0x10de0101
Revision Id: 0x100200

However, e.g. my non-ION2 laptop with 0b codecs (but different rev) is
_not_ affected:
Vendor Id: 0x10de000b
Subsystem Id: 0x10de0101
Revision Id: 0x100100
http://www.alsa-project.org/db/?f=bc940d23d19ae7e2ee1e83895d85f711c2d0e5b1

I'm still working with the OpenELEC devs and users to pinpoint the issue
further, but it is progressing rather slowly due to not many people
having affected systems (especially in the affected dual HDMI + S/PDIF
cabled configuration).

Feel free to suggest anything we should try out if you have some ideas :)
In the meantime, I'll continue investigating exactly why snd_pcm_close()
doesn't stop the HDMI output on the affected systems (or why does a
simple snd_pcm_open() even start outputting the audio, since that does
not seem to happen on other systems).

I'll keep you posted.


[1] It seems that on my Intel HDMI system (
http://www.alsa-project.org/db/?f=bb3fc8680b372c0475719d42d7fc8b2bb7bfb4eb
) the HDMI port keeps transmitting in approximately reversed situation
than in the above ION2 case. That is, if audio has been output in the
port e.g. with a speaker-test command, closing the device will not cause
the stream to stop (and therefore the above issue happens again,
receives ignores S/PDIF stream as HDMI stream is given higher priority
by default). I found out that the attached patch solves that one.
What are your thoughts on that?
(obviously the patch will not solve the ION2 regression, since cleanup()
is not called if prepare() has not been called; or at least I assume so,
way too tired to check that now...)
Note that closing the device after audio has been output stops HDMI port
transmission even without the patch on both the NVIDIA ION2 systems and
on my NVIDIA laptop, it is just the Intel HDMI codec where that does not
happen (well, of the tested ones, at least).


> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=51421
> 
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
> 
> diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
> index 0fcfa6f..37dd06d 100644
> --- a/sound/pci/hda/patch_hdmi.c
> +++ b/sound/pci/hda/patch_hdmi.c
> @@ -431,9 +431,11 @@ static void hdmi_init_pin(struct hda_codec *codec, hda_nid_t pin_nid)
>  	if (get_wcaps(codec, pin_nid) & AC_WCAP_OUT_AMP)
>  		snd_hda_codec_write(codec, pin_nid, 0,
>  				AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE);
> -	/* Disable pin out until stream is active*/
> +	/* Enable pin out: some machines with GM965 gets broken output when
> +	 * the pin is disabled or changed while using with HDMI
> +	 */
>  	snd_hda_codec_write(codec, pin_nid, 0,
> -			    AC_VERB_SET_PIN_WIDGET_CONTROL, 0);
> +			    AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT);
>  }
>  
>  static int hdmi_get_channel_count(struct hda_codec *codec, hda_nid_t cvt_nid)
> @@ -1341,7 +1343,6 @@ static int generic_hdmi_playback_pcm_prepare(struct hda_pcm_stream *hinfo,
>  	struct hdmi_spec *spec = codec->spec;
>  	int pin_idx = hinfo_to_pin_index(spec, hinfo);
>  	hda_nid_t pin_nid = spec->pins[pin_idx].pin_nid;
> -	int pinctl;
>  	bool non_pcm;
>  
>  	non_pcm = check_non_pcm_per_cvt(codec, cvt_nid);
> @@ -1350,11 +1351,6 @@ static int generic_hdmi_playback_pcm_prepare(struct hda_pcm_stream *hinfo,
>  
>  	hdmi_setup_audio_infoframe(codec, pin_idx, non_pcm, substream);
>  
> -	pinctl = snd_hda_codec_read(codec, pin_nid, 0,
> -				    AC_VERB_GET_PIN_WIDGET_CONTROL, 0);
> -	snd_hda_codec_write(codec, pin_nid, 0,
> -			    AC_VERB_SET_PIN_WIDGET_CONTROL, pinctl | PIN_OUT);
> -
>  	return hdmi_setup_stream(codec, cvt_nid, pin_nid, stream_tag, format);
>  }
>  
> @@ -1374,7 +1370,6 @@ static int hdmi_pcm_close(struct hda_pcm_stream *hinfo,
>  	int cvt_idx, pin_idx;
>  	struct hdmi_spec_per_cvt *per_cvt;
>  	struct hdmi_spec_per_pin *per_pin;
> -	int pinctl;
>  
>  	if (hinfo->nid) {
>  		cvt_idx = cvt_nid_to_cvt_index(spec, hinfo->nid);
> @@ -1391,11 +1386,6 @@ static int hdmi_pcm_close(struct hda_pcm_stream *hinfo,
>  			return -EINVAL;
>  		per_pin = &spec->pins[pin_idx];
>  
> -		pinctl = snd_hda_codec_read(codec, per_pin->pin_nid, 0,
> -					    AC_VERB_GET_PIN_WIDGET_CONTROL, 0);
> -		snd_hda_codec_write(codec, per_pin->pin_nid, 0,
> -				    AC_VERB_SET_PIN_WIDGET_CONTROL,
> -				    pinctl & ~PIN_OUT);
>  		snd_hda_spdif_ctls_unassign(codec, pin_idx);
>  		per_pin->chmap_set = false;
>  		memset(per_pin->chmap, 0, sizeof(per_pin->chmap));


-- 
Anssi Hannula

--------------060002000806050702000902
Content-Type: text/x-patch;
 name="0001-ALSA-hda-Always-clean-up-HDMI-streams-in-cleanup-cal.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-ALSA-hda-Always-clean-up-HDMI-streams-in-cleanup-cal.pa";
 filename*1="tch"

>From de006e0d6ccfa3709447757f1f4084621eb84dd7 Mon Sep 17 00:00:00 2001
From: Anssi Hannula <anssi.hannula@iki.fi>
Date: Sat, 16 Feb 2013 03:41:35 +0200
Subject: [PATCH] ALSA: hda - Always clean up HDMI streams in cleanup callback

Currently actual HDMI stream cleanup (resetting CHANNEL_STREAMID and
STREAM_FORMAT to zero) is deferred to a later time by
snd_hda_codec_cleanup_stream() like with other HDA streams.

On at least some Intel codecs (but not in at least some NVIDIA ones)
this will cause the HDMI port to continue transmitting an audio stream
after the device has been closed. This has the effect that a receiver
connected to such a port may give the HDMI port audio higher priority
than e.g. an actually active S/PDIF input port, causing silence to be
heard instead of audio of the S/PDIF input port of the receiver.

Change the cleanup callback to always clean up the streams to avoid such
issues.

Signed-off-by: Anssi Hannula <anssi.hannula@iki.fi>
---
 sound/pci/hda/patch_hdmi.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 807a2aa..283ed55 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -1358,7 +1358,8 @@ static int generic_hdmi_playback_pcm_cleanup(struct hda_pcm_stream *hinfo,
 					     struct hda_codec *codec,
 					     struct snd_pcm_substream *substream)
 {
-	snd_hda_codec_cleanup_stream(codec, hinfo->nid);
+	/* Avoid outputting silence after cleanup */
+	__snd_hda_codec_cleanup_stream(codec, hinfo->nid, 1);
 	return 0;
 }
 
-- 
1.7.10


--------------060002000806050702000902
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------060002000806050702000902--
