From: Sarah Sharp <sarah.a.sharp-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH] USB-sound: prevent kernel panic on disconnect
Date: Fri, 11 Feb 2011 14:22:24 -0800
Message-ID: <20110211222224.GA9588@xanatos>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="V0207lvV8h4k8FAm"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, Clemens Ladisch <clemens-P6GI/4k7KOmELgA04lAiVw@public.gmane.org>
Cc: bossart.nospam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Pierre-Louis Bossart <pierre-louis.bossart-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
List-Id: alsa-devel@alsa-project.org


--V0207lvV8h4k8FAm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

(Resending this, as the mail seems to have been eaten on the way to the
linux-usb mailing list.)

Hi Pierre,

I'm forwarding this to the linux-usb mailing list, as they might have
some insight into your issue.  I think this is a kernel issue since it
involves a kernel crash.  It looks like an issue with UHCI or the USB
audio driver.

I suspect it might be the audio driver, as someone on the alsa mailing
list suggested the USB sound driver can't handle when one isochronous
buffer in an URB has an error, but the URB status is 0.  I think Pierre
is running with the latest alsa code, which perhaps triggers the crash?

But I'm not an alsa or a USB sound expert, so could Jaroslav, Takashi,
or Clemens look at this issue?

Attached is Pierre's dmesg from the original crash, along with lsusb
output.  Note that the patch below is supposed to be against
sound/usb/urb.c.

Sarah Sharp

----- Forwarded message from Pierre-Louis Bossart <bossart.nospam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> -----

Date: Wed,  9 Feb 2011 13:13:24 -0600
From: Pierre-Louis Bossart <bossart.nospam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
Cc: bossart.nospam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, sarah.a.sharp-VuQAYsv1563Yd54FQh9/CA@public.gmane.org,
	Pierre-Louis Bossart <pierre-louis.bossart-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] ALSA: usb - prevent kernel panic on disconnect

Fix 100% reproducible kernel panic when a USB audio device is
disconnected during playback. When the PCM substream is NULL, any
dereference causes a kernel panic. This isn't a recent problem, the crash
happened with a 2.6.35 kernel as well

Note that this is only a work-around, it does not address the
root cause of this inconsistency between urbs and PCM states. The
dmesg below shows two calls to snd_urb_complete, the substream is
NULL and the state is either running or stopped. This doesn't make
any sense.

Thanks to Sarah Sharp <sarah.a.sharp-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> for her
help.

usb 6-1: USB disconnect, address 16
ALSA urb.c:492: frame 0 active: -84
ALSA urb.c:197: cannot submit urb (err = -19)
ALSA urb.c:492: frame 0 active: -84
ALSA urb.c:197: cannot submit urb (err = -19)
ALSA urb.c:492: frame 0 active: -84
ALSA urb.c:197: cannot submit urb (err = -19)
ALSA urb.c:492: frame 0 active: -84
ALSA urb.c:197: cannot submit urb (err = -19)
ALSA urb.c:492: frame 0 active: -84
ALSA urb.c:197: cannot submit urb (err = -19)
ALSA urb.c:197: cannot submit urb (err = -19)
ALSA urb.c:492: frame 0 active: -84
ALSA urb.c:197: cannot submit urb (err = -19)
ALSA urb.c:492: frame 0 active: -84
ALSA urb.c:197: cannot submit urb (err = -19)
ALSA urb.c:492: frame 0 active: -84
ALSA urb.c:197: cannot submit urb (err = -19)
ALSA urb.c:186: NULL substream (subs->running 1) <- How is this possible?
ALSA urb.c:186: NULL substream (subs->running 0)

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 usb/urb.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/usb/urb.c b/usb/urb.c
index e184349..1a264c2 100644
--- a/usb/urb.c
+++ b/usb/urb.c
@@ -170,6 +170,12 @@ static void snd_complete_urb(struct urb *urb)
 	struct snd_pcm_substream *substream = ctx->subs->pcm_substream;
 	int err = 0;
 
+        if (substream == NULL) {
+                snd_printd(KERN_ERR "NULL substream (subs->running %d)\n", subs->running);
+                clear_bit(ctx->index, &subs->active_mask);
+                return;
+        }
+
 	if ((subs->running && subs->ops.retire(subs, substream->runtime, urb)) ||
 	    !subs->running || /* can be stopped during retire callback */
 	    (err = subs->ops.prepare(subs, substream->runtime, urb)) < 0 ||
@@ -193,6 +199,12 @@ static void snd_complete_sync_urb(struct urb *urb)
 	struct snd_pcm_substream *substream = ctx->subs->pcm_substream;
 	int err = 0;
 
+        if (substream == NULL) {
+                snd_printd(KERN_ERR "NULL substream (subs->running %d)\n", subs->running);
+                clear_bit(ctx->index + 16, &subs->active_mask);
+                return;
+        }
+
 	if ((subs->running && subs->ops.retire_sync(subs, substream->runtime, urb)) ||
 	    !subs->running || /* can be stopped during retire callback */
 	    (err = subs->ops.prepare_sync(subs, substream->runtime, urb)) < 0 ||
-- 
1.7.4


----- End forwarded message -----

--V0207lvV8h4k8FAm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="log.txt"
Content-Transfer-Encoding: quoted-printable

ALSA sound/usb/pcm.c:226: setting usb interface 1:2
ALSA sound/usb/pcm.c:226: setting usb interface 2:1
ALSA sound/usb/pcm.c:226: setting usb interface 1:1
ALSA sound/usb/pcm.c:226: setting usb interface 2:1
ALSA sound/usb/pcm.c:226: setting usb interface 1:1
ALSA sound/usb/pcm.c:226: setting usb interface 2:1
ALSA sound/usb/pcm.c:226: setting usb interface 1:1
ALSA sound/usb/pcm.c:226: setting usb interface 2:1
ALSA sound/usb/pcm.c:226: setting usb interface 2:1
ALSA sound/usb/pcm.c:226: setting usb interface 1:1
ALSA sound/usb/pcm.c:226: setting usb interface 2:1
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=3D0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=3D0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=3D0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=3D0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=3D0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=3D0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=3D0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=3D0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=3D0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=3D0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=3D0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=3D0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=3D0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=3D0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=3D0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=3D0x10
ALSA sound/pci/hda/hda_intel.c:1675: azx_pcm_prepare: bufsize=3D0x4500, for=
mat=3D0x4011
ALSA sound/pci/hda/hda_codec.c:1227: hda_codec_setup_stream: NID=3D0x12, st=
ream=3D0x5, channel=3D0, format=3D0x4011
ALSA sound/pci/hda/hda_codec.c:1227: hda_codec_setup_stream: NID=3D0x10, st=
ream=3D0x5, channel=3D0, format=3D0x4011
ALSA sound/pci/hda/hda_intel.c:1675: azx_pcm_prepare: bufsize=3D0x4500, for=
mat=3D0x4011
ALSA sound/pci/hda/hda_codec.c:1227: hda_codec_setup_stream: NID=3D0x12, st=
ream=3D0x5, channel=3D0, format=3D0x4011
ALSA sound/pci/hda/hda_codec.c:1227: hda_codec_setup_stream: NID=3D0x10, st=
ream=3D0x5, channel=3D0, format=3D0x4011
ALSA sound/pci/hda/hda_intel.c:1675: azx_pcm_prepare: bufsize=3D0x4500, for=
mat=3D0x4011
ALSA sound/pci/hda/hda_codec.c:1227: hda_codec_setup_stream: NID=3D0x14, st=
ream=3D0x1, channel=3D0, format=3D0x4011
ALSA sound/pci/hda/hda_intel.c:1675: azx_pcm_prepare: bufsize=3D0x4500, for=
mat=3D0x4011
ALSA sound/pci/hda/hda_codec.c:1227: hda_codec_setup_stream: NID=3D0x14, st=
ream=3D0x1, channel=3D0, format=3D0x4011
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=3D0x14
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=3D0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=3D0x12
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=3D0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=3D0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=3D0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=3D0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=3D0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=3D0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=3D0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=3D0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=3D0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=3D0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=3D0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=3D0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=3D0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=3D0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=3D0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=3D0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=3D0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=3D0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=3D0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=3D0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=3D0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=3D0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=3D0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=3D0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=3D0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=3D0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=3D0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=3D0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=3D0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=3D0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=3D0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=3D0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=3D0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=3D0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=3D0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=3D0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=3D0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=3D0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=3D0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=3D0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=3D0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=3D0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=3D0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=3D0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=3D0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=3D0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=3D0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=3D0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=3D0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=3D0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=3D0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=3D0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=3D0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=3D0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=3D0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=3D0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=3D0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=3D0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=3D0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=3D0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=3D0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=3D0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=3D0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=3D0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=3D0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=3D0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=3D0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=3D0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=3D0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=3D0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=3D0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=3D0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=3D0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=3D0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=3D0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=3D0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=3D0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=3D0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=3D0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=3D0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=3D0x10
ALSA sound/pci/hda/hda_intel.c:1675: azx_pcm_prepare: bufsize=3D0x4500, for=
mat=3D0x4011
ALSA sound/pci/hda/hda_codec.c:1227: hda_codec_setup_stream: NID=3D0x12, st=
ream=3D0x8, channel=3D0, format=3D0x4011
ALSA sound/pci/hda/hda_intel.c:1675: azx_pcm_prepare: bufsize=3D0x4500, for=
mat=3D0x4011
ALSA sound/pci/hda/hda_codec.c:1227: hda_codec_setup_stream: NID=3D0x12, st=
ream=3D0x8, channel=3D0, format=3D0x4011
ALSA sound/pci/hda/hda_intel.c:1675: azx_pcm_prepare: bufsize=3D0x4500, for=
mat=3D0x4011
ALSA sound/pci/hda/hda_codec.c:1227: hda_codec_setup_stream: NID=3D0x14, st=
ream=3D0x1, channel=3D0, format=3D0x4011
ALSA sound/pci/hda/hda_intel.c:1675: azx_pcm_prepare: bufsize=3D0x4500, for=
mat=3D0x4011
ALSA sound/pci/hda/hda_codec.c:1227: hda_codec_setup_stream: NID=3D0x14, st=
ream=3D0x1, channel=3D0, format=3D0x4011
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=3D0x14
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=3D0x12
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=3D0x12
ALSA sound/pci/hda/hda_intel.c:1675: azx_pcm_prepare: bufsize=3D0x4500, for=
mat=3D0x4011
ALSA sound/pci/hda/hda_codec.c:1227: hda_codec_setup_stream: NID=3D0x12, st=
ream=3D0x8, channel=3D0, format=3D0x4011
ALSA sound/pci/hda/hda_intel.c:1675: azx_pcm_prepare: bufsize=3D0x4500, for=
mat=3D0x4011
ALSA sound/pci/hda/hda_codec.c:1227: hda_codec_setup_stream: NID=3D0x12, st=
ream=3D0x8, channel=3D0, format=3D0x4011
ALSA sound/pci/hda/hda_intel.c:1675: azx_pcm_prepare: bufsize=3D0x4500, for=
mat=3D0x4011
ALSA sound/pci/hda/hda_codec.c:1227: hda_codec_setup_stream: NID=3D0x14, st=
ream=3D0x1, channel=3D0, format=3D0x4011
ALSA sound/pci/hda/hda_intel.c:1675: azx_pcm_prepare: bufsize=3D0x4500, for=
mat=3D0x4011
ALSA sound/pci/hda/hda_codec.c:1227: hda_codec_setup_stream: NID=3D0x14, st=
ream=3D0x1, channel=3D0, format=3D0x4011
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=3D0x14
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=3D0x12
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=3D0x12
ALSA sound/pci/hda/hda_intel.c:1675: azx_pcm_prepare: bufsize=3D0x4500, for=
mat=3D0x4011
ALSA sound/pci/hda/hda_codec.c:1227: hda_codec_setup_stream: NID=3D0x14, st=
ream=3D0x1, channel=3D0, format=3D0x4011
ALSA sound/pci/hda/hda_intel.c:1675: azx_pcm_prepare: bufsize=3D0x4500, for=
mat=3D0x4011
ALSA sound/pci/hda/hda_codec.c:1227: hda_codec_setup_stream: NID=3D0x14, st=
ream=3D0x1, channel=3D0, format=3D0x4011
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=3D0x14
ALSA sound/pci/hda/hda_intel.c:1675: azx_pcm_prepare: bufsize=3D0x10000, fo=
rmat=3D0x4011
ALSA sound/pci/hda/hda_codec.c:1227: hda_codec_setup_stream: NID=3D0x12, st=
ream=3D0x5, channel=3D0, format=3D0x4011
ALSA sound/pci/hda/hda_codec.c:1227: hda_codec_setup_stream: NID=3D0x10, st=
ream=3D0x5, channel=3D0, format=3D0x4011
ALSA sound/pci/hda/hda_intel.c:1675: azx_pcm_prepare: bufsize=3D0x10000, fo=
rmat=3D0x4011
ALSA sound/pci/hda/hda_codec.c:1227: hda_codec_setup_stream: NID=3D0x12, st=
ream=3D0x5, channel=3D0, format=3D0x4011
ALSA sound/pci/hda/hda_codec.c:1227: hda_codec_setup_stream: NID=3D0x10, st=
ream=3D0x5, channel=3D0, format=3D0x4011
ALSA sound/pci/hda/hda_intel.c:1675: azx_pcm_prepare: bufsize=3D0x10000, fo=
rmat=3D0x4011
ALSA sound/pci/hda/hda_codec.c:1227: hda_codec_setup_stream: NID=3D0x14, st=
ream=3D0x1, channel=3D0, format=3D0x4011
ALSA sound/pci/hda/hda_intel.c:1675: azx_pcm_prepare: bufsize=3D0x10000, fo=
rmat=3D0x4011
ALSA sound/pci/hda/hda_codec.c:1227: hda_codec_setup_stream: NID=3D0x14, st=
ream=3D0x1, channel=3D0, format=3D0x4011
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=3D0x14
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=3D0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=3D0x12
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=3D0x10
usb 3-1: USB disconnect, address 2
usb 3-1: new full speed USB device using uhci_hcd and address 3
usb 3-1: New USB device found, idVendor=3D046d, idProduct=3D0a01
usb 3-1: New USB device strings: Mfr=3D1, Product=3D2, SerialNumber=3D0
usb 3-1: Product: Logitech USB Headset
usb 3-1: Manufacturer: Logitech
ALSA sound/usb/endpoint.c:434: 3:1:1: add audio endpoint 0x1
ALSA sound/usb/endpoint.c:434: 3:1:2: add audio endpoint 0x1
ALSA sound/usb/endpoint.c:434: 3:2:1: add audio endpoint 0x84
ALSA sound/usb/mixer.c:1140: [6] FU [Mic Playback Switch] ch =3D 1, val =3D=
 0/1/1
ALSA sound/usb/mixer.c:444: cannot set ctl value: req =3D 0x4, wValue =3D 0=
x200, wIndex =3D 0x600, type =3D 4, data =3D 0x8/0x0
ALSA sound/usb/mixer.c:1140: [6] FU [Mic Playback Volume] ch =3D 1, val =3D=
 -10496/-3072/16
ALSA sound/usb/mixer.c:1140: [1] FU [Speaker Playback Switch] ch =3D 1, val=
 =3D 0/1/1
ALSA sound/usb/mixer.c:444: cannot set ctl value: req =3D 0x4, wValue =3D 0=
x201, wIndex =3D 0x100, type =3D 4, data =3D 0x80/0x0
ALSA sound/usb/mixer.c:1140: [1] FU [Speaker Playback Volume] ch =3D 2, val=
 =3D -10496/768/256
ALSA sound/usb/mixer.c:1140: [2] FU [Mic Capture Switch] ch =3D 1, val =3D =
0/1/1
ALSA sound/usb/mixer.c:444: cannot set ctl value: req =3D 0x4, wValue =3D 0=
x200, wIndex =3D 0x200, type =3D 4, data =3D 0x80/0x0
ALSA sound/usb/mixer.c:1140: [2] FU [Mic Capture Volume] ch =3D 1, val =3D =
4096/7424/256
ALSA sound/usb/pcm.c:226: setting usb interface 1:2
ALSA sound/usb/pcm.c:226: setting usb interface 2:1
ALSA sound/usb/pcm.c:226: setting usb interface 1:1
ALSA sound/usb/pcm.c:226: setting usb interface 2:1
ALSA sound/usb/pcm.c:226: setting usb interface 1:1
ALSA sound/usb/pcm.c:226: setting usb interface 2:1
ALSA sound/usb/pcm.c:226: setting usb interface 1:1
ALSA sound/usb/pcm.c:226: setting usb interface 2:1
ALSA sound/usb/pcm.c:226: setting usb interface 2:1
ALSA sound/usb/pcm.c:226: setting usb interface 1:1
ALSA sound/usb/pcm.c:226: setting usb interface 2:1
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
usb 3-1: USB disconnect, address 3
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:179: cannot submit urb (err =3D -19)
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:179: cannot submit urb (err =3D -19)
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:179: cannot submit urb (err =3D -19)
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:179: cannot submit urb (err =3D -19)
BUG: unable to handle kernel NULL pointer dereference at 00000074
IP: [<f84d22ed>] snd_complete_urb+0x22/0x9d [snd_usb_audio]
*pde =3D 00000000=20
Oops: 0000 [#1] SMP=20
last sysfs file: /sys/devices/LNXSYSTM:00/device:00/PNP0A08:00/device:01/PN=
P0C09:00/PNP0C0A:00/power_supply/BAT0/voltage_now
Modules linked in: snd_usb_audio snd_usbmidi_lib snd_rawmidi tcp_lp netcons=
ole configfs sit tunnel4 fuse aes_i586 aes_generic rfcomm sco bnep l2cap co=
retemp cpufreq_ondemand acpi_cpufreq mperf ip6t_REJECT nf_conntrack_ipv6 nf=
_defrag_ipv6 ip6table_filter ip6_tables ipv6 uinput arc4 ecb iwlagn iwlcore=
 snd_hda_codec_conexant snd_hda_intel snd_hda_codec mac80211 snd_hwdep cfg8=
0211 snd_seq snd_seq_device uvcvideo e1000e btusb bluetooth snd_pcm videode=
v snd_timer snd_page_alloc iTCO_wdt iTCO_vendor_support v4l1_compat i2c_i80=
1 thinkpad_acpi wmi rfkill pcspkr joydev microcode snd soundcore firewire_o=
hci sdhci_pci firewire_core sdhci mmc_core yenta_socket crc_itu_t i915 drm_=
kms_helper drm i2c_algo_bit i2c_core video output [last unloaded: scsi_wait=
_scan]

Pid: 1781, comm: dbus-daemon Not tainted 2.6.37 #3 406227U/406227U
EIP: 0060:[<f84d22ed>] EFLAGS: 00010002 CPU: 0
EIP is at snd_complete_urb+0x22/0x9d [snd_usb_audio]
EAX: ec5dd23c EBX: ec5dd1bc ECX: 00000000 EDX: 00000000
ESI: 00000000 EDI: ed992cc0 EBP: f4409f08 ESP: f4409ef8
 DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068
Process dbus-daemon (pid: 1781, ti=3Df4408000 task=3Ded943300 task.ti=3Ded8=
aa000)
Stack:
 ec5dd23c f466a800 ed992cc0 00000000 f4409f1c c0696b31 f3cae4e0 f466a94c
 ed992cc0 f4409f4c c06af983 f466a908 000004e0 00000000 00000096 f3cae4fc
 f466a908 f466a800 f3cae4e0 edb7fe10 edb7fdfc f4409f94 c06b0147 00000000
Call Trace:
 [<c0696b31>] ? usb_hcd_giveback_urb+0x68/0x9d
 [<c06af983>] ? uhci_giveback_urb+0x106/0x1dc
 [<c06b0147>] ? uhci_scan_schedule+0x474/0x6a0
 [<c045b775>] ? clockevents_program_event+0xc7/0xd9
 [<c06b110d>] ? uhci_irq+0xd4/0xea
 [<c04905ae>] ? trace_hardirqs_off+0x8/0x1c
 [<c0696623>] ? usb_hcd_irq+0x3f/0x88
 [<c047dc13>] ? handle_IRQ_event+0x4e/0x103
 [<c047f86b>] ? handle_fasteoi_irq+0x95/0xcc
 [<c047f7d6>] ? handle_fasteoi_irq+0x0/0xcc
 <IRQ>=20
 [<c04049f7>] ? do_IRQ+0x43/0x8e
 [<c04038f5>] ? common_interrupt+0x35/0x3c
 [<c0790000>] ? gxfb_probe+0x29a/0x3d4
Code: 14 8d 65 f4 5b 5e 5f 5d c3 55 89 e5 57 56 53 83 ec 04 3e 8d 74 26 00 =
89 c7 8b 40 70 8b 58 08 89 45 f0 f6 43 68 01 8b 73 08 74 15 <8b> 56 74 89 f=
9 89 d8 ff 93 a0 01 00 00 89 c2 31 c0 85 d2 75 29=20
EIP: [<f84d22ed>] snd_complete_urb+0x22/0x9d [snd_usb_audio] SS:ESP 0068:f4=
409ef8
CR2: 0000000000000074
BUG: scheduling while atomic: dbus-daemon/1781/0x10010000
Modules linked in: snd_usb_audio snd_usbmidi_lib snd_rawmidi tcp_lp netcons=
ole configfs sit tunnel4 fuse aes_i586 aes_generic rfcomm sco bnep l2cap co=
retemp cpufreq_ondemand acpi_cpufreq mperf ip6t_REJECT nf_conntrack_ipv6 nf=
_defrag_ipv6 ip6table_filter ip6_tables ipv6 uinput arc4 ecb iwlagn iwlcore=
 snd_hda_codec_conexant snd_hda_intel snd_hda_codec mac80211 snd_hwdep cfg8=
0211 snd_seq snd_seq_device uvcvideo e1000e btusb bluetooth snd_pcm videode=
v snd_timer snd_page_alloc iTCO_wdt iTCO_vendor_support v4l1_compat i2c_i80=
1 thinkpad_acpi wmi rfkill pcspkr joydev microcode snd soundcore firewire_o=
hci sdhci_pci snd_hda_codec snd_seq uvcvideo btusb bluetooth videodev snd_t=
imer iTCO_wdt iTCO_vendor_support v4l1_compat i2c_i801 thinkpad_acpi wmi rf=
kill pcspkr joydev microcode snd soundcore firewire_ohci sdhci_pci firewire=
_core sdhci mmc_core yenta_socket crc_itu_t i915 drm_kms_helper drm i2c_alg=
o_bit i2c_core video output [last unloaded: scsi_wait_scan]

Pid: 1781, comm: dbus-daemon Not tainted 2.6.37 #3 406227U/406227U
EIP: 0073:[<b7653b08>] EFLAGS: 00000246 CPU: 0
EIP is at 0xb7653b08
EAX: 00000001 EBX: b7711ff4 ECX: 0000004b EDX: ffffffff
ESI: 00000000 EDI: b82f7598 EBP: bfcab258 ESP: bfcab244
 DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b
Process dbus-daemon (pid: 1781, ti=3Df4408000 task=3Ded943300 task.ti=3Ded8=
aa000)

Call Trace:
BUG: scheduling while atomic: dbus-daemon/1781/0x10010100
Modules linked in: snd_usb_audio snd_usbmidi_lib snd_rawmidi tcp_lp netcons=
ole configfs sit tunnel4 fuse aes_i586 aes_generic rfcomm sco bnep l2cap co=
retemp cpufreq_ondemand acpi_cpufreq mperf ip6t_REJECT nf_conntrack_ipv6 nf=
_defrag_ipv6 ip6table_filter ip6_tables ipv6 uinput arc4 ecb iwlagn iwlcore=
 snd_hda_codec_conexant snd_hda_intel snd_hda_codec mac80211 snd_hwdep cfg8=
0211 snd_seq snd_seq_deviceEIP is at 0xb7653b08
EAX: 00000001 EBX: b7711ff4 ECX: 0000004b EDX: ffffffff
ESI: 00000000 EDI: b82f7598 EBP: bfcab258 ESP: bfcab244
 DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b
Process dbus-daemon (pid: 1781, ti=3Df4408000 task=3Ded943300 task.ti=3Ded8=
aa000)
_ tunnel4 fuse aes_i586 aes_generic rfcomm sco bnep l2cap coretemp cpufreq_=
ondemand acpi_cpufreq mperf ip6t_REJECT nf_conntrack_ipv6 nf<4>Call Trace:
<3>BUG: scheduling while atomic: dbus-daemon/1781/0x10010100
<4>Modules linked in: snd_usb_audio snd_usbmidi_lib snd_rawmidi tcp_lp netc=
onsole configfs sit tunnel4 fuse aes_i586 aes_generic rfcomm sco bnep l2cap=
 coretemp cpufreq_ondemand acpi_cpufreq mperf ip6t_REJECT nf_conntrack_ipv6=
 nf_defrag_ipv6 ip6table_filter ip6_tables ipv6 uinput arc4 ecb iwlagn iwlc=
ore snd_hda_codec_conexant snd_hda_intel snd_hda_codec mac80211 snd_hwdep c=
fg80211 snd_seq snd_seq_device uvcvideo e1000e btusb bluetooth snd_pcm vide=
odev s tunnel4 fuse aes_i586 aes_generic rfcomm sco bnep l2cap coretemp cpu=
freq_ondemand acpi_cpufreq mperf ip6t_REJECT nf_conntrack_ipv6 nf_defrag_ip=
v6 ip6table_filter ip6_tables ipv6 uinput arc4 ecb iwlagn iwlcore snd_hda_c=
odec_conexant snd_hda_intel snd_hda_codec mac80211 snd_hwdep cfg80211 snd_s=
eq snd_seq tunnel4 fuse aes_i586 aes_generic rfcomm sco bnep l2cap coretemp=
 cpufreq_ondemand acpi_cpufreq mperf ip6t_REJECT nf_conntrack_ipv6 nf_defra=
g_ipv6 ip6table_filter ip6_tables ipv6 uinput arc4 ecb iwlagn iwlcore snd_h=
da_codec_conexant snd_hda_intel snd_hda_codec mac80211 snd_hwdep cfg80211 s=
nd_seq snd_seq_device uvcvideo e1000e btusb bluetooth snd_pcm videodev s tu=
nnel4 fuse aes_i586 aes_generic rfcomm sco bnep l2cap coretemp cpufreq_onde=
mand acpi_cpufreq mperf ip6t_REJECT nf_conntrack_ipv6 nf_defrag_ipv6 ip6tab=
le_filter ip6_tables ipv6 uinput arc4 ecb iwlagn iwlcore snd_hda_codec_cone=
xant snd_hda_intel snd_hda_codec mac80211 snd_hwdep cfg80211 snd_seq snd_se=
q tunnel4 fuse aes_i586 aes_generic rfcomm sco bnep l2cap coretemp cpufreq_=
ondemand acpi_cpufreq mperf ip6t_REJECT nf_conntrack_ipv6 nf_defrag_ipv6 ip=
6table_filter ip6_tables ipv6 uinput arc4 ecb iwlagn iwlcore snd_hda_codec_=
conexant snd_hda_intel snd_hda_codec mac80211 snd_hwdep cfg80211 snd_seq sn=
d_seq_device uvcvideo e1000e btusb bluetooth snd_pcm videodev s tunnel4 fus=
e aes_i586 aes_generic rfcomm sco bnep l2cap coretemp cpufreq_ondemand acpi=
_cpufreq mperf ip6t_REJECT nf_conntrack_ipv6 nf_defrag_ipv6 ip6table_filter=
 ip6_tables ipv6 uinput arc4 ecb iwlagn iwlcore snd_hda_codec_conexant snd_=
hda_intel snd_hda_codec mac80211 snd_hwdep cfg80211 snd_seq snd_seq tunnel4=
 fuse aes_i586 aes_generic rfcomm sco bnep l2cap coretemp cpufreq_ondemand =
acpi_cpufreq mperf ip6t_REJECT nf_conntrack_ipv6 nf_defrag_ipv6 ip6table_fi=
lter ip6_tables ipv6 uinput arc4 ecb iwlagn iwlcore snd_hda_codec_conexant =
snd_hda_intel snd_hda_codec mac80211 snd_hwdep cfg80211 snd_seq snd_seq_dev=
ice uvcvideo e1000e btusb bluetooth snd_pcm videodev s tunnel4 fuse aes_i58=
6 aes_generic rfcomm sco bnep l2cap coretemp cpufreq_ondemand acpi_cpufreq =
mperf ip6t_REJECT nf_conntrack_ipv6 nf_defrag_ipv6 ip6table_filter ip6_tabl=
es ipv6 uinput arc4 ecb iwlagn iwlcore snd_hda_codec_conexant snd_hda_intel=
 snd_hda_codec mac80211 snd_hwdep cfg80211 snd_seq snd_seq tunnel4 fuse aes=
_i586 aes_generic rfcomm sco bnep l2cap coretemp cpufreq_ondemand acpi_cpuf=
req mperf ip6t_REJECT nf_conntrack_ipv6 nf_defrag_ipv6 ip6table_filter ip6_=
tables ipv6 uinput arc4 ecb iwlagn iwlcore snd_hda_codec_conexant snd_hda_i=
ntel snd_hda_codec mac80211 snd_hwdep cfg80211 snd_seq snd_seq_device uvcvi=
deo e1000e btusb bluetooth snd_pcm videodev s tunnel4 fuse aes_i586 aes_gen=
eric rfcomm sco bnep l2cap coretemp cpufreq_ondemand acpi_cpufreq mperf ip6=
t_REJECT nf_conntrack_ipv6 nf_defrag_ipv6 ip6table_filter ip6_tables ipv6 u=
input arc4 ecb iwlagn iwlcore snd_hda_codec_conexant snd_hda_intel snd_hda_=
codec mac80211 snd_hwdep cfg80211 snd_seq snd_seqles ipv6 uinput arc4 ecb i=
wlagn iwlcore snd_hda_codec_conexant snd_hda_intel snd_hda_codec mac80211 s=
nd_hwdep cfg80211 snd_seq snd_seq_device uvcvideo e1000e btusb bluetooth sn=
d_pcm videodev snd_timer snd_page_alloc iTCO_wdt iTCO_vendor_support v4l1_c=
ompat i2c_i801 thinkpad_acpi wmi rfkill pcspkr joydev microcode snd soundco=
re firewire_ohci sdhci_pci firewire_ tunnel4 fuse aes_i586 aes_generic rfco=
mm sco bnep l2cap coretemp cpufreq_ondemand acpi_cpufreq mperf ip6t_REJECT =
nf_conntrack_ipv6 nf<4>Call Trace:

--V0207lvV8h4k8FAm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="log1.txt"

netconsole: local port 6665
netconsole: local IP 0.0.0.0
netconsole: interface 'eth0'
netconsole: remote port 6666
netconsole: remote IP 10.0.0.1
netconsole: remote ethernet address ff:ff:ff:ff:ff:ff
netconsole: local IP 10.0.0.2
SELinux: initialized (dev configfs, type configfs), uses genfs_contexts
console [netcon0] enabled
netconsole: network logging started
Monitor-Mwait will be used to enter C-3 state
usb 6-1: new full speed USB device using uhci_hcd and address 2
usb 6-1: New USB device found, idVendor=046d, idProduct=0a01
usb 6-1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
usb 6-1: Product: Logitech USB Headset
usb 6-1: Manufacturer: Logitech
ALSA sound/usb/endpoint.c:434: 2:1:1: add audio endpoint 0x1
ALSA sound/usb/endpoint.c:434: 2:1:2: add audio endpoint 0x1
ALSA sound/usb/endpoint.c:434: 2:2:1: add audio endpoint 0x84
ALSA sound/usb/mixer.c:1140: [6] FU [Mic Playback Switch] ch = 1, val = 0/1/1
ALSA sound/usb/mixer.c:444: cannot set ctl value: req = 0x4, wValue = 0x200, wIndex = 0x600, type = 4, data = 0x8/0x0
ALSA sound/usb/mixer.c:1140: [6] FU [Mic Playback Volume] ch = 1, val = -10496/-3072/16
ALSA sound/usb/mixer.c:1140: [1] FU [Speaker Playback Switch] ch = 1, val = 0/1/1
ALSA sound/usb/mixer.c:444: cannot set ctl value: req = 0x4, wValue = 0x201, wIndex = 0x100, type = 4, data = 0x80/0x0
ALSA sound/usb/mixer.c:1140: [1] FU [Speaker Playback Volume] ch = 2, val = -10496/768/256
ALSA sound/usb/mixer.c:1140: [2] FU [Mic Capture Switch] ch = 1, val = 0/1/1
ALSA sound/usb/mixer.c:444: cannot set ctl value: req = 0x4, wValue = 0x200, wIndex = 0x200, type = 4, data = 0x80/0x0
ALSA sound/usb/mixer.c:1140: [2] FU [Mic Capture Volume] ch = 1, val = 4096/7424/256
usbcore: registered new interface driver snd-usb-audio
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=0x10
ALSA sound/pci/hda/hda_intel.c:1675: azx_pcm_prepare: bufsize=0x4500, format=0x4011
ALSA sound/pci/hda/hda_codec.c:1227: hda_codec_setup_stream: NID=0x12, stream=0x5, channel=0, format=0x4011
ALSA sound/pci/hda/hda_codec.c:1227: hda_codec_setup_stream: NID=0x10, stream=0x5, channel=0, format=0x4011
ALSA sound/pci/hda/hda_intel.c:1675: azx_pcm_prepare: bufsize=0x4500, format=0x4011
ALSA sound/pci/hda/hda_codec.c:1227: hda_codec_setup_stream: NID=0x12, stream=0x5, channel=0, format=0x4011
ALSA sound/pci/hda/hda_codec.c:1227: hda_codec_setup_stream: NID=0x10, stream=0x5, channel=0, format=0x4011
ALSA sound/pci/hda/hda_intel.c:1675: azx_pcm_prepare: bufsize=0x4500, format=0x4011
ALSA sound/pci/hda/hda_codec.c:1227: hda_codec_setup_stream: NID=0x14, stream=0x1, channel=0, format=0x4011
ALSA sound/pci/hda/hda_intel.c:1675: azx_pcm_prepare: bufsize=0x4500, format=0x4011
ALSA sound/pci/hda/hda_codec.c:1227: hda_codec_setup_stream: NID=0x14, stream=0x1, channel=0, format=0x4011
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=0x14
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=0x12
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=0x10
ALSA sound/pci/hda/hda_intel.c:1675: azx_pcm_prepare: bufsize=0x4500, format=0x4011
ALSA sound/pci/hda/hda_codec.c:1227: hda_codec_setup_stream: NID=0x12, stream=0x8, channel=0, format=0x4011
ALSA sound/pci/hda/hda_intel.c:1675: azx_pcm_prepare: bufsize=0x4500, format=0x4011
ALSA sound/pci/hda/hda_codec.c:1227: hda_codec_setup_stream: NID=0x12, stream=0x8, channel=0, format=0x4011
ALSA sound/pci/hda/hda_intel.c:1675: azx_pcm_prepare: bufsize=0x4500, format=0x4011
ALSA sound/pci/hda/hda_codec.c:1227: hda_codec_setup_stream: NID=0x14, stream=0x1, channel=0, format=0x4011
ALSA sound/pci/hda/hda_intel.c:1675: azx_pcm_prepare: bufsize=0x4500, format=0x4011
ALSA sound/pci/hda/hda_codec.c:1227: hda_codec_setup_stream: NID=0x14, stream=0x1, channel=0, format=0x4011
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=0x14
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=0x12
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=0x12
ALSA sound/pci/hda/hda_intel.c:1675: azx_pcm_prepare: bufsize=0x4500, format=0x4011
ALSA sound/pci/hda/hda_codec.c:1227: hda_codec_setup_stream: NID=0x12, stream=0x8, channel=0, format=0x4011
ALSA sound/pci/hda/hda_intel.c:1675: azx_pcm_prepare: bufsize=0x4500, format=0x4011
ALSA sound/pci/hda/hda_codec.c:1227: hda_codec_setup_stream: NID=0x12, stream=0x8, channel=0, format=0x4011
ALSA sound/pci/hda/hda_intel.c:1675: azx_pcm_prepare: bufsize=0x4500, format=0x4011
ALSA sound/pci/hda/hda_codec.c:1227: hda_codec_setup_stream: NID=0x14, stream=0x1, channel=0, format=0x4011
ALSA sound/pci/hda/hda_intel.c:1675: azx_pcm_prepare: bufsize=0x4500, format=0x4011
ALSA sound/pci/hda/hda_codec.c:1227: hda_codec_setup_stream: NID=0x14, stream=0x1, channel=0, format=0x4011
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=0x14
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=0x12
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=0x12
ALSA sound/pci/hda/hda_intel.c:1675: azx_pcm_prepare: bufsize=0x4500, format=0x4011
ALSA sound/pci/hda/hda_codec.c:1227: hda_codec_setup_stream: NID=0x14, stream=0x1, channel=0, format=0x4011
ALSA sound/pci/hda/hda_intel.c:1675: azx_pcm_prepare: bufsize=0x4500, format=0x4011
ALSA sound/pci/hda/hda_codec.c:1227: hda_codec_setup_stream: NID=0x14, stream=0x1, channel=0, format=0x4011
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=0x14
ALSA sound/pci/hda/hda_intel.c:1675: azx_pcm_prepare: bufsize=0x10000, format=0x4011
ALSA sound/pci/hda/hda_codec.c:1227: hda_codec_setup_stream: NID=0x12, stream=0x5, channel=0, format=0x4011
ALSA sound/pci/hda/hda_codec.c:1227: hda_codec_setup_stream: NID=0x10, stream=0x5, channel=0, format=0x4011
ALSA sound/pci/hda/hda_intel.c:1675: azx_pcm_prepare: bufsize=0x10000, format=0x4011
ALSA sound/pci/hda/hda_codec.c:1227: hda_codec_setup_stream: NID=0x12, stream=0x5, channel=0, format=0x4011
ALSA sound/pci/hda/hda_codec.c:1227: hda_codec_setup_stream: NID=0x10, stream=0x5, channel=0, format=0x4011
ALSA sound/pci/hda/hda_intel.c:1675: azx_pcm_prepare: bufsize=0x10000, format=0x4011
ALSA sound/pci/hda/hda_codec.c:1227: hda_codec_setup_stream: NID=0x14, stream=0x1, channel=0, format=0x4011
ALSA sound/pci/hda/hda_intel.c:1675: azx_pcm_prepare: bufsize=0x10000, format=0x4011
ALSA sound/pci/hda/hda_codec.c:1227: hda_codec_setup_stream: NID=0x14, stream=0x1, channel=0, format=0x4011
ALSA sound/usb/pcm.c:226: setting usb interface 1:2
ALSA sound/usb/pcm.c:226: setting usb interface 2:1
ALSA sound/usb/pcm.c:226: setting usb interface 1:1
ALSA sound/usb/pcm.c:226: setting usb interface 2:1
ALSA sound/usb/pcm.c:226: setting usb interface 1:1
ALSA sound/usb/pcm.c:226: setting usb interface 2:1
ALSA sound/usb/pcm.c:226: setting usb interface 1:1
ALSA sound/usb/pcm.c:226: setting usb interface 2:1
ALSA sound/usb/pcm.c:226: setting usb interface 2:1
ALSA sound/usb/pcm.c:226: setting usb interface 1:1
ALSA sound/usb/pcm.c:226: setting usb interface 2:1
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
usb 6-1: USB disconnect, address 2
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:179: cannot submit urb (err = -19)
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=0x14
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=0x10
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=0x12
ALSA sound/pci/hda/hda_codec.c:1290: hda_codec_cleanup_stream: NID=0x10
usb 6-1: new full speed USB device using uhci_hcd and address 3
usb 6-1: New USB device found, idVendor=046d, idProduct=0a01
usb 6-1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
usb 6-1: Product: Logitech USB Headset
usb 6-1: Manufacturer: Logitech
ALSA sound/usb/endpoint.c:434: 3:1:1: add audio endpoint 0x1
ALSA sound/usb/endpoint.c:434: 3:1:2: add audio endpoint 0x1
ALSA sound/usb/endpoint.c:434: 3:2:1: add audio endpoint 0x84
ALSA sound/usb/mixer.c:1140: [6] FU [Mic Playback Switch] ch = 1, val = 0/1/1
ALSA sound/usb/mixer.c:444: cannot set ctl value: req = 0x4, wValue = 0x200, wIndex = 0x600, type = 4, data = 0x8/0x0
ALSA sound/usb/mixer.c:1140: [6] FU [Mic Playback Volume] ch = 1, val = -10496/-3072/16
ALSA sound/usb/mixer.c:1140: [1] FU [Speaker Playback Switch] ch = 1, val = 0/1/1
ALSA sound/usb/mixer.c:444: cannot set ctl value: req = 0x4, wValue = 0x201, wIndex = 0x100, type = 4, data = 0x80/0x0
ALSA sound/usb/mixer.c:1140: [1] FU [Speaker Playback Volume] ch = 2, val = -10496/768/256
ALSA sound/usb/mixer.c:1140: [2] FU [Mic Capture Switch] ch = 1, val = 0/1/1
ALSA sound/usb/mixer.c:444: cannot set ctl value: req = 0x4, wValue = 0x200, wIndex = 0x200, type = 4, data = 0x80/0x0
ALSA sound/usb/mixer.c:1140: [2] FU [Mic Capture Volume] ch = 1, val = 4096/7424/256
ALSA sound/usb/pcm.c:226: setting usb interface 1:2
ALSA sound/usb/pcm.c:226: setting usb interface 2:1
ALSA sound/usb/pcm.c:226: setting usb interface 1:1
ALSA sound/usb/pcm.c:226: setting usb interface 2:1
ALSA sound/usb/pcm.c:226: setting usb interface 1:1
ALSA sound/usb/pcm.c:226: setting usb interface 2:1
ALSA sound/usb/pcm.c:226: setting usb interface 1:1
ALSA sound/usb/pcm.c:226: setting usb interface 2:1
ALSA sound/usb/pcm.c:226: setting usb interface 2:1
ALSA sound/usb/pcm.c:226: setting usb interface 1:1
ALSA sound/usb/pcm.c:226: setting usb interface 2:1
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:462: frame 0 active: -84
usb 6-1: USB disconnect, address 3
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:179: cannot submit urb (err = -19)
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:179: cannot submit urb (err = -19)
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:179: cannot submit urb (err = -19)
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:179: cannot submit urb (err = -19)
ALSA sound/usb/urb.c:462: frame 0 active: -84
ALSA sound/usb/urb.c:179: cannot submit urb (err = -19)
BUG: unable to handle kernel NULL pointer dereference at 00000074
IP: [<f80ce2ed>] snd_complete_urb+0x22/0x9d [snd_usb_audio]
*pde = bd12f067 
Oops: 0000 [#1] SMP 
last sysfs file: /sys/devices/system/cpu/cpu1/cache/index2/shared_cpu_map
Modules linked in: snd_usb_audio snd_usbmidi_lib snd_rawmidi netconsole configfs sit tunnel4 fuse aes_i586 aes_generic rfcomm sco bnep l2cap coretemp cpufreq_ondemand acpi_cpufreq mperf ip6t_REJECT nf_conntrack_ipv6 nf_defrag_ipv6 ip6table_filter ip6_tables ipv6 uinput arc4 snd_hda_codec_conexant ecb snd_hda_intel iwlagn snd_hda_codec iwlcore mac80211 snd_hwdep snd_seq snd_seq_device snd_pcm snd_timer snd_page_alloc uvcvideo btusb cfg80211 bluetooth thinkpad_acpi i2c_i801 videodev iTCO_wdt snd e1000e iTCO_vendor_support v4l1_compat pcspkr rfkill wmi soundcore joydev microcode sdhci_pci sdhci firewire_ohci mmc_core firewire_core yenta_socket crc_itu_t i915 drm_kms_helper drm i2c_algo_bit i2c_core video output [last unloaded: scsi_wait_scan]

Pid: 2478, comm: udevd Not tainted 2.6.37 #3 406227U/406227U
EIP: 0060:[<f80ce2ed>] EFLAGS: 00010002 CPU: 0
EIP is at snd_complete_urb+0x22/0x9d [snd_usb_audio]
EAX: ec5586b4 EBX: ec5585bc ECX: 00000000 EDX: 00000000
ESI: 00000000 EDI: edab0540 EBP: f4409f08 ESP: f4409ef8
 DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068
Process udevd (pid: 2478, ti=f4408000 task=f1724c80 task.ti=ec430000)
Stack:
 ec5586b4 f3dd8000 edab0540 00000000 f4409f1c c0696b31 f3dc2420 f3dd814c
 edab0540 f4409f4c c06af983 f3dd8108 00000360 00000000 00000096 f3dc243c
 f3dd8108 f3dd8000 f3dc2420 ee1967b0 ee19679c f4409f94 c06b0147 00000000
Call Trace:
 [<c0696b31>] ? usb_hcd_giveback_urb+0x68/0x9d
 [<c06af983>] ? uhci_giveback_urb+0x106/0x1dc
 [<c06b0147>] ? uhci_scan_schedule+0x474/0x6a0
 [<c045b775>] ? clockevents_program_event+0xc7/0xd9
 [<c06b110d>] ? uhci_irq+0xd4/0xea
 [<c0696623>] ? usb_hcd_irq+0x3f/0x88
 [<c047dc13>] ? handle_IRQ_event+0x4e/0x103
 [<c047f86b>] ? handle_fasteoi_irq+0x95/0xcc
 [<c047f7d6>] ? handle_fasteoi_irq+0x0/0xcc
 <IRQ> 
 [<c04049f7>] ? do_IRQ+0x43/0x8e
 [<c04038f5>] ? common_interrupt+0x35/0x3c
 [<c07074b8>] ? skb_release_data+0x7c/0x80
 [<c05b00d8>] ? vsscanf+0x326/0x3f8
 [<c04c8d0c>] ? arch_local_save_flags+0x4/0xb
 [<c04c8d34>] ? arch_local_irq_save+0xb/0x18
 [<c04cb66a>] ? kfree+0x70/0xd5
 [<c07074b8>] ? skb_release_data+0x7c/0x80
 [<c07074b8>] ? skb_release_data+0x7c/0x80
 [<c0707677>] ? __kfree_skb+0x17/0x74
 [<c070772c>] ? consume_skb+0x58/0x5c
 [<c0709866>] ? skb_free_datagram+0x12/0x1c
 [<c072803d>] ? netlink_recvmsg+0x140/0x25e
 [<c0700089>] ? __sock_recvmsg+0x63/0x6d
 [<c070021f>] ? sock_recvmsg+0x9b/0xb0
 [<c070030e>] ? sock_sendmsg+0x98/0xac
 [<c042aa17>] ? need_resched+0x19/0x23
 [<c042aa2e>] ? should_resched+0xd/0x28
 [<c05b2a6e>] ? _copy_from_user+0x3e/0x52
 [<c0708961>] ? copy_from_user+0xd/0xf
 [<c0708c97>] ? verify_iovec+0x43/0x78
 [<c07006e2>] ? __sys_recvmsg+0x105/0x19c
 [<c0700184>] ? sock_recvmsg+0x0/0xb0
 [<c07007a7>] ? sockfd_lookup_light+0x1b/0x48
 [<c0701b61>] ? sys_sendto+0x120/0x142
 [<c04d4cc2>] ? fget_light+0x2f/0x5c
 [<c0702072>] ? sys_recvmsg+0x30/0x48
 [<c07023eb>] ? sys_socketcall+0x177/0x1a8
 [<c05b25e0>] ? trace_hardirqs_on_thunk+0xc/0x10
 [<c040335f>] ? sysenter_do_call+0x12/0x2d
Code: 14 8d 65 f4 5b 5e 5f 5d c3 55 89 e5 57 56 53 83 ec 04 3e 8d 74 26 00 89 c7 8b 40 70 8b 58 08 89 45 f0 f6 43 68 01 8b 73 08 74 15 <8b> 56 74 89 f9 89 d8 ff 93 a0 01 00 00 89 c2 31 c0 85 d2 75 29 
EIP: [<f80ce2ed>] snd_complete_urb+0x22/0x9d [snd_usb_audio] SS:ESP 0068:f4409ef8
CR2: 0000000000000074
BUG: scheduling while atomic: udevd/2478/0x10010000
Modules linked in: snd_usb_audio snd_usbmidi_lib snd_rawmidi netconsole configfs sit tunnel4 fuse aes_i586 aes_generic rfcomm sco bnep l2cap coretemp cpufreq_ondemand acpi_cpufreq mperf ip6t_REJECT nf_conntrack_ipv6 nf_defrag_ipv6 ip6table_filter ip6_tables ipv6 uinput arc4 snd_hda_codec_conexant ecb snd_hda_intel iwlagn snd_hda_codec iwlcore mac80211 snd_hwdep snd_seq snd_seq_device snd_pcm snd_timer snd_page_alloc uvcvideo btusb cfg80211 bluetooth thinkpad_acpi i2c_i801 videodev iTCO_wdt snd e1000e iTCO_vendor_support v4l1_compat pcspkr rfkill wmi soundcore joydev microcode sdhci_pci sdhci firewire_ohci mmc_core firewire_core yenta_socket crc_itu_t i915 drm_kms_helper drm i2c_algo_bit i2c_core video output [last unloaded: scsi_wait_scan]
Modules linked in: snd_usb_audio snd_usbmidi_lib snd_rawmidi netconsole configfs sit tunnel4 fuse aes_i586 aes_generic rfcomm sco bnep l2cap coretemp cpufreq_ondemand acpi_cpufreq mperf ip6t_REJECT nf_conntrack_ipv6 nf_defrag_ipv6 ip6table_filter ip6_tables ipv6 uinput arc4 snd_hda_codec_conexant ecb snd_hda_intel iwlagn snd_hda_codec iwlcore mac80211 snd_hwdep snd_seq snd_seq_device snd_pcm snd_timer snd_page_alloc uvcvideo btusb cfg80211 bluetooth thinkpad_acpi i2c_i801 videodev iTCO_wdt snd e1000e iTCO_vendor_support v4l1_compat pcspkr rfkill wmi soundcore joydev microcode sdhci_pci sdhci firewire_ohci mmc_core firewire_core yenta_socket crc_itu_t i915 drm_kms_helper drm i2c_algo_bit i2c_core video output [last unloaded: scsi_wait_scan]

Pid: 2478, comm: udevd Not tainted 2.6.37 #3 406227U/406227U
EIP: 0060:[<c04c8d0c>] EFLAGS: 00000286 CPU: 0
EIP is at arch_local_save_flags+0x4/0xb
EAX: 400040c0 EBX: f61cd940 ECX: 00000000 EDX: c07074b8
ESI: ec44a400 EDI: f4402500 EBP: ec431cac ESP: ec431ca8
08c97>] ? verify_iovec+0x43/0x78
<4> [<c07006e2>] __sys_recvmsg+0x105/0x19c
 [<c0700184>] ? sock_recvmsg+0x0/0xb0
c04cb66a c07074b8 ec431cd4
<4> f3f120c0 f3f120c0 ec431d40 ec431ce4 c07074b8 f3f120c0 f3f120c0 ec431cf0
 c0707677 f177d200 ec431d00 c070772c f177d200 f3f120e4 ec431d0c c0709866
irqs_on_thunk+0xc/0x10
+0x70/0xd5
<4> [<c07074b8>] ? skb_release_data+0x7c/0x80
snd_usb_audio snd_usbmidi_lib snd_rawmidi n? consume_skb+0x58/0x5c
<4> [<c0709866>] ? skb_free_datagram+0x12/0x1c
<4> [<c072803d>] ? netlink_recvmsg+0x140/0x25e
<4> [<c0700089>] ? __sock_recvmsg+0x63/0x6d
<4> [<c070021f>] ? sock_recvmsg+0x9b/0xb0
<4> [<c070030e>] ? sock_sendmsg+0x98/0xac
<4> [<c042aa17>] ? need_resched+0x19/0x23
<4> [<c042aa2e>] ? should_resched+0xd/0x28
<4> [<c05b2a6e>] ? _copy_from_user+0x3e/0x52
<4> [<c0708961>] ? copy_from_user+0xd/0xf
<4> [<c0708c97>] ? verify_iovec+0x43/0x78
<4> [<c07006e2>] ? __sys_recvmsg+0x105/0x19c
<4> [<c0700184>] ? sock_recvmsg+0x0/0xb0
<4> [<c07007a7>] ? sockfd_lookup_light+0x1b/0x48
<4> [<c0701b61>] ? sys_sendto+0x120/0x142
<4> [<c04d4cc2>] ? fget_light+0x2f/0x5c
<4> [<c0702072>] ? sys_recvmsg+0x30/0x48
nel4 fuse aes_i586 aes_generic rfcomm sco b65 f4 89 d0 5b 5e 5f 5d c3 90 90 90 55 89 e5 3e 8d 74 26 00 8d 50 ff 83 c8 ff c1 ea 0b 40 d1 ea 75 fb 5d c3 55 89 e5 9c <58> 8d 74 26 00 5d c3 55 89 e5 50 9d 8d 74 26 00 5d c3 55 89 e5 
<4>Call Trace:
<4> [<c04c8d34>] arch_local_irq_save+0xb/0x18
<4> [<c04cb66a>] kfree+0x70/0xd5
<4> [<c07074b8>] ? skb_release_data+0x7c/0x80
<4> [<c07074b8>] skb_release_data+0x7c/0x80
<4> [<c0707677>] __kfree_skb+0x17/0x74
<4> [<c070772c>] consume_skb+0x58/0x5c
<4> [<c0709866>] skb_free_datagram+0x12/0x1c
<4> [<c072803d>] netlink_recvmsg+0x140/0x25e
<4> [<c0700089>] __sock_recvmsg+0x63/0x6d
<4> [<c070021f>] sock_recvmsg+0x9b/0xb00
eed_resched+0x19/0x23
<4> [<c042aa2e>] ?
<4>ESI: ec44a400 EDI: f4402500 EBP: ec431cac ESP: ec431ca8
08c97>] ? verify_iovec+0x43/0x78
<4> [<c07006e2>] __sys_recvmsg+0x105/0x19c
0286 ec431cb8 c04c8d34 0000008b ec431cd4 c04cb66a c07074b8 ec431cd4
<4> [<c04d4cc2>] ? fget_light+0x2f/0x5c
<4> [<c0702072>] sys_recvmsg+0x30/0x48
c0709866
<0>Call Trace:
<4> [<c04c8d34>] ? arch_local_irq_save+0xb/0x18
x2d
<3>BUG: scheduling while atomic: udevd/2478/0x10010100
ic rfcomm sco bnep l2cap coretemp cpufreq_ondemand acpi_cpufreq mperf ip6t_REJECT nf_conntrack_ipv6 nf_defrag_ipv6 ip6table_filter ip6_tables ipv6 uinput arc4 snd_hda_codec_conexant ecb snd_hda_intel iwlagn snd_hda_codec iwlcore mac80211 snd_hwdep snd_seq snd_seq_device snd_pcm snd_timer snd_page_alloc uvcvideo btusb cfg80211 bluetooth thinkpad_acpi i2c_i801 videodev iTCO_wdt snd e1000e iTCO_vendor_support v4l1_compat pcspkr rfkill wmi soundcore joydev microcode sdhci_pci sdhci firewire_ohci mmc_core firewire_core yenta_socket crc_itu_t i915 drm_kms_helper drm i2c_algo_bit i2c_core video output [last unloaded: scsi_wait_scan]
<4>Modules linked in: snd_usb_audio snd_usbmidi_lib snd_rawmidi netconsole configfs sit tunnel4 fuse aes_i586 aes_ge6 ip6table_filter ip6_tables ipv6 uinput arc4 snd_hda_codec_conexant ecb snd_hda_intel iwlagn snd_hda_codec iwlcore mac80211 snd_hwdep snd_seq snd_seq_device snd_pcm snd_timer snd_page_alloc uvcvideo btusb cfg80211 bluetooth thinkpad_acpi i2c_i801 videodev iTCO_wdt snd e1000e iTCO_vendor_support v4l1_compat pcspkr rfkill wmi soundcore joydev microcode sdhci_pci sdhci firewire_ohci mmc_core firewire_core yenta_socket crc_itu_t i915 drm_kms_helper drm i2c_algo_bit i2c_core video output [last unloaded: scsi_wait_scan]
<4>
<4>Pid: 2478, comm: udevd Not tainted 2.6.37 #3 406227U/406227U
<4>EIP: 0060:[<c04c8d0c>] EFLAGS: 00000286 CPU: 0
eed_resched+0x19/0x23
<4> [<c042aa2e>] ?
<4>ESI: ec44a400 EDI: f4402500 EBP: ec431cac ESP: ec431ca8
08c97>] ? verify_iovec+0x43/0x78
<4> [<c07006ek.ti=ec430000)
<0>Stack:
<4> 00000286 ec431cb8 c04c8d34 0000008b ec431cd4 c04cb66a c07074b8 ec431cd4
<4> [<c04d4cc2>] ? fget_light+0x2f/0x5c
<4> [<c0702072>] sys_recvmsg+0x30ec431d0c c0709866
irqs_on_thunk+0xc/0x10
+0x70/0xd5
<4> [<c07074b8>] ? skb_releaseModules linked infigfs sit tunnel4 fuse aes_i586 aes_generic rfcomm sco bnep l2cap coretemp cpufreq_ondemand acpi_cpufreq mperf ip6t_REJECT nf_conntrack_ipv6 nf_defrag_ipv6 ip6table_filter ip6_tables ipv6 uinput arc4 snd_hda_codec_conexant ecb snd_hda_intel iwlagn snd_hda_codec iwlcore mac80211 snd_hwdep snd_seq snd_seq_device snd_pcm snd_timer snd_page_alloc uvcvideo btusb cfg80211 bluetooth thinkpad_acpi i2c_i801 videodev iTCO_wdt snd e1000e iTCO_vendor_support v4l1_compat pcspkr rfkill wmi soundcore joydev microcode sdhci_pci sdhci firewire_ohci mmc_core firewire_core yenta_socket crc_itu_t i915 drm_kms_helper drm i2c_algo_bit i2c_core video output [last unloaded: scsi_wait_scan]
<4>Modules linked in: snd_usb_audio snd_usbmidi_lib snd_ra_cpufreq mperf ip6t_REJECT nf_conntrack_ipv6 nf_defrag_ipv6 ip6table_filter ip6_tables ipv6 uinput arc4 snd_hda_codec_conexant ecb snd_hda_intel iwlagn snd_hda_codec iwlcore mac80211 snd_hwdep snd_seq snd_seq_device snd_pcm snd_timer snd_page_alloc uvcvideo btusb cfg80211 bluetooth thinkpad_acpi i2c_i801 videodev iTCO_wdt snd e1000e iTCO_vendor_support v4l1_compat pcspkr rfkill wmi soundcore joydev microcode sdhci_pci sdhci firewire_ohci mmc_core firewire_core yenta_socket crc_itu_t i915 drm_kms_helper drm i2c_algo_bit i2c_core video output [last unloaded: scsi_wait_scan]
<4>
<4>Pid: 2478, comm: udevd Not tainted 2.6.37 #3 406227U/406227U
<4>EIP: 0060:[<c04c8d0c>] EFLAGS: 00000286 CPU: 0
eed_resched+0x19/0x23
<4> [<c042aa2e>] ? should_resched+0xd/0x28
500 EBP: ec431cac ESP: ec431ca8
<4> DS: 00 ? verify_iovec+0x43/0x78
<4> [<c07006e2>] __sys_recvmsg+0x105/0x19c
0286 ec431cb8 c04c8d34 0000008b ec431c01b61>] ? sys_sendto+0x120/0x142
c0 ec431cf0
<4> c0707677 f177d200 ec431d00 c070772c f177d200 f3f120e4 ec431d0c c0709866
irqs_on_thunk+0xc/0x10
+0x70/0xd5
<4> [<c07074b8>] ? skb_releaseModules linked infigfs sit tunnel4 fuse aes_i586 aes_generic rfcomm sco bnep l2cap coretemp cpufreq_ondemand acpi_cpufreq mperf ip6t_REJECT nf_conntrack_ipv6 nf_defrag_ipv6 ip6table_filter ip6_tables ipv6 uinput arc4 snd_hda_codec_conexant ecb snd_hda_intel iwlagn snd_hda_codec iwlcore mac80211 snd_hwdep snd_seq snd_seq_device snd_pcm snd_timer snd_page_alloc uvcvideo btusb cfg80211 bluetooth thinkpad_acpi i2c_i801 videodev iTCO_wdt snd e1000e iTCO_vendor_support v4l1_compat pcspkr rfkill wmi soundcore joydev microcode sdhci_pci sdhci firewire_ohci mmc_core firewire_core yenta_socket crc_itu_t i915 drm_kms_helper drm i2c_algo_bit i2c_core video output [last unloaded: scsi_wait_scan]
<4>Modules linked in: snd_usb_audio snd_usbmidi_lib snd_ra_cpufreq mperf ip6t_REJECT nf_conntrack_ipv6 nf_defrag_ipv6 ip6table_filter ip6_tables ipv6 uinput arc4 snd_hda_codec_conexant ecb snd_hda_intel iwlagn snd_hda_codec iwlcore mac80211 snd_hwdep snd_seq snd_seq_device snd_pcm snd_timer snd_page_alloc uvcvideo btusb cfg80211 bluetooth thinkpad_acpi i2c_i801 videodev iTCO_wdt snd e1000e iTCO_vendor_support v4l1_compat pcspkr rfkill wmi soundcore joydev microcode sdhci_pci sdhci firewire_ohci mmc_core firewire_core yenta_socket crc_itu_t i915 drm_kms_helper drm i2c_algo_bit i2c_core video output [last unloaded: scsi_wait_scan]
<4>
<4>Pid: 2478, comm: udevd Not tainted 2.6.37 #3 406227U/406227U
<4>EIP: 0060:[<c04c8d0c>] EFLAGS: 00000286 CPU: 0
eed_resched+0x19/0x23
<4> [<c042aa2e>] ? should_resched+0xd/0x28
500 EBP: ec431cac ESP: ec431ca8
<4> DS: 00 ? verify_iovec+0x43/0x78
<4> [<c07006e2>] __sys_recvmsg+0x105/0x19c
0286 ec431cb8 c04c8d34 0000008b ec431c01b61>] ? sys_sendto+0x120/0x142
c0 ec431cf0
<4> c0707677 f177d200 ec431d00 c070772c f177d200 f3f120e4 ec431d0c c0709866
irqs_on_thunb66a>] ? kfree+0x70/0xd5
: udevd/2478/0x10010100
<4>Modules linked iep l2cap coretemp cpufreq_ondemand acpi_cpufreq mperf ip6t_REJECT nf_conntrack_ipv6 nf_defrag_ipv6 ip6table_filter ip6_tables ipv6 uinput arc4 snd_hda_codec_conexant ecb snd_hda_intel iwlagn snd_hda_codec iwlcore mac80211 snd_hwdep snd_seq snd_seq_device snd_pcm snd_timer snd_page_alloc uvcvideo btusb cfg80211 bluetooth thinkpad_acpi i2c_i801 videodev iTCO_wdt snd e1000e iTCO_vendor_support v4l1_compat pcspkr rfkill wmi soundcore joydev microcode sdhci_pci sdhci firewire_ohci mmc_core firewire_core yenta_socket crc_itu_t i915 drm_kms_helper drm i2c_algo_bit i2c_core video output [last unloaded: scsi_wait_scan]
<4>Modules linked in: snd_usb_audio snd_usbmidi_lib snd_rawmidi netconsole configfs sit tunnel4 fuse aes_i586 aes_ge<0>Code: 00 00 8d 65 f4 89 d0 5b 5e 5f 5d c3 90 90 90 55 89 e5 3e 8d 74 26 00 8d 50 ff 83 c8 ff c1 ea 0b 40 d1 ea 75 fb 5d c3 55 89 e5 9c <58> 8d 74 26 00 5d c3 55 89 e5 50 9d 8d 74 26 00 5d c3 55 89 e5 
<4>Call Trace:
<4> [<c04c8d34>] arch_local_irq_save+0xb/0x18
<4> [<c04cb66a>] kfree+0x70/0xd5
<4> [<c07074b8>] ? skb_release_data+0x7c/0x80
<4> [<c07074b8>] skb_release_data+0x7c/0x80
<4> [<c0707677>] __kfree_skb+0x17/0x74
<4> [<c070772c>] consume_skb+0x58/0x5c
<4> [<c0709866>] skb_free_datagram+0x12/0x1c
<4> [<c072803d>] netlink_recvmsg+0x140/0x25e
<4> [<c0700089>] __sock_recvmsg+0x63/0x6d
<4> [<c070021f>] sock_recvmsg+0x9b/0xb00 ? need_resched+0x19/0x23
0 EDX: c07074b8
<4>ESI: ec44a400 EDI: f41>] ? copy_from_user+0xd/0xf
<4> [<c0708c97>] ? verify_iovec+0x43/0x78
724c80 task.ti=ec430000)
<0>Stack:
<4> 00000286 ec431cb8 c04c8d34 0000008b ec431cd4 c04cb66a c07074b8 ec431cd4
<4> [<c04d4cc2>] ? fget_light+0x2f/0x5c
<4> [<c0702072>] sys_recvmsg+0x30ec431d0c c0709866
irqs_on_thunb66a>] ? kfree+0x70/0xd5
: udevd/2478/0x10010100
<4>Modules linked ib+0x58/0x5c
<4> [<c0709866>] ? skb_free_datagram+0x12/0x1c
<4> [<c072803d>] ? netlink_recvmsg+0x140/0x25e
<4> [<c0700089>] ? __sock_recvmsg+0x63/0x6d
<4> [<c070021f>] ? sock_recvmsg+0x9b/0xb0
<4> [<c070030e>] ? sock_sendmsg+0x98/0xac
<4> [<c042aa17>] ? need_resched+0x19/0x23
<4> [<c042aa2e>] ? should_resched+0xd/0x28
<4> [<c05b2a6e>] ? _copy_from_user+0x3e/0x52
<4> [<c0708961>] ? copy_from_user+0xd/0xf
<4> [<c0708c97>] ? verify_iovec+0x43/0x78
<4> [<c07006e2>] ? __sys_recvmsg+0x105/0x19c
<4> [<c0700184>] ? sock_recvmsg+0x0/0xb0
<4> [<c07007a7>] ? sockfd_lookup_light+0x1b/0x48
<4> [<c0701b61>] ? sys_sendto+0x120/0x142
<4> [<c04d4cc2>] ? fget_light+0x2f/0x5c
<4> [<c0702072>] ? sys_recvmsg+0x30/0x48
<4> [<c07023eb>] ? sys_sockeneric rfcomm sco b65 f4 89 d0 5b 5e 5f 5d c3 90 90 90 55 89 e5 3e 8d 74 26 00 8d 50 ff 83 c8 ff c1 ea 0b 40 d1 ea 75 fb 5d c3 55 89 e5 9c <58> 8d 74 26 00 5d c3 55 89 e5 50 9d 8d 74 26 00 5d c3 55 89 e5 
<4>Call Trace:
<4> [<c04c8d34>] arch_local_irq_save+0xb/0x18
<4> [<c04cb66a>] kfree+0x70/0xd5
<4> [<c07074b8>] ? skb_release_data+0x7c/0x80
<4> [<c07074b8>] skb_release_data+0x7c/0x80
<4> [<c0707677>] __kfree_skb+0x17/0x74
<4> [<c070772c>] consume_skb+0x58/0x5c
<4> [<c0709866>] skb_free_datagram+0x12/0x1c
<4> [<c072803d>] netlink_recvmsg+0x140/0x25e
<4> [<c0700089>] __sock_recvmsg+0x63/0x6d
<4> [<c070021f>] sock_recvmsg+0x9b/0xb00 ? need_resched+0x19/0x23
0 EDX: c07074b8
<4>ESI: ec44a400 EDI: f4402500 EBP: ec431cac ESP: ec431ca8
08c97>] ? verify_iovec+0x43/0x78
<4> [<c07006ek.ti=ec430000)
<0>Stack:
<4> 00000286 ec431cb8 c04c8d34 0000008b ec431cd4 c04cb66a c07074b8 ec431cd4
<4> [<c04d4cc2>] ? fget_light+0x2f/0x5c
<4> [<c0702072>] sys_recvmsg+0x30ec431d0c c0709866
irqs_on_thunk+0xc/0x10
+0x70/0xd5
<4> [<c07074b8>] ? skb_release_data+0x7c/0x80
snd_usb_audio snd_usbmidi_lib snd_rawmidi nfcomm sco bnep l2cap coretemp cpufreq_ondemand acpi_cpufreq mperf ip6t_REJECT nf_conntrack_ipv6 nf_defrag_ipv6 ip6table_filter ip6_tables ipv6 uinput arc4 snd_hda_codec_conexant ecb snd_hda_intel iwlagn snd_hda_codec iwlcore mac80211 snd_hwdep snd_seq snd_seq_device snd_pcm snd_timer snd_page_alloc uvcvideo btusb cfg80211 bluetooth thinkpad_acpi i2c_i801 videodev iTCO_wdt snd e1000e iTCO_vendor_support v4l1_compat pcspkr rfkill wmi soundcore joydev microcode sdhci_pci sdhci firewire_ohci mmc_core firewire_core yenta_socket crc_itu_t i915 drm_kms_helper drm i2c_algo_bit i2c_core video output [last unloaded: scsi_wait_scan]
<4>Modules linked in: snd_usb_audio snd_usbmidi_lib snd_ra_cpufreq mperf ip6t_REJECT nf_conntrack_ipv6 nf_defrag_ipv6 ip6table_filter ip6_tables ipv6 uinput arc4 snd_hda_codec_conexant ecb snd_hda_intel iwlagn snd_hda_codec iwlcore mac80211 snd_hwdep snd_seq snd_seq_device snd_pcm snd_timer snd_page_alloc uvcvideo btusb cfg80211 bluetooth thinkpad_acpi i2c_i801 videodev iTCO_wdt snd e1000e iTCO_vendor_support v4l1_compat pcspkr rfkill wmi soundcore joydev microcode sdhci_pci sdhci firewire_ohci mmc_core firewire_core yenta_socket crc_itu_t i915 drm_kms_helper drm i2c_algo_bit i2c_core video output [last unloaded: scsi_wait_scan]
<4>
<4>Pid: 2478, comm: udevd Not tainted 2.6.37 #3 406227U/406227U
<4>EIP: 0060:[<c04c8d0c>] EFLAGS: 00000286 CPU: 0
eed_resched+0x19/0x23
<4> [<c042aa2e>] ?
<4>ESI: ec44a400 EDI: f4402500 EBP: ec431cac ESP: ec431ca8
08c97>] ? verify_iovec+0x43/0x78
<4> [<c07006e2>] __sys_recvmsg+0x105/0x19c
0286 ec431cb8 c04c8d34 0000008b ec431c01b61>] ? sys_sendto+0x120/0x142
c0 ec431cf0
<4> c0707677 f177d200 ec431d00 c070772c f177d200 f3f120e4 ec431d0c c0709866
irqs_on_thunb66a>] ? kfree+0x70/0xd5
: udevd/2478/0x10010100
<4>Modules linked infigfs sit tunnel4 fuse aes_i586 aes_generic rfcomm sco bnep l2cap coretemp cpufreq_ondemand acpi_cpufreq mperf ip6t_REJECT nf_conntrack_ipv6 nf_defrag_ipv6 ip6table_filter ip6_tables ipv6 uinput arc4 snd_hda_codec_conexant ecb snd_hda_intel iwlagn snd_hda_codec iwlcore mac80211 snd_hwdep snd_seq snd_seq_device snd_pcm snd_timer snd_page_alloc uvcvideo btusb cfg80211 bluetooth thinkpad_acpi i2c_i801 videodev iTCO_wdt snd e1000e iTCO_vendor_support v4l1_compat pcspkr rfkill wmi soundcore joydev microcode sdhci_pci sdhci firewire_ohci mmc_core firewire_core yenta_socket crc_itu_t i915 drm_kms_helper drm i2c_algo_bit i2c_core video output [last unloaded: scsi_wait_scan]
<4>Modules linked in: snd_usb_audio snd_usbmidi_lib snd_rank+0xc/0x10
<4> [<c040335f>] ? sysenter_do_call+0x12/0x2d
<0>Code: 00 00 8d 65 f4 89 d0 5b 5e 5f 5d c3 90 90 90 55 89 e5 3e 8d 74 26 00 8d 50 ff 83 c8 ff c1 ea 0b 40 d1 ea 75 fb 5d c3 55 89 e5 9c <58> 8d 74 26 00 5d c3 55 89 e5 50 9d 8d 74 26 00 5d c3 55 89 e5 
<4>Call Trace:
<4> [<c04c8d34>] arch_local_irq_save+0xb/0x18
<4> [<c04cb66a>] kfree+0x70/0xd5
<4> [<c07074b8>] ? skb_release_data+0x7c/0x80
<4> [<c07074b8>] skb_release_data+0x7c/0x80
<4> [<c0707677>] __kfree_skb+0x17/0x74
<4> [<c070772c>] consume_skb+0x58/0x5c
<4> [<c0709866>] skb_free_datagram+0x12/0x1c
<4> [<c072803d>] netlink_recvmsg+0x140/0x25e
<4> [<c0700089>] __sock_recvmsg+0x63/0x6d
<4> [<c070021f>] sock_recvmsg+0x9b/0xb00 ? need_resched+0x19/0x23
0 EDX: c07074b8
<4>ESI: ec44a400 EDI: f4402500 EBP: ec431cac ESP: ec431ca8
08c97>] ? verify_iovec+0x43/0x78
<4> [<c07006ek.ti=ec430000)
<0>Stack:
<4> 00000286 ec431cb8 c04c8d34 0000008b ec431cd4 c04cb66a c07074b8 ec431cd4
<4> [<c04d4cc2>] ? fget_light+0x2f/0x5c
<4> [<c0702072>] sys_recvmsg+0x30ec431d0c c0709866
irqs_on_thunk+0xc/0x10
+0x70/0xd5
<4> [<c07074b8>] ? skb_release_data+0x7c/0x80
snd_usb_audio snd_usbmidi_lib snd_rawmidi nq mperf ip6t_REJECT nf_conntrack_ipv6 nf_defrag_ipv6 ip6table_filter ip6_tables ipv6 uinput arc4 snd_hda_codec_conexant ecb snd_hda_intel iwlagn snd_hda_codec iwlcore mac80211 snd_hwdep snd_seq snd_seq_device snd_pcm snd_timer snd_page_alloc uvcvideo btusb cfg80211 bluetooth thinkpad_acpi i2c_i801 videodev iTCO_wdt snd e1000e iTCO_vendor_support v4l1_compat pcspkr rfkill wmi soundcore joydev microcode sdhci_pci sdhci firewire_ohci mmc_core firewire_core yenta_socket crc_itu_t i915 drm_kms_helper drm i2c_algo_bit i2c_core video output [last unloaded: scsi_wait_scan]
<4>Modules linked in: snd_usb_audio snd_usbmidi_lib snd_rawmidi netconsole configfs sit tunnel4 fuse aes_i586 aes_ge<0>Code: 00 00 8d 65 f4 89 d0 5b 5e 5f 5d c3 90 90 90 55 89 e5 3e 8d 74 26 00 8d 50 ff 83 c8 ff c1 ea 0b 40 d1 ea 75 fb 5d c3 55 89 e5 9c <58> 8d 74 26 00 5d c3 55 89 e5 50 9d 8d 74 26 00 5d c3 55 89 e5 
<4>Call Trace:
<4> [<c04c8d34>] arch_local_irq_save+0xb/0x18
<4> [<c04cb66a>] kfree+0x70/0xd5
<4> [<c07074b8>] ? skb_release_data+0x7c/0x80
<4> [<c07074b8>] skb_release_data+0x7c/0x80
<4> [<c0707677>] __kfree_skb+0x17/0x74
<4> [<c070772c>] consume_skb+0x58/0x5c
<4> [<c0709866>] skb_free_datagram+0x12/0x1c
<4> [<c072803d>] netlink_recvmsg+0x140/0x25e
<4> [<c0700089>] __sock_recvmsg+0x63/0x6d
<4> [<c070021f>] sock_recvmsg+0x9b/0xb00
eed_resched+0x19/0x23
<4> [<c042aa2e>] ?
<4>ESI: ec44a400 EDI: f4402500 EBP: ec431cac ESP: ec431ca8
08c97>] ? verify_iovec+0x43/0x78
<4> [<c07006ek.ti=ec430000)
<0>Stack:
<4> 00000286 ec431cb8 c04c8d34 0000008b ec431cd4 c04cb66a c07074b8 ec431cd4
<4> [<c04d4cc2>] ? fget_light+0x2f/0x5c
<4> [<c0702072>] sys_recvmsg+0x30/0x48
c0709866
<0>Call Trace:
<4> [<c04c8d34>] c040335f>] sysenter_do_call+0x12/0x2d
ta+0x7c/0x80
<4> [<c07074b8>] ? skb_release_data+0x7wmidi nfcomm sco bnep l2cap coretemp cpufreq_ondemand acpi_cpufreq mperf ip6t_REJECT nf_conntrack_ipv6 nf_defrag_ipv6 ip6table_filter ip6_tables ipv6 uinput arc4 snd_hda_codec_conexant ecb snd_hda_intel iwlagn snd_hda_codec iwlcore mac80211 snd_hwdep snd_seq snd_seq_device snd_pcm snd_timer snd_page_alloc uvcvideo btusb cfg80211 bluetooth thinkpad_acpi i2c_i801 videodev iTCO_wdt snd e1000e iTCO_vendor_support v4l1_compat pcspkr rfkill wmi soundcore joydev microcode sdhci_pci sdhci firewire_ohci mmc_core firewire_core yenta_socket crc_itu_t i915 drm_kms_helper drm i2c_algo_bit i2c_core video output [last unloaded: scsi_wait_scan]
<4>Modules linked in: snd_usb_audio snd_usbmidi_lib snd_rank+0xc/0x10
<4> [<c040335f>] ? sysenter_do_call+0x12/0x2d
<0>Code: 00 00 8d 65 f4 89 d0 5b 5e 5f 5d c3 90 90 90 55 89 e5 3e 8d 74 26 00 8d 50 ff 83 c8 ff c1 ea 0b 40 d1 ea 75 fb 5d c3 55 89 e5 9c <58> 8d 74 26 00 5d c3 55 89 e5 50 9d 8d 74 26 00 5d c3 55 89 e5 
<4>Call Trace:
<4> [<c04c8d34>] arch_local_irq_save+0xb/0x18
<4> [<c04cb66a>] kfree+0x70/0xd5
<4> [<c07074b8>] ? skb_release_data+0x7c/0x80
<4> [<c07074b8>] skb_release_data+0x7c/0x80
<4> [<c0707677>] __kfree_skb+0x17/0x74
<4> [<c070772c>] consume_skb+0x58/0x5c
<4> [<c0709866>] skb_free_datagram+0x12/0x1c
<4> [<c072803d>] netlink_recvmsg+0x140/0x25e
<4> [<c0700089>] __sock_recvmsg+0x63/0x6d
<4> [<c070021f>] sock_recvmsg+0x9b/0xb00 ? need_resched+0x19/0x23
0 EDX: c07074b8
<4>ESI: ec44a400 EDI: f41>] ? copy_from_user+0xd/0xf
<4> [<c0708c97>] ? verify_iovec+0x43/0x78
724c80 task.ti=ec430000)
<0>Stack:
<4> 00000286 ec431cb8 c04c8d34 0000008b ec431cd4 c04cb66a c07074b8 ec431cd4
<4> [<c04d4cc2>] ? fget_light+0x2f/0x5c
<4> [<c0702072>] sys_recvmsg+0x30ec431d0c c0709866
irqs_on_thunb66a>] ? kfree+0x70/0xd5
: udevd/2478/0x10010100
<4>Modules linked infigfs sit tunnel4 fuse aes_i586 aes_generic rfcomm sco bnep l2cap coretemp cpufreq_ondemand acpi_cpufreq mperf ip6t_REJECT nf_conntrack_ipv6 nf_defrag_ipv6 ip6table_filter ip6_tables ipv6 uinput arc4 snd_hda_codec_conexant ecb snd_hda_intel iwlagn snd_hda_codec iwlcore mac80211 snd_hwdep snd_seq snd_seq_device snd_pcm snd_timer snd_page_alloc uvcvideo btusb cfg80211 bluetooth thinkpad_acpi i2c_i801 videodev iTCO_wdt snd e1000e iTCO_vendor_support v4l1_compat pcspkr rfkill wmi soundcore joydev microcode sdhci_pci sdhci firewire_ohci mmc_core firewire_core yenta_socket crc_itu_t i915 drm_kms_helper drm i2c_algo_bit i2c_core video output [last unloaded: scsi_wait_scan]
<4>Modules linked in: snd_usb_audio snd_usbmidi_lib snd_ra_cpufreq mperf ip6t_REJECT nf_conntrack_ipv6 nf_defrag_ipv6 ip6table_filter ip6_tables ipv6 uinput arc4 snd_hda_codec_conexant ecb snd_hda_intel iwlagn snd_hda_codec iwlcore mac80211 snd_hwdep snd_seq snd_seq_device snd_pcm snd_timer snd_page_alloc uvcvideo btusb cfg80211 bluetooth thinkpad_acpi i2c_i801 videodev iTCO_wdt snd e1000e iTCO_vendor_support v4l1_compat pcspkr rfkill wmi soundcore joydev microcode sdhci_pci sdhci firewire_ohci mmc_core firewire_core yenta_socket crc_itu_t i915 drm_kms_helper drm i2c_algo_bit i2c_core video output [last unloaded: scsi_wait_scan]
<4>
<4>Pid: 2478, comm: udevd Not tainted 2.6.37 #3 406227U/406227U
<4>EIP: 0060:[<c04c8d0c>] EFLAGS: 00000286 CPU: 0
eed_resched+0x19/0x23
<4> [<c042aa2e>] ?
<4>ESI: ec44a400 EDI: f4402500 EBP: ec431cac ESP: ec431ca8
08c97>] ? verify_iovec+0x43/0x78
<4> [<c07006ek.ti=ec430000)
<0>Stack:
<4> 00000286 ec431cb8 c04c8d34 0000008b ec431cd4 c04cb66a c07074b8 ec431cd4
<4> [<c04d4cc2>] ? fget_light+0x2f/0x5c
<4> [<c0702072>] sys_recvmsg+0x30ec431d0c c0709866
irqs_on_thunk+0xc/0x10
+0x70/0xd5
<4> [<c07074b8>] ? skb_releaseModules linked infigfs sit tunnel4 fuse aes_i586 aes_generic rfcomm sco bnep l2cap coretemp cpufreq_ondemand acpi_cpufreq mperf ip6t_REJECT nf_conntrack_ipv6 nf_defrag_ipv6 ip6table_filter ip6_tables ipv6 uinput arc4 snd_hda_codec_conexant ecb snd_hda_intel iwlagn snd_hda_codec iwlcore mac80211 snd_hwdep snd_seq snd_seq_device snd_pcm snd_timer snd_page_alloc uvcvideo btusb cfg80211 bluetooth thinkpad_acpi i2c_i801 videodev iTCO_wdt snd e1000e iTCO_vendor_support v4l1_compat pcspkr rfkill wmi soundcore joydev microcode sdhci_pci sdhci firewire_ohci mmc_core firewire_core yenta_socket crc_itu_t i915 drm_kms_helper drm i2c_algo_bit i2c_core video output [last unloaded: scsi_wait_scan]
<4>Modules linked in: snd_usb_audio snd_usbmidi_lib snd_ra_cpufreq mperf ip6t_REJECT nf_conntrack_ipv6 nf_defrag_ipv6 ip6table_filter ip6_tables ipv6 uinput arc4 snd_hda_codec_conexant ecb snd_hda_intel iwlagn snd_hda_codec iwlcore mac80211 snd_hwdep snd_seq snd_seq_device snd_pcm snd_timer snd_page_alloc uvcvideo btusb cfg80211 bluetooth thinkpad_acpi i2c_i801 videodev iTCO_wdt snd e1000e iTCO_vendor_support v4l1_compat pcspkr rfkill wmi soundcore joydev microcode sdhci_pci sdhci firewire_ohci mmc_core firewire_core yenta_socket crc_itu_t i915 drm_kms_helper drm i2c_algo_bit i2c_core video output [last unloaded: scsi_wait_scan]
<4>
<4>Pid: 2478, comm: udevd Not tainted 2.6.37 #3 406227U/406227U
<4>EIP: 0060:[<c04c8d0c>] EFLAGS: 00000286 CPU: ] ? need_resched+0x19/0x23
0 EDX: c07074b8
<4>ESI: ec44a400 EDI: f41>] ? copy_from_user+0xd/0xf
<4> [<c0708c97>] ? verify_iovec+0x43/0x78
724c80 task.ti=ec430000)
<0>Stack:
<4> 0? sockfd_lookup_light+0x1b/0x48
<4> [<c0701b61>] ? sys_sendto+0x120/0x142
c0 ec431cf0
<4> c0707677 f177d200 ec431d00 c070772c f177d200 f3f120e4 ec431d0c c0709866
irqs_on_thunb66a>] ? kfree+0x70/0xd5
: udevd/2478/0x10010100
<4>Modules linked i_REJECT nf_conntrack_ipv6 nf_defrag_ipv6 ip6table_filter ip6_tables ipv6 uinput arc4 snd_hda_codec_conexant ecb snd_hda_intel iwlagn snd_hda_codec iwlcore mac80211 snd_hwdep snd_seq snd_seq_device snd_pcm snd_timer snd_page_alloc uvcvideo btusb cfg80211 bluetooth thinkpad_acpi i2c_i801 videodev iTCO_wdt snd e1000e iTCO_vendor_support v4l1_compat pcspkr rfkill wmi soundcore joydev microcode sdhci_pci sdhci firewire_ohci mmc_core firewire_core yenta_socket crc_itu_t i915 drm_kms_helper drm i2c_algo_bit i2c_core video output [last unloaded: scsi_wait_scan]
<4>Modules linked in: snd_usb_audio snd_usbmidi_lib snd_rawmidi netconsole configfs sit tunnel4 fuse aes_i586 aes_generic rfcomm sco bnep l2cap coretemp cpufreq_ondemand acpic_conexant ecb snd_hda_intel iwlagn snd_hda_codec iwlcore mac80211 snd_hwdep snd_seq snd_seq_device snd_pcm snd_timer snd_page_alloc uvcvideo btusb cfg80211 bluetooth thinkpad_acpi i2c_i801 videodev iTCO_wdt snd e1000e iTCO_vendor_support v4l1_compat pcspkr rfkill wmi soundcore joydev microcode sdhci_pci sdhci firewire_ohci mmc_core firewire_core yenta_socket crc_itu_t i915 drm_kms_helper drm i2c_algo_bit i2c_core video output [last unloaded: scsi_wait_scan]
<4>
<4>Pid: 2478, comm: udevd Not tainted 2.6.37 #3 406227U/406227U
<4>EIP: 0060:[<c04c8d0c>] EFLAGS: 00000286 CPU: 0
eed_resched+0x19/0x23
<4> [<c042aa2e>] ?
<4>ESI: ec44a400 EDI: f4402500 EBP: ec431cac ESP: ec431ca8
08c97>] ? verify_iovec+0x43/0x78
<4> [<c07006e2>] __sys_recvmsg+0x105/0x19c
0286 ec431cb8 c04c8d34 0000008b ec431c01b61>] ? sys_sendto+0x120/0x142
c0 ec431cf0
<4> c0707677 f177d200 ec4s_socketcall+0x177/0x1a8
<4> [<c05b25e0>] ? trace_hardirqs_on_thunk+0xc/0x10
+0x70/0xd5
<4> [<c07074b8>] ? skb_release_data+0x7c/0x80
snd_usb_audio snd_usbmidi_lib snd_rawmidi nq mperf ip6t_REJECT nf_conntrack_ipv6 nf_defrag_ipv6 ip6table_filter ip6_tables ipv6 uinput arc4 snd_hda_codec_conexant ecb snd_hda_intel iwlagn snd_hda_codec iwlcore mac80211 snd_hwdep snd_seq snd_seq_device snd_pcm snd_timer snd_page_alloc uvcvideo btusb cfg80211 bluetooth thinkpad_acpi i2c_i801 videodev iTCO_wdt snd e1000e iTCO_vendor_support v4l1_compat pcspkr rfkill wmi soundcore joydev microcode sdhci_pci sdhci firewire_ohci mmc_core firewire_core yenta_socket crc_itu_t i915 drm_kms_helper drm i2c_algo_bit i2c_core video output [last unloaded: scsi_wait_scan]
<4>Modules linked in: snd_usb_audio snd_usbmidi_lib snd_rawmidi netconsole configfs sit tunnel4 fuse aes_i586 aes_ge<0>Code: 00 00 8d 65 f4 89 d0 5b 5e 5f 5d c3 90 90 90 55 89 e5 3e 8d 74 26 00 8d 50 ff 83 c8 ff c1 ea 0b 40 d1 ea 75 fb 5d c3 55 89 e5 9c <58> 8d 74 26 00 5d c3 55 89 e5 50 9d 8d 74 26 00 5d c3 55 89 e5 
<4>Call Trace:
<4> [<c04c8d34>] arch_local_irq_save+0xb/0x18
<4> [<c04cb66a>] kfree+0x70/0xd5
<4> [<c07074b8>] ? skb_release_data+0x7c/0x80
<4> [<c07074b8>] skb_release_data+0x7c/0x80
<4> [<c0707677>] __kfree_skb+0x17/0x74
<4> [<c070772c>] consume_skb+0x58/0x5c
<4> [<c0709866>] skb_free_datagram+0x12/0x1c
<4> [<c072803d>] netlink_recvmsg+0x140/0x25e
<4> [<c0700089>] __sock_recvmsg+0x63/0x6d
<4> [<c070021f>] sock_recvmsg+0x9b/0xb00 ? need_resched+0x19/0x23
0 EDX: c07074b8
<4>ESI: ec44a400 EDI: f4402500 EBP: ec431cac ESP: ec431ca8
08c97>] ? verify_iovec+0x43/0x78
<4> [<c07006ek.ti=ec430000)
<0>Stack:
<4> 00000286 ec431cb8 c04c8d34 0000008b ec431cd4 c04cb66a c07074b8 ec431cd4
<4> [<c04d4cc2>] ? fget_light+0x2f/0x5c
<4> [<c0702072>] sys_recvmsg+0x30ec431d0c c0709866
irqs_on_thunk+0xc/0x10
+0x70/0xd5
<4> [<c07074b8>] ? skb_release_data+0x7c/0x80
snd_usb_audio snd_usbmidi_lib snd_rawmidi nam+0x12/0x1c
<4> [<c072803d>] ? netlink_recvmsg+0x140/0x25e
<4> [<c0700089>] ? __sock_recvmsg+0x63/0x6d
<4> [<c070021f>] ? sock_recvmsg+0x9b/0xb0
<4> [<c070030e>] ? sock_sendmsg+0x98/0xac
<4> [<c042aa17>] ? need_resched+0x19/0x23
<4> [<c042aa2e>] ? should_resched+0xd/0x28
<4> [<c05b2a6e>] ? _copy_from_user+0x3e/0x52
<4> [<c0708961>] ? copy_from_user+0xd/0xf
<4> [<c0708c97>] ? verify_iovec+0x43/0x78
<4> [<c07006e2>] ? __sys_recvmsg+0x105/0x19c
oydev microcode sdhci_pci sdhci firewire_ohci mmc_core firewire_core yenta_socket crc_itu_t i915 drm_kms_helper drm i2c_algo_bit i2c_core video output [last unloaded: scsi_wait_scan]
<4>Modules linked in: snd_usb_audio snd_usbmidi_lib snd_rank+0xc/0x10
<4> [<c040335f>] ? sysenter_do_call+0x12/0x2d
<0>Code: 00 00 8d 65 f4 89 d0 5b 5e 5f 5d c3 90 90 90 55 89 e5 3e 8d 74 26 00 8d 50 ff 83 c8 ff c1 ea 0b 40 d1 ea 75 fb 5d c3 55 89 e5 9c <58> 8d 74 26 00 5d c3 55 89 e5 50 9d 8d 74 26 00 5d c3 55 89 e5 
<4>Call Trace:
<4> [<c04c8d34>] arch_local_irq_save+0xb/0x18
<4> [<c04cb66a>] kfree+0x70/0xd5
<4> [<c07074b8>] ? skb_release_data+0x7c/0x80
<4> [<c07074b8>] skb_release_data+0x7c/0x80
<4> [<c0707677>] __kfree_skb+0x17/0x74
<4> [<c070772c>] consume_skb+0x58/0x5c
<4> [<c0709866>] skb_free_datagram+0x12/0x1c
<4> [<c072803d>] netlink_recvmsg+0x140/0x25e
<4> [<c0700089>] __sock_recvmsg+0x63/0x6d
<4> [<c070021f>] sock_recvmsg+0x9b/0xb00 ? need_resched+0x19/0x23
0 EDX: c07074b8
<4>ESI: ec44a400 EDI: f41>] ? copy_from_user+0xd/0xf
<4> [<c0708c97>] ? verify_iovec+0x43/0x78
724c80 task.ti=ec430000)
<0>Stack:
<4> 00000286 ec431cb8 c04c8d34 0000008b ec431cd4 c04cb66a c07074b8 ec431cd4
<4> [<c04d4cc2>] ? fget_light+0x2f/0x5c
<4> [<c0702072>] sys_recvmsg+0x30/0x48
c0709866
<0>Call Trace:
<4> [<c04c8d34>] c040335f>] sysenter_do_call+0x12/0x2d
ta+0x7c/0x80
<4> [<c07074b8>] ? skb_release_data+0x7c/0x80
onsole configfs sit tunnel4 fuse aes_iecvmsg+0x140/0x25e
<4> [<c0700089>] ? __sock_recvmsg+0x63/0x6d
<4> [<c070021f>] ? sock_recvmsg+0x9b/0xb0
<4> [<c070030e>] ? sock_sendmsg+0x98/0xac
<4> [<c042aa17>] ? need_resched+0x19/0x23
<4> [<c042aa2e>] ? should_resched+0xd/0x28
<4> [<c05b2a6e>] ? _copy_from_user+0x3e/0x52
<4> [<c0708961>] ? copy_from_user+0xd/0xf
<4> [<c0708c97>] ? verify_iovec+0x43/0x78
<4> [<c07006e2>] ? __sys_recvmsg+0x105/0x19c
<4> [<c0700184>] ? sock_recvmsg+0x0/0xb0
<4> [<c07007a7>] ? sockfd_lookup_light+0x1b/0x48
<4> [<c0701b61>] ? sys_sendto+0x120/0x142
<4> [<c04d4cc2>] ? fget_light+0x2f/0x5c
<4> [<c0702072>] ? sys_recvmsg+0x30/0x48
<4> [<c07023eb>] ? sys_sockeneric rfcomm sco b65 f4 89 d0 5b 5e 5f 5d c3 90 90 90 55 89 e5 3e 8d 74 26 00 8d 50 ff 83 c8 ff c1 ea 0b 40 d1 ea 75 fb 5d c3 55 89 e5 9c <58> 8d 74 26 00 5d c3 55 89 e5 50 9d 8d 74 26 00 5d c3 55 89 e5 
<4>Call Trace:
<4> [<c04c8d34>] arch_local_irq_save+0xb/0x18
<4> [<c04cb66a>] kfree+0x70/0xd5
<4> [<c07074b8>] ? skb_release_data+0x7c/0x80
<4> [<c07074b8>] skb_release_data+0x7c/0x80
<4> [<c0707677>] __kfree_skb+0x17/0x74
<4> [<c070772c>] consume_skb+0x58/0x5c
<4> [<c0709866>] skb_free_datagram+0x12/0x1c
<4> [<c072803d>] netlink_recvmsg+0x140/0x25e
<4> [<c0700089>] __sock_recvmsg+0x63/0x6d
<4> [<c070021f>] sock_recvmsg+0x9b/0xb00
eed_resched+0x19/0x23
<4> [<c042aa2e>] ?
<4>ESI: ec44a400 EDI: f4402500 EBP: ec431cac ESP: ec431ca8
08c97>] ? verify_iovec+0x43/0x78
<4> [<c07006e2>] __sys_recvmsg+0x105/0x19c
0286 ec431cb8 c04c8d34 0000008b ec431c01b61>] ? sys_sendto+0x120/0x142
c0 ec431cf0
<4> c0707677 f177d200 ec431d00 c070772c f177d200 f3f120e4 ec431d0c c0709866
irqs_on_thunk+0xc/0x10
+0x70/0xd5
<4> [<c07074b8>] ? skb_release_data+0x7c/0x80
snd_usb_audio snd_usbmidi_lib snd_rawmidi nfcomm sco bnep l2cap coretemp cpufreq_ondemand acpi_cpufreq mperf ip6t_REJECT nf_conntrack_ipv6 nf_defrag_ipv6 ip6table_filter ip6_tables ipv6 uinput arc4 snd_hda_codec_conexant ecb snd_hda_intel iwlagn snd_hda_codec iwlcore mac80211 snd_hwdep snd_seq snd_seq_device snd_pcm snd_timer snd_page_alloc uvcvideo btusb cfg80211 bluetooth thinkpad_acpi i2c_i801 videodev iTCO_wdt snd e1000e iTCO_vendor_support v4l1_compat pcspkr rfkill wmi soundcore joydev microcode sdhci_pci sdhci firewire_ohci mmc_core firewire_core yenta_socket crc_itu_t i915 drm_kms_helper drm i2c_algo_bit i2c_core video output [last unloaded: scsi_wait_scan]
<4>Modules linked in: snd_usb_audio snd_usbmidi_lib snd_rank+0xc/0x10
<4> [<c040335f>] ? sysenter_do_call+0x12/0x2d
<0>Code: 00 00 8d 65 f4 89 d0 5b 5e 5f 5d c3 90 90 90 55 89 e5 3e 8d 74 26 00 8d 50 ff 83 c8 ff c1 ea 0b 40 d1 ea 75 fb 5d c3 55 89 e5 9c <58> 8d 74 26 00 5d c3 55 89 e5 50 9d 8d 74 26 00 5d c3 55 89 e5 
<4>Call Trace:
<4> [<c04c8d34>] arch_local_irq_save+0xb/0x18
<4> [<c04cb66a>] kfree+0x70/0xd5
<4> [<c07074b8>] ? skb_release_data+0x7c/0x80
<4> [<c07074b8>] skb_release_data+0x7c/0x80
<4> [<c0707677>] __kfree_skb+0x17/0x74
<4> [<c070772c>] consume_skb+0x58/0x5c
<4> [<c0709866>] skb_free_datagram+0x12/0x1c
<4> [<c072803d>] netlink_recvmsg+0x140/0x25e
<4> [<c0700089>] __sock_recvmsg+0x63/0x6d
<4> [<c070021f>] sock_recvmsg+0x9b/0xb00
eed_resched+0x19/0x23
<4> [<c042aa2e>] ?
<4>ESI: ec44a400 EDI: f4402500 EBP: ec431cac ESP: ec431ca8
08c97>] ? verify_iovec+0x43/0x78
<4> [<c07006e2>] __sys_recvmsg+0x105/0x19c
0286 ec431cb8 c04c8d34 0000008b ec431c01b61>] ? sys_sendto+0x120/0x142
c0 ec431cf0
<4> c0707677 f177d200 ec431d00 c070772c f177d200 f3f120e4 ec431d0c c0709866
irqs_on_thunk+0xc/0x10
+0x70/0xd5
<4> [<c07074b8>] ? skb_release_data+0x7c/0x80
snd_usb_audio snd_usbmidi_lib snd_rawmidi nam+0x12/0x1c
<4> [<c072803d>] ? netlink_recvmsg+0x140/0x25e
<4> [<c0700089>] ? __sock_recvmsg+0x63/0x6d
<4> [<c070021f>] ? sock_recvmsg+0x9b/0xb0
<4> [<c070030e>] ? sock_sendmsg+0x98/0xac
<4> [<c042aa17>] ? need_resched+0x19/0x23
<4> [<c042aa2e>] ? should_resched+0xd/0x28
<4> [<c05b2a6e>] ? _copy_from_user+0x3e/0x52
<4> [<c0708961>] ? copy_from_user+0xd/0xf
<4> [<c0708c97>] ? verify_iovec+0x43/0x78
<4> [<c07006e2>] ? __sys_recvmsg+0x105/0x19c
<4> [<c0700184>] ? sock_recvmsg+0x0/0xb0
<4> [<c07007a7>] ? sockfd_lookup_light+0x1b/0x48
<4> [<c0701b61>] ? sys_sendto+0x120/0x142
<4> [<c04d4cc2>] ? fget_light+0x2f/0x5c
<4> [<c0702072>] ? sys_recvmsg+0x30/0x48
<4> [<c07023eb>] ? sys_socketcall+0x177/0x1a8
 l2cap coretemp cpufreq_ondemand acpi_cpufreq mperf ip6t_REJECT nf_conntrack_ipv6 nf_defrag_ipv6 ip6table_filter ip6_tables ipv6 uinput arc4 snd_hda_codec_conexant ecb snd_hda_intel iwlagn snd_hda_codec iwlcore mac80211 snd_hwdep snd_seq snd_seq_device snd_pcm snd_timer snd_page_alloc uvcvideo btusb cfg80211 bluetooth thinkpad_acpi v4l1_compat pcspkr rfkill wmi soundcore joydev microcode sdhci_pci sdhci firewire_ohci mmc_core firewire_core yenta_socket crc_itu_t i915 drm_kms_helper drm i2c_algo_bit i2c_core video output [last unloaded: scsi_wait_scan]
<4>
<4>Pid: 2478, comm: udevd Not tainted 2.6.37 #3 406227U/406227U
0e>] ? sock_sendmsg+0x98/0xac
<4> [<c042aa17>] 0 EBX: f61cd940 ECX: 00000000 EDX: c07074b8
3e/0x52
<4> [<c0708961>] ? copy_from_user+0xd/0xf
<4> [<c0708c97>] ? verify_iovec+0x43/0x78
724c80 task.ti=ec430000)
<0>Stack:
<4> 00000286 ec431cb8 c04c8d34 0000008b ec431cd4 c04cb66a c07074b8 ec431cd4
<4> [<c04d4cc2>] ? fget_light+0x2f/0x5c
<4> [<c0702072>] sys_recvmsg+0x30ec431d0c c0709866
irqs_on_thunk+0xc/0x10
+0x70/0xd5
<4> [<c07074b8>] ? skb_release_data+0x7c/0x80
snd_usb_audio snd_usbmidi_lib snd_rawmidi nfcomm sco bnep l2cap coretemp cpufreq_ondemand acpi_cpufreq mperf ip6t_REJECT nf_conntrack_ipv6 nf_defrag_ipv6 ip6table_filter ip6_tables ipv6 uinput arc4 snd_hda_codec_conexant ecb snd_hda_intel iwlagn snd_hda_codec iwlcore mac80211 snd_hwdep snd_seq snd_seq_device snd_pcm snd_timer snd_page_alloc uvcvideo btusb cfg80211 bluetooth thinkpad_acpi i2c_i801 videodev iTCO_wdt snd e1000e iTCO_vendor_support v4l1_compat pcspkr rfkill wmi soundcore joydev microcode sdhci_pci sdhci firewire_ohci mmc_core firewire_core yenta_socket crc_itu_t i915 drm_kms_helper drm i2c_algo_bit i2c_core video output [last unloaded: scsi_wait_scan]
<4>Modules linked in: snd_usb_audio snd_usbmidi_lib snd_ra_cpufreq mperf ip6t_REJECT nf_conntrack_ipv6 nf_defrag_ipv6 ip6table_filter ip6_tables ipv6 uinput arc4 snd_hda_codec_conexant ecb snd_hda_intel iwlagn snd_hda_codec iwlcore mac80211 snd_hwdep snd_seq snd_seq_device snd_pcm snd_timer snd_page_alloc uvcvideo btusb cfg80211 bluetooth thinkpad_acpi i2c_i801 videodev iTCO_wdt snd e1000e iTCO_vendor_support v4l1_compat pcspkr rfkill wmi soundcore joydev microcode sdhci_pci sdhci firewire_ohci mmc_core firewire_core yenta_socket crc_itu_t i915 drm_kms_helper drm i2c_algo_bit i2c_core video output [last unloaded: scsi_wait_scan]
<4>
<4>Pid: 2478, comm: udevd Not tainted 2.6.37 #3 406227U/406227U
<4>EIP: 0060:[<c04c8d0c>] EFLAGS: 00000286 CPU: 0
eed_resched+0x19/0x23
<4> [<c042aa2e>] ?
<4>ESI: ec44a400 EDI: f4402500 EBP: ec431cac ESP: ec431ca8
08c97>] ? verify_iovec+0x43/0x78
<4> [<c07006e2>] __sys_recvmsg+0x105/0x19c
0286 ec431cb8 c04c8d34 0000008b ec431c01b61>] ? sys_sendto+0x120/0x142
c0 ec431cf0
<4> c0707677 f177d200 ec431d00 c070772c f177d200 f3f120e4 ec431d0c c0709866
irqs_on_thunb66a>] ? kfree+0x70/0xd5
: udevd/2478/0x10010100
<4>Modules linked infigfs sit tunnel4 fuse aes_i586 aes_generic rfcomm sco bnep l2cap coretemp cpufreq_ondemand acpi_cpufreq mperf ip6t_REJECT nf_conntrack_ipv6 nf_defrag_ipv6 ip6table_filter ip6_tables ipv6 uinput arc4 snd_hda_codec_conexant ecb snd_hda_intel iwlagn snd_hda_codec iwlcore mac80211 snd_hwdep snd_seq snd_seq_device snd_pcm snd_timer snd_page_alloc uvcvideo btusb cfg80211 bluetooth thinkpad_acpi i2c_i801 videodev iTCO_wdt snd e1000e iTCO_vendor_support v4l1_compat pcspkr rfkill wmi soundcore joydev microcode sdhci_pci sdhci firewire_ohci mmc_core firewire_core yenta_socket crc_itu_t i915 drm_kms_helper drm i2c_algo_bit i2c_core video output [last unloaded: scsi_wait_scan]
<4>Modules linked in: snd_usb_audio snd_usbmidi_lib snd_rank+0xc/0x10
<4> [<c040335f>] ? sysenter_do_call+0x12/0x2d
<0>Code: 00 00 8d 65 f4 89 d0 5b 5e 5f 5d c3 90 90 90 55 89 e5 3e 8d 74 26 00 8d 50 ff 83 c8 ff c1 ea 0b 40 d1 ea 75 fb 5d c3 55 89 e5 9c <58> 8d 74 26 00 5d c3 55 89 e5 50 9d 8d 74 26 00 5d c3 55 89 e5 
<4>Call Trace:
<4> [<c04c8d34>] arch_local_irq_save+0xb/0x18
<4> [<c04cb66a>] kfree+0x70/0xd5
<4> [<c07074b8>] ? skb_release_data+0x7c/0x80
<4> [<c07074b8>] skb_release_data+0x7c/0x80
<4> [<c0707677>] __kfree_skb+0x17/0x74
<4> [<c070772c>] consume_skb+0x58/0x5c
<4> [<c0709866>] skb_free_datagram+0x12/0x1c
<4> [<c072803d>] netlink_recvmsg+0x140/0x25e
<4> [<c0700089>] __sock_recvmsg+0x63/0x6d
<4> [<c070021f>] sock_recvmsg+0x9b/0xb00 ? need_resched+0x19/0x23
0 EDX: c07074b8
<4>ESI: ec44a400 EDI: f4402500 EBP: ec431cac ESP: ec431ca8
08c97>] ? verify_iovec+0x43/0x78
<4> [<c07006ek.ti=ec430000)
<0>Stack:
<4> 00000286 ec431cb8 c04c8d34 0000008b ec431cd4 c04cb66a c07074b8 ec431cd4
<4> [<c04d4cc2>] ? fget_light+0x2f/0x5c
<4> [<c0702072>] sys_recvmsg+0x30ec431d0c c0709866
irqs_on_thunk+0xc/0x10
+0x70/0xd5
<4> [<c07074b8>] ? skb_release_data+0x7c/0x80
snd_usb_audio snd_usbmidi_lib snd_rawmidi nam+0x12/0x1c
<4> [<c072803d>] ? netlink_recvmsg+0x140/0x25e
<4> [<c0700089>] ? __sock_recvmsg+0x63/0x6d
<4> [<c070021f>] ? sock_recvmsg+0x9b/0xb0
<4> [<c070030e>] ? sock_sendmsg+0x98/0xac
<4> [<c042aa17>] ? need_resched+0x19/0x23
<4> [<c042aa2e>] ? should_resched+0xd/0x28
<4> [<c05b2a6e>] ? _copy_from_user+0x3e/0x52
<4> [<c0708961>] ? copy_from_user+0xd/0xf
<4> [<c0708c97>] ? verify_iovec+0x43/0x78
<4> [<c07006e2>] ? __sys_recvmsg+0x105/0x19c
<4> [<c0700184>] ? sock_recvmsg+0x0/0xb0
<4> [<c07007a7>] ? sockfd_lookup_light+0x1b/0x48
<4> [<c0701b61>] ? sys_sendto+0x120/0x142
<4> [<c04d4cc2>] ? fget_light+0x2f/0x5c
<4> [<c0702072>] ? sys_recvmsg+0x30/0x48
<4> [<c07023eb>] ? sys_sockeneric rfcomm sco bip6_tables ipv6 uinput arc4 snd_hda_codec_conexant ecb snd_hda_intel iwlagn snd_hda_codec iwlcore mac80211 snd_hwdep snd_seq snd_seq_device snd_pcm snd_timer snd_page_alloc uvcvideo btusb cfg80211 bluetooth thinkpad_acpi i2c_i801 videodev iTCO_wdt snd e1000e iTCO_vendor_support v4l1_compat pcspkr rfkill wmi soundcore joydev microcode sdhci_pci sdhci firewire_ohci mmc_core firewire_core yenta_socket crc_itu_t i915 drm_kms_helper drm i2c_algo_bit i2c_core video output [last unloaded: scsi_wait_scan]
<4>
<4>Pid: 2478, comm: udevd Not tainted 2.6.37 #3 406227U/406227U
<4>EIP: 0060:[<c04c8d0c>] EFLAGS: 00000286 CPU: 0
eed_resched+0x19/0x23
<4> [<c042aa2e>] ?
<4>ESI: ec44a400 EDI: f4402500 EBP: ec431cac ESP: ec431ca8
08c97>] ? verify_iovec+0x43/0x78
<4> [<c07006ek.ti=ec430000)
<0>Stack:
<4> 00000286 ec431cb8 c04c8d34 0000008b ec431cd4 c04cb66a c07074b8 ec431cd4
<4> [<c04d4cc2>] ? fget_light+0x2f/0x5c
<4> [<c0702072>] sys_recvmsg+0x30/0x48
c0709866
<0>Call Trace:
<4> [<c04c8d34>] c040335f>] sysenter_do_call+0x12/0x2d
ta+0x7c/0x80
<4> [<c07074b8>] ? skb_release_data+0x7wmidi nam+0x12/0x1c
<4> [<c072803d>] ? netlink_recvmsg+0x140/0x25e
<4> [<c0700089>] ? __sock_recvmsg+0x63/0x6d
<4> [<c070021f>] ? sock_recvmsg+0x9b/0xb0
<4> [<c070030e>] ? sock_sendmsg+0x98/0xac
<4> [<c042aa17>] ? need_resched+0x19/0x23
<4> [<c042aa2e>] ? should_resched+0xd/0x28
<4> [<c05b2a6e>] ? _copy_from_user+0x3e/0x52
<4> [<c0708961>] ? copy_from_user+0xd/0xf
<4> [<c0708c97>] ? verify_iovec+0x43/0x78
<4> [<c07006e2>] ? __sys_recvmsg+0x105/0x19c
<4> [<c0700184>] ? sock_recvmsg+0x0/0xb0
<4> [<c07007a7>] ? sockfd_lookup_light+0x1b/0x48
<4> [<c0701b61>] ? sys_sendto+0x120/0x142
<4> [<c04d4cc2>] ? fget_light+0x2f/0x5c
<4> [<c0702072>] ? sys_recvmsg+0x30/0x48
<4> [<c07023eb>] ? sys_socketcall+0x177/0x1a8
 l2cap coretemp cpufreq_ondemand acpi_cpufreq mpe4 26 00 8d 50 ff 83 c8 ff c1 ea 0b 40 d1 ea 75 fb 5d c3 55 89 e5 9c <58> 8d 74 26 00 5d c3 55 89 e5 50 9d 8d 74 26 00 5d c3 55 89 e5 
<4>Call Trace:
<4> [<c04c8d34>] arch_local_irq_save+0xb/0x18
<4> [<c04cb66a>] kfree+0x70/0xd5
<4> [<c07074b8>] ? skb_release_data+0x7c/0x80
<4> [<c07074b8>] skb_release_data+0x7c/0x80
<4> [<c0707677>] __kfree_skb+0x17/0x74
<4> [<c070772c>] consume_skb+0x58/0x5c
<4> [<c0709866>] skb_free_datagram+0x12/0x1c
<4> [<c072803d>] netlink_recvmsg+0x140/0x25e
<4> [<c0700089>] __sock_recvmsg+0x63/0x6d
<4> [<c070021f>] sock_recvmsg+0x9b/0xb00 ? need_resched+0x19/0x23
0 EDX: c07074b8
<4>ESI: ec44a400 EDI: f4402500 EBP: ec431cac ESP: ec431ca8
08c97>] ? verify_iovec+0x43/0x78
<4> [<c07006ek.ti=ec430000)
<0>Stack:
<4> 00000286 ec431cb8 c04c8d34 0000008b ec431cd4 c04cb66a c07074b8 ec431cd4
<4> [<c04d4cc2>] ? fget_light+0x2f/0x5c
<4> [<c0702072>] sys_recvmsg+0x30/0x48
c0709866
<0>Call Trace:
<4> [<c04c8d34>] c040335f>] sysenter_do_call+0x12/0x2d
ta+0x7c/0x80
<4> [<c07074b8>] ? skb_release_data+0x7c/0x80
onsole configfs sit tunnel4 fuse aes_iemand acpi_cpufreq mperf ip6t_REJECT nf_conntrack_ipv6 nf_defrag_ipv6 ip6table_filter ip6_tables ipv6 uinput arc4 snd_hda_codec_conexant ecb snd_hda_intel iwlagn snd_hda_codec iwlcore mac80211 snd_hwdep snd_seq snd_seq_device snd_pcm snd_timer snd_page_alloc uvcvideo btusb cfg80211 bluetooth thinkpad_acpi i2c_i801 videodev iTCO_wdt snd e1000e iTCO_vendor_support v4l1_compat pcspkr rfkill wmi soundcore joydev microcode sdhci_pci sdhci firewire_ohci mmc_core firewire_core yenta_socket crc_itu_t i915 drm_kms_helper drm i2c_algo_bit i2c_core video output [last unloaded: scsi_wait_scan]
<4>Modules linked in: snd_usb_audio snd_usbmidi_lib snd_ra_cpufreq mperf ip6t_REJECT nf_conntrack_ipv6 nf_defrag_ipv6 ip6table_filter ip6_tables ipv6 uinput arc4 snd_hda_codec_conexant ecb snd_hda_intel iwlagn snd_hda_codec iwlcore mac80211 snd_hwdep snd_seq snd_seq_device snd_pcm snd_timer snd_page_alloc uvcvideo btusb cfg80211 bluetooth thinkpad_acpi i2c_i801 videodev iTCO_wdt snd e1000e iTCO_vendor_support v4l1_compat pcspkr rfkill wmi soundcore joydev microcode sdhci_pci sdhci firewire_ohci mmc_core firewire_core yenta_socket crc_itu_t i915 drm_kms_helper drm i2c_algo_bit i2c_core video output [last unloaded: scsi_wait_scan]
<4>
<4>Pid: 2478, comm: udevd Not tainted 2.6.37 #3 406227U/406227U
<4>EIP: 0060:[<c04c8d0c>] EFLAGS: 00000286 CPU: 0
eed_resched+0x19/0x23
<4> [<c042aa2e>] ?
<4>ESI: ec44a400 EDI: f4402500 EBP: ec431cac ESP: ec431ca8
08c97>] ? verify_iovec+0x43/0x78
<4> [<c07006ek.ti=ec430000)
<0>Stack:
<4> 00000286 ec431cb8 c04c8d34 0000008b ec431cd4 c04cb66a c07074b8 ec431cd4
<4> [<c04d4cc2>] ? fget_light+0x2f/0x5c
<4> [<c0702072>] sys_recvmsg+0x30/0x48
c0709866
<0>Call Trace:
<4> [<c04c8d34>] c040335f>] sysenter_do_call+0x12/0x2d
ta+0x7c/0x80
<4> [<c07074b8>] ? skb_release_data+0x7c/0x80
onsole configfs sit tunnel4 fuse aes_idefrag_ipv6 ip6table_filter ip6_tables ipv6 uinput arc4 snd_hda_codec_conexant ecb snd_hda_intel iwlagn snd_hda_codec iwlcore mac80211 snd_hwdep snd_seq snd_seq_device snd_pcm snd_timer snd_page_alloc uvcvideo btusb cfg80211 bluetooth thinkpad_acpi i2c_i801 videodev iTCO_wdt snd e1000e iTCO_vendor_support v4l1_compat pcspkr rfkill wmi soundcore joydev microcode sdhci_pci sdhci firewire_ohci mmc_core firewire_core yenta_socket crc_itu_t i915 drm_kms_helper drm i2c_algo_bit i2c_core video output [last unloaded: scsi_wait_scan]
<4>Modules linked in: snd_usb_audio snd_usbmidi_lib snd_rawmidi netconsole configfs sit tunnel4 fuse aes_i586 aes_ge<0>Code: 00 00 8d 65 f4 89 d0 5b 5e 5f 5d c3 90 90 90 55 89 e5 3e 8d 74 26 00 8d 50 ff 83 c8 ff c1 ea 0b 40 d1 ea 75 fb 5d c3 55 89 e5 9c <58> 8d 74 26 00 5d c3 55 89 e5 50 9d 8d 74 26 00 5d c3 55 89 e5 
<4>Call Trace:
<4> [<c04c8d34>] arch_local_irq_save+0xb/0x18
<4> [<c04cb66a>] kfree+0x70/0xd5
<4> [<c07074b8>] ? skb_release_data+0x7c/0x80
<4> [<c07074b8>] skb_release_data+0x7c/0x80
<4> [<c0707677>] __kfree_skb+0x17/0x74
<4> [<c070772c>] consume_skb+0x58/0x5c
<4> [<c0709866>] skb_free_datagram+0x12/0x1c
<4> [<c072803d>] netlink_recvmsg+0x140/0x25e
<4> [<c0700089>] __sock_recvmsg+0x63/0x6d
<4> [<c070021f>] sock_recvmsg+0x9b/0xb00
eed_resched+0x19/0x23
<4> [<c042aa2e>] ?
<4>ESI: ec44a400 EDI: f4402500 EBP: ec431cac ESP: ec431ca8
08c97>] ? verify_iovec+0x43/0x78
<4> [<c07006ek.ti=ec430000)
<0>Stack:
<4> 00000286 ec431cb8 c04c8d34 0000008b ec431cd4 c04cb66a c07074b8 ec431cd4
<4> [<c04d4cc2>] ? fget_light+0x2f/0x5c
<4> [<c0702072>] sys_recvmsg+0x30/0x48
c0709866
<0>Call Trace:
<4> [<c04c8d34>] c040335f>] sysenter_do_call+0x12/0x2d
ta+0x7c/0x80
<4> [<c07074b8>] ? skb_release_data+0x7c/0x80
onsole configfs sit tunnel4 fuse aes_iemand acpi_cpufreq mperf ip6t_REJECT nf_conntrack_ipv6 nf_defrag_ipv6 ip6table_filter ip6_tables ipv6 uinput arc4 snd_hda_codec_conexant ecb snd_hda_intel iwlagn snd_hda_codec iwlcore mac80211 snd_hwdep snd_seq snd_seq_device snd_pcm snd_timer snd_page_alloc uvcvideo btusb cfg80211 bluetooth thinkpad_acpi i2c_i801 videodev iTCO_wdt snd e1000e iTCO_vendor_support v4l1_compat pcspkr rfkill wmi soundcore joydev microcode sdhci_pci sdhci firewire_ohci mmc_core firewire_core yenta_socket crc_itu_t i915 drm_kms_helper drm i2c_algo_bit i2c_core video output [last unloaded: scsi_wait_scan]
<4>Modules linked in: snd_usb_audio snd_usbmidi_lib snd_ra_cpufreq mperf ip6t_REJECT nf_conntrack_ipv6 nf_defrag_ipv6 ip6table_filter ip6_tables ipv6 uinput arc4 snd_hda_codec_conexant ecb snd_hda_intel iwlagn snd_hda_codec iwlcore mac80211 snd_hwdep snd_seq snd_seq_device snd_pcm snd_timer snd_page_alloc uvcvideo btusb cfg80211 bluetooth thinkpad_acpi i2c_i801 videodev iTCO_wdt snd e1000e iTCO_vendor_support v4l1_compat pcspkr rfkill wmi soundcore joydev microcode sdhci_pci sdhci firewire_ohci mmc_core firewire_core yenta_socket crc_itu_t i915 drm_kms_helper drm i2c_algo_bit i2c_core video output [last unloaded: scsi_wait_scan]
<4>
<4>Pid: 2478, comm: udevd Not tainted 2.6.37 #3 406227U/406227U
<4>EIP: 0060:[<c04c8d0c>] EFLAGS: 00000286 CPU: ] ? need_resched+0x19/0x23
0 EDX: c07074b8
<4>ESI: ec44a400 EDI: f41>] ? copy_from_user+0xd/0xf
<4> [<c0708c97>] ? verify_iovec+0x43/0x78
724c80 task.ti=ec430000)
<0>Stack:
<4> 00000286 ec431cb8 c04c8d34 0000008b ec431cd4 c04cb66a c07074b8 ec431cd4
<4> [<c04d4cc2>] ? fget_light+0x2f/0x5c
<4> [<c0702072>] sys_recvmsg+0x30ec431d0c c0709866
irqs_on_thunb66a>] ? kfree+0x70/0xd5
: udevd/2478/0x10010100
<4>Modules linked infigfs sit tunnel4 fuse aes_i586 aes_generic rfcomm sco bnep l2cap coretemp cpufreq_ondemand acpi_cpufreq mperf ip6t_REJECT nf_conntrack_ipv6 nf_defrag_ipv6 ip6table_filter ip6_tables ipv6 uinput arc4 snd_hda_codec_conexant ecb snd_hda_intel iwlagn snd_hda_codec iwlcore mac80211 snd_hwdep snd_seq snd_seq_device snd_pcm snd_timer snd_page_alloc uvcvideo btusb cfg80211 bluetooth thinkpad_acpi i2c_i801 videodev iTCO_wdt snd e1000e iTCO_vendor_support v4l1_compat pcspkr rfkill wmi soundcore joydev microcode sdhci_pci sdhci firewire_ohci mmc_core firewire_core yenta_socket crc_itu_t i915 drm_kms_helper drm i2c_algo_bit i2c_core video output [last unloaded: scsi_wait_scan]
<4>Modules linked in: snd_usb_audio snd_usbmidi_lib snd_rank+0xc/0x10
<4> [<c040335f>] ? sysenter_do_call+0x12/0x2d
<0>Code: 00 00 8d 65 f4 89 d0 5b 5e 5f 5d c3 90 90 90 55 89 e5 3e 8d 74 26 00 8d 50 ff 83 c8 ff c1 ea 0b 40 d1 ea 75 fb 5d c3 55 89 e5 9c <58> 8d 74 26 00 5d c3 55 89 e5 50 9d 8d 74 26 00 5d c3 55 89 e5 
<4>Call Trace:
<4> [<c04c8d34>] arch_local_irq_save+0xb/0x18
<4> [<c04cb66a>] kfree+0x70/0xd5
<4> [<c07074b8>] ? skb_release_data+0x7c/0x80
<4> [<c07074b8>] skb_release_data+0x7c/0x80
<4> [<c0707677>] __kfree_skb+0x17/0x74
<4> [<c070772c>] consume_skb+0x58/0x5c
<4> [<c0709866>] skb_free_datagram+0x12/0x1c
<4> [<c072803d>] netlink_recvmsg+0x140/0x25e
<4> [<c0700089>] __sock_recvmsg+0x63/0x6d
<4> [<c070021f>] sock_recvmsg+0x9b/0xb00 ? need_resched+0x19/0x23
0 EDX: c07074b8
<4>ESI: ec44a400 EDI: f41>] ? copy_from_user+0xd/0xf
<4> [<c0708c97>] ? verify_iovec+0x43/0x78
724c80 task.ti=ec430000)
<0>Stack:
<4> 0? sockfd_lookup_light+0x1b/0x48
<4> [<c0701b61>] ? sys_sendto+0x120/0x142
c0 ec431cf0
<4> c0707677 f177d200 ec431d00 c070772c f177d200 f3f120e4 ec431d0c c0709866
irqs_on_thunb66a>] ? kfree+0x70/0xd5
: udevd/2478/0x10010100
<4>Modules linked iep l2cap coretemp cpufreq_ondemand acpi_cpufreq mperf ip6t_REJECT nf_conntrack_ipv6 nf_defrag_ipv6 ip6table_filter ip6_tables ipv6 uinput arc4 snd_hda_codec_conexant ecb snd_hda_intel iwlagn snd_hda_codec iwlcore mac80211 snd_hwdep snd_seq snd_seq_device snd_pcm snd_timer snd_page_alloc uvcvideo btusb cfg80211 bluetooth thinkpad_acpi i2c_i801 videodev iTCO_wdt snd e1000e iTCO_vendor_support v4l1_compat pcspkr rfkill wmi soundcore joydev microcode sdhci_pci sdhci firewire_ohci mmc_core firewire_core yenta_socket crc_itu_t i915 drm_kms_helper drm i2c_algo_bit i2c_core video output [last unloaded: scsi_wait_scan]
<4>Modules linked in: snd_usb_audio snd_usbmidi_lib snd_rawmidi netconsole configfs sit tunnel4 fuse aes_i586 aes_ge6 ip6table_filter ip6_tables ipv6 uinput arc4 snd_hda_codec_conexant ecb snd_hda_intel iwlagn snd_hda_codec iwlcore mac80211 snd_hwdep snd_seq snd_seq_device snd_pcm snd_timer snd_page_alloc uvcvideo btusb cfg80211 bluetooth thinkpad_acpi i2c_i801 videodev iTCO_wdt snd e1000e iTCO_vendor_support v4l1_compat pcspkr rfkill wmi soundcore joydev microcode sdhci_pci sdhci firewire_ohci mmc_core firewire_core yenta_socket crc_itu_t i915 drm_kms_helper drm i2c_algo_bit i2c_core video output [last unloaded: scsi_wait_scan]
<4>
<4>Pid: 2478, comm: udevd Not tainted 2.6.37 #3 406227U/406227U
<4>EIP: 0060:[<c04c8d0c>] EFLAGS: 00000286 CPU: 0
eed_resched+0x19/0x23
<4> [<c042aa2e>] ? should_resched+0xd/0x28
500 EBP: ec431cac ESP: ec431ca8
<4> DS: 00 ? verify_iovec+0x43/0x78
<4> [<c07006e2>] __sys_recvmsg+0x105/0x19c
0286 ec431cb8 c04c8d34 0000008b ec431c01b61>] ? sys_sendto+0x120/0x142
c0 ec431cf0
<4> c0707677 f177d200 ec4s_socketcall+0x177/0x1a8
<4> [<c05b25e0>] ? trace_hardirqs_on_thunk+0xc/0x10
+0x70/0xd5
<4> [<c07074b8>] ? skb_release_data+0x7c/0x80
snd_usb_audio snd_usbmidi_lib snd_rawmidi nq mperf ip6t_REJECT nf_conntrack_ipv6 nf_defrag_ipv6 ip6table_filter ip6_tables ipv6 uinput arc4 snd_hda_codec_conexant ecb snd_hda_intel iwlagn snd_hda_codec iwlcore mac80211 snd_hwdep snd_seq snd_seq_device snd_pcm snd_timer snd_page_alloc uvcvideo btusb cfg80211 bluetooth thinkpad_acpi i2c_i801 videodev iTCO_wdt snd e1000e iTCO_vendor_support v4l1_compat pcspkr rfkill wmi soundcore joydev microcode sdhci_pci sdhci firewire_ohci mmc_core firewire_core yenta_socket crc_itu_t i915 drm_kms_helper drm i2c_algo_bit i2c_core video output [last unloaded: scsi_wait_scan]
<4>Modules linked in: snd_usb_audio snd_usbmidi_lib snd_rawmidi netconsole configfs sit tunnel4 fuse aes_i586 aes_ge6 ip6table_filter ip6_tables ipv6 uinput arc4 snd_hda_codec_conexant ecb snd_hda_intel iwlagn snd_hda_codec iwlcore mac80211 snd_hwdep snd_seq snd_seq_device snd_pcm snd_timer snd_page_alloc uvcvideo btusb cfg80211 bluetooth thinkpad_acpi i2c_i801 videodev iTCO_wdt snd e1000e iTCO_vendor_support v4l1_compat pcspkr rfkill wmi soundcore joydev microcode sdhci_pci sdhci firewire_ohci mmc_core firewire_core yenta_socket crc_itu_t i915 drm_kms_helper drm i2c_algo_bit i2c_core video output [last unloaded: scsi_wait_scan]
<4>
<4>Pid: 2478, comm: udevd Not tainted 2.6.37 #3 406227U/406227U
<4>EIP: 0060:[<c04c8d0c>] EFLAGS: 00000286 CPU: 0
eed_resched+0x19/0x23
<4> [<c042aa2e>] ?
<4>ESI: ec44a400 EDI: f4402500 EBP: ec431cac ESP: ec431ca8
08c97>] ? verify_iovec+0x43/0x78
<4> [<c07006e2>] __sys_recvmsg+0x105/0x19c
0286 ec431cb8 c04c8d34 0000008b ec431c01b61>] ? sys_sendto+0x120/0x142
c0 ec431cf0
<4> c0707677 f177d200 ec4s_socketcall+0x177/0x1a8
<4> [<c05b25e0>] ? trace_hardirqs_on_thunk+0xc/0x10
+0x70/0xd5
<4> [<c07074b8>] ? skb_release_data+0x7c/0x80
snd_usb_audio snd_usbmidi_lib snd_rawmidi nq mperf ip6t_REJECT nf_conntrack_ipv6 nf_defrag_ipv6 ip6table_filter ip6_tables ipv6 uinput arc4 snd_hda_codec_conexant ecb snd_hda_intel iwlagn snd_hda_codec iwlcore mac80211 snd_hwdep snd_seq snd_seq_device snd_pcm snd_timer snd_page_alloc uvcvideo btusb cfg80211 bluetooth thinkpad_acpi i2c_i801 videodev iTCO_wdt snd e1000e iTCO_vendor_support v4l1_compat pcspkr rfkill wmi soundcore joydev microcode sdhci_pci sdhci firewire_ohci mmc_core firewire_core yenta_socket crc_itu_t i915 drm_kms_helper drm i2c_algo_bit i2c_core video output [last unloaded: scsi_wait_scan]
<4>Modules linked in: snd_usb_audio snd_usbmidi_lib snd_rawmidi netconsole configfs sit tunnel4 fuse aes_i586 aes_ge<0>Code: 00 00 8d 65 f4 89 d0 5b 5e 5f 5d c3 90 90 90 55 89 e5 3e 8d 74 26 00 8d 50 ff 83 c8 ff c1 ea 0b 40 d1 ea 75 fb 5d c3 55 89 e5 9c <58> 8d 74 26 00 5d c3 55 89 e5 50 9d 8d 74 26 00 5d c3 55 89 e5 
<4>Call Trace:
<4> [<c04c8d34>] arch_local_irq_save+0xb/0x18
<4> [<c04cb66a>] kfree+0x70/0xd5
<4> [<c07074b8>] ? skb_release_data+0x7c/0x80
<4> [<c07074b8>] skb_release_data+0x7c/0x80
<4> [<c0707677>] __kfree_skb+0x17/0x74
<4> [<c070772c>] consume_skb+0x58/0x5c
<4> [<c0709866>] skb_free_datagram+0x12/0x1c
<4> [<c072803d>] netlink_recvmsg+0x140/0x25e
<4> [<c0700089>] __sock_recvmsg+0x63/0x6d
<4> [<c070021f>] sock_recvmsg+0x9b/0xb00 ? need_resched+0x19/0x23
0 EDX: c07074b8
<4>ESI: ec44a400 EDI: f41>] ? copy_from_user+0xd/0xf
<4> [<c0708c97>] ? verify_iovec+0x43/0x78
724c80 task.ti=ec430000)
<0>Stack:
<4> 00000286 ec431cb8 c04c8d34 0000008b ec431cd4 c04cb66a c07074b8 ec431cd4
<4> [<c04d4cc2>] ? fget_light+0x2f/0x5c
<4> [<c0702072>] sys_recvmsg+0x30ec431d0c c0709866
irqs_on_thunk+0xc/0x10
+0x70/0xd5
<4> [<c07074b8>] ? skb_releaseModules linked infigfs sit tunnel4 fuse aes_i586 aes_generic rfcomm sco bnep l2cap coretemp cpufreq_ondemand acpi_cpufreq mperf ip6t_REJECT nf_conntrack_ipv6 nf_defrag_ipv6 ip6table_filter ip6_tables ipv6 uinput arc4 snd_hda_codec_conexant ecb snd_hda_intel iwlagn snd_hda_codec iwlcore mac80211 snd_hwdep snd_seq snd_seq_device snd_pcm snd_timer snd_page_alloc uvcvideo btusb cfg80211 bluetooth thinkpad_acpi i2c_i801 videodev iTCO_wdt snd e1000e iTCO_vendor_support v4l1_compat pcspkr rfkill wmi soundcore joydev microcode sdhci_pci sdhci firewire_ohci mmc_core firewire_core yenta_socket crc_itu_t i915 drm_kms_helper drm i2c_algo_bit i2c_core video output [last unloaded: scsi_wait_scan]
<4>Modules linked in: snd_usb_audio snd_usbmidi_lib snd_ra_cpufreq mperf ip6t_REJECT nf_conntrack_ipv6 nf_defrag_ipv6 ip6table_filter ip6_tables ipv6 uinput arc4 snd_hda_codec_conexant ecb snd_hda_intel iwlagn snd_hda_codec iwlcore mac80211 snd_hwdep snd_seq snd_seq_device snd_pcm snd_timer snd_page_alloc uvcvideo btusb cfg80211 bluetooth thinkpad_acpi i2c_i801 videodev iTCO_wdt snd e1000e iTCO_vendor_support v4l1_compat pcspkr rfkill wmi soundcore joydev microcode sdhci_pci sdhci firewire_ohci mmc_core firewire_core yenta_socket crc_itu_t i915 drm_kms_helper drm i2c_algo_bit i2c_core video output [last unloaded: scsi_wait_scan]
<4>
<4>Pid: 2478, comm: udevd Not tainted 2.6.37 #3 406227U/406227U
<4>EIP: 0060:[<c04c8d0c>] EFLAGS: 00000286 CPU: 0
eed_resched+0x19/0x23
<4> [<c042aa2e>] ? should_resched+0xd/0x28
500 EBP: ec431cac ESP: ec431ca8
<4> DS: 00 ? verify_iovec+0x43/0x78
<4> [<c07006e2>] __sys_recvmsg+0x105/0x19c
0286 ec431cb8 c04c8d34 0000008b ec431c01b61>] ? sys_sendto+0x120/0x142
c0 ec431cf0
<4> c0707677 f177d200 ec431d00 c070772c f177d200 f3f120e4 ec431d0c c0709866
irqs_on_thunb66a>] ? kfree+0x70/0xd5
: udevd/2478/0x10010100
<4>Modules linked infigfs sit tunnel4 fuse aes_i586 aes_generic rfcomm sco bnep l2cap coretemp cpufreq_ondemand acpi_cpufreq mperf ip6t_REJECT nf_conntrack_ipv6 nf_defrag_ipv6 ip6table_filter ip6_tables ipv6 uinput arc4 snd_hda_codec_conexant ecb snd_hda_intel iwlagn snd_hda_codec iwlcore mac80211 snd_hwdep snd_seq snd_seq_device snd_pcm snd_timer snd_page_alloc uvcvideo btusb cfg80211 bluetooth thinkpad_acpi i2c_i801 videodev iTCO_wdt snd e1000e iTCO_vendor_support v4l1_compat pcspkr rfkill wmi soundcore joydev microcode sdhci_pci sdhci firewire_ohci mmc_core firewire_core yenta_socket crc_itu_t i915 drm_kms_helper drm i2c_algo_bit i2c_core video output [last unloaded: scsi_wait_scan]
<4>Modules linked in: snd_usb_audio snd_usbmidi_lib snd_ra_cpufreq mperf ip6t_REJECT nf_conntrack_ipv6 nf_defrag_ipv6 ip6table_filter ip6_tables ipv6 uinput arc4 snd_hda_codec_conexant ecb snd_hda_intel iwlagn snd_hda_codec iwlcore mac80211 snd_hwdep snd_seq snd_seq_device snd_pcm snd_timer snd_page_alloc uvcvideo btusb cfg80211 bluetooth thinkpad_acpi i2c_i801 videodev iTCO_wdt snd e1000e iTCO_vendor_support v4l1_compat pcspkr rfkill wmi soundcore joydev microcode sdhci_pci sdhci firewire_ohci mmc_core firewire_core yenta_socket crc_itu_t i915 drm_kms_helper drm i2c_algo_bit i2c_core video output [last unloaded: scsi_wait_scan]
<4>
<4>Pid: 2478, comm: udevd Not tainted 2.6.37 #3 406227U/406227U
<4>EIP: 0060:[<c04c8d0c>] EFLAGS: 00000286 CPU: 0
eed_resched+0x19/0x23
<4> [<c042aa2e>] ?
<4>ESI: ec44a400 EDI: f4402500 EBP: ec431cac ESP: ec431ca8
08c97>] ? verify_iovec+0x43/0x78
<4> [<c07006ek.ti=ec430000)
<0>Stack:
<4> 00000286 ec431cb8 c04c8d34 0000008b ec431cd4 c04cb66a c07074b8 ec431cd4
<4> [<c04d4cc2>] ? fget_light+0x2f/0x5c
<4> [<c0702072>] sys_recvmsg+0x30/0x48
c0709866
<0>Call Trace:
<4> [<c04c8d34>] c040335f>] sysenter_do_call+0x12/0x2d
ta+0x7c/0x80
<4> [<c07074b8>] ? skb_release_data+0x7wmidi nam+0x12/0x1c
<4> [<c072803d>] ? netlink_recvmsg+0x140/0x25e
<4> [<c0700089>] ? __sock_recvmsg+0x63/0x6d
<4> [<c070021f>] ? sock_recvmsg+0x9b/0xb0
<4> [<c070030e>] ? sock_sendmsg+0x98/0xac
<4> [<c042aa17>] ? need_resched+0x19/0x23
<4> [<c042aa2e>] ? should_resched+0xd/0x28
<4> [<c05b2a6e>] ? _copy_from_user+0x3e/0x52
<4> [<c0708961>] ? copy_from_user+0xd/0xf
<4> [<c0708c97>] ? verify_iovec+0x43/0x78
<4> [<c07006e2>] ? __sys_recvmsg+0x105/0x19c
<4> [<c0700184>] ? sock_recvmsg+0x0/0xb0
<4> [<c07007a7>] ? sockfd_lookup_light+0x1b/0x48
<4> [<c0701b61>] ? sys_sendto+0x120/0x142
<4> [<c04d4cc2>] ? fget_light+0x2f/0x5c
<4> [<c0702072>] ? sys_recvmsg+0x30/0x48
<4> [<c07023eb>] ? sys_sockeneric rfcomm sco bip6_tables ipv6 uinput arc4 snd_hda_codec_conexant ecb snd_hda_intel iwlagn snd_hda_codec iwlcore mac80211 snd_hwdep snd_seq snd_seq_device snd_pcm snd_timer snd_page_alloc uvcvideo btusb cfg80211 bluetooth thinkpad_acpi i2c_i801 videodev iTCO_wdt snd e1000e iTCO_vendor_support v4l1_compat pcspkr rfkill wmi soundcore joydev microcode sdhci_pci sdhci firewire_ohci mmc_core firewire_core yenta_socket crc_itu_t i915 drm_kms_helper drm i2c_algo_bit i2c_core video output [last unloaded: scsi_wait_scan]
<4>
<4>Pid: 2478, comm: udevd Not tainted 2.6.37 #3 406227U/406227U
<4>EIP: 0060:[<c04c8d0c>] EFLAGS: 00000286 CPU: 0
eed_resched+0x19/0x23
<4> [<c042aa2e>] ? should_resched+0xd/0x28
500 EBP: ec431cac ESP: ec431ca8
<4> DS: 00 ? verify_iovec+0x43/0x78
<4> [<c07006e2>] __sys_recvmsg+0x105/0x19c
0286 ec431cb8 c04c8d34 0000008b ec431cd4 c04cb66a c07074b8 ec431cd4
<4> [<c04d4cc2>] ? fget_light+0x2f/0x5c
<4> [<c0702072>] sys_recvmsg+0x30ec431d0c c0709866
irqs_on_thunb66a>] ? kfree+0x70/0xd5
: udevd/2478/0x10010100
<4>Modules linked infigfs sit tunnel4 fuse aes_i586 aes_generic rfcomm sco bnep l2cap coretemp cpufreq_ondemand acpi_cpufreq mperf ip6t_REJECT nf_conntrack_ipv6 nf_defrag_ipv6 ip6table_filter ip6_tables ipv6 uinput arc4 snd_hda_codec_conexant ecb snd_hda_intel iwlagn snd_hda_codec iwlcore mac80211 snd_hwdep snd_seq snd_seq_device snd_pcm snd_timer snd_page_alloc uvcvideo btusb cfg80211 bluetooth thinkpad_acpi i2c_i801 videodev iTCO_wdt snd e1000e iTCO_vendor_support v4l1_compat pcspkr rfkill wmi soundcore joydev microcode sdhci_pci sdhci firewire_ohci mmc_core firewire_core yenta_socket crc_itu_t i915 drm_kms_helper drm i2c_algo_bit i2c_core video output [last unloaded: scsi_wait_scan]
<4>Modules linked in: snd_usb_audio snd_usbmidi_lib snd_ra_cpufreq mperf ip6t_REJECT nf_conntrack_ipv6 nf_defrag_ipv6 ip6table_filter ip6_tables ipv6 uinput arc4 snd_hda_codec_conexant ecb snd_hda_intel iwlagn snd_hda_codec iwlcore mac80211 snd_hwdep snd_seq snd_seq_device snd_pcm snd_timer snd_page_alloc uvcvideo btusb cfg80211 bluetooth thinkpad_acpi i2c_i801 videodev iTCO_wdt snd e1000e iTCO_vendor_support v4l1_compat pcspkr rfkill wmi soundcore joydev microcode sdhci_pci sdhci firewire_ohci mmc_core firewire_core yenta_socket crc_itu_t i915 drm_kms_helper drm i2c_algo_bit i2c_core video output [last unloaded: scsi_wait_scan]
<4>
<4>Pid: 2478, comm: udevd Not tainted 2.6.37 #3 406227U/406227U
<4>EIP: 0060:[<c04c8d0c>] EFLAGS: 00000286 CPU: 0
eed_resched+0x19/0x23
<4> [<c042aa2e>] ?
<4>ESI: ec44a400 EDI: f4402500 EBP: ec431cac ESP: ec431ca8
08c97>] ? verify_iovec+0x43/0x78
<4> [<c07006ek.ti=ec430000)
<0>Stack:
<4> 00000286 ec431cb8 c04c8d34 0000008b ec431cd4 c04cb66a c07074b8 ec431cd4
<4> [<c04d4cc2>] ? fget_light+0x2f/0x5c
<4> [<c0702072>] sys_recvmsg+0x30ec431d0c c0709866
irqs_on_thunk+0xc/0x10
+0x70/0xd5
<4> [<c07074b8>] ? skb_releaseModules linked ib+0x58/0x5c
<4> [<c0709866>] ? skb_free_datagram+0x12/0x1c
<4> [<c072803d>] ? netlink_recvmsg+0x140/0x25e
<4> [<c0700089>] ? __sock_recvmsg+0x63/0x6d
<4> [<c070021f>] ? sock_recvmsg+0x9b/0xb0
<4> [<c070030e>] ? sock_sendmsg+0x98/0xac
<4> [<c042aa17>] ? need_resched+0x19/0x23
<4> [<c042aa2e>] ? should_resched+0xd/0x28
<4> [<c05b2a6e>] ? _copy_from_user+0x3e/0x52
<4> [<c0708961>] ? copy_from_user+0xd/0xf
<4> [<c0708c97>] ? verify_iovec+0x43/0x78
<4> [<c07006e2>] ? __sys_recvmsg+0x105/0x19c
<4> [<c0700184>] ? sock_recvmsg+0x0/0xb0
<4> [<c07007a7>] ? sockfd_lookup_light+0x1b/0x48
<4> [<c0701b61>] ? sys_sendto+0x120/0x142
<4> [<c04d4cc2>] ? fget_light+0x2f/0x5c
<4> [<c0702072>] ? sys_recvmsg+0x30/0x48
<4> [<c07023eb>] ? sys_sockeneric rfcomm sco b65 f4 89 d0 5b 5e 5f 5d c3 90 90 90 55 89 e5 3e 8d 74 26 00 8d 50 ff 83 c8 ff c1 ea 0b 40 d1 ea 75 fb 5d c3 55 89 e5 9c <58> 8d 74 26 00 5d c3 55 89 e5 50 9d 8d 74 26 00 5d c3 55 89 e5 
<4>Call Trace:
<4> [<c04c8d34>] arch_local_irq_save+0xb/0x18
<4> [<c04cb66a>] kfree+0x70/0xd5
<4> [<c07074b8>] ? skb_release_data+0x7c/0x80
<4> [<c07074b8>] skb_release_data+0x7c/0x80
<4> [<c0707677>] __kfree_skb+0x17/0x74
<4> [<c070772c>] consume_skb+0x58/0x5c
<4> [<c0709866>] skb_free_datagram+0x12/0x1c
<4> [<c072803d>] netlink_recvmsg+0x140/0x25e
<4> [<c0700089>] __sock_recvmsg+0x63/0x6d
<4> [<c070021f>] sock_recvmsg+0x9b/0xb00 ? need_resched+0x19/0x23
0 EDX: c07074b8
<4>ESI: ec44a400 EDI: f41>] ? copy_from_user+0xd/0xf
<4> [<c0708c97>] ? verify_iovec+0x43/0x78
724c80 task.ti=ec430000)
<0>Stack:
<4> 00000286 ec431cb8 c04c8d34 0000008b ec431cd4 c04cb66a c07074b8 ec431cd4
<4> [<c04d4cc2>] ? fget_light+0x2f/0x5c
<4> [<c0702072>] sys_recvmsg+0x30ec431d0c c0709866
irqs_on_thunk+0xc/0x10
+0x70/0xd5
<4> [<c07074b8>] ? skb_release_data+0x7c/0x80
snd_usb_audio snd_usbmidi_lib snd_rawmidi nfcomm sco bnep l2cap coretemp cpufreq_ondemand acpi_cpufreq mperf ip6t_REJECT nf_conntrack_ipv6 nf_defrag_ipv6 ip6table_filter ip6_tables ipv6 uinput arc4 snd_hda_codec_conexant ecb snd_hda_intel iwlagn snd_hda_codec iwlcore mac80211 snd_hwdep snd_seq snd_seq_device snd_pcm snd_timer snd_page_alloc uvcvideo btusb cfg80211 bluetooth thinkpad_acpi i2c_i801 videodev iTCO_wdt snd e1000e iTCO_vendor_support v4l1_compat pcspkr rfkill wmi soundcore joydev microcode sdhci_pci sdhci firewire_ohci mmc_core firewire_core yenta_socket crc_itu_t i915 drm_kms_helper drm i2c_algo_bit i2c_core video output [last unloaded: scsi_wait_scan]
<4>Modules linked in: snd_usb_audio snd_usbmidi_lib snd_ra_cpufreq mperf ip6t_REJECT nf_conntrack_ipv6 nf_defrag_ipv6 ip6table_filter ip6_tables ipv6 uinput arc4 snd_hda_codec_conexant ecb snd_hda_intel iwlagn snd_hda_codec iwlcore mac80211 snd_hwdep snd_seq snd_seq_device snd_pcm snd_timer snd_page_alloc uvcvideo btusb cfg80211 bluetooth thinkpad_acpi i2c_i801 videodev iTCO_wdt snd e1000e iTCO_vendor_support v4l1_compat pcspkr rfkill wmi soundcore joydev microcode sdhci_pci sdhci firewire_ohci mmc_core firewire_core yenta_socket crc_itu_t i915 drm_kms_helper drm i2c_algo_bit i2c_core video output [last unloaded: scsi_wait_scan]
<4>
<4>Pid: 2478, comm: udevd Not tainted 2.6.37 #3 406227U/406227U
<4>EIP: 0060:[<c04c8d0c>] EFLAGS: 00000286 CPU: 0
eed_resched+0x19/0x23
<4> [<c042aa2e>] ?
<4>ESI: ec44a400 EDI: f4402500 EBP: ec431cac ESP: ec431ca8
08c97>] ? verify_iovec+0x43/0x78
<4> [<c07006ek.ti=ec430000)
<0>Stack:
<4> 00000286 ec431cb8 c04c8d34 0000008b ec431cd4 c04cb66a c07074b8 ec431cd4
<4> [<c04d4cc2>] ? fget_light+0x2f/0x5c
<4> [<c0702072>] sys_recvmsg+0x30/0x48
c0709866
<0>Call Trace:
<4> [<c04c8d34>] c040335f>] sysenter_do_call+0x12/0x2d
ta+0x7c/0x80
<4> [<c07074b8>] ? skb_release_data+0x7c/0x80
onsole configfs sit tunnel4 fuse aes_idefrag_ipv6 ip6table_filter ip6_tables ipv6 uinput arc4 snd_hda_codec_conexant ecb snd_hda_intel iwlagn snd_hda_codec iwlcore mac80211 snd_hwdep snd_seq snd_seq_device snd_pcm snd_timer snd_page_alloc uvcvideo btusb cfg80211 bluetooth thinkpad_acpi i2c_i801 videodev iTCO_wdt snd e1000e iTCO_vendor_support v4l1_compat pcspkr rfkill wmi soundcore joydev microcode sdhci_pci sdhci firewire_ohci mmc_core firewire_core yenta_socket crc_itu_t i915 drm_kms_helper drm i2c_algo_bit i2c_core video output [last unloaded: scsi_wait_scan]
<4>Modules linked in: snd_usb_audio snd_usbmidi_lib snd_rawmidi netconsole configfs sit tunnel4 fuse aes_i586 aes_ge<0>Code: 00 00 8d 65 f4 89 d0 5b 5e 5f 5d c3 90 90 90 55 89 e5 3e 8d 74 26 00 8d 50 ff 83 c8 ff c1 ea 0b 40 d1 ea 75 fb 5d c3 55 89 e5 9c <58> 8d 74 26 00 5d c3 55 89 e5 50 9d 8d 74 26 00 5d c3 55 89 e5 
<4>Call Trace:
<4> [<c04c8d34>] arch_local_irq_save+0xb/0x18
<4> [<c04cb66a>] kfree+0x70/0xd5
<4> [<c07074b8>] ? skb_release_data+0x7c/0x80
<4> [<c07074b8>] skb_release_data+0x7c/0x80
<4> [<c0707677>] __kfree_skb+0x17/0x74
<4> [<c070772c>] consume_skb+0x58/0x5c
<4> [<c0709866>] skb_free_datagram+0x12/0x1c
<4> [<c072803d>] netlink_recvmsg+0x140/0x25e
<4> [<c0700089>] __sock_recvmsg+0x63/0x6d
<4> [<c070021f>] sock_recvmsg+0x9b/0xb00
eed_resched+0x19/0x23
<4> [<c042aa2e>] ?
<4>ESI: ec44a400 EDI: f4402500 EBP: ec431cac ESP: ec431ca8
08c97>] ? verify_iovec+0x43/0x78
<4> [<c07006ek.ti=ec430000)
<0>Stack:
<4> 00000286 ec431cb8 c04c8d34 0000008b ec431cd4 c04cb66a c07074b8 ec431cd4
<4> [<c04d4cc2>] ? fget_light+0x2f/0x5c
<4> [<c0702072>] sys_recvmsg+0x30/0x48
c0709866
<0>Call Trace:
<4> [<c04c8d34>] c040335f>] sysenter_do_call+0x12/0x2d
ta+0x7c/0x80
<4> [<c07074b8>] ? skb_release_data+0x7c/0x80
onsole configfs sit tunnel4 fuse aes_iemand acpi_cpufreq mperf ip6t_REJECT nf_conntrack_ipv6 nf_defrag_ipv6 ip6table_filter ip6_tables ipv6 uinput arc4 snd_hda_codec_conexant ecb snd_hda_intel iwlagn snd_hda_codec iwlcore mac80211 snd_hwdep snd_seq snd_seq_device snd_pcm snd_timer snd_page_alloc uvcvideo btusb cfg80211 bluetooth thinkpad_acpi i2c_i801 videodev iTCO_wdt snd e1000e iTCO_vendor_support v4l1_compat pcspkr rfkill wmi soundcore joydev microcode sdhci_pci sdhci firewire_ohci mmc_core firewire_core yenta_socket crc_itu_t i915 drm_kms_helper drm i2c_algo_bit i2c_core video output [last unloaded: scsi_wait_scan]
<4>Modules linked in: snd_usb_audio snd_usbmidi_lib snd_ra_cpufreq mperf ip6t_REJECT nf_conntrack_ipv6 nf_defrag_ipv6 ip6table_filter ip6_tables ipv6 uinput arc4 snd_hda_codec_conexant ecb snd_hda_intel iwlagn snd_hda_codec iwlcore mac80211 snd_hwdep snd_seq snd_seq_device snd_pcm snd_timer snd_page_alloc uvcvideo btusb cfg80211 bluetooth thinkpad_acpi i2c_i801 videodev iTCO_wdt snd e1000e iTCO_vendor_support v4l1_compat pcspkr rfkill wmi soundcore joydev microcode sdhci_pci sdhci firewire_ohci mmc_core firewire_core yenta_socket crc_itu_t i915 drm_kms_helper drm i2c_algo_bit i2c_core video output [last unloaded: scsi_wait_scan]
<4>
<4>Pid: 2478, comm: udevd Not tainted 2.6.37 #3 406227U/406227U
<4>EIP: 0060:[<c04c8d0c>] EFLAGS: 00000286 CPU: ] ? need_resched+0x19/0x23
0 EDX: c07074b8
<4>ESI: ec44a400 EDI: f4402500 EBP: ec431cac ESP: ec431ca8
08c97>] ? verify_iovec+0x43/0x78
<4> [<c07006ek.ti=ec430000)
<0>Stack:
<4> 00000286 ec431cb8 c04c8d34 0000008b ec431cd4 c04cb66a c07074b8 ec431cd4
<4> [<c04d4cc2>] ? fget_light+0x2f/0x5c
<4> [<c0702072>] sys_recvmsg+0x30ec431d0c c0709866
irqs_on_thunb66a>] ? kfree+0x70/0xd5
: udevd/2478/0x10010100
<4>Modules linked infigfs sit tunnel4 fuse aes_i586 aes_generic rfcomm sco bnep l2cap coretemp cpufreq_ondemand acpi_cpufreq mperf ip6t_REJECT nf_conntrack_ipv6 nf_defrag_ipv6 ip6table_filter ip6_tables ipv6 uinput arc4 snd_hda_codec_conexant ecb snd_hda_intel iwlagn snd_hda_codec iwlcore mac80211 snd_hwdep snd_seq snd_seq_device snd_pcm snd_timer snd_page_alloc uvcvideo btusb cfg80211 bluetooth thinkpad_acpi i2c_i801 videodev iTCO_wdt snd e1000e iTCO_vendor_support v4l1_compat pcspkr rfkill wmi soundcore joydev microcode sdhci_pci sdhci firewire_ohci mmc_core firewire_core yenta_socket crc_itu_t i915 drm_kms_helper drm i2c_algo_bit i2c_core video output [last unloaded: scsi_wait_scan]
<4>Modules linked in: snd_usb_audio snd_usbmidi_lib snd_rank+0xc/0x10
<4> [<c040335f>] ? sysenter_do_call+0x12/0x2d
<0>Code: 00 00 8d 65 f4 89 d0 5b 5e 5f 5d c3 90 90 90 55 89 e5 3e 8d 74 26 00 8d 50 ff 83 c8 ff c1 ea 0b 40 d1 ea 75 fb 5d c3 55 89 e5 9c <58> 8d 74 26 00 5d c3 55 89 e5 50 9d 8d 74 26 00 5d c3 55 89 e5 
<4>Call Trace:
<4> [<c04c8d34>] arch_local_irq_save+0xb/0x18
<4> [<c04cb66a>] kfree+0x70/0xd5
<4> [<c07074b8>] ? skb_release_data+0x7c/0x80
<4> [<c07074b8>] skb_release_data+0x7c/0x80
<4> [<c0707677>] __kfree_skb+0x17/0x74
<4> [<c070772c>] consume_skb+0x58/0x5c
<4> [<c0709866>] skb_free_datagram+0x12/0x1c
<4> [<c072803d>] netlink_recvmsg+0x140/0x25e
<4> [<c0700089>] __sock_recvmsg+0x63/0x6d
<4> [<c070021f>] sock_recvmsg+0x9b/0xb00 ? need_resched+0x19/0x23
0 EDX: c07074b8
<4>ESI: ec44a400 EDI: f41>] ? copy_from_user+0xd/0xf
<4> [<c0708c97>] ? verify_iovec+0x43/0x78
724c80 task.ti=ec430000)
<0>Stack:
<4> 0? sockfd_lookup_light+0x1b/0x48
<4> [<c0701b61>] ? sys_sendto+0x120/0x142
c0 ec431cf0
<4> c0707677 f177d200 ec431d00 c070772c f177d200 f3f120e4 ec431d0c c0709866
irqs_on_thunb66a>] ? kfree+0x70/0xd5
: udevd/2478/0x10010100
<4>Modules linked iep l2cap coretemp cpufreq_ondemand acpi_cpufreq mperf ip6t_REJECT nf_conntrack_ipv6 nf_defrag_ipv6 ip6table_filter ip6_tables ipv6 uinput arc4 snd_hda_codec_conexant ecb snd_hda_intel iwlagn snd_hda_codec iwlcore mac80211 snd_hwdep snd_seq snd_seq_device snd_pcm snd_timer snd_page_alloc uvcvideo btusb cfg80211 bluetooth thinkpad_acpi i2c_i801 videodev iTCO_wdt snd e1000e iTCO_vendor_support v4l1_compat pcspkr rfkill wmi soundcore joydev microcode sdhci_pci sdhci firewire_ohci mmc_core firewire_core yenta_socket crc_itu_t i915 drm_kms_helper drm i2c_algo_bit i2c_core video output [last unloaded: scsi_wait_scan]
<4>Modules linked in: snd_usb_audio snd_usbmidi_lib snd_rawmidi netconsole configfs sit tunnel4 fuse aes_i586 aes_ge6 ip6table_filter ip6_tables ipv6 uinput arc4 snd_hda_codec_conexant ecb snd_hda_intel iwlagn snd_hda_codec iwlcore mac80211 snd_hwdep snd_seq snd_seq_device snd_pcm snd_timer snd_page_alloc uvcvideo btusb cfg80211 bluetooth thinkpad_acpi i2c_i801 videodev iTCO_wdt snd e1000e iTCO_vendor_support v4l1_compat pcspkr rfkill wmi soundcore joydev microcode sdhci_pci sdhci firewire_ohci mmc_core firewire_core yenta_socket crc_itu_t i915 drm_kms_helper drm i2c_algo_bit i2c_core video output [last unloaded: scsi_wait_scan]
<4>
<4>Pid: 2478, comm: udevd Not tainted 2.6.37 #3 406227U/406227U
<4>EIP: 0060:[<c04c8d0c>] EFLAGS: 00000286 CPU: 0
eed_resched+0x19/0x23
<4> [<c042aa2e>] ? should_resched+0xd/0x28
500 EBP: ec431cac ESP: ec431ca8
<4> DS: 00 ? verify_iovec+0x43/0x78
<4> [<c07006e2>] __sys_recvmsg+0x105/0x19c
0286 ec431cb8 c04c8d34 0000008b ec431c01b61>] ? sys_sendto+0x120/0x142
c0 ec431cf0
<4> c0707677 f177d200 ec4s_socketcall+0x177/0x1a8
<4> [<c05b25e0>] ? trace_hardirqs_on_thunk+0xc/0x10
+0x70/0xd5
<4> [<c07074b8>] ? skb_releaseModules linked ib+0x58/0x5c
<4> [<c0709866>] ? skb_free_datagram+0x12/0x1c
<4> [<c072803d>] ? netlink_recvmsg+0x140/0x25e
<4> [<c0700089>] ? __sock_recvmsg+0x63/0x6d
<4> [<c070021f>] ? sock_recvmsg+0x9b/0xb0
<4> [<c070030e>] ? sock_sendmsg+0x98/0xac
<4> [<c042aa17>] ? need_resched+0x19/0x23
<4> [<c042aa2e>] ? should_resched+0xd/0x28
<4> [<c05b2a6e>] ? _copy_from_user+0x3e/0x52
<4> [<c0708961>] ? copy_from_user+0xd/0xf
<4> [<c0708c97>] ? verify_iovec+0x43/0x78
<4> [<c07006e2>] ? __sys_recvmsg+0x105/0x19c
<4> [<c0700184>] ? sock_recvmsg+0x0/0xb0
<4> [<c07007a7>] ? sockfd_lookup_light+0x1b/0x48
<4> [<c0701b61>] ? sys_sendto+0x120/0x142
<4> [<c04d4cc2>] ? fget_light+0x2f/0x5c
<4> [<c0702072>] ? sys_recvmsg+0x30/0x48
<4> [<c07023eb>] ? sys_sockeneric rfcomm sco bip6_tables ipv6 uinput arc4 snd_hda_codec_conexant ecb snd_hda_intel iwlagn snd_hda_codec iwlcore mac80211 snd_hwdep snd_seq snd_seq_device snd_pcm snd_timer snd_page_alloc uvcvideo btusb cfg80211 bluetooth thinkpad_acpi i2c_i801 videodev iTCO_wdt snd e1000e iTCO_vendor_support v4l1_compat pcspkr rfkill wmi soundcore joydev microcode sdhci_pci sdhci firewire_ohci mmc_core firewire_core yenta_socket crc_itu_t i915 drm_kms_helper drm i2c_algo_bit i2c_core video output [last unloaded: scsi_wait_scan]
<4>
<4>Pid: 2478, comm: udevd Not tainted 2.6.37 #3 406227U/406227U
<4>EIP: 0060:[<c04c8d0c>] EFLAGS: 00000286 CPU: 0
eed_resched+0x19/0x23
<4> [<c042aa2e>] ?
<4>ESI: ec44a400 EDI: f4402500 EBP: ec431cac ESP: ec431ca8
08c97>] ? verify_iovec+0x43/0x78
<4> [<c07006e2>] __sys_recvmsg+0x105/0x19c
0286 ec431cb8 c04c8d34 0000008b ec431c01b61>] ? sys_sendto+0x120/0x142
c0 ec431cf0
<4> c0707677 f177d200 ec4s_socketcall+0x177/0x1a8
<4> [<c05b25e0>] ? trace_hardirqs_on_thunk+0xc/0x10
+0x70/0xd5
<4> [<c07074b8>] ? skb_release_data+0x7c/0x80
snd_usb_audio snd_usbmidi_lib snd_rawmidi nq mperf ip6t_REJECT nf_conntrack_ipv6 nf_defrag_ipv6 ip6table_filter ip6_tables ipv6 uinput arc4 snd_hda_codec_conexant ecb snd_hda_intel iwlagn snd_hda_codec iwlcore mac80211 snd_hwdep snd_seq snd_seq_device snd_pcm snd_timer snd_page_alloc uvcvideo btusb cfg80211 bluetooth thinkpad_acpi i2c_i801 videodev iTCO_wdt snd e1000e iTCO_vendor_support v4l1_compat pcspkr rfkill wmi soundcore joydev microcode sdhci_pci sdhci firewire_ohci mmc_core firewire_core yenta_socket crc_itu_t i915 drm_kms_helper drm i2c_algo_bit i2c_core video output [last unloaded: scsi_wait_scan]
<4>Modules linked in: snd_usb_audio snd_usbmidi_lib snd_rawmidi netconsole configfs sit tunnel4 fuse aes_i586 aes_ge<0>Code: 00 00 8d 65 f4 89 d0 5b 5e 5f 5d c3 90 90 90 55 89 e5 3e 8d 74 26 00 8d 50 ff 83 c8 ff c1 ea 0b 40 d1 ea 75 fb 5d c3 55 89 e5 9c <58> 8d 74 26 00 5d c3 55 89 e5 50 9d 8d 74 26 00 5d c3 55 89 e5 
<4>Call Trace:
<4> [<c04c8d34>] arch_local_irq_save+0xb/0x18
<4> [<c04cb66a>] kfree+0x70/0xd5
<4> [<c07074b8>] ? skb_release_data+0x7c/0x80
<4> [<c07074b8>] skb_release_data+0x7c/0x80
<4> [<c0707677>] __kfree_skb+0x17/0x74
<4> [<c070772c>] consume_skb+0x58/0x5c
<4> [<c0709866>] skb_free_datagram+0x12/0x1c
<4> [<c072803d>] netlink_recvmsg+0x140/0x25e
<4> [<c0700089>] __sock_recvmsg+0x63/0x6d
<4> [<c070021f>] sock_recvmsg+0x9b/0xb00 ? need_resched+0x19/0x23
0 EDX: c07074b8
<4>ESI: ec44a400 EDI: f4402500 EBP: ec431cac ESP: ec431ca8
08c97>] ? verify_iovec+0x43/0x78
<4> [<c07006ek.ti=ec430000)
<0>Stack:
<4> 00000286 ec431cb8 c04c8d34 0000008b ec431cd4 c04cb66a c07074b8 ec431cd4
<4> [<c04d4cc2>] ? fget_light+0x2f/0x5c
<4> [<c0702072>] sys_recvmsg+0x30ec431d0c c0709866
irqs_on_thunk+0xc/0x10
+0x70/0xd5
<4> [<c07074b8>] ? skb_release_data+0x7c/0x80
snd_usb_audio snd_usbmidi_lib snd_rawmidi nam+0x12/0x1c
<4> [<c072803d>] ? netlink_recvmsg+0x140/0x25e
<4> [<c0700089>] ? __sock_recvmsg+0x63/0x6d
<4> [<c070021f>] ? sock_recvmsg+0x9b/0xb0
<4> [<c070030e>] ? sock_sendmsg+0x98/0xac
<4> [<c042aa17>] ? need_resched+0x19/0x23
<4> [<c042aa2e>] ? should_resched+0xd/0x28
<4> [<c05b2a6e>] ? _copy_from_user+0x3e/0x52
<4> [<c0708961>] ? copy_from_user+0xd/0xf
<4> [<c0708c97>] ? verify_iovec+0x43/0x78
<4> [<c07006e2>] ? __sys_recvmsg+0x105/0x19c
<4> [<c0700184>] ? sock_recvmsg+0x0/0xb0
<4> [<c07007a7>] ? sockfd_lookup_light+0x1b/0x48
<4> [<c0701b61>] ? sys_sendto+0x120/0x142
<4> [<c04d4cc2>] ? fget_light+0x2f/0x5c
<4> [<c0702072>] ? sys_recvmsg+0x30/0x48
<4> [<c07023eb>] ? sys_sockeneric rfcomm sco bip6_tables ipv6 uinput arc4 snd_hda_codec_conexant ecb snd_hda_intel iwlagn snd_hda_codec iwlcore mac80211 snd_hwdep snd_seq snd_seq_device snd_pcm snd_timer snd_page_alloc uvcvideo btusb cfg80211 bluetooth thinkpad_acpi i2c_i801 videodev iTCO_wdt snd e1000e iTCO_vendor_support v4l1_compat pcspkr rfkill wmi soundcore joydev microcode sdhci_pci sdhci firewire_ohci mmc_core firewire_core yenta_socket crc_itu_t i915 drm_kms_helper drm i2c_algo_bit i2c_core video output [last unloaded: scsi_wait_scan]
<4>
<4>Pid: 2478, comm: udevd Not tainted 2.6.37 #3 406227U/406227U
<4>EIP: 0060:[<c04c8d0c>] EFLAGS: 00000286 CPU: 0
eed_resched+0x19/0x23
<4> [<c042aa2e>] ?
<4>ESI: ec44a400 EDI: f4402500 EBP: ec431cac ESP: ec431ca8
08c97>] ? verify_iovec+0x43/0x78
<4> [<c07006ek.ti=ec430000)
<0>Stack:
<4> 00000286 ec431cb8 c04c8d34 0000008b ec431cd4 c04cb66a c07074b8 ec431cd4
<4> [<c04d4cc2>] ? fget_light+0x2f/0x5c
<4> [<c0702072>] sys_recvmsg+0x30/0x48
c0709866
<0>Call Trace:
<4> [<c04c8d34>] ? arch_local_irq_save+0xb/0x18
x2d
<3>BUG: scheduling while atob8>] ? skb_release_data+0x7c/0x80
onsole configfs sit tunnel4 fuse aes_iecvmsg+0x140/0x25e
<4> [<c0700089>] ? __sock_recvmsg+0x63/0x6d
<4> [<c070021f>] ? sock_recvmsg+0x9b/0xb0
<4> [<c070030e>] ? sock_sendmsg+0x98/0xac
<4> [<c042aa17>] ? need_resched+0x19/0x23
<4> [<c042aa2e>] ? should_resched+0xd/0x28
<4> [<c05b2a6e>] ? _copy_from_user+0x3e/0x52
<4> [<c0708961>] ? copy_from_user+0xd/0xf
<4> [<c0708c97>] ? verify_iovec+0x43/0x78
<4> [<c07006e2>] ? __sys_recvmsg+0x105/0x19c
<4> [<c0700184>] ? sock_recvmsg+0x0/0xb0
<4> [<c07007a7>] ? sockfd_lookup_light+0x1b/0x48
<4> [<c0701b61>] ? sys_sendto+0x120/0x142
<4> [<c04d4cc2>] ? fget_light+0x2f/0x5c
<4> [<c0702072>] ? sys_recvmsg+0x30/0x48
<4> [<c07023eb>] ? sys_sockeneric rfcomm sco b65 f4 89 d0 5b 5e 5f 5d c3 90 90 90 55 89 e5 3e 8d 74 26 00 8d 50 ff 83 c8 ff c1 ea 0b 40 d1 ea 75 fb 5d c3 55 89 e5 9c <58> 8d 74 26 00 5d c3 55 89 e5 50 9d 8d 74 26 00 5d c3 55 89 e5 
<4>Call Trace:
<4> [<c04c8d34>] arch_local_irq_save+0xb/0x18
<4> [<c04cb66a>] kfree+0x70/0xd5
<4> [<c07074b8>] ? skb_release_data+0x7c/0x80
<4> [<c07074b8>] skb_release_data+0x7c/0x80
<4> [<c0707677>] __kfree_skb+0x17/0x74
<4> [<c070772c>] consume_skb+0x58/0x5c
<4> [<c0709866>] skb_free_datagram+0x12/0x1c
<4> [<c072803d>] netlink_recvmsg+0x140/0x25e
<4> [<c0700089>] __sock_recvmsg+0x63/0x6d
<4> [<c070021f>] sock_recvmsg+0x9b/0xb00 ? need_resched+0x19/0x23
0 EDX: c07074b8
<4>ESI: ec44a400 EDI: f4402500 EBP: ec431cac ESP: ec431ca8
08c97>] ? verify_iovec+0x43/0x78
<4> [<c07006ek.ti=ec430000)
<0>Stack:
<4> 00000286 ec431cb8 c04c8d34 0000008b ec431cd4 c04cb66a c07074b8 ec431cd4
<4> [<c04d4cc2>] ? fget_light+0x2f/0x5c
<4> [<c0702072>] sys_recvmsg+0x30/0x48
c0709866
<0>Call Trace:
<4> [<c04c8d34>] ? arch_local_irq_save+0xb/0x18
x2d
<3>BUG: scheduling while atob8>] ? skb_release_data+0x7c/0x80
onsole configfs sit tunnel4 fuse aes_iemand acpi_cpufreq mperf ip6t_REJECT nf_conntrack_ipv6 nf_defrag_ipv6 ip6table_filter ip6_tables ipv6 uinput arc4 snd_hda_codec_conexant ecb snd_hda_intel iwlagn snd_hda_codec iwlcore mac80211 snd_hwdep snd_seq snd_seq_device snd_pcm snd_timer snd_page_alloc uvcvideo btusb cfg80211 bluetooth thinkpad_acpi i2c_i801 videodev iTCO_wdt snd e1000e iTCO_vendor_support v4l1_compat pcspkr rfkill wmi soundcore joydev microcode sdhci_pci sdhci firewire_ohci mmc_core firewire_core yenta_socket crc_itu_t i915 drm_kms_helper drm i2c_algo_bit i2c_core video output [last unloaded: scsi_wait_scan]
<4>Modules linked in: snd_usb_audio snd_usbmidi_lib snd_ra_cpufreq mperf ip6t_REJECT nf_conntrack_ipv6 nf_defrag_ipv6 ip6table_filter ip6_tables ipv6 uinput arc4 snd_hda_codec_conexant ecb snd_hda_intel iwlagn snd_hda_codec iwlcore mac80211 snd_hwdep snd_seq snd_seq_device snd_pcm snd_timer snd_page_alloc uvcvideo btusb cfg80211 bluetooth thinkpad_acpi i2c_i801 videodev iTCO_wdt snd e1000e iTCO_vendor_support v4l1_compat pcspkr rfkill wmi soundcore joydev microcode sdhci_pci sdhci firewire_ohci mmc_core firewire_core yenta_socket crc_itu_t i915 drm_kms_helper drm i2c_algo_bit i2c_core video output [last unloaded: scsi_wait_scan]
<4>
<4>Pid: 2478, comm: udevd Not tainted 2.6.37 #3 406227U/406227U
<4>EIP: 0060:[<c04c8d0c>] EFLAGS: 00000286 CPU: ] ? need_resched+0x19/0x23
0 EDX: c07074b8
<4>ESI: ec44a400 EDI: f4402500 EBP: ec431cac ESP: ec431ca8
08c97>] ? verify_iovec+0x43/0x78
<4> [<c07006ek.ti=ec430000)
<0>Stack:
<4> 00000286 ec431cb8 c04c8d34 0000008b ec431cd4 c04cb66a c07074b8 ec431cd4
<4> [<c04d4cc2>] ? fget_light+0x2f/0x5c
<4> [<c0702072>] sys_recvmsg+0x30/0x48
c0709866
<0>Call Trace:
<4> [<c04c8d34>] c040335f>] sysenter_do_call+0x12/0x2d
ta+0x7c/0x80
<4> [<c07074b8>] ? skb_release_data+0x7c/0x80
onsole configfs sit tunnel4 fuse aes_iecvmsg+0x140/0x25e
<4> [<c0700089>] ? __sock_recvmsg+0x63/0x6d
<4> [<c070021f>] ? sock_recvmsg+0x9b/0xb0
<4> [<c070030e>] ? sock_sendmsg+0x98/0xac
<4> [<c042aa17>] ? need_resched+0x19/0x23
<4> [<c042aa2e>] ? should_resched+0xd/0x28
<4> [<c05b2a6e>] ? _copy_from_user+0x3e/0x52
<4> [<c0708961>] ? copy_from_user+0xd/0xf
<4> [<c0708c97>] ? verify_iovec+0x43/0x78
<4> [<c07006e2>] ? __sys_recvmsg+0x105/0x19c
<4> [<c0700184>] ? sock_recvmsg+0x0/0xb0
<4> [<c07007a7>] ? sockfd_lookup_light+0x1b/0x48
<4> [<c0701b61>] ? sys_sendto+0x120/0x142
<4> [<c04d4cc2>] ? fget_light+0x2f/0x5c
<4> [<c0702072>] ? sys_recvmsg+0x30/0x48
<4> [<c07023eb>] ? sys_sockeneric rfcomm sco b65 f4 89 d0 5b 5e 5f 5d c3 90 90 90 55 89 e5 3e 8d 74 26 00 8d 50 ff 83 c8 ff c1 ea 0b 40 d1 ea 75 fb 5d c3 55 89 e5 9c <58> 8d 74 26 00 5d c3 55 89 e5 50 9d 8d 74 26 00 5d c3 55 89 e5 
<4>Call Trace:
<4> [<c04c8d34>] arch_local_irq_save+0xb/0x18
<4> [<c04cb66a>] kfree+0x70/0xd5
<4> [<c07074b8>] ? skb_release_data+0x7c/0x80
<4> [<c07074b8>] skb_release_data+0x7c/0x80
<4> [<c0707677>] __kfree_skb+0x17/0x74
<4> [<c070772c>] consume_skb+0x58/0x5c
<4> [<c0709866>] skb_free_datagram+0x12/0x1c
<4> [<c072803d>] netlink_recvmsg+0x140/0x25e
<4> [<c0700089>] __sock_recvmsg+0x63/0x6d
<4> [<c070021f>] sock_recvmsg+0x9b/0xb00
eed_resched+0x19/0x23
<4> [<c042aa2e>] ?
<4>ESI: ec44a400 EDI: f4402500 EBP: ec431cac ESP: ec431ca8
08c97>] ? verify_iovec+0x43/0x78
<4> [<c07006e2>] __sys_recvmsg+0x105/0x19c
0286 ec431cb8 c04c8d34 0000008b ec431cd4 c04cb66a c07074b8 ec431cd4
<4> [<c04d4cc2>] ? fget_light+0x2f/0x5c
<4> [<c0702072>] sys_recvmsg+0x30/0x48
c0709866
<0>Call Trace:
<4> [<c04c8d34>] c040335f>] sysenter_do_call+0x12/0x2d
ta+0x7c/0x80
<4> [<c07074b8>] ? skb_release_data+0x7c/0x80
onsole configfs sit tunnel4 fuse aes_iemand acpi_cpufreq mperf ip6t_REJECT nf_conntrack_ipv6 nf_defrag_ipv6 ip6table_filter ip6_tables ipv6 uinput arc4 snd_hda_codec_conexant ecb snd_hda_intel iwlagn snd_hda_codec iwlcore mac80211 snd_hwdep snd_seq snd_seq_device snd_pcm snd_timer snd_page_alloc uvcvideo btusb cfg80211 bluetooth thinkpad_acpi i2c_i801 videodev iTCO_wdt snd e1000e iTCO_vendor_support v4l1_compat pcspkr rfkill wmi soundcore joydev microcode sdhci_pci sdhci firewire_ohci mmc_core firewire_core yenta_socket crc_itu_t i915 drm_kms_helper drm i2c_algo_bit i2c_core video output [last unloaded: scsi_wait_scan]
<4>Modules linked in: snd_usb_audio snd_usbmidi_lib snd_ra_cpufreq mperf ip6t_REJECT nf_conntrack_ipv6 nf_defrag_ipv6 ip6table_filter ip6_tables ipv6 uinput arc4 snd_hda_codec_conexant ecb snd_hda_intel iwlagn snd_hda_codec iwlcore mac80211 snd_hwdep snd_seq snd_seq_device snd_pcm snd_timer snd_page_alloc uvcvideo btusb cfg80211 bluetooth thinkpad_acpi i2c_i801 videodev iTCO_wdt snd e1000e iTCO_vendor_support v4l1_compat pcspkr rfkill wmi soundcore joydev microcode sdhci_pci sdhci firewire_ohci mmc_core firewire_core yenta_socket crc_itu_t i915 drm_kms_helper drm i2c_algo_bit i2c_core video output [last unloaded: scsi_wait_scan]
<4>
<4>Pid: 2478, comm: udevd Not tainted 2.6.37 #3 406227U/406227U
<4>EIP: 0060:[<c04c8d0c>] EFLAGS: 00000286 CPU: ] ? need_resched+0x19/0x23
0 EDX: c07074b8
<4>ESI: ec44a400 EDI: f4402500 EBP: ec431cac ESP: ec431ca8
08c97>] ? verify_iovec+0x43/0x78
<4> [<c07006ek.ti=ec430000)
<0>Stack:
<4> 00000286 ec431cb8 c04c8d34 0000008b ec431cd4 c04cb66a c07074b8 ec431cd4
<4> [<c04d4cc2>] ? fget_light+0x2f/0x5c
<4> [<c0702072>] sys_recvmsg+0x30/0x48
c0709866
<0>Call Trace:
<4> [<c04c8d34>] c040335f>] sysenter_do_call+0x12/0x2d
ta+0x7c/0x80
<4> [<c07074b8>] ? skb_release_data+0x7c/0x80
onsole configfs sit tunnel4 fuse aes_iecvmsg+0x140/0x25e
<4> [<c0700089>] ? __sock_recvmsg+0x63/0x6d
<4> [<c070021f>] ? sock_recvmsg+0x9b/0xb0
<4> [<c070030e>] ? sock_sendmsg+0x98/0xac
<4> [<c042aa17>] ? need_resched+0x19/0x23
<4> [<c042aa2e>] ? should_resched+0xd/0x28
<4> [<c05b2a6e>] ? _copy_from_user+0x3e/0x52
<4> [<c0708961>] ? copy_from_user+0xd/0xf
<4> [<c0708c97>] ? verify_iovec+0x43/0x78
<4> [<c07006e2>] ? __sys_recvmsg+0x105/0x19c
<4> [<c0700184>] ? sock_recvmsg+0x0/0xb0
<4> [<c07007a7>] ? sockfd_lookup_light+0x1b/0x48
<4> [<c0701b61>] ? sys_sendto+0x120/0x142
<4> [<c04d4cc2>] ? fget_light+0x2f/0x5c
<4> [<c0702072>] ? sys_recvmsg+0x30/0x48
<4> [<c07023eb>] ? sys_sockeneric rfcomm sco b65 f4 89 d0 5b 5e 5f 5d c3 90 90 90 55 89 e5 3e 8d 74 26 00 8d 50 ff 83 c8 ff c1 ea 0b 40 d1 ea 75 fb 5d c3 55 89 e5 9c <58> 8d 74 26 00 5d c3 55 89 e5 50 9d 8d 74 26 00 5d c3 55 89 e5 
<4>Call Trace:
<4> [<c04c8d34>] arch_local_irq_save+0xb/0x18
<4> [<c04cb66a>] kfree+0x70/0xd5
<4> [<c07074b8>] ? skb_release_data+0x7c/0x80
<4> [<c07074b8>] skb_release_data+0x7c/0x80
<4> [<c0707677>] __kfree_skb+0x17/0x74
<4> [<c070772c>] consume_skb+0x58/0x5c
<4> [<c0709866>] skb_free_datagram+0x12/0x1c
<4> [<c072803d>] netlink_recvmsg+0x140/0x25e
<4> [<c0700089>] __sock_recvmsg+0x63/0x6d
<4> [<c070021f>] sock_recvmsg+0x9b/0xb00
eed_resched+0x19/0x23
<4> [<c042aa2e>] ?
<4>ESI: ec44a400 EDI: f4402500 EBP: ec431cac ESP: ec431ca8
08c97>] ? verify_iovec+0x43/0x78
<4> [<c07006e2>] __sys_recvmsg+0x105/0x19c
0286 ec431cb8 c04c8d34 0000008b ec431cd4 c04cb66a c07074b8 ec431cd4
<4> [<c04d4cc2>] ? fget_light+0x2f/0x5c
<4> [<c0702072>] sys_recvmsg+0x30ec431d0c c0709866
irqs_on_thunk+0xc/0x10
+0x70/0xd5
<4> [<c07074b8>] ? skb_release_data+0x7c/0x80
snd_usb_audio snd_usbmidi_lib snd_rawmidi nfcomm sco bnep l2cap coretemp cpufreq_ondemand acpi_cpufreq mperf ip6t_REJECT nf_conntrack_ipv6 nf_defrag_ipv6 ip6table_filter ip6_tables ipv6 uinput arc4 snd_hda_codec_conexant ecb snd_hda_intel iwlagn snd_hda_codec iwlcore mac80211 snd_hwdep snd_seq snd_seq_device snd_pcm snd_timer snd_page_alloc uvcvideo btusb cfg80211 bluetooth thinkpad_acpi i2c_i801 videodev iTCO_wdt snd e1000e iTCO_vendor_support v4l1_compat pcspkr rfkill wmi soundcore joydev microcode sdhci_pci sdhci firewire_ohci mmc_core firewire_core yenta_socket crc_itu_t i915 drm_kms_helper drm i2c_algo_bit i2c_core video output [last unloaded: scsi_wait_scan]
<4>Modules linked in: snd_usb_audio snd_usbmidi_lib snd_ra_cpufreq mperf ip6t_REJECT nf_conntrack_ipv6 nf_defrag_ipv6 ip6table_filter ip6_tables ipv6 uinput arc4 snd_hda_codec_conexant ecb snd_hda_intel iwlagn snd_hda_codec iwlcore mac80211 snd_hwdep snd_seq snd_seq_device snd_pcm snd_timer snd_page_alloc uvcvideo btusb cfg80211 bluetooth thinkpad_acpi i2c_i801 videodev iTCO_wdt snd e1000e iTCO_vendor_support v4l1_compat pcspkr rfkill wmi soundcore joydev microcode sdhci_pci sdhci firewire_ohci mmc_core firewire_core yenta_socket crc_itu_t i915 drm_kms_helper drm i2c_algo_bit i2c_core video output [last unloaded: scsi_wait_scan]
<4>
<4>Pid: 2478, comm: udevd Not tainted 2.6.37 #3 406227U/406227U
<4>EIP: 0060:[<c04c8d0c>] EFLAGS: 00000286 CPU: 0
eed_resched+0x19/0x23
<4> [<c042aa2e>] ?
<4>ESI: ec44a400 EDI: f4402500 EBP: ec431cac ESP: ec431ca8
08c97>] ? verify_iovec+0x43/0x78
<4> [<c07006ek.ti=ec430000)
<0>Stack:
<4> 00000286 ec431cb8 c04c8d34 0000008b ec431cd4 c04cb66a c07074b8 ec431cd4
<4> [<c04d4cc2>] ? fget_light+0x2f/0x5c
<4> [<c0702072>] sys_recvmsg+0x30/0x48
c0709866
<0>Call Trace:
<4> [<c04c8d34>] ? arch_local_irq_save+0xb/0x18
x2d
<3>BUG: scheduling while atob8>] ? skb_release_data+0x7c/0x80
onsole configfs sit tunnel4 fuse aes_iemand acpi_cpufreq mperf ip6t_REJECT nf_conntrack_ipv6 nf_defrag_ipv6 ip6table_filter ip6_tables ipv6 uinput arc4 snd_hda_codec_conexant ecb snd_hda_intel iwlagn snd_hda_codec iwlcore mac80211 snd_hwdep snd_seq snd_seq_device snd_pcm snd_timer snd_page_alloc uvcvideo btusb cfg80211 bluetooth thinkpad_acpi i2c_i801 videodev iTCO_wdt snd e1000e iTCO_vendor_support v4l1_compat pcspkr rfkill wmi soundcore joydev microcode sdhci_pci sdhci firewire_ohci mmc_core firewire_core yenta_socket crc_itu_t i915 drm_kms_helper drm i2c_algo_bit i2c_core video output [last unloaded: scsi_wait_scan]
<4>Modules linked in: snd_usb_audio snd_usbmidi_lib snd_rank+0xc/0x10
<4> [<c040335f>] ? sysenter_do_call+0x12/0x2d
<0>Code: 00 00 8d 65 f4 89 d0 5b 5e 5f 5d c3 90 90 90 55 89 e5 3e 8d 74 26 00 8d 50 ff 83 c8 ff c1 ea 0b 40 d1 ea 75 fb 5d c3 55 89 e5 9c <58> 8d 74 26 00 5d c3 55 89 e5 50 9d 8d 74 26 00 5d c3 55 89 e5 
<4>Call Trace:
<4> [<c04c8d34>] arch_local_irq_save+0xb/0x18
<4> [<c04cb66a>] kfree+0x70/0xd5
<4> [<c07074b8>] ? skb_release_data+0x7c/0x80
<4> [<c07074b8>] skb_release_data+0x7c/0x80
<4> [<c0707677>] __kfree_skb+0x17/0x74
<4> [<c070772c>] consume_skb+0x58/0x5c
<4> [<c0709866>] skb_free_datagram+0x12/0x1c
<4> [<c072803d>] netlink_recvmsg+0x140/0x25e
<4> [<c0700089>] __sock_recvmsg+0x63/0x6d
<4> [<c070021f>] sock_recvmsg+0x9b/0xb00 ? need_resched+0x19/0x23
0 EDX: c07074b8
<4>ESI: ec44a400 EDI: f4402500 EBP: ec431cac ESP: ec431ca8
08c97>] ? verify_iovec+0x43/0x78
<4> [<c07006ek.ti=ec430000)
<0>Stack:
<4> 00000286 ec431cb8 c04c8d34 0000008b ec431cd4 c04cb66a c07074b8 ec431cd4
<4> [<c04d4cc2>] ? fget_light+0x2f/0x5c
<4> [<c0702072>] sys_recvmsg+0x30/0x48
c0709866
<0>Call Trace:
<4> [<c04c8d34>] ? arch_local_irq_save+0xb/0x18
x2d
<3>BUG: scheduling while atob8>] ? skb_release_data+0x7c/0x80
onsole configfs sit tunnel4 fuse aes_iemand acpi_cpufreq mperf ip6t_REJECT nf_conntrack_ipv6 nf_defrag_ipv6 ip6table_filter ip6_tables ipv6 uinput arc4 snd_hda_codec_conexant ecb snd_hda_intel iwlagn snd_hda_codec iwlcore mac80211 snd_hwdep snd_seq snd_seq_device snd_pcm snd_timer snd_page_alloc uvcvideo btusb cfg80211 bluetooth thinkpad_acpi i2c_i801 videodev iTCO_wdt snd e1000e iTCO_vendor_support v4l1_compat pcspkr rfkill wmi soundcore joydev microcode sdhci_pci sdhci firewire_ohci mmc_core firewire_core yenta_socket crc_itu_t i915 drm_kms_helper drm i2c_algo_bit i2c_core video output [last unloaded: scsi_wait_scan]
<4>Modules linked in: snd_usb_audio snd_usbmidi_lib snd_ra_cpufreq mperf ip6t_REJECT nf_conntrack_ipv6 nf_defrag_ipv6 ip6table_filter ip6_tables ipv6 uinput arc4 snd_hda_codec_conexant ecb snd_hda_intel iwlagn snd_hda_codec iwlcore mac80211 snd_hwdep snd_seq snd_seq_device snd_pcm snd_timer snd_page_alloc uvcvideo btusb cfg80211 bluetooth thinkpad_acpi i2c_i801 videodev iTCO_wdt snd e1000e iTCO_vendor_support v4l1_compat pcspkr rfkill wmi soundcore joydev microcode sdhci_pci sdhci firewire_ohci mmc_core firewire_core yenta_socket crc_itu_t i915 drm_kms_helper drm i2c_algo_bit i2c_core video output [last unloaded: scsi_wait_scan]
<4>
<4>Pid: 2478, comm: udevd Not tainted 2.6.37 #3 406227U/406227U
<4>EIP: 0060:[<c04c8d0c>] EFLAGS: 00000286 CPU: 0
eed_resched+0x19/0x23
<4> [<c042aa2e>] ? should_resched+0xd/0x28
500 EBP: ec431cac ESP: ec431ca8
<4> DS: 00 ? verify_iovec+0x43/0x78
<4> [<c07006e2>] __sys_recvmsg+0x105/0x19c
0286 ec431cb8 c04c8d34 0000008b ec431cd4 c04cb66a c07074b8 ec431cd4
<4> [<c04d4cc2>] ? fget_light+0x2f/0x5c
<4> [<c0702072>] sys_recvmsg+0x30ec431d0c c0709866
irqs_on_thunb66a>] ? kfree+0x70/0xd5
: udevd/2478/0x10010100
<4>Modules linked infigfs sit tunnel4 fuse aes_i586 aes_generic rfcomm sco bnep l2cap coretemp cpufreq_ondemand acpi_cpufreq mperf ip6t_REJECT nf_conntrack_ipv6 nf_defrag_ipv6 ip6table_filter ip6_tables ipv6 uinput arc4 snd_hda_codec_conexant ecb snd_hda_intel iwlagn snd_hda_codec iwlcore mac80211 snd_hwdep snd_seq snd_seq_device snd_pcm snd_timer snd_page_alloc uvcvideo btusb cfg80211 bluetooth thinkpad_acpi i2c_i801 videodev iTCO_wdt snd e1000e iTCO_vendor_support v4l1_compat pcspkr rfkill wmi soundcore joydev microcode sdhci_pci sdhci firewire_ohci mmc_core firewire_core yenta_socket crc_itu_t i915 drm_kms_helper drm i2c_algo_bit i2c_core video output [last unloaded: scsi_wait_scan]
<4>Modules linked in: snd_usb_audio snd_usbmidi_lib snd_ra_cpufreq mperf ip6t_REJECT nf_conntrack_ipv6 nf_defrag_ipv6 ip6table_filter ip6_tables ipv6 uinput arc4 snd_hda_codec_conexant ecb snd_hda_intel iwlagn snd_hda_codec iwlcore mac80211 snd_hwdep snd_seq snd_seq_device snd_pcm snd_timer snd_page_alloc uvcvideo btusb cfg80211 bluetooth thinkpad_acpi i2c_i801 videodev iTCO_wdt snd e1000e iTCO_vendor_support v4l1_compat pcspkr rfkill wmi soundcore joydev microcode sdhci_pci sdhci firewire_ohci mmc_core firewire_core yenta_socket crc_itu_t i915 drm_kms_helper drm i2c_algo_bit i2c_core video output [last unloaded: scsi_wait_scan]
<4>
<4>Pid: 2478, comm: udevd Not tainted 2.6.37 #3 406227U/406227U
<4>EIP: 0060:[<c04c8d0c>] EFLAGS: 00000286 CPU: 0
eed_resched+0x19/0x23
<4> [<c042aa2e>] ?
<4>ESI: ec44a400 EDI: f4402500 EBP: ec431cac ESP: ec431ca8
08c97>] ? verify_iovec+0x43/0x78
<4> [<c07006ek.ti=ec430000)
<0>Stack:
<4> 00000286 ec431cb8 c04c8d34 0000008b ec431cd4 c04cb66a c07074b8 ec431cd4
<4> [<c04d4cc2>] ? fget_light+0x2f/0x5c
<4> [<c0702072>] sys_recvmsg+0x30ec431d0c c0709866
irqs_on_thunk+0xc/0x10
+0x70/0xd5
<4> [<c07074b8>] ? skb_releaseModules linked ib+0x58/0x5c
<4> [<c0709866>] ? skb_free_datagram+0x12/0x1c
<4> [<c072803d>] ? netlink_recvmsg+0x140/0x25e
<4> [<c0700089>] ? __sock_recvmsg+0x63/0x6d
<4> [<c070021f>] ? sock_recvmsg+0x9b/0xb0
<4> [<c070030e>] ? sock_sendmsg+0x98/0xac
<4> [<c042aa17>] ? need_resched+0x19/0x23
<4> [<c042aa2e>] ? should_resched+0xd/0x28
<4> [<c05b2a6e>] ? _copy_from_user+0x3e/0x52
<4> [<c0708961>] ? copy_from_user+0xd/0xf
<4> [<c0708c97>] ? verify_iovec+0x43/0x78
<4> [<c07006e2>] ? __sys_recvmsg+0x105/0x19c
<4> [<c0700184>] ? sock_recvmsg+0x0/0xb0
<4> [<c07007a7>] ? sockfd_lookup_light+0x1b/0x48
<4> [<c0701b61>] ? sys_sendto+0x120/0x142
<4> [<c04d4cc2>] ? fget_light+0x2f/0x5c
<4> [<c0702072>] ? sys_recvmsg+0x30/0x48
<4> [<c07023eb>] ? sys_sockeneric rfcomm sco bip6_tables ipv6 uinput arc4 snd_hda_codec_conexant ecb snd_hda_intel iwlagn snd_hda_codec iwlcore mac80211 snd_hwdep snd_seq snd_seq_device snd_pcm snd_timer snd_page_alloc uvcvideo btusb cfg80211 bluetooth thinkpad_acpi i2c_i801 videodev iTCO_wdt snd e1000e iTCO_vendor_support v4l1_compat pcspkr rfkill wmi soundcore joydev microcode sdhci_pci sdhci firewire_ohci mmc_core firewire_core yenta_socket crc_itu_t i915 drm_kms_helper drm i2c_algo_bit i2c_core video output [last unloaded: scsi_wait_scan]
<4>
<4>Pid: 2478, comm: udevd Not tainted 2.6.37 #3 406227U/406227U
<4>EIP: 0060:[<c04c8d0c>] EFLAGS: 00000286 CPU: 0
eed_resched+0x19/0x23
<4> [<c042aa2e>] ?
<4>ESI: ec44a400 EDI: f4402500 EBP: ec431cac ESP: ec431ca8
08c97>] ? verify_iovec+0x43/0x78
<4> [<c07006e2>] __sys_recvmsg+0x105/0x19c
0286 ec431cb8 c04c8d34 0000008b ec431c01b61>] ? sys_sendto+0x120/0x142
c0 ec431cf0
<4> c0707677 f177d200 ec4s_socketcall+0x177/0x1a8
<4> [<c05b25e0>] ? trace_hardirqs_on_thunk+0xc/0x10
+0x70/0xd5
<4> [<c07074b8>] ? skb_release_data+0x7c/0x80
snd_usb_audio snd_usbmidi_lib snd_rawmidi nq mperf ip6t_REJECT nf_conntrack_ipv6 nf_defrag_ipv6 ip6table_filter ip6_tables ipv6 uinput arc4 snd_hda_codec_conexant ecb snd_hda_intel iwlagn snd_hda_codec iwlcore mac80211 snd_hwdep snd_seq snd_seq_device snd_pcm snd_timer snd_page_alloc uvcvideo btusb cfg80211 bluetooth thinkpad_acpi i2c_i801 videodev iTCO_wdt snd e1000e iTCO_vendor_support v4l1_compat pcspkr rfkill wmi soundcore joydev microcode sdhci_pci sdhci firewire_ohci mmc_core firewire_core yenta_socket crc_itu_t i915 drm_kms_helper drm i2c_algo_bit i2c_core video output [last unloaded: scsi_wait_scan]
<4>Modules linked in: snd_usb_audio snd_usbmidi_lib snd_rawmidi netconsole configfs sit tunnel4 fuse aes_i586 aes_ge<0>Code: 00 00 8d 65 f4 89 d0 5b 5e 5f 5d c3 90 90 90 55 89 e5 3e 8d 74 26 00 8d 50 ff 83 c8 ff c1 ea 0b 40 d1 ea 75 fb 5d c3 55 89 e5 9c <58> 8d 74 26 00 5d c3 55 89 e5 50 9d 8d 74 26 00 5d c3 55 89 e5 
<4>Call Trace:
<4> [<c04c8d34>] arch_local_irq_save+0xb/0x18
<4> [<c04cb66a>] kfree+0x70/0xd5
<4> [<c07074b8>] ? skb_release_data+0x7c/0x80
<4> [<c07074b8>] skb_release_data+0x7c/0x80
<4> [<c0707677>] __kfree_skb+0x17/0x74
<4> [<c070772c>] consume_skb+0x58/0x5c
<4> [<c0709866>] skb_free_datagram+0x12/0x1c
<4> [<c072803d>] netlink_recvmsg+0x140/0x25e
<4> [<c0700089>] __sock_recvmsg+0x63/0x6d
<4> [<c070021f>] sock_recvmsg+0x9b/0xb00 ? need_resched+0x19/0x23
0 EDX: c07074b8
<4>ESI: ec44a400 EDI: f41>] ? copy_from_user+0xd/0xf
<4> [<c0708c97>] ? verify_iovec+0x43/0x78
724c80 task.ti=ec430000)
<0>Stack:
<4> 0? sockfd_lookup_light+0x1b/0x48
<4> [<c0701b61>] ? sys_sendto+0x120/0x142
c0 ec431cf0
<4> c0707677 f177d200 ec431d00 c070772c f177d200 f3f120e4 ec431d0c c0709866
irqs_on_thunb66a>] ? kfree+0x70/0xd5
: udevd/2478/0x10010100
<4>Modules linked infigfs sit tunnel4 fuse aes_i586 aes_generic rfcomm sco bnep l2cap coretemp cpufreq_ondemand acpi_cpufreq mperf ip6t_REJECT nf_conntrack_ipv6 nf_defrag_ipv6 ip6table_filter ip6_tables ipv6 uinput arc4 snd_hda_codec_conexant ecb snd_hda_intel iwlagn snd_hda_codec iwlcore mac80211 snd_hwdep snd_seq snd_seq_device snd_pcm snd_timer snd_page_alloc uvcvideo btusb cfg80211 bluetooth thinkpad_acpi i2c_i801 videodev iTCO_wdt snd e1000e iTCO_vendor_support v4l1_compat pcspkr rfkill wmi soundcore joydev microcode sdhci_pci sdhci firewire_ohci mmc_core firewire_core yenta_socket crc_itu_t i915 drm_kms_helper drm i2c_algo_bit i2c_core video output [last unloaded: scsi_wait_scan]
<4>Modules linked in: snd_usb_audio snd_usbmidi_lib snd_ra_cpufreq mperf ip6t_REJECT nf_conntrack_ipv6 nf_defrag_ipv6 ip6table_filter ip6_tables ipv6 uinput arc4 snd_hda_codec_conexant ecb snd_hda_intel iwlagn snd_hda_codec iwlcore mac80211 snd_hwdep snd_seq snd_seq_device snd_pcm snd_timer snd_page_alloc uvcvideo btusb cfg80211 bluetooth thinkpad_acpi i2c_i801 videodev iTCO_wdt snd e1000e iTCO_vendor_support v4l1_compat pcspkr rfkill wmi soundcore joydev microcode sdhci_pci sdhci firewire_ohci mmc_core firewire_core yenta_socket crc_itu_t i915 drm_kms_helper drm i2c_algo_bit i2c_core video output [last unloaded: scsi_wait_scan]
<4>
<4>Pid: 2478, comm: udevd Not tainted 2.6.37 #3 406227U/406227U
<4>EIP: 0060:[<c04c8d0c>] EFLAGS: 00000286 CPU: ] ? need_resched+0x19/0x23
0 EDX: c07074b8
<4>ESI: ec44a400 EDI: f4402500 EBP: ec431cac ESP: ec431ca8
08c97>] ? verify_iovec+0x43/0x78
<4> [<c07006ek.ti=ec430000)
<0>Stack:
<4> 00000286 ec431cb8 c04c8d34 0000008b ec431cd4 c04cb66a c07074b8 ec431cd4
<4> [<c04d4cc2>] ? fget_light+0x2f/0x5c
<4> [<c0702072>] sys_recvmsg+0x30ec431d0c c0709866
irqs_on_thunb66a>] ? kfree+0x70/0xd5
: udevd/2478/0x10010100
<4>Modules linked infigfs sit tunnel4 fuse aes_i586 aes_generic rfcomm sco bnep l2cap coretemp cpufreq_ondemand acpi_cpufreq mperf ip6t_REJECT nf_conntrack_ipv6 nf_defrag_ipv6 ip6table_filter ip6_tables ipv6 uinput arc4 snd_hda_codec_conexant ecb snd_hda_intel iwlagn snd_hda_codec iwlcore mac80211 snd_hwdep snd_seq snd_seq_device snd_pcm snd_timer snd_page_alloc uvcvideo btusb cfg80211 bluetooth thinkpad_acpi i2c_i801 videodev iTCO_wdt snd e1000e iTCO_vendor_support v4l1_compat pcspkr rfkill wmi soundcore joydev microcode sdhci_pci sdhci firewire_ohci mmc_core firewire_core yenta_socket crc_itu_t i915 drm_kms_helper drm i2c_algo_bit i2c_core video output [last unloaded: scsi_wait_scan]
<4>Modules linked in: snd_usb_audio snd_usbmidi_lib snd_ra_cpufreq mperf ip6t_REJECT nf_conntrack_ipv6 nf_defrag_ipv6 ip6table_filter ip6_tables ipv6 uinput arc4 snd_hda_codec_conexant ecb snd_hda_intel iwlagn snd_hda_codec iwlcore mac80211 snd_hwdep snd_seq snd_seq_device snd_pcm snd_timer snd_page_alloc uvcvideo btusb cfg80211 bluetooth thinkpad_acpi i2c_i801 videodev iTCO_wdt snd e1000e iTCO_vendor_support v4l1_compat pcspkr rfkill wmi soundcore joydev microcode sdhci_pci sdhci firewire_ohci mmc_core firewire_core yenta_socket crc_itu_t i915 drm_kms_helper drm i2c_algo_bit i2c_core video output [last unloaded: scsi_wait_scan]
<4>
<4>Pid: 2478, comm: udevd Not tainted 2.6.37 #3 406227U/406227U
<4>EIP: 0060:[<c04c8d0c>] EFLAGS: 00000286 CPU: ] ? need_resched+0x19/0x23
0 EDX: c07074b8
<4>ESI: ec44a400 EDI: f41>] ? copy_from_user+0xd/0xf
<4> [<c0708c97>] ? verify_iovec+0x43/0x78
724c80 task.ti=ec430000)
<0>Stack:
<4> 0? sockfd_lookup_light+0x1b/0x48
<4> [<c0701b61>] ? sys_sendto+0x120/0x142
c0 ec431cf0
<4> c0707677 f177d200 ec431d00 c070772c f177d200 f3f120e4 ec431d0c c0709866
irqs_on_thunb66a>] ? kfree+0x70/0xd5
: udevd/2478/0x10010100
<4>Modules linked i
<4> [<c072803d>] ? netlink_recvmsg+0x140/0x25e
<4> [<c0700089>] ? __sock_recvmsg+0x63/0x6d
<4> [<c070021f>] ? sock_recvmsg+0x9b/0xb0
<4> [<c070030e>] ? sock_sendmsg+0x98/0xac
<4> [<c042aa17>] ? need_resched+0x19/0x23
<4> [<c042aa2e>] ? should_resched+0xd/0x28
<4> [<c05b2a6e>] ? _copy_from_user+0x3e/0x52
<4> [<c0708961>] ? copy_from_user+0xd/0xf
<4> [<c0708c97>] ? verify_iovec+0x43/0x78
<4> [<c07006e2>] ? __sys_recvmsg+0x105/0x19c
<4> [<c0700184>] ? sock_recvmsg+0x0/0xb0
<4> [<c07007a7>] ? sockfd_lookup_light+0x1b/0x48
<4> [<c0701b61>] ? sys_sendto+0x120/0x142
<4> [<c04d4cc2>] ? fget_light+0x2f/0x5c
<4> [<c0702072>] ? sys_recvmsg+0x30/0x48
<4> [<c07023eb>] ? sys_socketcall+0x177/0x1a8
<4> [<c05b25e0>] ? trace_hardirqs_on_thunk+0xc/0x10
ip6t_REJECT nf_conntrack_ipv6 nf_defrag_ipvc_conexant ecb snd_hda_intel iwlagn snd_hda_codec iwlcore mac80211 snd_hwdep snd_seq snd_seq_device snd_pcm snd_timer snd_page_alloc uvcvideo btusb cfg80211 bluetooth thinkpad_acpi i2c_i801 videodev iTCO_wdt snd e1000e iTCO_vendor_support v4l1_compat pcspkr rfkill wmi soundcore joydev microcode sdhci_pci sdhci firewire_ohci mmc_core firewire_core yenta_socket crc_itu_t i915 drm_kms_helper drm i2c_algo_bit i2c_core video output [last unloaded: scsi_wait_scan]
<4>
<4>Pid: 2478, comm: udevd Not tainted 2.6.37 #3 406227U/406227U
0e>] ? sock_sendmsg+0x98/0xac
<4> [<c042aa17>] 0 EBX: f61cd940 ECX: 00000000 EDX: c07074b8
3e/0x52
<4> [<c0708961>] ? copy_from_user+0xd/0xf
<4> [<s udevd (pid: 2478, ti=f4408000 task=f1724c80 task.ti=ec430000)
<c07007a7>] ? sockfd_lookup_light+0x1b/0x48
ec431d40 ec431ce4 c07074b8 f3f120c0 f3fys_recvmsg+0x30/0x48
c0709866
<0>Call Trace:
<4> [<c04c8d34>] c040335f>] sysenter_do_call+0x12/0x2d
ta+0x7c/0x80
<4> [<c07074b8>] ? skb_release_data+0x7wmidi nam+0x12/0x1c
<4> [<c072803d>] ? netlink_recvmsg+0x140/0x25e
<4> [<c0700089>] ? __sock_recvmsg+0x63/0x6d
<4> [<c070021f>] ? sock_recvmsg+0x9b/0xb0
<4> [<c070030e>] ? sock_sendmsg+0x98/0xac
<4> [<c042aa17>] ? need_resched+0x19/0x23
<4> [<c042aa2e>] ? should_resched+0xd/0x28
<4> [<c05b2a6e>] ? _copy_from_user+0x3e/0x52
<4> [<c0708961>] ? copy_from_user+0xd/0xf
<4> [<c0708c97>] ? verify_iovec+0x43/0x78
<4> [<c07006e2>] ? __sys_recvmsg+0x105/0x19c
<4> [<c0700184>] ? sock_recvmsg+0x0/0xb0
<4> [<c07007a7>] ? sockfd_lookup_light+0x1b/0x48
<4> [<c0701b61>] ? sys_sendto+0x120/0x142
<4> [<c04d4cc2>] ? fget_light+0x2f/0x5c
<4> [<c0702072>] ? sys_recvmsg+0x30/0x48
<4> [<c07023eb>] ? sys_sockeneric rfcomm sco b65 f4 89 d0 5b 5e 5f 5d c3 90 90 90 55 89 e5 3e 8d 74 26 00 8d 50 ff 83 c8 ff c1 ea 0b 40 d1 ea 75 fb 5d c3 55 89 e5 9c <58> 8d 74 26 00 5d c3 55 89 e5 50 9d 8d 74 26 00 5d c3 55 89 e5 
<4>Call Trace:
<4> [<c04c8d34>] arch_local_irq_save+0xb/0x18
<4> [<c04cb66a>] kfree+0x70/0xd5
<4> [<c07074b8>] ? skb_release_data+0x7c/0x80
<4> [<c07074b8>] skb_release_data+0x7c/0x80
<4> [<c0707677>] __kfree_skb+0x17/0x74
<4> [<c070772c>] consume_skb+0x58/0x5c
<4> [<c0709866>] skb_free_datagram+0x12/0x1c
<4> [<c072803d>] netlink_recvmsg+0x140/0x25e
<4> [<c0700089>] __sock_recvmsg+0x63/0x6d
<4> [<c070021f>] sock_recvmsg+0x9b/0xb00 ? need_resched+0x19/0x23
0 EDX: c07074b8
<4>ESI: ec44a400 EDI: f41>] ? copy_from_user+0xd/0xf
<4> [<c0708c97>] ? verify_iovec+0x43/0x78
724c80 task.ti=ec430000)
<0>Stack:
<4> 00000286 ec431cb8 c04c8d34 0000008b ec431cd4 c04cb66a c07074b8 ec431cd4
<4> [<c04d4cc2>] ? fget_light+0x2f/0x5c
<4> [<c0702072>] sys_recvmsg+0x30ec431d0c c0709866
irqs_on_thunk+0xc/0x10
+0x70/0xd5
<4> [<c07074b8>] ? skb_release_data+0x7c/0x80
snd_usb_audio snd_usbmidi_lib snd_rawmidi nam+0x12/0x1c
<4> [<c072803d>] ? netlink_recvmsg+0x140/0x25e
<4> [<c0700089>] ? __sock_recvmsg+0x63/0x6d
<4> [<c070021f>] ? sock_recvmsg+0x9b/0xb0
<4> [<c070030e>] ? sock_sendmsg+0x98/0xac
<4> [<c042aa17>] ? need_resched+0x19/0x23
<4> [<c042aa2e>] ? should_resched+0xd/0x28
<4> [<c05b2a6e>] ? _copy_from_user+0x3e/0x52
<4> [<c0708961>] ? copy_from_user+0xd/0xf
<4> [<c0708c97>] ? verify_iovec+0x43/0x78
<4> [<c07006e2>] ? __sys_recvmsg+0x105/0x19c
<4> [<c0700184>] ? sock_recvmsg+0x0/0xb0
<4> [<c07007a7>] ? sockfd_lookup_light+0x1b/0x48
<4> [<c0701b61>] ? sys_sendto+0x120/0x142
<4> [<c04d4cc2>] ? fget_light+0x2f/0x5c
<4> [<c0702072>] ? sys_recvmsg+0x30/0x48
<4> [<c07023eb>] ? sys_sockeneric rfcomm sco b65 f4 89 d0 5b 5e 5f 5d c3 90 90 90 55 89 e5 3e 8d 74 26 00 8d 50 ff 83 c8 ff c1 ea 0b 40 d1 ea 75 fb 5d c3 55 89 e5 9c <58> 8d 74 26 00 5d c3 55 89 e5 50 9d 8d 74 26 00 5d c3 55 89 e5 
<4>Call Trace:
<4> [<c04c8d34>] arch_local_irq_save+0xb/0x18
<4> [<c04cb66a>] kfree+0x70/0xd5
<4> [<c07074b8>] ? skb_release_data+0x7c/0x80
<4> [<c07074b8>] skb_release_data+0x7c/0x80
<4> [<c0707677>] __kfree_skb+0x17/0x74
<4> [<c070772c>] consume_skb+0x58/0x5c
<4> [<c0709866>] skb_free_datagram+0x12/0x1c
<4> [<c072803d>] netlink_recvmsg+0x140/0x25e
<4> [<c0700089>] __sock_recvmsg+0x63/0x6d
<4> [<c070021f>] sock_recvmsg+0x9b/0xb00
eed_resched+0x19/0x23
<4> [<c042aa2e>] ?
<4>ESI: ec44a400 EDI: f4402500 EBP: ec431cac ESP: ec431ca8
08c97>] ? verify_iovec+0x43/0x78
<4> [<c07006e2>] __sys_recvmsg+0x105/0x19c
0286 ec431cb8 c04c8d34 0000008b ec431cd4 c04cb66a c07074b8 ec431cd4
<4> [<c04d4cc2>] ? fget_light+0x2f/0x5c
<4> [<c0702072>] sys_recvmsg+0x30/0x48
c0709866
<0>Call Trace:
<4> [<c04c8d34>] ? arch_local_irq_save+0xb/0x18
x2d
<3>BUG: scheduling while atomic: udevd/2478/0x10010100
c>] ? consume_skb+0x58/0x5c
<4> [<c0709866>] ? skb_free_datagram+0x12/0x1c
<4> [<c072803d>] ? netlink_recvmsg+0x140/0x25e
<4> [<c0700089>] ? __sock_recvmsg+0x63/0x6d
<4> [<c070021f>] ? sock_recvmsg+0x9b/0xb0
<4> [<c070030e>] ? sock_sendmsg+0x98/0xac
<4> [<c042aa17>] ? need_resched+0x19/0x23
<4> [<c042aa2e>] ? should_resched+0xd/0x28
<4> [<c05b2a6e>] ? _copy_from_user+0x3e/0x52
<4> [<c0708961>] ? copy_from_user+0xd/0xf
<4> [<c0708c97>] ? verify_iovec+0x43/0x78
<4> [<c07006e2>] ? __sys_recvmsg+0x105/0x19c
<4> [<c0700184>] ? sock_recvmsg+0x0/0xb0
<4> [<c07007a7>] ? sockfd_lookup_light+0x1b/0x48
<4> [<c0701b61>] ? sys_sendto+0x120/0x142
<4> [<c04d4cc2>] ? fget_light+0x2f/0x5c
<4> [<c0702072>] ? sys_recvmsg+0x30/0x48
<4> [<c07023eb>] ? sys_sockeneric rfcomm sco b65 f4 89 d0 5b 5e 5f 5d c3 90 90 90 55 89 e5 3e 8d 74 26 00 8d 50 ff 83 c8 ff c1 ea 0b 40 d1 ea 75 fb 5d c3 55 89 e5 9c <58> 8d 74 26 00 5d c3 55 89 e5 50 9d 8d 74 26 00 5d c3 55 89 e5 
<4>Call Trace:
<4> [<c04c8d34>] arch_local_irq_save+0xb/0x18
<4> [<c04cb66a>] kfree+0x70/0xd5
<4> [<c07074b8>] ? skb_release_data+0x7c/0x80
<4> [<c07074b8>] skb_release_data+0x7c/0x80
<4> [<c0707677>] __kfree_skb+0x17/0x74
<4> [<c070772c>] consume_skb+0x58/0x5c
<4> [<c0709866>] skb_free_datagram+0x12/0x1c
<4> [<c072803d>] netlink_recvmsg+0x140/0x25e
<4> [<c0700089>] __sock_recvmsg+0x63/0x6d
<4> [<c070021f>] sock_recvmsg+0x9b/0xb00 ? need_resched+0x19/0x23
0 EDX: c07074b8
<4>ESI: ec44a400 EDI: f4402500 EBP: ec431cac ESP: ec431ca8
08c97>] ? verify_iovec+0x43/0x78
<4> [<c07006ek.ti=ec430000)
<0>Stack:
<4> 00000286 ec431cb8 c04c8d34 0000008b ec431cd4 c04cb66a c07074b8 ec431cd4
<4> [<c04d4cc2>] ? fget_light+0x2f/0x5c
<4> [<c0702072>] sys_recvmsg+0x30/0x48
c0709866
<0>Call Trace:
<4> [<c04c8d34>] ? arch_local_irq_save+0xb/0x18
x2d
<3>BUG: scheduling while atomic: udevd/2478/0x10010100
c>] ? consume_skb+0x58/0x5c
<4> [<c0709866>] ? skb_free_datagram+0x12/0x1c
<4> [<c072803d>] ? netlink_recvmsg+0x140/0x25e
<4> [<c0700089>] ? __sock_recvmsg+0x63/0x6d
<4> [<c070021f>] ? sock_recvmsg+0x9b/0xb0
<4> [<c070030e>] ? sock_sendmsg+0x98/0xac
<4> [<c042aa17>] ? need_resched+0x19/0x23
<4> [<c042aa2e>] ? should_resched+0xd/0x28
<4> [<c05b2a6e>] ? _copy_from_user+0x3e/0x52
<4> [<c0708961>] ? copy_from_user+0xd/0xf
<4> [<c0708c97>] ? verify_iovec+0x43/0x78
<4> [<c07006e2>] ? __sys_recvmsg+0x105/0x19c
<4> [<c0700184>] ? sock_recvmsg+0x0/0xb0
<4> [<c07007a7>] ? sockfd_lookup_light+0x1b/0x48
<4> [<c0701b61>] ? sys_sendto+0x120/0x142
<4> [<c04d4cc2>] ? fget_light+0x2f/0x5c
<4> [<c0702072>] ? sys_recvmsg+0x30/0x48
<4> [<c07023eb>] ? sys_sockeneric rfcomm sco bip6_tables ipv6 uinput arc4 snd_hda_codec_conexant ecb snd_hda_intel iwlagn snd_hda_codec iwlcore mac80211 snd_hwdep snd_seq snd_seq_device snd_pcm snd_timer snd_page_alloc uvcvideo btusb cfg80211 bluetooth thinkpad_acpi i2c_i801 videodev iTCO_wdt snd e1000e iTCO_vendor_support v4l1_compat pcspkr rfkill wmi soundcore joydev microcode sdhci_pci sdhci firewire_ohci mmc_core firewire_core yenta_socket crc_itu_t i915 drm_kms_helper drm i2c_algo_bit i2c_core video output [last unloaded: scsi_wait_scan]
<4>
<4>Pid: 2478, comm: udevd Not tainted 2.6.37 #3 406227U/406227U
<4>EIP: 0060:[<c04c8d0c>] EFLAGS: 00000286 CPU: 0
eed_resched+0x19/0x23
<4> [<c042aa2e>] ?
<4>ESI: ec44a400 EDI: f4402500 EBP: ec431cac ESP: ec431ca8
08c97>] ? verify_iovec+0x43/0x78
<4> [<c07006e2>] __sys_recvmsg+0x105/0x19c
0286 ec431cb8 c04c8d34 0000008b ec431c01b61>] ? sys_sendto+0x120/0x142
c0 ec431cf0
<4> c0707677 f177d200 ec431d00 c070772c f177d200 f3f120e4 ec431d0c c0709866
irqs_on_thunb66a>] ? kfree+0x70/0xd5
: udevd/2478/0x10010100
<4>Modules linked ib+0x58/0x5c
<4> [<c0709866>] ? skb_free_datagram+0x12/0x1c
<4> [<c072803d>] ? netlink_recvmsg+0x140/0x25e
<4> [<c0700089>] ? __sock_recvmsg+0x63/0x6d
<4> [<c070021f>] ? sock_recvmsg+0x9b/0xb0
<4> [<c070030e>] ? sock_sendmsg+0x98/0xac
<4> [<c042aa17>] ? need_resched+0x19/0x23
<4> [<c042aa2e>] ? should_resched+0xd/0x28
<4> [<c05b2a6e>] ? _copy_from_user+0x3e/0x52
<4> [<c0708961>] ? copy_from_user+0xd/0xf
<4> [<c0708c97>] ? verify_iovec+0x43/0x78
<4> [<c07006e2>] ? __sys_recvmsg+0x105/0x19c
<4> [<c0700184>] ? sock_recvmsg+0x0/0xb0
<4> [<c07007a7>] ? sockfd_lookup_light+0x1b/0x48
<4> [<c0701b61>] ? sys_sendto+0x120/0x142
<4> [<c04d4cc2>] ? fget_light+0x2f/0x5c
<4> [<c0702072>] ? sys_recvmsg+0x30/0x48
<4> [<c07023eb>] ? sys_sockeneric rfcomm sco bip6_tables ipv6 uinput arc4 snd_hda_codec_conexant ecb snd_hda_intel iwlagn snd_hda_codec iwlcore mac80211 snd_hwdep snd_seq snd_seq_device snd_pcm snd_timer snd_page_alloc uvcvideo btusb cfg80211 bluetooth thinkpad_acpi i2c_i801 videodev iTCO_wdt snd e1000e iTCO_vendor_support v4l1_compat pcspkr rfkill wmi soundcore joydev microcode sdhci_pci sdhci firewire_ohci mmc_core firewire_core yenta_socket crc_itu_t i915 drm_kms_helper drm i2c_algo_bit i2c_core video output [last unloaded: scsi_wait_scan]
<4>
<4>Pid: 2478, comm: udevd Not tainted 2.6.37 #3 406227U/406227U
<4>EIP: 0060:[<c04c8d0c>] EFLAGS: 00000286 CPU: 0
eed_resched+0x19/0x23
<4> [<c042aa2e>] ?
<4>ESI: ec44a400 EDI: f4402500 EBP: ec431cac ESP: ec431ca8
08c97>] ? verify_iovec+0x43/0x78
<4> [<c07006e2>] __sys_recvmsg+0x105/0x19c
0286 ec431cb8 c04c8d34 0000008b ec431c01b61>] ? sys_sendto+0x120/0x142
c0 ec431cf0
<4> c0707677 f177d200 ec431d00 c070772c f177d200 f3f120e4 ec431d0c c0709866
irqs_on_thunb66a>] ? kfree+0x70/0xd5
: udevd/2478/0x10010100
<4>Modules linked ib+0x58/0x5c
<4> [<c0709866>] ? skb_free_datagram+0x12/0x1c
<4> [<c072803d>] ? netlink_recvmsg+0x140/0x25e
<4> [<c0700089>] ? __sock_recvmsg+0x63/0x6d
<4> [<c070021f>] ? sock_recvmsg+0x9b/0xb0
<4> [<c070030e>] ? sock_sendmsg+0x98/0xac
<4> [<c042aa17>] ? need_resched+0x19/0x23
<4> [<c042aa2e>] ? should_resched+0xd/0x28
<4> [<c05b2a6e>] ? _copy_from_user+0x3e/0x52
<4> [<c0708961>] ? copy_from_user+0xd/0xf
<4> [<c0708c97>] ? verify_iovec+0x43/0x78
<4> [<c07006e2>] ? __sys_recvmsg+0x105/0x19c
<4> [<c0700184>] ? sock_recvmsg+0x0/0xb0
<4> [<c07007a7>] ? sockfd_lookup_light+0x1b/0x48
<4> [<c0701b61>] ? sys_sendto+0x120/0x142
<4> [<c04d4cc2>] ? fget_light+0x2f/0x5c
<4> [<c0702072>] ? sys_recvmsg+0x30/0x48
<4> [<c07023eb>] ? sys_sockeneric rfcomm sco b65 f4 89 d0 5b 5e 5f 5d c3 90 90 90 55 89 e5 3e 8d 74 26 00 8d 50 ff 83 c8 ff c1 ea 0b 40 d1 ea 75 fb 5d c3 55 89 e5 9c <58> 8d 74 26 00 5d c3 55 89 e5 50 9d 8d 74 26 00 5d c3 55 89 e5 
<4>Call Trace:
<4> [<c04c8d34>] arch_local_irq_save+0xb/0x18
<4> [<c04cb66a>] kfree+0x70/0xd5
<4> [<c07074b8>] ? skb_release_data+0x7c/0x80
<4> [<c07074b8>] skb_release_data+0x7c/0x80
<4> [<c0707677>] __kfree_skb+0x17/0x74
<4> [<c070772c>] consume_skb+0x58/0x5c
<4> [<c0709866>] skb_free_datagram+0x12/0x1c
<4> [<c072803d>] netlink_recvmsg+0x140/0x25e
<4> [<c0700089>] __sock_recvmsg+0x63/0x6d
<4> [<c070021f>] sock_recvmsg+0x9b/0xb00
eed_resched+0x19/0x23
<4> [<c042aa2e>] ?
<4>ESI: ec44a400 EDI: f4402500 EBP: ec431cac ESP: ec431ca8
08c97>] ? verify_iovec+0x43/0x78
<4> [<c07006e2>] __sys_recvmsg+0x105/0x19c
0286 ec431cb8 c04c8d34 0000008b ec431c01b61>] ? sys_sendto+0x120/0x142
c0 ec431cf0
<4> c0707677 f177d200 ec431d00 c070772c f177d200 f3f120e4 ec431d0c c0709866
irqs_on_thunk+0xc/0x10
+0x70/0xd5
<4> [<c07074b8>] ? skb_release_data+0x7c/0x80
snd_usb_audio snd_usbmidi_lib snd_rawmidi nfcomm sco bnep l2cap coretemp cpufreq_ondemand acpi_cpufreq mperf ip6t_REJECT nf_conntrack_ipv6 nf_defrag_ipv6 ip6table_filter ip6_tables ipv6 uinput arc4 snd_hda_codec_conexant ecb snd_hda_intel iwlagn snd_hda_codec iwlcore mac80211 snd_hwdep snd_seq snd_seq_device snd_pcm snd_timer snd_page_alloc uvcvideo btusb cfg80211 bluetooth thinkpad_acpi i2c_i801 videodev iTCO_wdt snd e1000e iTCO_vendor_support v4l1_compat pcspkr rfkill wmi soundcore joydev microcode sdhci_pci sdhci firewire_ohci mmc_core firewire_core yenta_socket crc_itu_t i915 drm_kms_helper drm i2c_algo_bit i2c_core video output [last unloaded: scsi_wait_scan]
<4>Modules linked in: snd_usb_audio snd_usbmidi_lib snd_ra_cpufreq mperf ip6t_REJECT nf_conntrack_ipv6 nf_defrag_ipv6 ip6table_filter ip6_tables ipv6 uinput arc4 snd_hda_codec_conexant ecb snd_hda_intel iwlagn snd_hda_codec iwlcore mac80211 snd_hwdep snd_seq snd_seq_device snd_pcm snd_timer snd_page_alloc uvcvideo btusb cfg80211 bluetooth thinkpad_acpi i2c_i801 videodev iTCO_wdt snd e1000e iTCO_vendor_support v4l1_compat pcspkr rfkill wmi soundcore joydev microcode sdhci_pci sdhci firewire_ohci mmc_core firewire_core yenta_socket crc_itu_t i915 drm_kms_helper drm i2c_algo_bit i2c_core video output [last unloaded: scsi_wait_scan]
<4>
<4>Pid: 2478, comm: udevd Not tainted 2.6.37 #3 406227U/406227U
<4>EIP: 0060:[<c04c8d0c>] EFLAGS: 00000286 CPU: 0
eed_resched+0x19/0x23
<4> [<c042aa2e>] ? should_resched+0xd/0x28
500 EBP: ec431cac ESP: ec431ca8
<4> DS: 00 ? verify_iovec+0x43/0x78
<4> [<c07006e2>] __sys_recvmsg+0x105/0x19c
0286 ec431cb8 c04c8d34 0000008b ec431cd4 c04cb66a c07074b8 ec431cd4
<4> [<c04d4cc2>] ? fget_light+0x2f/0x5c
<4> [<c0702072>] sys_recvmsg+0x30/0x48
c0709866
<0>Call Trace:
<4> [<c04c8d34>] c040335f>] sysenter_do_call+0x12/0x2d
ta+0x7c/0x80
<4> [<c07074b8>] ? skb_release_data+0x7c/0x80
onsole configfs sit tunnel4 fuse aes_iemand acpi_cpufreq mperf ip6t_REJECT nf_conntrack_ipv6 nf_defrag_ipv6 ip6table_filter ip6_tables ipv6 uinput arc4 snd_hda_codec_conexant ecb snd_hda_intel iwlagn snd_hda_codec iwlcore mac80211 snd_hwdep snd_seq snd_seq_device snd_pcm snd_timer snd_page_alloc uvcvideo btusb cfg80211 bluetooth thinkpad_acpi i2c_i801 videodev iTCO_wdt snd e1000e iTCO_vendor_support v4l1_compat pcspkr rfkill wmi soundcore joydev microcode sdhci_pci sdhci firewire_ohci mmc_core firewire_core yenta_socket crc_itu_t i915 drm_kms_helper drm i2c_algo_bit i2c_core video output [last unloaded: scsi_wait_scan]
<4>Modules linked in: snd_usb_audio snd_usbmidi_lib snd_ra_cpufreq mperf ip6t_REJECT nf_conntrack_ipv6 nf_defrag_ipv6 ip6table_filter ip6_tables ipv6 uinput arc4 snd_hda_codec_conexant ecb snd_hda_intel iwlagn snd_hda_codec iwlcore mac80211 snd_hwdep snd_seq snd_seq_device snd_pcm snd_timer snd_page_alloc uvcvideo btusb cfg80211 bluetooth thinkpad_acpi i2c_i801 videodev iTCO_wdt snd e1000e iTCO_vendor_support v4l1_compat pcspkr rfkill wmi soundcore joydev microcode sdhci_pci sdhci firewire_ohci mmc_core firewire_core yenta_socket crc_itu_t i915 drm_kms_helper drm i2c_algo_bit i2c_core video output [last unloaded: scsi_wait_scan]
<4>
<4>Pid: 2478, comm: udevd Not tainted 2.6.37 #3 406227U/406227U
<4>EIP: 0060:[<c04c8d0c>] EFLAGS: 00000286 CPU: ] ? need_resched+0x19/0x23
0 EDX: c07074b8
<4>ESI: ec44a400 EDI: f4402500 EBP: ec431cac ESP: ec431ca8
08c97>] ? verify_iovec+0x43/0x78
<4> [<c07006ek.ti=ec430000)
<0>Stack:
<4> 00000286 ec431cb8 c04c8d34 0000008b ec431cd4 c04cb66a c07074b8 ec431cd4
<4> [<c04d4cc2>] ? fget_light+0x2f/0x5c
<4> [<c0702072>] sys_recvmsg+0x30/0x48
c0709866
<0>Call Trace:
<4> [<c04c8d34>] c040335f>] sysenter_do_call+0x12/0x2d
ta+0x7c/0x80
<4> [<c07074b8>] ? skb_release_data+0x7c/0x80
onsole configfs sit tunnel4 fuse aes_iemand acpi_cpufreq mperf ip6t_REJECT nf_conntrack_ipv6 nf_defrag_ipv6 ip6table_filter ip6_tables ipv6 uinput arc4 snd_hda_codec_conexant ecb snd_hda_intel iwlagn snd_hda_codec iwlcore mac80211 snd_hwdep snd_seq snd_seq_device snd_pcm snd_timer snd_page_alloc uvcvideo btusb cfg80211 bluetooth thinkpad_acpi i2c_i801 videodev iTCO_wdt snd e1000e iTCO_vendor_support v4l1_compat pcspkr rfkill wmi soundcore joydev microcode sdhci_pci sdhci firewire_ohci mmc_core firewire_core yenta_socket crc_itu_t i915 drm_kms_helper drm i2c_algo_bit i2c_core video output [last unloaded: scsi_wait_scan]
<4>Modules linked in: snd_usb_audio snd_usbmidi_lib snd_raneric rfcomm sco bnep l2cap coretemp cpufreq_ondemand acpi_cpufreq mperf ip6t_REJECT nf_conntrack_ipv6 nf_defrag_ipv6 ip6table_filter ip6_tables ipv6 uinput arc4 snd_hda_codec_conexant ecb snd_hda_intel iwlagn snd_hda_codec iwlcore mac80211 snd_hwdep snd_seq snd_seq_device snd_pcm snd_timer snd_page_alloc uvcvideo btusb cfg80211 bluetooth thinkpad_acpi i2c_i801 videodev iTCO_wdt snd e1000e iTCO_vendor_support v4l1_compat pcspkr rfkill wmi soundcore joydev microcode sdhci_pci sdhci firewper drm i2c_algo_bit i2c_core video output [last unloaded: scsi_wait_scan]
<4>
<4>Pid: 2478, comm: udevd Not tainted 2.6.37 #3 406227U/406227U
<4>EIP: 0060:[<c04c8d0c>] EFLAGS: 00000286 CPU: 0
eed_resched+0x19/0x23
<4> [<c042aa2e>] ?
<4>ESI: ec44a400 EDI: f4402500 EBP: ec431cac ESP: ec431ca8
08c97>] ? verify_iovec+0x43/0x78
<4> [<c07006e2>] __sys_recvmsg+0x105/0x19c
0286 ec431cb8 c04c8d34 0000008b ec431c01b61>] ? sys_sendto+0x120/0x142
c0 ec431cf0
<4> c0707677 f177d200 ec4s_socketcall+0x177/0x1a8
<4> [<c05b25e0>] ? trace_hardirqs_on_thunk+0xc/0x10
+0x70/0xd5
<4> [<c07074b8>] ? skb_release_data+0x7c/0x80
snd_usb_audio snd_usbmidi_lib snd_rawmidi nam+0x12/0x1c
<4> [<c072803d>] ? netlink_recvmsg+0x140/0x25e
<4> [<c0700089>] ? __sock_recvmsg+0x63/0x6d
<4> [<c070021f>] ? sock_recvmsg+0x9b/0xb0
<4> [<c070030e>] ? sock_sendmsg+0x98/0xac
<4> [<c042aa17>] ? need_resched+0x19/0x23
<4> [<c042aa2e>] ? should_resched+0xd/0x28
<4> [<c05b2a6e>] ? _copy_from_user+0x3e/0x52
<4> [<c0708961>] ? copy_from_user+0xd/0xf
<4> [<c0708c97>] ? verify_iovec+0x43/0x78
<4> [<c07006e2>] ? __sys_recvmsg+0x105/0x19c
<4> [<c0700184>] ? sock_recvmsg+0x0/0xb0
<4> [<c07007a7>] ? sockfd_lookup_light+0x1b/0x48
<4> [<c0701b61>] ? sys_sendto+0x120/0x142
<4> [<c04d4cc2>] ? fget_light+0x2f/0x5c
<4> [<c0702072>] ? sys_recvmsg+0x30/0x48
<4> [<c07023eb>] ? sys_sockeneric rfcomm sco bip6_tables ipv6 uinput arc4 snd_hda_codec_conexant ecb snd_hda_intel iwlagn snd_hda_codec iwlcore mac80211 snd_hwdep snd_seq snd_seq_device snd_pcm snd_timer snd_page_alloc uvcvideo btusb cfg80211 bluetooth thinkpad_acpi i2c_i801 videodev iTCO_wdt snd e1000e iTCO_vendor_support v4l1_compat pcspkr rfkill wmi soundcore joydev microcode sdhci_pci sdhci firewire_ohci mmc_core firewire_core yenta_socket crc_itu_t i915 drm_kms_helper drm i2c_algo_bit i2c_core video output [last unloaded: scsi_wait_scan]
<4>
<4>Pid: 2478, comm: udevd Not tainted 2.6.37 #3 406227U/406227U
<4>EIP: 0060:[<c04c8d0c>] EFLAGS: 00000286 CPU: 0
eed_resched+0x19/0x23
<4> [<c042aa2e>] ?
<4>ESI: ec44a400 EDI: f4402500 EBP: ec431cac ESP: ec431ca8
08c97>] ? verify_iovec+0x43/0x78
<4> [<c07006ek.ti=ec430000)
<0>Stack:
<4> 00000286 ec431cb8 c04c8d34 0000008b ec431cd4 c04cb66a c07074b8 ec431cd4
<4> [<c04d4cc2>] ? fget_light+0x2f/0x5c
<4> [<c0702072>] sys_recvmsg+0x30ec431d0c c0709866
irqs_on_thunk+0xc/0x10
+0x70/0xd5
<4> [<c07074b8>] ? skb_releaseModules linked ib+0x58/0x5c
<4> [<c0709866>] ? skb_free_datagram+0x12/0x1c
<4> [<c072803d>] ? netlink_recvmsg+0x140/0x25e
<4> [<c0700089>] ? __sock_recvmsg+0x63/0x6d
<4> [<c070021f>] ? sock_recvmsg+0x9b/0xb0
<4> [<c070030e>] ? sock_sendmsg+0x98/0xac
<4> [<c042aa17>] ? need_resched+0x19/0x23
<4> [<c042aa2e>] ? should_resched+0xd/0x28
<4> [<c05b2a6e>] ? _copy_from_user+0x3e/0x52
<4> [<c0708961>] ? copy_from_user+0xd/0xf
<4> [<c0708c97>] ? verify_iovec+0x43/0x78
<4> [<c07006e2>] ? __sys_recvmsg+0x105/0x19c
<4> [<c0700184>] ? sock_recvmsg+0x0/0xb0
<4> [<c07007a7>] ? sockfd_lookup_light+0x1b/0x48
<4> [<c0701b61>] ? sys_sendto+0x120/0x142
_core video output [last unloaded: scsi_wait_scan]
<4>Modules linked in: snd_usb_audio snd_usbmidi_lib snd_ra_cpufreq mperf ip6t_REJECT nf_conntrack_ipv6 nf_defrag_ipv6 ip6table_filter ip6_tables ipv6 uinput arc4 snd_hda_codec_conexant ecb snd_hda_intel iwlagn snd_hda_codec iwlcore mac80211 snd_hwdep snd_seq snd_seq_device snd_pcm snd_timer snd_page_alloc uvcvideo btusb cfg80211 bluetooth thinkpad_acpi i2c_i801 videodev iTCO_wdt snd e1000e iTCO_vendor_support v4l1_compat pcspkr rfkill wmi soundcore joydev microcode sdhci_pci sdhci firewire_ohci mmc_core firewire_core yenta_socket crc_itu_t i915 drm_kms_helper drm i2c_algo_bit i2c_core video output [last unloaded: scsi_wait_scan]
<4>
<4>Pid: 2478, comm: udevd Not tainted 2.6.37 #3 406227U/406227U
<4>EIP: 0060:[<c04c8d0c>] EFLAGS: 00000286 CPU: 0
eed_resched+0x19/0x23
<4> [<c042aa2e>] ?
<4>ESI: ec44a400 EDI: f4402500 EBP: ec431cac ESP: ec431ca8
08c97>] ? verify_iovec+0x43/0x78
<4> [<c07006e2>] __sys_recvmsg+0x105/0x19c
0286 ec431cb8 c04c8d34 0000008b ec431c01b61>] ? sys_sendto+0x120/0x142
c0 ec431cf0
<4> c0707677 f177d200 ec4s_socketcall+0x177/0x1a8
<4> [<c05b25e0>] ? trace_hardirqs_on_thunk+0xc/0x10
+0x70/0xd5
<4> [<c07074b8>] ? skb_release_data+0x7c/0x80
snd_usb_audio snd_usbmidi_lib snd_rawmidi nam+0x12/0x1c
<4> [<c072803d>] ? netlink_recvmsg+0x140/0x25e
<4> [<c0700089>] ? __sock_recvmsg+0x63/0x6d
<4> [<c070021f>] ? sock_recvmsg+0x9b/0xb0
<4> [<c070030e>] ? sock_sendmsg+0x98/0xac
<4> [<c042aa17>] ? need_resched+0x19/0x23
<4> [<c042aa2e>] ? should_resched+0xd/0x28
<4> [<c05b2a6e>] ? _copy_from_user+0x3e/0x52
<4> [<c0708961>] ? copy_from_user+0xd/0xf
<4> [<c0708c97>] ? verify_iovec+0x43/0x78
<4> [<c07006e2>] ? __sys_recvmsg+0x105/0x19c
<4> [<c0700184>] ? sock_recvmsg+0x0/0xb0
<4> [<c07007a7>] ? sockfd_lookup_light+0x1b/0x48
<4> [<c0701b61>] ? sys_sendto+0x120/0x142
<4> [<c04d4cc2>] ? fget_light+0x2f/0x5c
<4> [<c0702072>] ? sys_recvmsg+0x30/0x48
<4> [<c07023eb>] ? sys_sockeneric rfcomm sco bip6_tables ipv6 uinput arc4 snd_hda_codec_conexant ecb snd_hda_intel iwlagn snd_hda_codec iwlcore mac80211 snd_hwdep snd_seq snd_seq_device snd_pcm snd_timer snd_page_alloc uvcvideo btusb cfg80211 bluetooth thinkpad_acpi i2c_i801 videodev iTCO_wdt snd e1000e iTCO_vendor_support v4l1_compat pcspkr rfkill wmi soundcore joydev microcode sdhci_pci sdhci firewire_ohci mmc_core firewire_core yenta_socket crc_itu_t i915 drm_kms_helper drm i2c_algo_bit i2c_core video output [last unloaded: scsi_wait_scan]
<4>
<4>Pid: 2478, comm: udevd Not tainted 2.6.37 #3 406227U/406227U
<4>EIP: 0060:[<c04c8d0c>] EFLAGS: 00000286 CPU: 0
eed_resched+0x19/0x23
<4> [<c042aa2e>] ?
<4>ESI: ec44a400 EDI: f4402500 EBP: ec431cac ESP: ec431ca8
08c97>] ? verify_iovec+0x43/0x78
<4> [<c07006ek.ti=ec430000)
<0>Stack:
<4> 00000286 ec431cb8 c04c8d34 0000008b ec431cd4 c04cb66a c07074b8 ec431cd4
<4> [<c04d4cc2>] ? fget_light+0x2f/0x5c
<4> [<c0702072>] sys_recvmsg+0x30ec431d0c c0709866
irqs_on_thunk+0xc/0x10
+0x70/0xd5
<4> [<c07074b8>] ? skb_releaseModules linked infigfs sit tunnel4 fuse aes_i586 aes_generic rfcomm sco bnep l2cap coretemp cpufreq_ondemand acpi_cpufreq mperf ip6t_REJECT nf_conntrack_ipv6 nf_defrag_ipv6 ip6table_filter ip6_tables ipv6 uinput arc4 snd_hda_codec_conexant ecb snd_hda_intel iwlagn snd_hda_codec iwlcore mac80211 snd_hwdep snd_seq snd_seq_device snd_pcm snd_timer snd_page_alloc uvcvideo btusb cfg80211 bluetooth thinkpad_acpi i2c_i801 videodev iTCO_wdt snd e1000e iTCO_vendor_support v4l1_compat pcspkr rfkill wmi soundcore joydev microcode sdhci_pci sdhci firewire_ohci mmc_core firewire_core yenta_socket crc_itu_t i915 drm_kms_helper drm i2c_algo_bit i2c_core video output [last unloaded: scsi_wait_scan]
<4>Modules linked in: snd_usb_audio snd_usbmidi_lib snd_ra_cpufreq mperf ip6t_REJECT nf_conntrack_ipv6 nf_defrag_ipv6 ip6table_filter ip6_tables ipv6 uinput arc4 snd_hda_codec_conexant ecb snd_hda_intel iwlagn snd_hda_codec iwlcore mac80211 snd_hwdep snd_seq snd_seq_device snd_pcm snd_timer snd_page_alloc uvcvideo btusb cfg80211 bluetooth thinkpad_acpi i2c_i801 videodev iTCO_wdt snd e1000e iTCO_vendor_support v4l1_compat pcspkr rfkill wmi soundcore joydev microcode sdhci_pci sdhci firewire_ohci mmc_core firewire_core yenta_socket crc_itu_t i915 drm_kms_helper drm i2c_algo_bit i2c_core video output [last unloaded: scsi_wait_scan]
<4>
<4>Pid: 2478, comm: udevd Not tainted 2.6.37 #3 406227U/406227U
<4>EIP: 0060:[<c04c8d0c>] EFLAGS: 00000286 CPU: ] ? need_resched+0x19/0x23
0 EDX: c07074b8
<4>ESI: ec44a400 EDI: f41>] ? copy_from_user+0xd/0xf
<4> [<c0708c97>] ? verify_iovec+0x43/0x78
724c80 task.ti=ec430000)
<0>Stack:
<4> 00000286 ec431cb8 c04c8d34 0000008b ec431cd4 c04cb66a c07074b8 ec431cd4
<4> [<c04d4cc2>] ? fget_light+0x2f/0x5c
<4> [<c0702072>] sys_recvmsg+0x30ec431d0c c0709866
irqs_on_thunb66a>] ? kfree+0x70/0xd5
: udevd/2478/0x10010100
<4>Modules linked iep l2cap coretemp cpufreq_ondemand acpi_cpufreq mperf ip6t_REJECT nf_conntrack_ipv6 nf_defrag_ipv6 ip6table_filter ip6_tables ipv6 uinput arc4 snd_hda_codec_conexant ecb snd_hda_intel iwlagn snd_hda_codec iwlcore mac80211 snd_hwdep snd_seq snd_seq_device snd_pcm snd_timer snd_page_alloc uvcvideo btusb cfg80211 bluetooth thinkpad_acpi i2c_i801 videodev iTCO_wdt snd e1000e iTCO_vendor_support v4l1_compat pcspkr rfkill wmi soundcore joydev microcode sdhci_pci sdhci firewire_ohci mmc_core firewire_core yenta_socket crc_itu_t i915 drm_kms_helper drm i2c_algo_bit i2c_core video output [last unloaded: scsi_wait_scan]
<4>Modules linked in: snd_usb_audio snd_usbmidi_lib snd_rawmidi netconsole configfs sit tunnel4 fuse aes_i586 aes_ge6 ip6table_filter ip6_tables ipv6 uinput arc4 snd_hda_codec_conexant ecb snd_hda_intel iwlagn snd_hda_codec iwlcore mac80211 snd_hwdep snd_seq snd_seq_device snd_pcm snd_timer snd_page_alloc uvcvideo btusb cfg80211 bluetooth thinkpad_acpi i2c_i801 videodev iTCO_wdt snd e1000e iTCO_vendor_support v4l1_compat pcspkr rfkill wmi soundcore joydev microcode sdhci_pci sdhci firewire_ohci mmc_core firewire_core yenta_socket crc_itu_t i915 drm_kms_helper drm i2c_algo_bit i2c_core video output [last unloaded: scsi_wait_scan]
<4>
<4>Pid: 2478, comm: udevd Not tainted 2.6.37 #3 406227U/406227U
<4>EIP: 0060:[<c04c8d0c>] EFLAGS: 00000286 CPU: 0
eed_resched+0x19/0x23
<4> [<c042aa2e>] ?
<4>ESI: ec44a400 EDI: f4402500 EBP: ec431cac ESP: ec431ca8
08c97>] ? verify_iovec+0x43/0x78
<4> [<c07006ek.ti=ec430000)
<0>Stack:
<4> 00000286 ec431cb8 c04c8d34 0000008b ec431cd4 c04cb66a c07074b8 ec431cd4
<4> [<c04d4cc2>] ? fget_light+0x2f/0x5c
<4> [<c0702072>] sys_recvmsg+0x30/0x48
c0709866
<0>Call Trace:
<4> [<c04c8d34>] c040335f>] sysenter_do_call+0x12/0x2d
ta+0x7c/0x80
<4> [<c07074b8>] ? skb_release_data+0x7wmidi nfcomm sco bnep l2cap coretemp cpufreq_ondemand acpi_cpufreq mperf ip6t_REJECT nf_conntrack_ipv6 nf_defrag_ipv6 ip6table_filter ip6_tables ipv6 uinput arc4 snd_hda_codec_conexant ecb snd_hda_intel iwlagn snd_hda_codec iwlcore mac80211 snd_hwdep snd_seq snd_seq_device snd_pcm snd_timer snd_page_alloc uvcvideo btusb cfg80211 bluetooth thinkpad_acpi i2c_i801 videodev iTCO_wdt snd e1000e iTCO_vendor_support v4l1_compat pcspkr rfkill wmi soundcore joydev microcode sdhci_pci sdhci firewire_ohci mmc_core firewire_core yenta_socket crc_itu_t i915 drm_kms_helper drm i2c_algo_bit i2c_core video output [last unloaded: scsi_wait_scan]
<4>Modules linked in: snd_usb_audio snd_usbmidi_lib snd_ra_cpufreq mperf ip6t_REJECT nf_conntrack_ipv6 nf_defrag_ipv6 ip6table_filter ip6_tables ipv6 uinput arc4 snd_hda_codec_conexant ecb snd_hda_intel iwlagn snd_hda_codec iwlcore mac80211 snd_hwdep snd_seq snd_seq_device snd_pcm snd_timer snd_page_alloc uvcvideo btusb cfg80211 bluetooth thinkpad_acpi i2c_i801 videodev iTCO_wdt snd e1000e iTCO_vendor_support v4l1_compat pcspkr rfkill wmi soundcore joydev microcode sdhci_pci sdhci firewire_ohci mmc_core firewire_core yenta_socket crc_itu_t i915 drm_kms_helper drm i2c_algo_bit i2c_core video output [last unloaded: scsi_wait_scan]
<4>
<4>Pid: 2478, comm: udevd Not tainted 2.6.37 #3 406227U/406227U
<4>EIP: 0060:[<c04c8d0c>] EFLAGS: 00000286 CPU: 0
eed_resched+0x19/0x23
<4> [<c042aa2e>] ?
<4>ESI: ec44a400 EDI: f4402500 EBP: ec431cac ESP: ec431ca8
08c97>] ? verify_iovec+0x43/0x78
<4> [<c07006e2>] __sys_recvmsg+0x105/0x19c
0286 ec431cb8 c04c8d34 0000008b ec431c01b61>] ? sys_sendto+0x120/0x142
c0 ec431cf0
<4> c0707677 f177d200 ec4s_socketcall+0x177/0x1a8
<4> [<c05b25e0>] ? trace_hardirqs_on_thunk+0xc/0x10
+0x70/0xd5
<4> [<c07074b8>] ? skb_releaseModules linked infigfs sit tunnel4 fuse aes_i586 aes_generic rfcomm sco bnep l2cap coretemp cpufreq_ondemand acpi_cpufreq mperf ip6t_REJECT nf_conntrack_ipv6 nf_defrag_ipv6 ip6table_filter ip6_tables ipv6 uinput arc4 snd_hda_codec_conexant ecb snd_hda_intel iwlagn snd_hda_codec iwlcore mac80211 snd_hwdep snd_seq snd_seq_device snd_pcm snd_timer snd_page_alloc uvcvideo btusb cfg80211 bluetooth thinkpad_acpi i2c_i801 videodev iTCO_wdt snd e1000e iTCO_vendor_support v4l1_compat pcspkr rfkill wmi soundcore joydev microcode sdhci_pci sdhci firewire_ohci mmc_core firewire_core yenta_socket crc_itu_t i915 drm_kms_helper drm i2c_algo_bit i2c_core video output [last unloaded: scsi_wait_scan]
<4>Modules linked in: snd_usb_audio snd_usbmidi_lib snd_ra_cpufreq mperf ip6t_REJECT nf_conntrack_ipv6 nf_defrag_ipv6 ip6table_filter ip6_tables ipv6 uinput arc4 snd_hda_codec_conexant ecb snd_hda_intel iwlagn snd_hda_codec iwlcore mac80211 snd_hwdep snd_seq snd_seq_device snd_pcm snd_timer snd_page_alloc uvcvideo btusb cfg80211 bluetooth thinkpad_acpi i2c_i801 videodev iTCO_wdt snd e1000e iTCO_vendor_support v4l1_compat pcspkr rfkill wmi soundcore joydev microcode sdhci_pci sdhci firewire_ohci mmc_core firewire_core yenta_socket crc_itu_t i915 drm_kms_helper drm i2c_algo_bit i2c_core video output [last unloaded: scsi_wait_scan]
<4>
<4>Pid: 2478, comm: udevd Not tainted 2.6.37 #3 406227U/406227U
<4>EIP: 0060:[<c04c8d0c>] EFLAGS: 00000286 CPU: 0
eed_resched+0x19/0x23
<4> [<c042aa2e>] ?
<4>ESI: ec44a400 EDI: f4402500 EBP: ec431cac ESP: ec431ca8
08c97>] ? verify_iovec+0x43/0x78
<4> [<c07006e2>] __sys_recvmsg+0x105/0x19c
0286 ec431cb8 c04c8d34 0000008b ec431c01b61>] ? sys_sendto+0x120/0x142
c0 ec431cf0
<4> c0707677 f177d200 ec4s_socketcall+0x177/0x1a8
<4> [<c05b25e0>] ? trace_hardirqs_on_thunk+0xc/0x10
+0x70/0xd5
<4> [<c07074b8>] ? skb_releaseModules linked infigfs sit tunnel4 fuse aes_i586 aes_generic rfcomm sco bnep l2cap coretemp cpufreq_ondemand acpi_cpufreq mperf ip6t_REJECT nf_conntrack_ipv6 nf_defrag_ipv6 ip6table_filter ip6_tables ipv6 uinput arc4 snd_hda_codec_conexant ecb snd_hda_intel iwlagn snd_hda_codec iwlcore mac80211 snd_hwdep snd_seq snd_seq_device snd_pcm snd_timer snd_page_alloc uvcvideo btusb cfg80211 bluetooth thinkpad_acpi i2c_i801 videodev iTCO_wdt snd e1000e iTCO_vendor_support v4l1_compat pcspkr rfkill wmi soundcore joydev microcode sdhci_pci sdhci firewire_ohci mmc_core firewire_core yenta_socket crc_itu_t i915 drm_kms_helper drm i2c_algo_bit i2c_core video output [last unloaded: scsi_wait_scan]
<4>Modules linked in: snd_usb_audio snd_usbmidi_lib snd_ra_cpufreq mperf ip6t_REJECT nf_conntrack_ipv6 nf_defrag_ipv6 ip6table_filter ip6_tables ipv6 uinput arc4 snd_hda_codec_conexant ecb snd_hda_intel iwlagn snd_hda_codec iwlcore mac80211 snd_hwdep snd_seq snd_seq_device snd_pcm snd_timer snd_page_alloc uvcvideo btusb cfg80211 bluetooth thinkpad_acpi i2c_i801 videodev iTCO_wdt snd e1000e iTCO_vendor_support v4l1_compat pcspkr rfkill wmi soundcore joydev microcode sdhci_pci sdhci firewire_ohci mmc_core firewire_core yenta_socket crc_itu_t i915 drm_kms_helper drm i2c_algo_bit i2c_core video output [last unloaded: scsi_wait_scan]
<4>
<4>Pid: 2478, comm: udevd Not tainted 2.6.37 #3 406227U/406227U
<4>EIP: 0060:[<c04c8d0c>] EFLAGS: 00000286 CPU: 0
eed_resched+0x19/0x23
<4> [<c042aa2e>] ?
<4>ESI: ec44a400 EDI: f4402500 EBP: ec431cac ESP: ec431ca8
08c97>] ? verify_iovec+0x43/0x78
<4> [<c07006ek.ti=ec430000)
<0>Stack:
<4> 00000286 ec431cb8 c04c8d34 0000008b ec431cd4 c04cb66a c07074b8 ec431cd4
<4> [<c04d4cc2>] ? fget_light+0x2f/0x5c
<4> [<c0702072>] sys_recvmsg+0x30ec431d0c c0709866
irqs_on_thunk+0xc/0x10
+0x70/0xd5
<4> [<c07074b8>] ? skb_releaseModules linked infigfs sit tunnel4 fuse aes_i586 aes_generic rfcomm sco bnep l2cap coretemp cpufreq_ondemand acpi_cpufreq mperf ip6t_REJECT nf_conntrack_ipv6 nf_defrag_ipv6 ip6table_filter ip6_tables ipv6 uinput arc4 snd_hda_codec_conexant ecb snd_hda_intel iwlagn snd_hda_codec iwlcore mac80211 snd_hwdep snd_seq snd_seq_device snd_pcm snd_timer snd_page_alloc uvcvideo btusb cfg80211 bluetooth thinkpad_acpi i2c_i801 videodev iTCO_wdt snd e1000e iTCO_vendor_support v4l1_compat pcspkr rfkill wmi soundcore joydev microcode sdhci_pci sdhci firewire_ohci mmc_core firewire_core yenta_socket crc_itu_t i915 drm_kms_helper drm i2c_algo_bit i2c_core video output [last unloaded: scsi_wait_scan]
<4>Modules linked in: snd_usb_audio snd_usbmidi_lib snd_ra<0>Code: 00 00 8d 65 f4 89 d0 5b 5e 5f 5d c3 90 90 90 55 89 e5 3e 8d 74 26 00 8d 50 ff 83 c8 ff c1 ea 0b 40 d1 ea 75 fb 5d c3 55 89 e5 9c <58> 8d 74 26 00 5d c3 55 89 e5 50 9d 8d 74 26 00 5d c3 55 89 e5 
<4>Call Trace:
<4> [<c04c8d34>] arch_local_irq_save+0xb/0x18
<4> [<c04cb66a>] kfree+0x70/0xd5
<4> [<c07074b8>] ? skb_release_data+0x7c/0x80
<4> [<c07074b8>] skb_release_data+0x7c/0x80
<4> [<c0707677>] __kfree_skb+0x17/0x74
<4> [<c070772c>] consume_skb+0x58/0x5c
<4> [<c0709866>] skb_free_datagram+0x12/0x1c
<4> [<c072803d>] netlink_recvmsg+0x140/0x25e
<4> [<c0700089>] __sock_recvmsg+0x63/0x6d
<4> [<c070021f>] sock_recvmsg+0x9b/0xb0
<4> [<c070030e>] ? sock_sendmsg+0x98/0xac
<4> [<c042aa17>0c0 EBX: f61cd940 ECX: 0000] ? _copy_from_user+0x3e/0x52
ES: 007b FS: 00d8 GS: 00e0 SS: 0068
<0>Process udevd (pid: 2478, ti=f4408000 task=f1724c80 task.ti=ec430000)
<c07007c07074b8 ec431cd4
<4> f3f120c0 f3f120c0 ec431d40 ec431ce4 c07074b8 f3f120c0 f3f120c0 ec431cf0
48
<4> [<c07023eb>] sys_socketcall+0x177/0x1a8
<4> [<c05b25e0>] ? trace_h0x18
<4> [<c04cb66a>] ? kfree+0x70/0xd5
: udevd/2478/0x10010100
<4>Modules linked i_REJECT nf_conntrack_ipv6 nf_defrag_ipv6 ip6table_filter ip6_tables ipv6 uinput arc4 snd_hda_codec_conexant ecb snd_hda_intel iwlagn snd_hda_codec iwlcore mac80211 snd_hwdep snd_seq snd_seq_device snd_pcm snd_timer snd_page_alloc uvcvideo btusb cfg80211 bluetooth thinkpad_acpi i2c_i801 videodev iTCO_wdt snd e1000e iTCO_vendor_support v4l1_compat pcspkr rfkill wmi soundcore joydev microcode sdhci_pci sdhci firewire_ohci mmc_core firewire_core yenta_socket crc_itu_t i915 drm_kms_helper drm i2c_algo_bit i2c_core video output [last unloaded: scsi_wait_scan]
<4>Modules linked in: snd_usb_audio snd_usbmidi_lib snd_rawmidi netconsole configfs sit tunnel4 fuse aes_i586 aes_generic rfcomm sco bnep l2cap coretemp cpufreq_ondemand acpic_conexant ecb snd_hda_intel iwlagn snd_hda_codec iwlcore mac80211 snd_hwdep snd_seq snd_seq_device snd_pcm snd_timer snd_page_alloc uvcvideo btusb cfg80211 bluetooth thinkpad_acpi i2c_i801 videodev iTCO_wdt snd e1000e iTCO_vendor_support v4l1_compat pcspkr rfkill wmi soundcore joydev microcode sdhci_pci sdhci firewire_ohci mmc_core firewire_core yenta_socket crc_itu_t i915 drm_kms_helper drm i2c_algo_bit i2c_core video output [last unloaded: scsi_wait_scan]
<4>
<4>Pid: 2478, comm: udevd Not tainted 2.6.37 #3 406227U/406227U
<4>EIP: 0060:[<c04c8d0c>] EFLAGS: 00000286 CPU: 0
eed_resched+0x19/0x23
<4> [<c042aa2e>] ?
<4>ESI: ec44a400 EDI: f4402500 EBP: ec431cac ESP: ec431ca8
08c97>] ? verify_iovec+0x43/0x78
<4> [<c07006ek.ti=ec430000)
<0>Stack:
<4> 00000286 ec431cb8 c04c8d34 0000008b ec431cd4 c04cb66a c07074b8 ec431cd4
<4> [<c04d4cc2>] ? fget_light+0x2f/0x5c
<4> [<c0702072>] sys_recvmsg+0x30ec431d0c c0709866
irqs_on_thunb66a>] ? kfree+0x70/0xd5
: udevd/2478/0x10010100
<4>Modules linked infigfs sit tunnel4 fuse aes_i586 aes_generic rfcomm sco bnep l2cap coretemp cpufreq_ondemand acpi_cpufreq mperf ip6t_REJECT nf_conntrack_ipv6 nf_defrag_ipv6 ip6table_filter ip6_tables ipv6 uinput arc4 snd_hda_codec_conexant ecb snd_hda_intel iwlagn snd_hda_codec iwlcore mac80211 snd_hwdep snd_seq snd_seq_device snd_pcm snd_timer snd_page_alloc uvcvideo btusb cfg80211 bluetooth thinkpad_acpi i2c_i801 videodev iTCO_wdt snd e1000e iTCO_vendor_support v4l1_compat pcspkr rfkill wmi soundcore joydev microcode sdhci_pci sdhci firewire_ohci mmc_core firewire_core yenta_socket crc_itu_t i915 drm_kms_helper drm i2c_algo_bit i2c_core video output [last unloaded: scsi_wait_scan]
<4>Modules linked in: snd_usb_audio snd_usbmidi_lib snd_ra_cpufreq mperf ip6t_REJECT nf_conntrack_ipv6 nf_defrag_ipv6 ip6table_filter ip6_tables ipv6 uinput arc4 snd_hda_codec_conexant ecb snd_hda_intel iwlagn snd_hda_codec iwlcore mac80211 snd_hwdep snd_seq snd_seq_device snd_pcm snd_timer snd_page_alloc uvcvideo btusb cfg80211 bluetooth thinkpad_acpi i2c_i801 videodev iTCO_wdt snd e1000e iTCO_vendor_support v4l1_compat pcspkr rfkill wmi soundcore joydev microcode sdhci_pci sdhci firewire_ohci mmc_core firewire_core yenta_socket crc_itu_t i915 drm_kms_helper drm i2c_algo_bit i2c_core video output [last unloaded: scsi_wait_scan]
<4>
<4>Pid: 2478, comm: udevd Not tainted 2.6.37 #3 406227U/406227U
<4>EIP: 0060:[<c04c8d0c>] EFLAGS: 00000286 CPU: 0
eed_resched+0x19/0x23
<4> [<c042aa2e>] ?
<4>ESI: ec44a400 EDI: f4402500 EBP: ec431cac ESP: ec431ca8
08c97>] ? verify_iovec+0x43/0x78
<4> [<c07006e2>] __sys_recvmsg+0x105/0x19c
0286 ec431cb8 c04c8d34 0000008b ec431c01b61>] ? sys_sendto+0x120/0x142
c0 ec431cf0
<4> c0707677 f177d200 ec4s_socketcall+0x177/0x1a8
<4> [<c05b25e0>] ? trace_hardirqs_on_thunk+0xc/0x10
+0x70/0xd5
<4> [<c07074b8>] ? skb_releaseModules linked ib+0x58/0x5c
<4> [<c0709866>] ? skb_free_datagram+0x12/0x1c
<4> [<c072803d>] ? netlink_recvmsg+0x140/0x25e
<4> [<c0700089>] ? __sock_recvmsg+0x63/0x6d
<4> [<c070021f>] ? sock_recvmsg+0x9b/0xb0
<4> [<c070030e>] ? sock_sendmsg+0x98/0xac
<4> [<c042aa17>] ? need_resched+0x19/0x23
<4> [<c042aa2e>] ? should_resched+0xd/0x28
<4> [<c05b2a6e>] ? _copy_from_user+0x3e/0x52
<4> [<c0708961>] ? copy_from_user+0xd/0xf
<4> [<c0708c97>] ? verify_iovec+0x43/0x78
<4> [<c07006e2>] ? __sys_recvmsg+0x105/0x19c
<4> [<c0700184>] ? sock_recvmsg+0x0/0xb0
<4> [<c07007a7>] ? sockfd_lookup_light+0x1b/0x48
<4> [<c0701b61>] ? sys_sendto+0x120/0x142
<4> [<c04d4cc2>] ? fget_light+0x2f/0x5c
<4> [<c0702072>] ? sys_recvmsg+0x30/0x48
<4> [<c07023eb>] ? sys_sockeneric rfcomm sco bip6_tables ipv6 uinput arc4 snd_hda_codec_conexant ecb snd_hda_intel iwlagn snd_hda_codec iwlcore mac80211 snd_hwdep snd_seq snd_seq_device snd_pcm snd_timer snd_page_alloc uvcvideo btusb cfg80211 bluetooth thinkpad_acpi i2c_i801 videodev iTCO_wdt snd e1000e iTCO_vendor_support v4l1_compat pcspkr rfkill wmi soundcore joydev microcode sdhci_pci sdhci firewire_ohci mmc_core firewire_core yenta_socket crc_itu_t i915 drm_kms_helper drm i2c_algo_bit i2c_core video output [last unloaded: scsi_wait_scan]
<4>
<4>Pid: 2478, comm: udevd Not tainted 2.6.37 #3 406227U/406227U
<4>EIP: 0060:[<c04c8d0c>] EFLAGS: 00000286 CPU: 0
eed_resched+0x19/0x23
<4> [<c042aa2e>] ? should_resched+0xd/0x28
500 EBP: ec431cac ESP: ec431ca8
<4> DS: 00 ? verify_iovec+0x43/0x78
<4> [<c07006e2>] __sys_recvmsg+0x105/0x19c
0286 ec431cb8 c04c8d34 0000008b ec431c01b61>] ? sys_sendto+0x120/0x142
c0 ec431cf0
<4> c0707677 f177d200 ec431d00 c070772c f177d200 f3f120e4 ec431d0c c0709866
irqs_on_thunb66a>] ? kfree+0x70/0xd5
: udevd/2478/0x10010100
<4>Modules linked infigfs sit tunnel4 fuse aes_i586 aes_generic rfcomm sco bnep l2cap coretemp cpufreq_ondemand acpi_cpufreq mperf ip6t_REJECT nf_conntrack_ipv6 nf_defrag_ipv6 ip6table_filter ip6_tables ipv6 uinput arc4 snd_hda_codec_conexant ecb snd_hda_intel iwlagn snd_hda_codec iwlcore mac80211 snd_hwdep snd_seq snd_seq_device snd_pcm snd_timer snd_page_alloc uvcvideo btusb cfg80211 bluetooth thinkpad_acpi i2c_i801 videodev iTCO_wdt snd e1000e iTCO_vendor_support v4l1_compat pcspkr rfkill wmi soundcore joydev microcode sdhci_pci sdhci firewire_ohci mmc_core firewire_core yenta_socket crc_itu_t i915 drm_kms_helper drm i2c_algo_bit i2c_core video output [last unloaded: scsi_wait_scan]
<4>Modules linked in: snd_usb_audio snd_usbmidi_lib snd_ra_cpufreq mperf ip6t_REJECT nf_conntrack_ipv6 nf_defrag_ipv6 ip6table_filter ip6_tables ipv6 uinput arc4 snd_hda_codec_conexant ecb snd_hda_intel iwlagn snd_hda_codec iwlcore mac80211 snd_hwdep snd_seq snd_seq_device snd_pcm snd_timer snd_page_alloc uvcvideo btusb cfg80211 bluetooth thinkpad_acpi i2c_i801 videodev iTCO_wdt snd e1000e iTCO_vendor_support v4l1_compat pcspkr rfkill wmi soundcore joydev microcode sdhci_pci sdhci firewire_ohci mmc_core firewire_core yenta_socket crc_itu_t i915 drm_kms_helper drm i2c_algo_bit i2c_core video output [last unloaded: scsi_wait_scan]
<4>
<4>Pid: 2478, comm: udevd Not tainted 2.6.37 #3 406227U/406227U
<4>EIP: 0060:[<c04c8d0c>] EFLAGS: 00000286 CPU: 0
eed_resched+0x19/0x23
<4> [<c042aa2e>] ?
<4>ESI: ec44a400 EDI: f4402500 EBP: ec431cac ESP: ec431ca8
08c97>] ? verify_iovec+0x43/0x78
<4> [<c07006ek.ti=ec430000)
<0>Stack:
<4> 00000286 ec431cb8 c04c8d34 0000008b ec431cd4 c04cb66a c07074b8 ec431cd4
<4> [<c04d4cc2>] ? fget_light+0x2f/0x5c
<4> [<c0702072>] sys_recvmsg+0x30/0x48
c0709866
<0>Call Trace:
<4> [<c04c8d34>] c040335f>] sysenter_do_call+0x12/0x2d
ta+0x7c/0x80
<4> [<c07074b8>] ? skb_release_data+0x7wmidi nam+0x12/0x1c
<4> [<c072803d>] ? netlink_recvmsg+0x140/0x25e
<4> [<c0700089>] ? __sock_recvmsg+0x63/0x6d
<4> [<c070021f>] ? sock_recvmsg+0x9b/0xb0
<4> [<c070030e>] ? sock_sendmsg+0x98/0xac
<4> [<c042aa17>] ? need_resched+0x19/0x23
<4> [<c042aa2e>] ? should_resched+0xd/0x28
<4> [<c05b2a6e>] ? _copy_from_user+0x3e/0x52
<4> [<c0708961>] ? copy_from_user+0xd/0xf
<4> [<c0708c97>] ? verify_iovec+0x43/0x78
<4> [<c07006e2>] ? __sys_recvmsg+0x105/0x19c
<4> [<c0700184>] ? sock_recvmsg+0x0/0xb0
<4> [<c07007a7>] ? sockfd_lookup_light+0x1b/0x48
<4> [<c0701b61>] ? sys_sendto+0x120/0x142
<4> [<c04d4cc2>] ? fget_light+0x2f/0x5c
<4> [<c0702072>] ? sys_recvmsg+0x30/0x48
<4> [<c07023eb>] ? sys_sockeneric rfcomm sco b65 f4 89 d0 5b 5e 5f 5d c3 90 90 90 55 89 e5 3e 8d 74 26 00 8d 50 ff 83 c8 ff c1 ea 0b 40 d1 ea 75 fb 5d c3 55 89 e5 9c <58> 8d 74 26 00 5d c3 55 89 e5 50 9d 8d 74 26 00 5d c3 55 89 e5 
<4>Call Trace:
<4> [<c04c8d34>] arch_local_irq_save+0xb/0x18
<4> [<c04cb66a>] kfree+0x70/0xd5
<4> [<c07074b8>] ? skb_release_data+0x7c/0x80
<4> [<c07074b8>] skb_release_data+0x7c/0x80
<4> [<c0707677>] __kfree_skb+0x17/0x74
<4> [<c070772c>] consume_skb+0x58/0x5c
<4> [<c0709866>] skb_free_datagram+0x12/0x1c
<4> [<c072803d>] netlink_recvmsg+0x140/0x25e
<4> [<c0700089>] __sock_recvmsg+0x63/0x6d
<4> [<c070021f>] sock_recvmsg+0x9b/0xb00 ? need_resched+0x19/0x23
0 EDX: c07074b8
<4>ESI: ec44a400 EDI: f4402500 EBP: ec431cac ESP: ec431ca8
08c97>] ? verify_iovec+0x43/0x78
<4> [<c07006ek.ti=ec430000)
<0>Stack:
<4> 00000286 ec431cb8 c04c8d34 0000008b ec431cd4 c04cb66a c07074b8 ec431cd4
<4> [<c04d4cc2>] ? fget_light+0x2f/0x5c
<4> [<c0702072>] sys_recvmsg+0x30ec431d0c c0709866
irqs_on_thunk+0xc/0x10
+0x70/0xd5
<4> [<c07074b8>] ? skb_release_data+0x7c/0x80
snd_usb_audio snd_usbmidi_lib snd_rawmidi nfcomm sco bnep l2cap coretemp cpufreq_ondemand acpi_cpufreq mperf ip6t_REJECT nf_conntrack_ipv6 nf_defrag_ipv6 ip6table_filter ip6_tables ipv6 uinput arc4 snd_hda_codec_conexant ecb snd_hda_intel iwlagn snd_hda_codec iwlcore mac80211 snd_hwdep snd_seq snd_seq_device snd_pcm snd_timer snd_page_alloc uvcvideo btusb cfg80211 bluetooth thinkpad_acpi i2c_i801 videodev iTCO_wdt snd e1000e iTCO_vendor_support v4l1_compat pcspkr rfkill wmi soundcore joydev microcode sdhci_pci sdhci firewire_ohci mmc_core firewire_core yenta_socket crc_itu_t i915 drm_kms_helper drm i2c_algo_bit i2c_core video output [last unloaded: scsi_wait_scan]
<4>Modules linked in: snd_usb_audio snd_usbmidi_lib snd_ra_cpufreq mperf ip6t_REJECT nf_conntrack_ipv6 nf_defrag_ipv6 ip6table_filter ip6_tables ipv6 uinput arc4 snd_hda_codec_conexant ecb snd_hda_intel iwlagn snd_hda_codec iwlcore mac80211 snd_hwdep snd_seq snd_seq_device snd_pcm snd_timer snd_page_alloc uvcvideo btusb cfg80211 bluetooth thinkpad_acpi i2c_i801 videodev iTCO_wdt snd e1000e iTCO_vendor_support v4l1_compat pcspkr rfkill wmi soundcore joydev microcode sdhci_pci sdhci firewire_ohci mmc_core firewire_core yenta_socket crc_itu_t i915 drm_kms_helper drm i2c_algo_bit i2c_core video output [last unloaded: scsi_wait_scan]
<4>
<4>Pid: 2478, comm: udevd Not tainted 2.6.37 #3 406227U/406227U
<4>EIP: 0060:[<c04c8d0c>] EFLAGS: 00000286 CPU: 0
eed_resched+0x19/0x23
<4> [<c042aa2e>] ?
<4>ESI: ec44a400 EDI: f4402500 EBP: ec431cac ESP: ec431ca8
08c97>] ? verify_iovec+0x43/0x78
<4> [<c07006ek.ti=ec430000)
<0>Stack:
<4> 00000286 ec431cb8 c04c8d34 0000008b ec431cd4 c04cb66a c07074b8 ec431cd4
<4> [<c04d4cc2>] ? fget_light+0x2f/0x5c
<4> [<c0702072>] sys_recvmsg+0x30/0x48
c0709866
<0>Call Trace:
<4> [<c04c8d34>] c040335f>] sysenter_do_call+0x12/0x2d
ta+0x7c/0x80
<4> [<c07074b8>] ? skb_release_data+0x7wmidi nam+0x12/0x1c
<4> [<c072803d>] ? netlink_recvmsg+0x140/0x25e
<4> [<c0700089>] ? __sock_recvmsg+0x63/0x6d
<4> [<c070021f>] ? sock_recvmsg+0x9b/0xb0
<4> [<c070030e>] ? sock_sendmsg+0x98/0xac
<4> [<c042aa17>] ? need_resched+0x19/0x23
<4> [<c042aa2e>] ? should_resched+0xd/0x28
<4> [<c05b2a6e>] ? _copy_from_user+0x3e/0x52
<4> [<c0708961>] ? copy_from_user+0xd/0xf
<4> [<c0708c97>] ? verify_iovec+0x43/0x78
<4> [<c07006e2>] ? __sys_recvmsg+0x105/0x19c
<4> [<c0700184>] ? sock_recvmsg+0x0/0xb0
<4> [<c07007a7>] ? sockfd_lookup_light+0x1b/0x48
<4> [<c0701b61>] ? sys_sendto+0x120/0x142
<4> [<c04d4cc2>] ? fget_light+0x2f/0x5c
<4> [<c0702072>] ? sys_recvmsg+0x30/0x48
<4> [<c07023eb>] ? sys_sockeneric rfcomm sco b65 f4 89 d0 5b 5e 5f 5d c3 90 90 90 55 89 e5 3e 8d 74 26 00 8d 50 ff 83 c8 ff c1 ea 0b 40 d1 ea 75 fb 5d c3 55 89 e5 9c <58> 8d 74 26 00 5d c3 55 89 e5 50 9d 8d 74 26 00 5d c3 55 89 e5 
<4>Call Trace:
<4> [<c04c8d34>] arch_local_irq_save+0xb/0x18
<4> [<c04cb66a>] kfree+0x70/0xd5
<4> [<c07074b8>] ? skb_release_data+0x7c/0x80
<4> [<c07074b8>] skb_release_data+0x7c/0x80
<4> [<c0707677>] __kfree_skb+0x17/0x74
<4> [<c070772c>] consume_skb+0x58/0x5c
<4> [<c0709866>] skb_free_datagram+0x12/0x1c
<4> [<c072803d>] netlink_recvmsg+0x140/0x25e
<4> [<c0700089>] __sock_recvmsg+0x63/0x6d
<4> [<c070021f>] sock_recvmsg+0x9b/0xb00 ? need_resched+0x19/0x23
0 EDX: c07074b8
<4>ESI: ec44a400 EDI: f4402500 EBP: ec431cac ESP: ec431ca8
08c97>] ? verify_iovec+0x43/0x78
<4> [<c07006ek.ti=ec430000)
<0>Stack:
<4> 00000286 ec431cb8 c04c8d34 0000008b ec431cd4 c04cb66a c07074b8 ec431cd4
<4> [<c04d4cc2>] ? fget_light+0x2f/0x5c
<4> [<c0702072>] sys_recvmsg+0x30/0x48
c0709866
<0>Call Trace:
<4> [<c04c8d34>] ? arch_local_irq_save+0xb/0x18
x2d
<3>BUG: scheduling while atob8>] ? skb_release_data+0x7c/0x80
onsole configfs sit tunnel4 fuse aes_iemand acpi_cpufreq mperf ip6t_REJECT nf_conntrack_ipv6 nf_defrag_ipv6 ip6table_filter ip6_tables ipv6 uinput arc4 snd_hda_codec_conexant ecb snd_hda_intel iwlagn snd_hda_codec iwlcore mac80211 snd_hwdep snd_seq snd_seq_device snd_pcm snd_timer snd_page_alloc uvcvideo btusb cfg80211 bluetooth thinkpad_acpi i2c_i801 videodev iTCO_wdt snd e1000e iTCO_vendor_support v4l1_compat pcspkr rfkill wmi soundcore joydev microcode sdhci_pci sdhci firewire_ohci mmc_core firewire_core yenta_socket crc_itu_t i915 drm_kms_helper drm i2c_algo_bit i2c_core video output [last unloaded: scsi_wait_scan]
<4>Modules linked in: snd_usb_audio snd_usbmidi_lib snd_rank+0xc/0x10
<4> [<c040335f>] ? sysenter_do_call+0x12/0x2d
<0>Code: 00 00 8d 65 f4 89 d0 5b 5e 5f 5d c3 90 90 90 55 89 e5 3e 8d 74 26 00 8d 50 ff 83 c8 ff c1 ea 0b 40 d1 ea 75 fb 5d c3 55 89 e5 9c <58> 8d 74 26 00 5d c3 55 89 e5 50 9d 8d 74 26 00 5d c3 55 89 e5 
<4>Call Trace:
<4> [<c04c8d34>] arch_local_irq_save+0xb/0x18
<4> [<c04cb66a>] kfree+0x70/0xd5
<4> [<c07074b8>] ? skb_release_data+0x7c/0x80
<4> [<c07074b8>] skb_release_data+0x7c/0x80
<4> [<c0707677>] __kfree_skb+0x17/0x74
<4> [<c070772c>] consume_skb+0x58/0x5c
<4> [<c0709866>] skb_free_datagram+0x12/0x1c
<4> [<c072803d>] netlink_recvmsg+0x140/0x25e
<4> [<c0700089>] __sock_recvmsg+0x63/0x6d
<4> [<c070021f>] sock_recvmsg+0x9b/0xb00 ? need_resched+0x19/0x23
0 EDX: c07074b8
<4>ESI: ec44a400 EDI: f41>] ? copy_from_user+0xd/0xf
<4> [<c0708c97>] ? verify_iovec+0x43/0x78
724c80 task.ti=ec430000)
<0>Stack:
<4> 00000286 ec431cb8 c04c8d34 0000008b ec431cd4 c04cb66a c07074b8 ec431cd4
<4> [<c04d4cc2>] ? fget_light+0x2f/0x5c
<4> [<c0702072>] sys_recvmsg+0x30ec431d0c c0709866
irqs_on_thunk+0xc/0x10
+0x70/0xd5
<4> [<c07074b8>] ? skb_releaseModules linked infigfs sit tunnel4 fuse aes_i586 aes_generic rfcomm sco bnep l2cap coretemp cpufreq_ondemand acpi_cpufreq mperf ip6t_REJECT nf_conntrack_ipv6 nf_defrag_ipv6 ip6table_filter ip6_tables ipv6 uinput arc4 snd_hda_codec_conexant ecb snd_hda_intel iwlagn snd_hda_codec iwlcore mac80211 snd_hwdep snd_seq snd_seq_device snd_pcm snd_timer snd_page_alloc uvcvideo btusb cfg80211 bluetooth thinkpad_acpi i2c_i801 videodev iTCO_wdt snd e1000e iTCO_vendor_support v4l1_compat pcspkr rfkill wmi soundcore joydev microcode sdhci_pci sdhci firewire_ohci mmc_core firewire_core yenta_socket crc_itu_t i915 drm_kms_helper drm i2c_algo_bit i2c_core video output [last unloaded: scsi_wait_scan]
<4>Modules linked in: snd_usb_audio snd_usbmidi_lib snd_rank+0xc/0x10
<4> [<c040335f>] ? sysenter_do_call+0x12/0x2d
<0>Code: 00 00 8d 65 f4 89 d0 5b 5e 5f 5d c3 90 90 90 55 89 e5 3e 8d 74 26 00 8d 50 ff 83 c8 ff c1 ea 0b 40 d1 ea 75 fb 5d c3 55 89 e5 9c <58> 8d 74 26 00 5d c3 55 89 e5 50 9d 8d 74 26 00 5d c3 55 89 e5 
<4>Call Trace:
<4> [<c04c8d34>] arch_local_irq_save+0xb/0x18
<4> [<c04cb66a>] kfree+0x70/0xd5
<4> [<c07074b8>] ? skb_release_data+0x7c/0x80
<4> [<c07074b8>] skb_release_data+0x7c/0x80
<4> [<c0707677>] __kfree_skb+0x17/0x74
<4> [<c070772c>] consume_skb+0x58/0x5c
<4> [<c0709866>] skb_free_datagram+0x12/0x1c
<4> [<c072803d>] netlink_recvmsg+0x140/0x25e
<4> [<c0700089>] __sock_recvmsg+0x63/0x6d
<4> [<c070021f>] sock_recvmsg+0x9b/0xb00 ? need_resched+0x19/0x23
0 EDX: c07074b8
<4>ESI: ec44a400 EDI: f4402500 EBP: ec431cac ESP: ec431ca8
08c97>] ? verify_iovec+0x43/0x78
<4> [<c07006ek.ti=ec430000)
<0>Stack:
<4> 00000286 ec431cb8 c04c8d34 0000008b ec431cd4 c04cb66a c07074b8 ec431cd4
<4> [<c04d4cc2>] ? fget_light+0x2f/0x5c
<4> [<c0702072>] sys_recvmsg+0x30/0x48
c0709866
<0>Call Trace:
<4> [<c04c8d34>] c040335f>] sysenter_do_call+0x12/0x2d
ta+0x7c/0x80
<4> [<c07074b8>] ? skb_release_data+0x7c/0x80
onsole configfs sit tunnel4 fuse aes_iemand acpi_cpufreq mperf ip6t_REJECT nf_conntrack_ipv6 nf_defrag_ipv6 ip6table_filter ip6_tables ipv6 uinput arc4 snd_hda_codec_conexant ecb snd_hda_intel iwlagn snd_hda_codec iwlcore mac80211 snd_hwdep snd_seq snd_seq_device snd_pcm snd_timer snd_page_alloc uvcvideo btusb cfg80211 bluetooth thinkpad_acpi i2c_i801 videodev iTCO_wdt snd e1000e iTCO_vendor_support v4l1_compat pcspkr rfkill wmi soundcore joydev microcode sdhci_pci sdhci firewire_ohci mmc_core firewire_core yenta_socket crc_itu_t i915 drm_kms_helper drm i2c_algo_bit i2c_core video output [last unloaded: scsi_wait_scan]
<4>Modules linked in: snd_usb_audio snd_usbmidi_lib snd_ra_cpufreq mperf ip6t_REJECT nf_conntrack_ipv6 nf_defrag_ipv6 ip6table_filter ip6_tables ipv6 uinput arc4 snd_hda_codec_conexant ecb snd_hda_intel iwlagn snd_hda_codec iwlcore mac80211 snd_hwdep snd_seq snd_seq_device snd_pcm snd_timer snd_page_alloc uvcvideo btusb cfg80211 bluetooth thinkpad_acpi i2c_i801 videodev iTCO_wdt snd e1000e iTCO_vendor_support v4l1_compat pcspkr rfkill wmi soundcore joydev microcode sdhci_pci sdhci firewire_ohci mmc_core firewire_core yenta_socket crc_itu_t i915 drm_kms_helper drm i2c_algo_bit i2c_core video output [last unloaded: scsi_wait_scan]
<4>
<4>Pid: 2478, comm: udevd Not tainted 2.6.37 #3 406227U/406227U
<4>EIP: 0060:[<c04c8d0c>] EFLAGS: 00000286 CPU: 0
eed_resched+0x19/0x23
<4> [<c042aa2e>] ?
<4>ESI: ec44a400 EDI: f4402500 EBP: ec431cac ESP: ec431ca8
08c97>] ? verify_iovec+0x43/0x78
<4> [<c07006ek.ti=ec430000)
<0>Stack:
<4> 00000286 ec431cb8 c04c8d34 0000008b ec431cd4 c04cb66a c07074b8 ec431cd4
<4> [<c04d4cc2>] ? fget_light+0x2f/0x5c
<4> [<c0702072>] sys_recvmsg+0x30ec431d0c c0709866
irqs_on_thunk+0xc/0x10
+0x70/0xd5
<4> [<c07074b8>] ? skb_releaseModules linked infigfs sit tunnel4 fuse aes_i586 aes_generic rfcomm sco bnep l2cap coretemp cpufreq_ondemand acpi_cpufreq mperf ip6t_REJECT nf_conntrack_ipv6 nf_defrag_ipv6 ip6table_filter ip6_tables ipv6 uinput arc4 snd_hda_codec_conexant ecb snd_hda_intel iwlagn snd_hda_codec iwlcore mac80211 snd_hwdep snd_seq snd_seq_device snd_pcm snd_timer snd_page_alloc uvcvideo btusb cfg80211 bluetooth thinkpad_acpi i2c_i801 videodev iTCO_wdt snd e1000e iTCO_vendor_support v4l1_compat pcspkr rfkill wmi soundcore joydev microcode sdhci_pci sdhci firewire_ohci mmc_core firewire_core yenta_socket crc_itu_t i915 drm_kms_helper drm i2c_algo_bit i2c_core video output [last unloaded: scsi_wait_scan]
<4>Modules linked in: snd_usb_audio snd_usbmidi_lib snd_ra_cpufreq mperf ip6t_REJECT nf_conntrack_ipv6 nf_defrag_ipv6 ip6table_filter ip6_tables ipv6 uinput arc4 snd_hda_codec_conexant ecb snd_hda_intel iwlagn snd_hda_codec iwlcore mac80211 snd_hwdep snd_seq snd_seq_device snd_pcm snd_timer snd_page_alloc uvcvideo btusb cfg80211 bluetooth thinkpad_acpi i2c_i801 videodev iTCO_wdt snd e1000e iTCO_vendor_support v4l1_compat pcspkr rfkill wmi soundcore joydev microcode sdhci_pci sdhci firewire_ohci mmc_core firewire_core yenta_socket crc_itu_t i915 drm_kms_helper drm i2c_algo_bit i2c_core video output [last unloaded: scsi_wait_scan]
<4>
<4>Pid: 2478, comm: udevd Not tainted 2.6.37 #3 406227U/406227U
<4>EIP: 0060:[<c04c8d0c>] EFLAGS: 00000286 CPU: ] ? need_resched+0x19/0x23
0 EDX: c07074b8
<4>ESI: ec44a400 EDI: f41>] ? copy_from_user+0xd/0xf
<4> [<c0708c97>] ? verify_iovec+0x43/0x78
724c80 task.ti=ec430000)
<0>Stack:
<4> 0? sockfd_lookup_light+0x1b/0x48
<4> [<c0701b61>] ? sys_sendto+0x120/0x142
c0 ec431cf0
<4> c0707677 f177d200 ec4s_socketcall+0x177/0x1a8
<4> [<c05b25e0>] ? trace_hardirqs_on_thunk+0xc/0x10
+0x70/0xd5
<4> [<c07074b8>] ? skb_release_data+0x7c/0x80
snd_usb_audio snd_usbmidi_lib snd_rawmidi nq mperf ip6t_REJECT nf_conntrack_ipv6 nf_defrag_ipv6 ip6table_filter ip6_tables ipv6 uinput arc4 snd_hda_codec_conexant ecb snd_hda_intel iwlagn snd_hda_codec iwlcore mac80211 snd_hwdep snd_seq snd_seq_device snd_pcm snd_timer snd_page_alloc uvcvideo btusb cfg80211 bluetooth thinkpad_acpi i2c_i801 videodev iTCO_wdt snd e1000e iTCO_vendor_support v4l1_compat pcspkr rfkill wmi soundcore joydev microcode sdhci_pci sdhci firewire_ohci mmc_core firewire_core yenta_socket crc_itu_t i915 drm_kms_helper drm i2c_algo_bit i2c_core video output [last unloaded: scsi_wait_scan]
<4>Modules linked in: snd_usb_audio snd_usbmidi_lib snd_rawmidi netconsole configfs sit tunnel4 fuse aes_i586 aes_ge6 ip6table_filter ip6_tables ipv6 uinput arc4 snd_hda_codec_conexant ecb snd_hda_intel iwlagn snd_hda_codec iwlcore mac80211 snd_hwdep snd_seq snd_seq_device snd_pcm snd_timer snd_page_alloc uvcvideo btusb cfg80211 bluetooth thinkpad_acpi i2c_i801 videodev iTCO_wdt snd e1000e iTCO_vendor_support v4l1_compat pcspkr rfkill wmi soundcore joydev microcode sdhci_pci sdhci firewire_ohci mmc_core firewire_core yenta_socket crc_itu_t i915 drm_kms_helper drm i2c_algo_bit i2c_core video output [last unloaded: scsi_wait_scan]
<4>
<4>Pid: 2478, comm: udevd Not tainted 2.6.37 #3 406227U/406227U
<4>EIP: 0060:[<c04c8d0c>] EFLAGS: 00000286 CPU: ] ? need_resched+0x19/0x23
0 EDX: c07074b8
<4>ESI: ec44a400 EDI: f41>] ? copy_from_user+0xd/0xf
<4> [<c0708c97>] ? verify_iovec+0x43/0x78
724c80 task.ti=ec430000)
<0>Stack:
<4> 0? sockfd_lookup_light+0x1b/0x48
<4> [<c0701b61>] ? sys_sendto+0x120/0x142
c0 ec431cf0
<4> c0707677 f177d200 ec4s_socketcall+0x177/0x1a8
<4> [<c05b25e0>] ? trace_hardirqs_on_thunk+0xc/0x10
+0x70/0xd5
<4> [<c07074b8>] ? skb_releaseModules linked infigfs sit tunnel4 fuse aes_i586 aes_generic rfcomm sco bnep l2cap coretemp cpufreq_ondemand acpi_cpufreq mperf ip6t_REJECT nf_conntrack_ipv6 nf_defrag_ipv6 ip6table_filter ip6_tables ipv6 uinput arc4 snd_hda_codec_conexant ecb snd_hda_intel iwlagn snd_hda_codec iwlcore mac80211 snd_hwdep snd_seq snd_seq_device snd_pcm snd_timer snd_page_alloc uvcvideo btusb cfg80211 bluetooth thinkpad_acpi i2c_i801 videodev iTCO_wdt snd e1000e iTCO_vendor_support v4l1_compat pcspkr rfkill wmi soundcore joydev microcode sdhci_pci sdhci firewire_ohci mmc_core firewire_core yenta_socket crc_itu_t i915 drm_kms_helper drm i2c_algo_bit i2c_core video output [last unloaded: scsi_wait_scan]
<4>Modules linked in: snd_usb_audio snd_usbmidi_lib snd_ra_cpufreq mperf ip6t_REJECT nf_conntrack_ipv6 nf_defrag_ipv6 ip6table_filter ip6_tables ipv6 uinput arc4 snd_hda_codec_conexant ecb snd_hda_intel iwlagn snd_hda_codec iwlcore mac80211 snd_hwdep snd_seq snd_seq_device snd_pcm snd_timer snd_page_alloc uvcvideo btusb cfg80211 bluetooth thinkpad_acpi i2c_i801 videodev iTCO_wdt snd e1000e iTCO_vendor_support v4l1_compat pcspkr rfkill wmi soundcore joydev microcode sdhci_pci sdhci firewire_ohci mmc_core firewire_core yenta_socket crc_itu_t i915 drm_kms_helper drm i2c_algo_bit i2c_core video output [last unloaded: scsi_wait_scan]
<4>
<4>Pid: 2478, comm: udevd Not tainted 2.6.37 #3 406227U/406227U
<4>EIP: 0060:[<c04c8d0c>] EFLAGS: 00000286 CPU: 0
eed_resched+0x19/0x23
<4> [<c042aa2e>] ?
<4>ESI: ec44a400 EDI: f4402500 EBP: ec431cac ESP: ec431ca8
08c97>] ? verify_iovec+0x43/0x78
<4> [<c07006ek.ti=ec430000)
<0>Stack:
<4> 00000286 ec431cb8 c04c8d34 0000008b ec431cd4 c04cb66a c07074b8 ec431cd4
<4> [<c04d4cc2>] ? fget_light+0x2f/0x5c
<4> [<c0702072>] sys_recvmsg+0x30ec431d0c c0709866
irqs_on_thunb66a>] ? kfree+0x70/0xd5
: udevd/2478/0x10010100
<4>Modules linked i_REJECT nf_conntrack_ipv6 nf_defrag_ipv6 ip6table_filter ip6_tables ipv6 uinput arc4 snd_hda_codec_conexant ecb snd_hda_intel iwlagn snd_hda_codec iwlcore mac80211 snd_hwdep snd_seq snd_seq_device snd_pcm snd_timer snd_page_alloc uvcvideo btusb cfg80211 bluetooth thinkpad_acpi i2c_i801 videodev iTCO_wdt snd e1000e iTCO_vendor_support v4l1_compat pcspkr rfkill wmi soundcore joydev microcode sdhci_pci sdhci firewire_ohci mmc_core firewire_core yenta_socket crc_itu_t i915 drm_kms_helper drm i2c_algo_bit i2c_core video output [last unloaded: scsi_wait_scan]
<4>Modules linked in: snd_usb_audio snd_usbmidi_lib snd_rawmidi netconsole configfs sit tunnel4 fuse aes_i586 aes_generic rfcomm sco bnep l2cap coretemp cpufreq_ondemand acpic_conexant ecb snd_hda_intel iwlagn snd_hda_codec iwlcore mac80211 snd_hwdep snd_seq snd_seq_device snd_pcm snd_timer snd_page_alloc uvcvideo btusb cfg80211 bluetooth thinkpad_acpi i2c_i801 videodev iTCO_wdt snd e1000e iTCO_vendor_support v4l1_compat pcspkr rfkill wmi soundcore joydev microcode sdhci_pci sdhci firewire_ohci mmc_core firewire_core yenta_socket crc_itu_t i915 drm_kms_helper drm i2c_algo_bit i2c_core video output [last unloaded: scsi_wait_scan]
<4>
<4>Pid: 2478, comm: udevd Not tainted 2.6.37 #3 406227U/406227U
<4>EIP: 0060:[<c04c8d0c>] EFLAGS: 00000286 CPU: ] ? need_resched+0x19/0x23
0 EDX: c07074b8
<4>ESI: ec44a400 EDI: f41>] ? copy_from_user+0xd/0xf
<4> [<c0708c97>] ? verify_iovec+0x43/0x78
724c80 task.ti=ec430000)
<0>Stack:
<4> 0? sockfd_lookup_light+0x1b/0x48
<4> [<c0701b61>] ? sys_sendto+0x120/0x142
c0 ec431cf0
<4> c0707677 f177d200 ec431d00 c070772c f177d200 f3f120e4 ec431d0c c0709866
irqs_on_thunb66a>] ? kfree+0x70/0xd5

--V0207lvV8h4k8FAm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="lsusb-with-headset.txt"


Bus 008 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass            9 Hub
  bDeviceSubClass         0 Unused
  bDeviceProtocol         0 Full speed (or root) hub
  bMaxPacketSize0        64
  idVendor           0x1d6b Linux Foundation
  idProduct          0x0001 1.1 root hub
  bcdDevice            2.06
  iManufacturer           3 Linux 2.6.37 uhci_hcd
  iProduct                2 UHCI Host Controller
  iSerial                 1 0000:00:1d.2
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           25
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0 
    bmAttributes         0xe0
      Self Powered
      Remote Wakeup
    MaxPower                0mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         9 Hub
      bInterfaceSubClass      0 Unused
      bInterfaceProtocol      0 Full speed (or root) hub
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0002  1x 2 bytes
        bInterval             255
Hub Descriptor:
  bLength               9
  bDescriptorType      41
  nNbrPorts             2
  wHubCharacteristic 0x000a
    No power switching (usb 1.0)
    Per-port overcurrent protection
  bPwrOn2PwrGood        1 * 2 milli seconds
  bHubContrCurrent      0 milli Ampere
  DeviceRemovable    0x00
  PortPwrCtrlMask    0xff
 Hub Port Status:
   Port 1: 0000.0100 power
   Port 2: 0000.0100 power
Device Status:     0x0003
  Self Powered
  Remote Wakeup Enabled

Bus 007 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass            9 Hub
  bDeviceSubClass         0 Unused
  bDeviceProtocol         0 Full speed (or root) hub
  bMaxPacketSize0        64
  idVendor           0x1d6b Linux Foundation
  idProduct          0x0001 1.1 root hub
  bcdDevice            2.06
  iManufacturer           3 Linux 2.6.37 uhci_hcd
  iProduct                2 UHCI Host Controller
  iSerial                 1 0000:00:1d.1
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           25
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0 
    bmAttributes         0xe0
      Self Powered
      Remote Wakeup
    MaxPower                0mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         9 Hub
      bInterfaceSubClass      0 Unused
      bInterfaceProtocol      0 Full speed (or root) hub
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0002  1x 2 bytes
        bInterval             255
Hub Descriptor:
  bLength               9
  bDescriptorType      41
  nNbrPorts             2
  wHubCharacteristic 0x000a
    No power switching (usb 1.0)
    Per-port overcurrent protection
  bPwrOn2PwrGood        1 * 2 milli seconds
  bHubContrCurrent      0 milli Ampere
  DeviceRemovable    0x00
  PortPwrCtrlMask    0xff
 Hub Port Status:
   Port 1: 0000.0100 power
   Port 2: 0000.0100 power
Device Status:     0x0003
  Self Powered
  Remote Wakeup Enabled

Bus 006 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass            9 Hub
  bDeviceSubClass         0 Unused
  bDeviceProtocol         0 Full speed (or root) hub
  bMaxPacketSize0        64
  idVendor           0x1d6b Linux Foundation
  idProduct          0x0001 1.1 root hub
  bcdDevice            2.06
  iManufacturer           3 Linux 2.6.37 uhci_hcd
  iProduct                2 UHCI Host Controller
  iSerial                 1 0000:00:1d.0
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           25
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0 
    bmAttributes         0xe0
      Self Powered
      Remote Wakeup
    MaxPower                0mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         9 Hub
      bInterfaceSubClass      0 Unused
      bInterfaceProtocol      0 Full speed (or root) hub
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0002  1x 2 bytes
        bInterval             255
Hub Descriptor:
  bLength               9
  bDescriptorType      41
  nNbrPorts             2
  wHubCharacteristic 0x000a
    No power switching (usb 1.0)
    Per-port overcurrent protection
  bPwrOn2PwrGood        1 * 2 milli seconds
  bHubContrCurrent      0 milli Ampere
  DeviceRemovable    0x00
  PortPwrCtrlMask    0xff
 Hub Port Status:
   Port 1: 0000.0100 power
   Port 2: 0000.0100 power
Device Status:     0x0003
  Self Powered
  Remote Wakeup Enabled

Bus 005 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass            9 Hub
  bDeviceSubClass         0 Unused
  bDeviceProtocol         0 Full speed (or root) hub
  bMaxPacketSize0        64
  idVendor           0x1d6b Linux Foundation
  idProduct          0x0001 1.1 root hub
  bcdDevice            2.06
  iManufacturer           3 Linux 2.6.37 uhci_hcd
  iProduct                2 UHCI Host Controller
  iSerial                 1 0000:00:1a.2
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           25
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0 
    bmAttributes         0xe0
      Self Powered
      Remote Wakeup
    MaxPower                0mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         9 Hub
      bInterfaceSubClass      0 Unused
      bInterfaceProtocol      0 Full speed (or root) hub
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0002  1x 2 bytes
        bInterval             255
Hub Descriptor:
  bLength               9
  bDescriptorType      41
  nNbrPorts             2
  wHubCharacteristic 0x000a
    No power switching (usb 1.0)
    Per-port overcurrent protection
  bPwrOn2PwrGood        1 * 2 milli seconds
  bHubContrCurrent      0 milli Ampere
  DeviceRemovable    0x00
  PortPwrCtrlMask    0xff
 Hub Port Status:
   Port 1: 0000.0100 power
   Port 2: 0000.0100 power
Device Status:     0x0003
  Self Powered
  Remote Wakeup Enabled

Bus 004 Device 003: ID 0a5c:2145 Broadcom Corp. Bluetooth with Enhanced Data Rate II
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass          224 Wireless
  bDeviceSubClass         1 Radio Frequency
  bDeviceProtocol         1 Bluetooth
  bMaxPacketSize0        64
  idVendor           0x0a5c Broadcom Corp.
  idProduct          0x2145 Bluetooth with Enhanced Data Rate II
  bcdDevice            3.99
  iManufacturer           1 Lenovo Computer Corp
  iProduct                2 ThinkPad Bluetooth with Enhanced Data Rate II
  iSerial                 0 
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength          216
    bNumInterfaces          4
    bConfigurationValue     1
    iConfiguration          0 
    bmAttributes         0xe0
      Self Powered
      Remote Wakeup
    MaxPower              100mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           3
      bInterfaceClass       224 Wireless
      bInterfaceSubClass      1 Radio Frequency
      bInterfaceProtocol      1 Bluetooth
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0010  1x 16 bytes
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x82  EP 2 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x02  EP 2 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       0
      bNumEndpoints           2
      bInterfaceClass       224 Wireless
      bInterfaceSubClass      1 Radio Frequency
      bInterfaceProtocol      1 Bluetooth
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0000  1x 0 bytes
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x03  EP 3 OUT
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0000  1x 0 bytes
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       1
      bNumEndpoints           2
      bInterfaceClass       224 Wireless
      bInterfaceSubClass      1 Radio Frequency
      bInterfaceProtocol      1 Bluetooth
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0009  1x 9 bytes
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x03  EP 3 OUT
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0009  1x 9 bytes
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       2
      bNumEndpoints           2
      bInterfaceClass       224 Wireless
      bInterfaceSubClass      1 Radio Frequency
      bInterfaceProtocol      1 Bluetooth
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0011  1x 17 bytes
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x03  EP 3 OUT
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0011  1x 17 bytes
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       3
      bNumEndpoints           2
      bInterfaceClass       224 Wireless
      bInterfaceSubClass      1 Radio Frequency
      bInterfaceProtocol      1 Bluetooth
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0020  1x 32 bytes
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x03  EP 3 OUT
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0020  1x 32 bytes
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       4
      bNumEndpoints           2
      bInterfaceClass       224 Wireless
      bInterfaceSubClass      1 Radio Frequency
      bInterfaceProtocol      1 Bluetooth
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x03  EP 3 OUT
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       5
      bNumEndpoints           2
      bInterfaceClass       224 Wireless
      bInterfaceSubClass      1 Radio Frequency
      bInterfaceProtocol      1 Bluetooth
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x03  EP 3 OUT
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        2
      bAlternateSetting       0
      bNumEndpoints           2
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass    255 Vendor Specific Subclass
      bInterfaceProtocol    255 Vendor Specific Protocol
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x84  EP 4 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0020  1x 32 bytes
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x04  EP 4 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0020  1x 32 bytes
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        3
      bAlternateSetting       0
      bNumEndpoints           0
      bInterfaceClass       254 Application Specific Interface
      bInterfaceSubClass      1 Device Firmware Update
      bInterfaceProtocol      0 
      iInterface              0 
      Device Firmware Upgrade Interface Descriptor:
        bLength                             7
        bDescriptorType                    33
        bmAttributes                        7
          Will Not Detach
          Manifestation Tolerant
          Upload Supported
          Download Supported
        wDetachTimeout                   5000 milliseconds
        wTransferSize                      64 bytes
Device Status:     0x0001
  Self Powered

Bus 004 Device 002: ID 08ff:2810 AuthenTec, Inc. AES2810
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass          255 Vendor Specific Class
  bDeviceSubClass       255 Vendor Specific Subclass
  bDeviceProtocol       255 Vendor Specific Protocol
  bMaxPacketSize0         8
  idVendor           0x08ff AuthenTec, Inc.
  idProduct          0x2810 AES2810
  bcdDevice           17.03
  iManufacturer           0 
  iProduct                1 Fingerprint Sensor
  iSerial                 0 
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           32
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0 
    bmAttributes         0xa0
      (Bus Powered)
      Remote Wakeup
    MaxPower              100mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           2
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass    255 Vendor Specific Subclass
      bInterfaceProtocol    255 Vendor Specific Protocol
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x02  EP 2 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0008  1x 8 bytes
        bInterval               0
Device Status:     0x0000
  (Bus Powered)

Bus 004 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass            9 Hub
  bDeviceSubClass         0 Unused
  bDeviceProtocol         0 Full speed (or root) hub
  bMaxPacketSize0        64
  idVendor           0x1d6b Linux Foundation
  idProduct          0x0001 1.1 root hub
  bcdDevice            2.06
  iManufacturer           3 Linux 2.6.37 uhci_hcd
  iProduct                2 UHCI Host Controller
  iSerial                 1 0000:00:1a.1
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           25
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0 
    bmAttributes         0xe0
      Self Powered
      Remote Wakeup
    MaxPower                0mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         9 Hub
      bInterfaceSubClass      0 Unused
      bInterfaceProtocol      0 Full speed (or root) hub
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0002  1x 2 bytes
        bInterval             255
Hub Descriptor:
  bLength               9
  bDescriptorType      41
  nNbrPorts             2
  wHubCharacteristic 0x000a
    No power switching (usb 1.0)
    Per-port overcurrent protection
  bPwrOn2PwrGood        1 * 2 milli seconds
  bHubContrCurrent      0 milli Ampere
  DeviceRemovable    0x00
  PortPwrCtrlMask    0xff
 Hub Port Status:
   Port 1: 0000.0103 power enable connect
   Port 2: 0000.0103 power enable connect
Device Status:     0x0003
  Self Powered
  Remote Wakeup Enabled

Bus 003 Device 086: ID 046d:0a01 Logitech, Inc. USB Headset
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass            0 (Defined at Interface level)
  bDeviceSubClass         0 
  bDeviceProtocol         0 
  bMaxPacketSize0         8
  idVendor           0x046d Logitech, Inc.
  idProduct          0x0a01 USB Headset
  bcdDevice           10.13
  iManufacturer           1 Logitech
  iProduct                2 Logitech USB Headset
  iSerial                 0 
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength          318
    bNumInterfaces          3
    bConfigurationValue     1
    iConfiguration          0 
    bmAttributes         0x80
      (Bus Powered)
    MaxPower              100mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           0
      bInterfaceClass         1 Audio
      bInterfaceSubClass      1 Control Device
      bInterfaceProtocol      0 
      iInterface              0 
      AudioControl Interface Descriptor:
        bLength                10
        bDescriptorType        36
        bDescriptorSubtype      1 (HEADER)
        bcdADC               1.00
        wTotalLength          117
        bInCollection           2
        baInterfaceNr( 0)       1
        baInterfaceNr( 1)       2
      AudioControl Interface Descriptor:
        bLength                12
        bDescriptorType        36
        bDescriptorSubtype      2 (INPUT_TERMINAL)
        bTerminalID            13
        wTerminalType      0x0201 Microphone
        bAssocTerminal          0
        bNrChannels             1
        wChannelConfig     0x0001
          Left Front (L)
        iChannelNames           0 
        iTerminal               0 
      AudioControl Interface Descriptor:
        bLength                 9
        bDescriptorType        36
        bDescriptorSubtype      6 (FEATURE_UNIT)
        bUnitID                 6
        bSourceID              13
        bControlSize            1
        bmaControls( 0)      0x03
          Mute Control
          Volume Control
        bmaControls( 1)      0x00
        iFeature                0 
      AudioControl Interface Descriptor:
        bLength                12
        bDescriptorType        36
        bDescriptorSubtype      2 (INPUT_TERMINAL)
        bTerminalID            12
        wTerminalType      0x0101 USB Streaming
        bAssocTerminal          0
        bNrChannels             2
        wChannelConfig     0x0003
          Left Front (L)
          Right Front (R)
        iChannelNames           0 
        iTerminal               0 
      AudioControl Interface Descriptor:
        bLength                13
        bDescriptorType        36
        bDescriptorSubtype      4 (MIXER_UNIT)
        bUnitID                 9
        bNrInPins               2
        baSourceID( 0)         12
        baSourceID( 1)          6
        bNrChannels             2
        wChannelConfig     0x0003
          Left Front (L)
          Right Front (R)
        iChannelNames           0 
        bmControls         0x00
        iMixer                  0 
      AudioControl Interface Descriptor:
        bLength                10
        bDescriptorType        36
        bDescriptorSubtype      6 (FEATURE_UNIT)
        bUnitID                 1
        bSourceID               9
        bControlSize            1
        bmaControls( 0)      0x01
          Mute Control
        bmaControls( 1)      0x02
          Volume Control
        bmaControls( 2)      0x02
          Volume Control
        iFeature                0 
      AudioControl Interface Descriptor:
        bLength                 9
        bDescriptorType        36
        bDescriptorSubtype      3 (OUTPUT_TERMINAL)
        bTerminalID            14
        wTerminalType      0x0301 Speaker
        bAssocTerminal          0
        bSourceID               1
        iTerminal               0 
      AudioControl Interface Descriptor:
        bLength                12
        bDescriptorType        36
        bDescriptorSubtype      2 (INPUT_TERMINAL)
        bTerminalID            11
        wTerminalType      0x0201 Microphone
        bAssocTerminal          0
        bNrChannels             1
        wChannelConfig     0x0001
          Left Front (L)
        iChannelNames           0 
        iTerminal               0 
      AudioControl Interface Descriptor:
        bLength                 9
        bDescriptorType        36
        bDescriptorSubtype      6 (FEATURE_UNIT)
        bUnitID                 2
        bSourceID              11
        bControlSize            1
        bmaControls( 0)      0x03
          Mute Control
          Volume Control
        bmaControls( 1)      0x00
        iFeature                0 
      AudioControl Interface Descriptor:
        bLength                12
        bDescriptorType        36
        bDescriptorSubtype      4 (MIXER_UNIT)
        bUnitID                 7
        bNrInPins               1
        baSourceID( 0)          2
        bNrChannels             1
        wChannelConfig     0x0001
          Left Front (L)
        iChannelNames           0 
        bmControls         0x00
        iMixer                  0 
      AudioControl Interface Descriptor:
        bLength                 9
        bDescriptorType        36
        bDescriptorSubtype      3 (OUTPUT_TERMINAL)
        bTerminalID            10
        wTerminalType      0x0101 USB Streaming
        bAssocTerminal          0
        bSourceID               7
        iTerminal               0 
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       0
      bNumEndpoints           0
      bInterfaceClass         1 Audio
      bInterfaceSubClass      2 Streaming
      bInterfaceProtocol      0 
      iInterface              0 
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       1
      bNumEndpoints           1
      bInterfaceClass         1 Audio
      bInterfaceSubClass      2 Streaming
      bInterfaceProtocol      0 
      iInterface              0 
      AudioStreaming Interface Descriptor:
        bLength                 7
        bDescriptorType        36
        bDescriptorSubtype      1 (AS_GENERAL)
        bTerminalLink          12
        bDelay                  1 frames
        wFormatTag              1 PCM
      AudioStreaming Interface Descriptor:
        bLength                23
        bDescriptorType        36
        bDescriptorSubtype      2 (FORMAT_TYPE)
        bFormatType             1 (FORMAT_TYPE_I)
        bNrChannels             2
        bSubframeSize           2
        bBitResolution         16
        bSamFreqType            5 Discrete
        tSamFreq[ 0]         8000
        tSamFreq[ 1]        11025
        tSamFreq[ 2]        22050
        tSamFreq[ 3]        44100
        tSamFreq[ 4]        48000
      Endpoint Descriptor:
        bLength                 9
        bDescriptorType         5
        bEndpointAddress     0x01  EP 1 OUT
        bmAttributes            9
          Transfer Type            Isochronous
          Synch Type               Adaptive
          Usage Type               Data
        wMaxPacketSize     0x00c0  1x 192 bytes
        bInterval               1
        bRefresh                0
        bSynchAddress           0
        AudioControl Endpoint Descriptor:
          bLength                 7
          bDescriptorType        37
          bDescriptorSubtype      1 (EP_GENERAL)
          bmAttributes         0x01
            Sampling Frequency
          bLockDelayUnits         0 Undefined
          wLockDelay              0 Undefined
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       2
      bNumEndpoints           1
      bInterfaceClass         1 Audio
      bInterfaceSubClass      2 Streaming
      bInterfaceProtocol      0 
      iInterface              0 
      AudioStreaming Interface Descriptor:
        bLength                 7
        bDescriptorType        36
        bDescriptorSubtype      1 (AS_GENERAL)
        bTerminalLink          12
        bDelay                  1 frames
        wFormatTag              1 PCM
      AudioStreaming Interface Descriptor:
        bLength                23
        bDescriptorType        36
        bDescriptorSubtype      2 (FORMAT_TYPE)
        bFormatType             1 (FORMAT_TYPE_I)
        bNrChannels             1
        bSubframeSize           2
        bBitResolution         16
        bSamFreqType            5 Discrete
        tSamFreq[ 0]         8000
        tSamFreq[ 1]        11025
        tSamFreq[ 2]        22050
        tSamFreq[ 3]        44100
        tSamFreq[ 4]        48000
      Endpoint Descriptor:
        bLength                 9
        bDescriptorType         5
        bEndpointAddress     0x01  EP 1 OUT
        bmAttributes            9
          Transfer Type            Isochronous
          Synch Type               Adaptive
          Usage Type               Data
        wMaxPacketSize     0x0060  1x 96 bytes
        bInterval               1
        bRefresh                0
        bSynchAddress           0
        AudioControl Endpoint Descriptor:
          bLength                 7
          bDescriptorType        37
          bDescriptorSubtype      1 (EP_GENERAL)
          bmAttributes         0x01
            Sampling Frequency
          bLockDelayUnits         0 Undefined
          wLockDelay              0 Undefined
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        2
      bAlternateSetting       0
      bNumEndpoints           0
      bInterfaceClass         1 Audio
      bInterfaceSubClass      2 Streaming
      bInterfaceProtocol      0 
      iInterface              0 
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        2
      bAlternateSetting       1
      bNumEndpoints           1
      bInterfaceClass         1 Audio
      bInterfaceSubClass      2 Streaming
      bInterfaceProtocol      0 
      iInterface              0 
      AudioStreaming Interface Descriptor:
        bLength                 7
        bDescriptorType        36
        bDescriptorSubtype      1 (AS_GENERAL)
        bTerminalLink          10
        bDelay                  0 frames
        wFormatTag              1 PCM
      AudioStreaming Interface Descriptor:
        bLength                23
        bDescriptorType        36
        bDescriptorSubtype      2 (FORMAT_TYPE)
        bFormatType             1 (FORMAT_TYPE_I)
        bNrChannels             1
        bSubframeSize           2
        bBitResolution         16
        bSamFreqType            5 Discrete
        tSamFreq[ 0]         8000
        tSamFreq[ 1]        11025
        tSamFreq[ 2]        22050
        tSamFreq[ 3]        44100
        tSamFreq[ 4]        48000
      Endpoint Descriptor:
        bLength                 9
        bDescriptorType         5
        bEndpointAddress     0x84  EP 4 IN
        bmAttributes            9
          Transfer Type            Isochronous
          Synch Type               Adaptive
          Usage Type               Data
        wMaxPacketSize     0x0060  1x 96 bytes
        bInterval               1
        bRefresh                0
        bSynchAddress           0
        AudioControl Endpoint Descriptor:
          bLength                 7
          bDescriptorType        37
          bDescriptorSubtype      1 (EP_GENERAL)
          bmAttributes         0x01
            Sampling Frequency
          bLockDelayUnits         2 Decoded PCM samples
          wLockDelay              1 Decoded PCM samples
Device Status:     0x0000
  (Bus Powered)

Bus 003 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass            9 Hub
  bDeviceSubClass         0 Unused
  bDeviceProtocol         0 Full speed (or root) hub
  bMaxPacketSize0        64
  idVendor           0x1d6b Linux Foundation
  idProduct          0x0001 1.1 root hub
  bcdDevice            2.06
  iManufacturer           3 Linux 2.6.37 uhci_hcd
  iProduct                2 UHCI Host Controller
  iSerial                 1 0000:00:1a.0
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           25
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0 
    bmAttributes         0xe0
      Self Powered
      Remote Wakeup
    MaxPower                0mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         9 Hub
      bInterfaceSubClass      0 Unused
      bInterfaceProtocol      0 Full speed (or root) hub
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0002  1x 2 bytes
        bInterval             255
Hub Descriptor:
  bLength               9
  bDescriptorType      41
  nNbrPorts             2
  wHubCharacteristic 0x000a
    No power switching (usb 1.0)
    Per-port overcurrent protection
  bPwrOn2PwrGood        1 * 2 milli seconds
  bHubContrCurrent      0 milli Ampere
  DeviceRemovable    0x00
  PortPwrCtrlMask    0xff
 Hub Port Status:
   Port 1: 0000.0103 power enable connect
   Port 2: 0000.0100 power
Device Status:     0x0003
  Self Powered
  Remote Wakeup Enabled

Bus 002 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass            9 Hub
  bDeviceSubClass         0 Unused
  bDeviceProtocol         0 Full speed (or root) hub
  bMaxPacketSize0        64
  idVendor           0x1d6b Linux Foundation
  idProduct          0x0002 2.0 root hub
  bcdDevice            2.06
  iManufacturer           3 Linux 2.6.37 ehci_hcd
  iProduct                2 EHCI Host Controller
  iSerial                 1 0000:00:1d.7
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           25
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0 
    bmAttributes         0xe0
      Self Powered
      Remote Wakeup
    MaxPower                0mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         9 Hub
      bInterfaceSubClass      0 Unused
      bInterfaceProtocol      0 Full speed (or root) hub
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0004  1x 4 bytes
        bInterval              12
Hub Descriptor:
  bLength               9
  bDescriptorType      41
  nNbrPorts             6
  wHubCharacteristic 0x000a
    No power switching (usb 1.0)
    Per-port overcurrent protection
  bPwrOn2PwrGood       10 * 2 milli seconds
  bHubContrCurrent      0 milli Ampere
  DeviceRemovable    0x00
  PortPwrCtrlMask    0xff
 Hub Port Status:
   Port 1: 0000.0100 power
   Port 2: 0000.0100 power
   Port 3: 0000.0100 power
   Port 4: 0000.0100 power
   Port 5: 0000.0100 power
   Port 6: 0000.0100 power
Device Status:     0x0003
  Self Powered
  Remote Wakeup Enabled

Bus 001 Device 004: ID 17ef:4807 Lenovo UVC Camera
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass          239 Miscellaneous Device
  bDeviceSubClass         2 ?
  bDeviceProtocol         1 Interface Association
  bMaxPacketSize0        64
  idVendor           0x17ef Lenovo
  idProduct          0x4807 UVC Camera
  bcdDevice           31.34
  iManufacturer           1 Chicony Electronics Co., Ltd.
  iProduct                0 
  iSerial                 0 
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength          851
    bNumInterfaces          2
    bConfigurationValue     1
    iConfiguration          0 
    bmAttributes         0x80
      (Bus Powered)
    MaxPower              100mA
    Interface Association:
      bLength                 8
      bDescriptorType        11
      bFirstInterface         0
      bInterfaceCount         2
      bFunctionClass         14 Video
      bFunctionSubClass       3 Video Interface Collection
      bFunctionProtocol       0 
      iFunction               2 Integrated Camera
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass        14 Video
      bInterfaceSubClass      1 Video Control
      bInterfaceProtocol      0 
      iInterface              2 Integrated Camera
      VideoControl Interface Descriptor:
        bLength                13
        bDescriptorType        36
        bDescriptorSubtype      1 (HEADER)
        bcdUVC               1.00
        wTotalLength           51
        dwClockFrequency       24.000000MHz
        bInCollection           1
        baInterfaceNr( 0)       1
      VideoControl Interface Descriptor:
        bLength                18
        bDescriptorType        36
        bDescriptorSubtype      2 (INPUT_TERMINAL)
        bTerminalID             1
        wTerminalType      0x0201 Camera Sensor
        bAssocTerminal          3
        iTerminal               0 
        wObjectiveFocalLengthMin      0
        wObjectiveFocalLengthMax      0
        wOcularFocalLength            0
        bControlSize                  3
        bmControls           0x00000004
          Auto-Exposure Priority
      VideoControl Interface Descriptor:
        bLength                11
        bDescriptorType        36
        bDescriptorSubtype      5 (PROCESSING_UNIT)
      Warning: Descriptor too short
        bUnitID                 2
        bSourceID               1
        wMaxMultiplier          0
        bControlSize            2
        bmControls     0x0000043f
          Brightness
          Contrast
          Hue
          Saturation
          Sharpness
          Gamma
          Power Line Frequency
        iProcessing             0 
        bmVideoStandards     0x 9
          None
          SECAM - 625/50
      VideoControl Interface Descriptor:
        bLength                 9
        bDescriptorType        36
        bDescriptorSubtype      3 (OUTPUT_TERMINAL)
        bTerminalID             3
        wTerminalType      0x0101 USB Streaming
        bAssocTerminal          1
        bSourceID               2
        iTerminal               0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval              16
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       0
      bNumEndpoints           0
      bInterfaceClass        14 Video
      bInterfaceSubClass      2 Video Streaming
      bInterfaceProtocol      0 
      iInterface              0 
      VideoStreaming Interface Descriptor:
        bLength                            15
        bDescriptorType                    36
        bDescriptorSubtype                  1 (INPUT_HEADER)
        bNumFormats                         2
        wTotalLength                      529
        bEndPointAddress                  130
        bmInfo                              1
        bTerminalLink                       3
        bStillCaptureMethod                 1
        bTriggerSupport                     0
        bTriggerUsage                       0
        bControlSize                        1
        bmaControls( 0)                    27
        bmaControls( 1)                    27
      VideoStreaming Interface Descriptor:
        bLength                            27
        bDescriptorType                    36
        bDescriptorSubtype                  4 (FORMAT_UNCOMPRESSED)
        bFormatIndex                        1
        bNumFrameDescriptors                7
        guidFormat                            {59555932-0000-1000-8000-00aa00389b71}
        bBitsPerPixel                      16
        bDefaultFrameIndex                  1
        bAspectRatioX                       0
        bAspectRatioY                       0
        bmInterlaceFlags                 0x02
          Interlaced stream or variable: No
          Fields per frame: 2 fields
          Field 1 first: No
          Field pattern: Field 1 only
          bCopyProtect                      0
      VideoStreaming Interface Descriptor:
        bLength                            30
        bDescriptorType                    36
        bDescriptorSubtype                  5 (FRAME_UNCOMPRESSED)
        bFrameIndex                         1
        bmCapabilities                   0x01
          Still image supported
        wWidth                            640
        wHeight                           480
        dwMinBitRate                147456000
        dwMaxBitRate                147456000
        dwMaxVideoFrameBufferSize      614400
        dwDefaultFrameInterval         333333
        bFrameIntervalType                  1
        dwFrameInterval( 0)            333333
      VideoStreaming Interface Descriptor:
        bLength                            30
        bDescriptorType                    36
        bDescriptorSubtype                  5 (FRAME_UNCOMPRESSED)
        bFrameIndex                         2
        bmCapabilities                   0x01
          Still image supported
        wWidth                            320
        wHeight                           240
        dwMinBitRate                 36864000
        dwMaxBitRate                 36864000
        dwMaxVideoFrameBufferSize      153600
        dwDefaultFrameInterval         333333
        bFrameIntervalType                  1
        dwFrameInterval( 0)            333333
      VideoStreaming Interface Descriptor:
        bLength                            30
        bDescriptorType                    36
        bDescriptorSubtype                  5 (FRAME_UNCOMPRESSED)
        bFrameIndex                         3
        bmCapabilities                   0x01
          Still image supported
        wWidth                            800
        wHeight                           600
        dwMinBitRate                 57600000
        dwMaxBitRate                 57600000
        dwMaxVideoFrameBufferSize      960000
        dwDefaultFrameInterval        1333333
        bFrameIntervalType                  1
        dwFrameInterval( 0)           1333333
      VideoStreaming Interface Descriptor:
        bLength                            30
        bDescriptorType                    36
        bDescriptorSubtype                  5 (FRAME_UNCOMPRESSED)
        bFrameIndex                         4
        bmCapabilities                   0x01
          Still image supported
        wWidth                           1024
        wHeight                           600
        dwMinBitRate                 73728000
        dwMaxBitRate                 73728000
        dwMaxVideoFrameBufferSize     1228800
        dwDefaultFrameInterval        1333333
        bFrameIntervalType                  1
        dwFrameInterval( 0)           1333333
      VideoStreaming Interface Descriptor:
        bLength                            30
        bDescriptorType                    36
        bDescriptorSubtype                  5 (FRAME_UNCOMPRESSED)
        bFrameIndex                         5
        bmCapabilities                   0x01
          Still image supported
        wWidth                           1024
        wHeight                           768
        dwMinBitRate                 94371840
        dwMaxBitRate                 94371840
        dwMaxVideoFrameBufferSize     1572864
        dwDefaultFrameInterval        1333333
        bFrameIntervalType                  1
        dwFrameInterval( 0)           1333333
      VideoStreaming Interface Descriptor:
        bLength                            30
        bDescriptorType                    36
        bDescriptorSubtype                  5 (FRAME_UNCOMPRESSED)
        bFrameIndex                         6
        bmCapabilities                   0x01
          Still image supported
        wWidth                           1280
        wHeight                           800
        dwMinBitRate                122880000
        dwMaxBitRate                122880000
        dwMaxVideoFrameBufferSize     2048000
        dwDefaultFrameInterval        1333333
        bFrameIntervalType                  1
        dwFrameInterval( 0)           1333333
      VideoStreaming Interface Descriptor:
        bLength                            30
        bDescriptorType                    36
        bDescriptorSubtype                  5 (FRAME_UNCOMPRESSED)
        bFrameIndex                         7
        bmCapabilities                   0x01
          Still image supported
        wWidth                           1280
        wHeight                          1024
        dwMinBitRate                157286400
        dwMaxBitRate                157286400
        dwMaxVideoFrameBufferSize     2621440
        dwDefaultFrameInterval        1333333
        bFrameIntervalType                  1
        dwFrameInterval( 0)           1333333
      VideoStreaming Interface Descriptor:
        bLength                            11
        bDescriptorType                    36
        bDescriptorSubtype                  6 (FORMAT_MJPEG)
        bFormatIndex                        2
        bNumFrameDescriptors                7
        bFlags                              0
          Fixed-size samples: No
        bDefaultFrameIndex                  1
        bAspectRatioX                       0
        bAspectRatioY                       0
        bmInterlaceFlags                 0x02
          Interlaced stream or variable: No
          Fields per frame: 2 fields
          Field 1 first: No
          Field pattern: Field 1 only
          bCopyProtect                      0
      VideoStreaming Interface Descriptor:
        bLength                            38
        bDescriptorType                    36
        bDescriptorSubtype                  7 (FRAME_MJPEG)
        bFrameIndex                         1
        bmCapabilities                   0x01
          Still image supported
        wWidth                            640
        wHeight                           480
        dwMinBitRate                147456000
        dwMaxBitRate                147456000
        dwMaxVideoFrameBufferSize      614400
        dwDefaultFrameInterval         333333
        bFrameIntervalType                  0
        dwMinFrameInterval             333332
        dwMaxFrameInterval             333333
        dwFrameIntervalStep                 1
      VideoStreaming Interface Descriptor:
        bLength                            38
        bDescriptorType                    36
        bDescriptorSubtype                  7 (FRAME_MJPEG)
        bFrameIndex                         2
        bmCapabilities                   0x01
          Still image supported
        wWidth                            320
        wHeight                           240
        dwMinBitRate                 36864000
        dwMaxBitRate                 36864000
        dwMaxVideoFrameBufferSize      153600
        dwDefaultFrameInterval         333333
        bFrameIntervalType                  0
        dwMinFrameInterval             333332
        dwMaxFrameInterval             333333
        dwFrameIntervalStep                 1
      VideoStreaming Interface Descriptor:
        bLength                            38
        bDescriptorType                    36
        bDescriptorSubtype                  7 (FRAME_MJPEG)
        bFrameIndex                         3
        bmCapabilities                   0x01
          Still image supported
        wWidth                            800
        wHeight                           600
        dwMinBitRate                115200000
        dwMaxBitRate                115200000
        dwMaxVideoFrameBufferSize      960000
        dwDefaultFrameInterval         666666
        bFrameIntervalType                  0
        dwMinFrameInterval             666665
        dwMaxFrameInterval             666666
        dwFrameIntervalStep                 1
      VideoStreaming Interface Descriptor:
        bLength                            38
        bDescriptorType                    36
        bDescriptorSubtype                  7 (FRAME_MJPEG)
        bFrameIndex                         4
        bmCapabilities                   0x01
          Still image supported
        wWidth                           1024
        wHeight                           600
        dwMinBitRate                147456000
        dwMaxBitRate                147456000
        dwMaxVideoFrameBufferSize     1228800
        dwDefaultFrameInterval         666666
        bFrameIntervalType                  0
        dwMinFrameInterval             666665
        dwMaxFrameInterval             666666
        dwFrameIntervalStep                 1
      VideoStreaming Interface Descriptor:
        bLength                            38
        bDescriptorType                    36
        bDescriptorSubtype                  7 (FRAME_MJPEG)
        bFrameIndex                         5
        bmCapabilities                   0x01
          Still image supported
        wWidth                           1024
        wHeight                           768
        dwMinBitRate                188743680
        dwMaxBitRate                188743680
        dwMaxVideoFrameBufferSize     1572864
        dwDefaultFrameInterval         666666
        bFrameIntervalType                  0
        dwMinFrameInterval             666665
        dwMaxFrameInterval             666666
        dwFrameIntervalStep                 1
      VideoStreaming Interface Descriptor:
        bLength                            38
        bDescriptorType                    36
        bDescriptorSubtype                  7 (FRAME_MJPEG)
        bFrameIndex                         6
        bmCapabilities                   0x01
          Still image supported
        wWidth                           1280
        wHeight                           800
        dwMinBitRate                245760000
        dwMaxBitRate                245760000
        dwMaxVideoFrameBufferSize     2048000
        dwDefaultFrameInterval         666666
        bFrameIntervalType                  0
        dwMinFrameInterval             666665
        dwMaxFrameInterval             666666
        dwFrameIntervalStep                 1
      VideoStreaming Interface Descriptor:
        bLength                            38
        bDescriptorType                    36
        bDescriptorSubtype                  7 (FRAME_MJPEG)
        bFrameIndex                         7
        bmCapabilities                   0x01
          Still image supported
        wWidth                           1280
        wHeight                          1024
        dwMinBitRate                314572800
        dwMaxBitRate                314572800
        dwMaxVideoFrameBufferSize     2621440
        dwDefaultFrameInterval         666666
        bFrameIntervalType                  0
        dwMinFrameInterval             666665
        dwMaxFrameInterval             666666
        dwFrameIntervalStep                 1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       1
      bNumEndpoints           1
      bInterfaceClass        14 Video
      bInterfaceSubClass      2 Video Streaming
      bInterfaceProtocol      0 
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x82  EP 2 IN
        bmAttributes            5
          Transfer Type            Isochronous
          Synch Type               Asynchronous
          Usage Type               Data
        wMaxPacketSize     0x13d4  3x 980 bytes
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       2
      bNumEndpoints           1
      bInterfaceClass        14 Video
      bInterfaceSubClass      2 Video Streaming
      bInterfaceProtocol      0 
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x82  EP 2 IN
        bmAttributes            5
          Transfer Type            Isochronous
          Synch Type               Asynchronous
          Usage Type               Data
        wMaxPacketSize     0x0bc8  2x 968 bytes
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       3
      bNumEndpoints           1
      bInterfaceClass        14 Video
      bInterfaceSubClass      2 Video Streaming
      bInterfaceProtocol      0 
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x82  EP 2 IN
        bmAttributes            5
          Transfer Type            Isochronous
          Synch Type               Asynchronous
          Usage Type               Data
        wMaxPacketSize     0x1400  3x 1024 bytes
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       4
      bNumEndpoints           1
      bInterfaceClass        14 Video
      bInterfaceSubClass      2 Video Streaming
      bInterfaceProtocol      0 
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x82  EP 2 IN
        bmAttributes            5
          Transfer Type            Isochronous
          Synch Type               Asynchronous
          Usage Type               Data
        wMaxPacketSize     0x1400  3x 1024 bytes
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       5
      bNumEndpoints           1
      bInterfaceClass        14 Video
      bInterfaceSubClass      2 Video Streaming
      bInterfaceProtocol      0 
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x82  EP 2 IN
        bmAttributes            5
          Transfer Type            Isochronous
          Synch Type               Asynchronous
          Usage Type               Data
        wMaxPacketSize     0x13ec  3x 1004 bytes
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       6
      bNumEndpoints           1
      bInterfaceClass        14 Video
      bInterfaceSubClass      2 Video Streaming
      bInterfaceProtocol      0 
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x82  EP 2 IN
        bmAttributes            5
          Transfer Type            Isochronous
          Synch Type               Asynchronous
          Usage Type               Data
        wMaxPacketSize     0x1400  3x 1024 bytes
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       7
      bNumEndpoints           1
      bInterfaceClass        14 Video
      bInterfaceSubClass      2 Video Streaming
      bInterfaceProtocol      0 
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x82  EP 2 IN
        bmAttributes            5
          Transfer Type            Isochronous
          Synch Type               Asynchronous
          Usage Type               Data
        wMaxPacketSize     0x13ec  3x 1004 bytes
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       8
      bNumEndpoints           1
      bInterfaceClass        14 Video
      bInterfaceSubClass      2 Video Streaming
      bInterfaceProtocol      0 
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x82  EP 2 IN
        bmAttributes            5
          Transfer Type            Isochronous
          Synch Type               Asynchronous
          Usage Type               Data
        wMaxPacketSize     0x13bc  3x 956 bytes
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       9
      bNumEndpoints           1
      bInterfaceClass        14 Video
      bInterfaceSubClass      2 Video Streaming
      bInterfaceProtocol      0 
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x82  EP 2 IN
        bmAttributes            5
          Transfer Type            Isochronous
          Synch Type               Asynchronous
          Usage Type               Data
        wMaxPacketSize     0x0348  1x 840 bytes
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting      10
      bNumEndpoints           1
      bInterfaceClass        14 Video
      bInterfaceSubClass      2 Video Streaming
      bInterfaceProtocol      0 
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x82  EP 2 IN
        bmAttributes            5
          Transfer Type            Isochronous
          Synch Type               Asynchronous
          Usage Type               Data
        wMaxPacketSize     0x1400  3x 1024 bytes
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting      11
      bNumEndpoints           1
      bInterfaceClass        14 Video
      bInterfaceSubClass      2 Video Streaming
      bInterfaceProtocol      0 
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x82  EP 2 IN
        bmAttributes            5
          Transfer Type            Isochronous
          Synch Type               Asynchronous
          Usage Type               Data
        wMaxPacketSize     0x1400  3x 1024 bytes
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting      12
      bNumEndpoints           1
      bInterfaceClass        14 Video
      bInterfaceSubClass      2 Video Streaming
      bInterfaceProtocol      0 
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x82  EP 2 IN
        bmAttributes            5
          Transfer Type            Isochronous
          Synch Type               Asynchronous
          Usage Type               Data
        wMaxPacketSize     0x1400  3x 1024 bytes
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting      13
      bNumEndpoints           1
      bInterfaceClass        14 Video
      bInterfaceSubClass      2 Video Streaming
      bInterfaceProtocol      0 
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x82  EP 2 IN
        bmAttributes            5
          Transfer Type            Isochronous
          Synch Type               Asynchronous
          Usage Type               Data
        wMaxPacketSize     0x1400  3x 1024 bytes
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting      14
      bNumEndpoints           1
      bInterfaceClass        14 Video
      bInterfaceSubClass      2 Video Streaming
      bInterfaceProtocol      0 
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x82  EP 2 IN
        bmAttributes            5
          Transfer Type            Isochronous
          Synch Type               Asynchronous
          Usage Type               Data
        wMaxPacketSize     0x1400  3x 1024 bytes
        bInterval               1
Device Qualifier (for other device speed):
  bLength                10
  bDescriptorType         6
  bcdUSB               2.00
  bDeviceClass          239 Miscellaneous Device
  bDeviceSubClass         2 ?
  bDeviceProtocol         1 Interface Association
  bMaxPacketSize0        64
  bNumConfigurations      1
Device Status:     0x0000
  (Bus Powered)

Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass            9 Hub
  bDeviceSubClass         0 Unused
  bDeviceProtocol         0 Full speed (or root) hub
  bMaxPacketSize0        64
  idVendor           0x1d6b Linux Foundation
  idProduct          0x0002 2.0 root hub
  bcdDevice            2.06
  iManufacturer           3 Linux 2.6.37 ehci_hcd
  iProduct                2 EHCI Host Controller
  iSerial                 1 0000:00:1a.7
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           25
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0 
    bmAttributes         0xe0
      Self Powered
      Remote Wakeup
    MaxPower                0mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         9 Hub
      bInterfaceSubClass      0 Unused
      bInterfaceProtocol      0 Full speed (or root) hub
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0004  1x 4 bytes
        bInterval              12
Hub Descriptor:
  bLength               9
  bDescriptorType      41
  nNbrPorts             6
  wHubCharacteristic 0x000a
    No power switching (usb 1.0)
    Per-port overcurrent protection
  bPwrOn2PwrGood       10 * 2 milli seconds
  bHubContrCurrent      0 milli Ampere
  DeviceRemovable    0x00
  PortPwrCtrlMask    0xff
 Hub Port Status:
   Port 1: 0000.0100 power
   Port 2: 0000.0100 power
   Port 3: 0000.0100 power
   Port 4: 0000.0100 power
   Port 5: 0000.0100 power
   Port 6: 0000.0503 highspeed power enable connect
Device Status:     0x0003
  Self Powered
  Remote Wakeup Enabled

--V0207lvV8h4k8FAm--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
