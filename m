From: John Knottenbelt <jak97@doc.ic.ac.uk>
Subject: Re: Exchange DAC Setting Disappeared - CMIPCI
Date: Sun, 21 Mar 2004 22:06:58 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200403212206.58539.jak97@doc.ic.ac.uk>
References: <200403212113.35943.jak97@doc.ic.ac.uk>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_CIhXAXHfjC/jLBn"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200403212113.35943.jak97@doc.ic.ac.uk>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--Boundary-00=_CIhXAXHfjC/jLBn
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I was able to restore the 'Exchange DAC' Setting with the attached patch. Do 
you think it would be worth while to try and make it a module setting?

Cheers

John

On Sunday 21 March 2004 21:13, John Knottenbelt wrote:
> Hi
>
> I see that the exchange DAC setting has disappeared from my mixer settings.
> I understand after reading thread
>
>  
> http://www.mail-archive.com/alsa-devel%40lists.sourceforge.net/msg09930.htm
>l
>
> That this is because it wasn't working well in a multi-channel context.
>
> The use that I was putting this to, however, was to switch between
> headphones and loudspeakers (by connecting loudspeakers to blue and
> headphones to green). I only ever do stereo output.
>
> Is it possible to achieve the same functionality without this switch? If
> not, would it be possible to bring it back? Specifically I would like to be
> able to switch between loudspeakers and headphones without having to
> restart any applications and for the switch to have immediate effect.
>
> My card is a 6 channel on board cmipci:
>
> 00:0c.0 Multimedia audio controller: C-Media Electronics Inc CM8738 (rev
> 10) Subsystem: Micro-Star International Co., Ltd.: Unknown device 5900
>
> Many thanks
>
> John
>
>
> -------------------------------------------------------
> This SF.Net email is sponsored by: IBM Linux Tutorials
> Free Linux tutorial presented by Daniel Robbins, President and CEO of
> GenToo technologies. Learn everything from fundamentals to system
> administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel

--Boundary-00=_CIhXAXHfjC/jLBn
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="alsa.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="alsa.patch"

--- sound/pci/cmipci.c.orig	2004-03-21 21:34:55.000000000 +0000
+++ sound/pci/cmipci.c	2004-03-21 21:35:09.000000000 +0000
@@ -2753,13 +2753,13 @@
 		err = snd_ctl_add(cm->card, snd_ctl_new1(sw, cm));
 		if (err < 0)
 			return err;
 	}
-	if (! cm->can_multi_ch) {
+/* 	if (! cm->can_multi_ch) { */
 		err = snd_ctl_add(cm->card, snd_ctl_new1(&snd_cmipci_nomulti_switch, cm));
 		if (err < 0)
 			return err;
-	}
+/* 	} */
 	if (cm->device == PCI_DEVICE_ID_CMEDIA_CM8738 ||
 	    cm->device == PCI_DEVICE_ID_CMEDIA_CM8738B) {
 		sw = snd_cmipci_8738_mixer_switches;
 		for (idx = 0; idx < num_controls(snd_cmipci_8738_mixer_switches); idx++, sw++) {

--Boundary-00=_CIhXAXHfjC/jLBn--


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
