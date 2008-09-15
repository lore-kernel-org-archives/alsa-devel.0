From: "S. Aguinaga" <sa_jr@yahoo.com>
Subject: alsa on Apple Mac Pro Tower ( macPro3, 1, quad core,
	xenon)
Date: Mon, 15 Sep 2008 09:14:35 -0700 (PDT)
Message-ID: <767489.26449.qm@web65616.mail.ac4.yahoo.com>
Reply-To: "S. Aguinaga" <sa_jr@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from web65616.mail.ac4.yahoo.com (web65616.mail.ac4.yahoo.com
	[76.13.9.84]) by alsa0.perex.cz (Postfix) with SMTP id 007B0243BC
	for <alsa-devel@alsa-project.org>;
	Mon, 15 Sep 2008 18:14:36 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I downloaded the latest development drivers, lib, and utils (1.0.18rc3) and compiled and installed it again.  Next I made sure that the /etc/modprobe.d/sound had the following line:
options snd-hda-intel model=imac24

and first I checked the gui tool called "PulseAudio Volume Control" from my "multimedia" section, and it crashes!  

Next I tried the aplay somesound.wav file from the command line, it my Mac Pro sings!!!


I don't know what the PulseAudio issues are, but ... oh well!!

Next I checked that Amrok works using the alsa engine, and it does!!


If I plug in a headphone set, and I play music again it comes out of the MacPro speaker only, but no from the headphones. 


Do you have a handle this, if you guys have some links for me to read, please send them my way!

Thank you.
// Sal Aguinaga
// Northwestern University
// Evanston, IL 



----- Original Message ----
From: Takashi Iwai <tiwai@suse.de>
To: S. Aguinaga <sa_jr@ieee.org>
Cc: alsa-devel@alsa-project.org
Sent: Tuesday, August 19, 2008 5:48:47 AM
Subject: Re: [alsa-devel] Alsa-devel Digest, Vol 18, Issue 45

At Mon, 18 Aug 2008 10:26:42 -0700 (PDT),
S. Aguinaga wrote:
> 
> ==============================================
> Trying to figure out where to add this "model=macpro"
> and it looks like it should be in a file called modprobe.conf or an options file under /etc/modprobe.d/
> 
> but I don't have (with my installation -- fedora {9} ) those files, do you have any input on this?

You can create any file, typically, /etc/modprobe.d/sound or so.
Put the following line there

options snd-hda-intel model=macpro

Then reload the module, check the sysfs file
/sys/modules/snd_hda_intel/parameters/macpro to see whether the
specified option was really passed properly.


Takashi

> below are the only files I have.
> 
> /etc/modprobe.d/
>  
> anaconda  
> blacklist-visor  
> i915modeset
> blacklist  
> floppy-pnp      
> modprobe.conf.dist
> 
> 
> ==============================================
> Subject: Re: [alsa-devel] Alsa-devel Digest, Vol 18, Issue 45
> 
> At Sat, 16 Aug 2008 06:15:46 -0700 (PDT),
> S. Aguinaga wrote:
> > 
> > S. Aguinaga wrote:
> > > 
> > > Hello Stan,
> > > 
> > > This is awesome I did find the problem it's listed in the /var/log/messages under ALSA.
> > > 
> > > 1.   When I bring up the "Pulse Volume Control" gui, the first tab "Playback"  comes up empty, and grayed-out is "No Streams Available"
> > > 2.   aplay does not produce sound, period!
> > > 3.   Amrok's welcome sample does not produce sound out of the std tower speaker or the headphone jack.
> > > 
> > > I didn't notice anything strange on the output of the alsa-info.sh file, but when I checked the var/log/messages, this is what I found:
> > > 
> > >  sudo cat /var/log/messages | grep ALSA
> > > Aug 11 07:52:10 macprolinx kernel: ALSA sound/pci/hda/hda_intel.c:1810: chipset global capabilities = 0x4401
> > > Aug 11 07:52:10 macprolinx kernel: ALSA sound/pci/hda/hda_intel.c:749: codec_mask = 0x1
> > > Aug 11 07:52:10 macprolinx kernel: ALSA sound/pci/hda/hda_codec.c:1073: Cannot find slave Surround Playback Volume, skipped
> (snip)
> 
> These messages are harmless.  It's just information from the driver,
> enabled only when you build it with CONFIG_SND_DEBUG_VERBOSE=y.
> 
> > I think your problem is a misidentification of your sound chip.  The 
> > model being used for your 889A appears to be incompatible, thus all 
> > the errors above.  It appears that the macpro ALC885 is being selected 
> > before it gets to the choice for the ALC889A.  Perhaps a developer can 
> > look into this.
> 
> Well, ALC882, ALC885 and ALC889A are almost compatible.  In the
> driver, they are all handled in the same routine.
> 
> There are a few models for intel macs with ALC88x.  Try to specify
> either model=macpro, model=mbp3 or model=imac24 as the module option
> of snd-hda-intel driver.
> 
> 
> Takashi
> 
> 
> 
>      
> 
