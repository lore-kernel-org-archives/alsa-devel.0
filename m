From: Benny Sjostrand <gorm@cucumelo.org>
Subject: Re: [PATCH] cs46xx: Center-LFE channel support + a lot
 of hacking
Date: Sun, 06 Apr 2003 00:45:38 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E8F5C92.8080801@cucumelo.org>
References: <3E873CA2.2010607@cucumelo.org> <3E8B4877.4030306@gmx.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090007080305080101050900"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Friedrich Ewaldt <friedrich.ewaldt@gmx.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------090007080305080101050900
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

> I just tested your patches with my terratec DMX XFire 1024. Rear 
> channel doesn't seem to work as intended:
> I always get the same output out of both output jacks when I play back 
> on hw:0,0 (should be on the first/front output only, I assume).
> I can't hear anything from the analog outputs when playing back on 
> hw:0,1 (this should be the second output, correct?).
> I.e. the behaviour of the analog outputs of the XFire seems to not 
> have changed. 


Untested code is condemned to fail. Once again reading the cs4294 spec. 
I think I got an explication for this (see the 6.1.30 section, EAM bit ...)
So, I got a patch the hopefully would bring 4 channel sound for the 
XFire 1024 card. Please, would you like help testing it ?? and tell 
about the results ...

>
> SPDIF input no works basically again (it worked up to rc6, afterwards, 
> no non-distorted digital recording was possible with the XFire -- up 
> to your newest great patches :) ). That's a really great improvement! 
> Many thanks for this.
> I noticed that I can't change SPDIF input volume any more. Is this 
> intended? For me that's o.k. For recordings it's even better to have 
> no additional scaling. 

 Good to hear that the SPDIF input parts is functional again. I've not 
been able to test this parts course the SPDIF input on my Hercules GTXP 
card does not work at all since a couple a month agoo. I'm suspecting 
the HW, like I manage to burn it up with all weird experiments. Now with 
my new Terratec SiXPack 5.1 finally I've been able to do some tests again.

About the volume, there is not any code in the DSP that scales the 
samples anymore since I've change the tasklet with the last patch. The 
DSP tasklet that receives the input samples from the SPDIF input is very 
dummy, it just moves the samples to the output mixer, without doing any 
procesing at all (the same tasklet used for SPDIF pass-through) Another 
limitation is that no other sample-rate than 48khz will work, the 
CODEC's native sample-rate, as we for the moment dont know how to detect 
the incoming sample-rate, and setup a working sample-rate-converter 
tasklet it really dont matter ...

>
> SPDIF sounds good, as far I can hear with not-too-expensive headphones 
> near my not-too-silent computer. But as I've looked at a spectrogram 
> (short time spectra of short time windows), I noticed there are some 
> errors (spikes) approx. every 0.24 second. You can see these as thin 
> vertical lines that shouldn't be there in the plot I've attached. The 
> errors are not very severe: Most of them you can't seen in the time 
> signal, even if you know where they are an zoom into the signal ;) 

Sorry, I dont see any atachment in the mail ?

>
> I don't get these spikes when recording from analog sources or when 
> recording from SPDIF under win98. Not really true: sometimes I get 
> them also under win98, if I introduce many biterrors by 
> disonnecting/connecting the digital input cable several times. 
> Theoretically the SPDIF input should resync to the audio stream 
> afterwards, but sometimes it doesn't, even with the 'original' win 
> driver. Under win98, I can solve this problem by switching SPDIF input 
> off/on in the driver panel.

Seems like it has been hard even for the Cirrus developers to make the 
SPDIF input parts to work.

>
> so far my first results with the new patches. The SPDIF input results 
> are very encouraging that this card will get more and more useful 
> under linux thanks to your work...
>  fe
>
Thanks! always nice to hear some positive words :)

/Benny

--------------090007080305080101050900
Content-Type: text/plain;
 name="cs46xx_lib.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cs46xx_lib.patch"

--- alsa-kernel/pci/cs46xx/cs46xx_lib.c	Sat Apr  5 21:09:20 2003
+++ ../cvs/alsa-kernel/pci/cs46xx/cs46xx_lib.c	Sat Apr  5 21:22:58 2003
@@ -2543,13 +2543,21 @@
 	chip->eapd_switch = snd_ctl_find_id(chip->card, &id);
     
 #ifdef CONFIG_SND_CS46XX_NEW_DSP
+	if (chip->nr_ac97_codecs == 1 && 
+	   snd_cs46xx_codec_read(chip,AC97_VENDOR_ID2,
+				 CS46XX_PRIMARY_CODEC_INDEX) == 0x5d2d) {
+		/* set primary cs4294 codec into Extended Audio Mode */
+		snd_printdd("setting EAM bit on cs4294 CODEC\n");
+		snd_cs46xx_codec_write(chip,AC97_CSR_ACMODE,0x200,
+				       CS46XX_PRIMARY_CODEC_INDEX);
+	}
 	/* do soundcard specific mixer setup */
 	if (chip->mixer_init) {
 		snd_printdd ("calling chip->mixer_init(chip);\n");
 		chip->mixer_init(chip);
 	}
 #endif
-
+	
  	/* turn on amplifier */
 	chip->amplifier_ctrl(chip, 1);
     

--------------090007080305080101050900--



-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
