From: "S. Aguinaga" <sa_jr@yahoo.com>
Subject: alsa driver on latest Mac Pro (MacPro3,1)
Date: Thu, 21 Aug 2008 13:34:04 -0700 (PDT)
Message-ID: <295071.94996.qm@web65614.mail.ac4.yahoo.com>
Reply-To: "S. Aguinaga" <sa_jr@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from web65614.mail.ac4.yahoo.com (web65614.mail.ac4.yahoo.com
	[76.13.9.82]) by alsa0.perex.cz (Postfix) with SMTP id AD1BB244D1
	for <alsa-devel@alsa-project.org>;
	Thu, 21 Aug 2008 22:34:05 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, "S. Aguinaga" <sa_jr@ieee.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


Additionally, I noticed that the results file from 'alsa-info.sh' the section about Module is does now show "macpro" under the model section.

Might I be doing something wrong?
< snippet >
....

!!Module: snd_hda_intel
bdl_pos_adj : 1,-1,-1,-1,-1,-1,-1,-1
enable : Y,Y,Y,Y,Y,Y,Y,Y
enable_msi : 0
id : <NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>
index : -1,-1,-1,-1,-1,-1,-1,-1
model : <NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>
position_fix : 0,0,0,0,0,0,0,0
power_save : 0
power_save_controller : Y
probe_mask : -1,-1,-1,-1,-1,-1,-1,-1
single_cmd : N
 ....
< snippet >

// Salvador 
// Northwestern Univeristy




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
