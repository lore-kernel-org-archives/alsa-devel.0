From: Ben Saylor <bensaylor@fastmail.fm>
Subject: Re: Audiophile USB samplerate workaround
Date: Wed, 23 Jul 2003 13:14:03 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200307231314.03395.bensaylor@fastmail.fm>
References: <200307222259.25527.bensaylor@fastmail.fm> <200307230205.50810.bensaylor@fastmail.fm> <s5hn0f5mtsv.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_bqvH/L3zbLVtM1h"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hn0f5mtsv.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--Boundary-00=_bqvH/L3zbLVtM1h
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

That does the trick.  Here's a patch against 0.9.5.

I don't know if this is related, but one thing I've been puzzling over 
is that half the time after I plug in the audiophile I get static 
instead of sound.  I have to unload alsa and plug it in again.  (As I 
mentioned before, I always get static if I load the alsa modules 
explicitly).

Ben

On Wednesday 23 July 2003 2:17 am, Takashi Iwai wrote:
> At Wed, 23 Jul 2003 02:05:50 -0800,
>
> Ben Saylor wrote:
> > > ok, then it supports other sample rates :)
> > >
> > > about the symptom: do you mean that the playback gets too fast
> > > with the lower sample rate,
> >
> > Yes.  i.e. it will play a 44100 hz or whatever stream, but playback
> > is too fast.
>
> so apparently we need some workaround (as found below line 2291 of
> usbaudio.c).
> please try to check the product and vendor id and set
> 	fp->attribtes |= EP_CS_ATTR_SAMPLERATE
> with that condition.
> if it works, please give me the patch.
>
>
> thanks,
>
> Takashi

--Boundary-00=_bqvH/L3zbLVtM1h
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="audiophile1.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="audiophile1.diff"

--- alsa-driver-0.9.5/alsa-kernel/usb/usbaudio.c	2003-06-23 04:41:36.000000000 -0800
+++ alsa-driver-0.9.5-brs/alsa-kernel/usb/usbaudio.c	2003-07-23 12:53:19.000000000 -0800
@@ -2295,6 +2295,14 @@
 			 */
 			fp->attributes &= ~EP_CS_ATTR_SAMPLE_RATE;
 		}
+
+		/* workaround for M-Audio Audiophile USB */
+		if (dev->descriptor.idVendor == 0x0763 &&
+		    dev->descriptor.idProduct == 0x2003) {
+			/* doesn't set the sample rate attribute, but supports it */
+			fp->attributes |= EP_CS_ATTR_SAMPLE_RATE;
+		}
+
 		/*
 		 * plantronics headset and Griffin iMic have set adaptive-in
 		 * although it's really not...
@@ -2695,11 +2703,6 @@
 	if (quirk && quirk->ifnum != QUIRK_ANY_INTERFACE && ifnum != quirk->ifnum)
 		goto __err_val;
 
-	if (usb_set_configuration(dev, get_cfg_desc(config)->bConfigurationValue) < 0) {
-		snd_printk(KERN_ERR "cannot set configuration (value 0x%x)\n", get_cfg_desc(config)->bConfigurationValue);
-		goto __err_val;
-	}
-
 	/* SB Extigy needs special boot-up sequence */
 	/* if more models come, this will go to the quirk list. */
 	if (dev->descriptor.idVendor == 0x041e && dev->descriptor.idProduct == 0x3000) {
@@ -2729,6 +2732,11 @@
 		/* it's a fresh one.
 		 * now look for an empty slot and create a new card instance
 		 */
+		if (usb_set_configuration(dev, get_cfg_desc(config)->bConfigurationValue) < 0) {
+			snd_printk(KERN_ERR "cannot set configuration (value 0x%x)\n", get_cfg_desc(config)->bConfigurationValue);
+			goto __err_val;
+		}
+
 		for (i = 0; i < SNDRV_CARDS; i++)
 			if (enable[i] && ! usb_chip[i] &&
 			    (vid[i] == -1 || vid[i] == dev->descriptor.idVendor) &&

--Boundary-00=_bqvH/L3zbLVtM1h--



-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
