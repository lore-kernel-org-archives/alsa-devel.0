From: "Matthew R. Hurne" <matt.hurne@versatile.com>
Subject: Re: no front speaker sound with ALC262
Date: Tue, 26 Feb 2008 11:59:18 -0500
Message-ID: <47C44566.1030409@versatile.com>
References: <165af2360802221645p9fa6bb0y3a5573caa7bcdbd7@mail.gmail.com>	<47BF84BF.702@versatile.com>	<47BF8500.1050802@versatile.com>	<7D68F908-875D-4EDE-B25D-CCBDD4E4A339@gmail.com>
	<s5h1w6zvrz4.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mustang.versatile.com (mustang.versatile.com [206.61.179.31])
	by alsa0.perex.cz (Postfix) with ESMTP id 824732464B
	for <alsa-devel@alsa-project.org>; Tue, 26 Feb 2008 17:59:20 +0100 (CET)
In-Reply-To: <s5h1w6zvrz4.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Rene Dohmen <acidjunk@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Mon, 25 Feb 2008 13:49:43 +0100,
> Rene Dohmen wrote:
>> Hi List,
>>
>> Is there any chance that this bug will be fixed soon?
> 
> Well, it's up to you.
> 
> One of the problems is that BIOS on your machine doesn't give the
> useful information for auto-probing at all.  A typical workaround in
> such a case is to try the existing preset models.  Pass model=basic or
> model=benq to snd-hda-intel module, for example.  The available model
> values can be found in ALSA-Configuration.txt.  Don't forget to
> check and adjust the mixer status again after changing the model
> because the mixers appear completly differently depending on the
> model.
> 
> If none of the existing models doesn't match with your device, we have
> to figure out the exact codec configuration.  For some codecs like
> ALC880 or ALC260, you have model=test option that allows you to test
> all codec configurations via mixer interface.  Unfortunately, ALC262
> has no model=test support, so you have to do check it literally
> manually.  Below is a brief instruction how to explore the mysterious
> world of HD-audio codecs.
> 
> First of all, install the very latest ALSA HG version.  Don't stick
> with 1.0.16 release.  You can use the daily snapshot tarball instead,
> too.
> 
> Then, get hda-verb program found on
> 	ftp://ftp.suse.com/pub/people/tiwai/misc/
> Extract the tarball, run make.  Install it or invoke it locally.  This
> program can be usable only as root.
> 
> The next step is to get ALC262 datasheet from Realtek web site.  Take
> a look at the block diagram page.  There are pins in the right side
> and two DACs in the left side.  We have to set up the correct pins and
> connect to the DAC properly.
> 
> Now, assume the port-D (NID 0x14) is the speaker output.  Check
> /proc/asound/card0/codec#0 and look for Node 0x14.  It may have the
> entry like the following:
> 
> 	Node 0x14 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
> 	  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
> 	  Amp-In vals:  [0x00 0x00] [0x00 0x00]
> 	  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
> 	  Amp-Out vals:  [0x80 0x80]
> 	  Pincap 0x083e: IN OUT HP Detect Trigger
> 	  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
> 	    Conn = 1/8, Color = Black
> 	    DefAssociation = 0xf, Sequence = 0x0
> 	    Misc = NO_PRESENCE
> 	  Pin-ctls: 0x20: IN
> 	  Unsolicited: tag=00, enabled=0
> 	  Connection: 2
> 	     0x0c* 0x0d
> 
> For this widget, we have a couple of things to do: fix the pin type,
> adjust the amp and check the connection.  First, change the pin type
> to the correct one, the output type.  Usually, it's either 0x40 or
> 0xc0.  The latter type is with a headphone amplifier.  Let's take
> 0xc0 as an example.  Call hda-verb like below (as root user):
> 
> 	# hda-verb /dev/snd/hwC0D0 0x14 SET_PIN_WID 0xc0
> 
> Check /proc/asound/card0/codec#0 again whether the pin-ctls is changed
> properly.  Similarly, unmute the output volume of this widget with
> hda-verb.  For this, pass 0xb000 to SET_AMP verb:
> 
> 	# hda-verb /dev/snd/hwC0D0 0x14 SET_AMP 0xb000
> 
> 0xb000 means to set the AMP-output to 0x00.  The mute bit is 0x80, so
> 0x00 means to unmute and set the volume 0.  (The volume 0 doesn't
> matter because this widget has no volume but only mute control.)
> 
> In the example above, this pin is connected from the NID 0x0c, which
> is a mixer amp.  That's fine and let's keep as is.
> Check this widget 0x0c whether the first Amp-In vals is unmuted
> (i.e. has *no* 0x80 bit mask).  The first element of 0x0c is connected
> to the DAC, 0x02, directly.  If it's muted, call like below 
> 
> 	# hda-verb /dev/snd/hwC0D0 0x0c SET_AMP 0x7000
> 
> 0x7000 means to set the AMP-input of the first element (index 0) to
> 0x00.  For the second element, it'd be 0x7100.
> 
> OK, all set ready.  Try aplay and pray.  If this doesn't work, try
> other ports as well until you find a gold mine.
> 
> You could check the inputs similarly if anything doesn't work.
> Once after you figure out all pin configurations, we can create a new
> model (or fix the existing model) to adapt your device.
> 
> Have fun,
> 
> 
> Takashi

Thanks, Takashi!  If it so happens I have the time, I will try to play with this in tandem to Rene.

Regards,
-- 
Matthew Hurne
Versatile Systems, Inc.
717.919.9102
matthew.hurne@versatile.com
