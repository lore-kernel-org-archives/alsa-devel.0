From: Karsten Wiese <annabellesgarden@yahoo.de>
Subject: Re: snd-usb-usx2y 0.8.7 hwdep pcm oopses!
Date: Tue, 14 Dec 2004 19:49:49 +0100
Message-ID: <200412141949.50054.annabellesgarden@yahoo.de>
References: <64648.195.245.190.93.1103017646.squirrel@195.245.190.93>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_OXzvB1G5CCxk38h"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <64648.195.245.190.93.1103017646.squirrel@195.245.190.93>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Rui Nuno Capela <rncbc@rncbc.org>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

--Boundary-00=_OXzvB1G5CCxk38h
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Am Dienstag 14 Dezember 2004 10:47 schrieb Rui Nuno Capela:
> Hi,
> 
> While testing the new snd-usb-usx2y 0.8.7 hwdep pcm interface on my Tascam
> US-224, and feeding it via aplay -D hw:N,2 samefile.wav, I've come to face
> a couple of issues I would like to report here.
> 
> The first one is about a repeatable kernel crash happening on my SUSE 9.2
> Pro box (P4/HT), but also on my Mdk 10.1 laptop (P4/UP), everytime I try
> to aplay against the hw:N,2 device (N=soundcard index). See below for the
> whole data and the proper oops dumps. As every kernel crash, the system is
> left in a very dangerous and unstable state, so that this particular issue
> should be addressed ASAP.

OK, that one is fixed by attached patch.
Takashi: Please apply with
>>>>>>
Summary: return -EBUSY from snd_usX2Y_usbpcm_open(),
  if the associated hwdep device is not opened.

It now works as originally intended. Had forgotten a pair of parenthesis.

Signed-off-by: Karsten Wiese <annabellesgarden@yahoo.de>
<<<<<<
 

> OTOH, on the SUSE desktop I've not been able to run jackd with the 'usx2y'
> backend driver, always telling me that the 'hwdep' assertion has failed on
> hwdep.c:588 (this is from memory). On the laptop, where I've been testing
> the usx2y backend quite extensively, it works just fine as myself has
> already praised :) Take a note that,o n either box, the snd-usb-usx2y and
> kernel versions are exactly the same, so are jackd's, currently
> 0.99.35cvs, but it doesn't matter as the jack_usx2y backend code is still
> Karsten's original. At first glance, the differences I can point between
> the two are the hardware (obviously) and the SMP vs. UP kernel. One thing
> that now comes to mind is that the snd-usb-usx2y is being loaded as the
> third soundcard on the failing system and not as the second as once was
> and I'm sure it used to work the last time I've tried long ago.

Could be that assert: 
const char *snd_hwdep_dsp_status_get_id(const snd_hwdep_dsp_status_t *obj)
{
 assert(obj);
 return obj->id;
}

Mmmh,,,,,, what could cause it ?
Rui: Just 1 idea: Does this also happen, when jackd is started as root?
I had udev assigning some devices rights to root only occasionally.

Karsten

--Boundary-00=_OXzvB1G5CCxk38h
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="snd-usb-usx2y.patch.0.8.7.1"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="snd-usb-usx2y.patch.0.8.7.1"

Index: alsa-kernel/usb/usx2y/usbusx2y.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/usb/usx2y/usbusx2y.c,v
retrieving revision 1.7
diff -U3 -r1.7 usbusx2y.c
--- alsa-kernel/usb/usx2y/usbusx2y.c	2 Dec 2004 14:41:21 -0000	1.7
+++ alsa-kernel/usb/usx2y/usbusx2y.c	14 Dec 2004 18:26:02 -0000
@@ -1,6 +1,10 @@
 /*
  * usbusy2y.c - ALSA USB US-428 Driver
  *
+2004-12-14 Karsten Wiese
+	Version 0.8.7.1:
+	snd_pcm_open for rawusb pcm-devices now returns -EBUSY if called without rawusb's hwdep device being open.
+
 2004-12-02 Karsten Wiese
 	Version 0.8.7:
 	Use macro usb_maxpacket() for portability.
@@ -139,7 +143,7 @@
 
 
 MODULE_AUTHOR("Karsten Wiese <annabellesgarden@yahoo.de>");
-MODULE_DESCRIPTION("TASCAM "NAME_ALLCAPS" Version 0.8.7");
+MODULE_DESCRIPTION("TASCAM "NAME_ALLCAPS" Version 0.8.7.1");
 MODULE_LICENSE("GPL");
 MODULE_SUPPORTED_DEVICE("{{TASCAM(0x1604), "NAME_ALLCAPS"(0x8001)(0x8005)(0x8007) }}");
 
Index: alsa-kernel/usb/usx2y/usx2yhwdeppcm.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/usb/usx2y/usx2yhwdeppcm.c,v
retrieving revision 1.1
diff -U3 -r1.1 usx2yhwdeppcm.c
--- alsa-kernel/usb/usx2y/usx2yhwdeppcm.c	8 Dec 2004 19:29:21 -0000	1.1
+++ alsa-kernel/usb/usx2y/usx2yhwdeppcm.c	14 Dec 2004 18:26:04 -0000
@@ -22,7 +22,7 @@
  It provides the alsa kernel half of the usx2y-alsa-jack driver pair.
  The pair uses a hardware dependant alsa-device for mmaped pcm transport.
  Advantage achieved:
-         The usb_hcd places reads/writes pcm data into dma-memory.
+         The usb_hc moves pcm data from/into memory via DMA.
          That memory is mmaped by jack's usx2y driver.
          Jack's usx2y driver is the first/last to read/write pcm data.
          Read/write is a combination of power of 2 period shaping and
@@ -568,7 +568,7 @@
 					 snd_pcm_substream_chip(substream))[substream->stream];
 	snd_pcm_runtime_t	*runtime = substream->runtime;
 
-	if (!subs->usX2Y->chip_status & USX2Y_STAT_CHIP_MMAP_PCM_URBS)
+	if (!(subs->usX2Y->chip_status & USX2Y_STAT_CHIP_MMAP_PCM_URBS))
 		return -EBUSY;
 
 	runtime->hw = SNDRV_PCM_STREAM_PLAYBACK == substream->stream ? snd_usX2Y_2c :

--Boundary-00=_OXzvB1G5CCxk38h--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
