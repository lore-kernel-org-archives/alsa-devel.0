From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: UCM questions
Date: Fri, 21 Jan 2011 15:24:51 +0000
Message-ID: <1295623491.3348.284.camel@odin>
References: <AANLkTim72DeHVzx3kmgF59EQQwC8jHAVpMZnt+kVTddX@mail.gmail.com>
	<20110121113744.GA18682@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-lO0tc87jp2tSVouv1IuS"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f41.google.com (mail-ww0-f41.google.com [74.125.82.41])
	by alsa0.perex.cz (Postfix) with ESMTP id DC9EE24602
	for <alsa-devel@alsa-project.org>; Fri, 21 Jan 2011 16:24:55 +0100 (CET)
Received: by wwi18 with SMTP id 18so796099wwi.2
	for <alsa-devel@alsa-project.org>; Fri, 21 Jan 2011 07:24:55 -0800 (PST)
In-Reply-To: <20110121113744.GA18682@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: pl bossart <bossart.nospam@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org


--=-lO0tc87jp2tSVouv1IuS
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2011-01-21 at 11:37 +0000, Mark Brown wrote:
> On Thu, Jan 20, 2011 at 04:06:55PM -0600, pl bossart wrote:
> > Hello all,
> > I've been looking at the UCM code in
> > git://git.alsa-project.org/alsa-lib.git branch ucm. Looks both
> > simple/powerfl/useful, still I have a couple of questions (most likely
> > for Liam and Mark):
> 
> CCing in Liam so he sees this.  Below are my initial thoughts but Liam
> can give better answers.

Adding to Mark's answers below.

> 
> > - how would a USB device be handled? An audio use case is defined by a
> > verb and device parameter. My understanding is for a USB headset used
> > for music playback, we would still use the 'HiFi' verb, but then we
> > would need a 'USB' device added in include/use-case.h ? Then how would
> 
> The device/use case names there are just defaults, systems can add their
> own.  The default set of use cases and devices are likely to handle
> most cases but there's going to be a dependence on the system
> integration.
> 
> > I make a difference between a USB headset and USB speakers?
> 
> You'd probably need to handle identifying the different classes USB
> devices in whatever owns the use case configuration for the system.
> I'm not sure that's been looked at in much detail, USB host support is
> fairly unusual in the embedded systems this targets.
> 
> > - same question for remote displays/display port.
> 
> A similar thing applies here - I'd imagine many applications would make
> the decision to use a display output based partly on use case.
> 

As Mark says the applications would make the decision here based on use
case and UCM could provide the correct PCM source and sink device and hw
volume to use in each use case.

Fwiw, the USB and display port examples above are also fairly trivial
wrt internal audio routing within their hardware. They should not really
require any internal hardware routing support from UCM (as they likely
both have direct path from DAC to transducer), but I expect they will
have any PCM data routing performed in software by Pulseaudio (based on
any Pulseaudio policy/configuration).

> > - how useful is the notion of 'card list'? Seems to me that the verbs
> > are the main entry points, and the notion of card is abstracted away.
> > For a given use case, the application can query the string containing
> > the device name. Or I am misled and verbs are only related to a given
> > card?

Originally, verbs were mapped 1:1 with cards, however Jaroslav recently
added support for multiple cards per verb.

> > - If I want to enable a camcorder use case, possibly with multiple
> > microphones, do I still use the 'HiFi' verb? Or do we need a new verb
> > for capture cases? I don't see any mics as capture devices hence the
> > question.
> 
> I'd suggest that'd either be the HiFi verb or a new verb.

Probably a "Camcorder" verb, with the Mics as it's devices.

> 
> > - how would IEC-formatted data be handled for HDMI/SPDIF? It could be
> > a different physical device for PCM and IEC-formatted data, and you
> > would need to enable IEC-related switches in the alsa controls. Or
> > would a modifier be more appropriate to provide additional information
> > on the content type?
> 
> I'd guess modifier.
> 
> > - has anyone generated a typical configuration file for USB and
> > HDAudio? I only see an OMAP conf.
> 
> Someone asked this at LPC as well - my thought there is that probably
> PC systems would be happier trying to work without explicit use case
> configuration as they are currently.

I've attached a more recent configuration example. This shows all the
configurations options, albeit with dummy values.

Liam

-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk

--=-lO0tc87jp2tSVouv1IuS
Content-Disposition: attachment; filename="hifi"
Content-Type: text/x-tex; name="hifi"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

# Example Use case verb section for HiFi music e.g. MP3 playback
# By Joe Blogs <joe@blogs.com>

SectionVerb {
  	
	# enable and disable sequences are compulsory
  	EnableSequence [
		
		#set the cdev for the following cset ops.
		cdev "hw:AudioPCI"
		cset "name='PCM Volume' 5,5"

		# run this command when we are finished
		exec "ls -l"
	]

	DisableSequence [
		cdev "hw:AudioPCI"
		cset "name='PCM Volume' 15,15"
	]

	# Optional QoS and ALSA PCMs
	TQ HiFi
	CapturePCM "hw:0,0"
	PlaybackPCM "hw:0,0"
}

SectionDevice."Headphones".0 {
	
	EnableSequence [
		cdev "hw:AudioPCI"
		cset "name='PCM Capture Switch' 1,1"
	]

	DisableSequence [
		cdev "hw:AudioPCI"
		cset "name='PCM Capture Switch' 0,0"
	]

	# the hardware volume controls for this device
	PlaybackVolume "name='Master Playback Volume',index=2"
	PlaybackSwitch "name='Master Playback Switch',index=2"
}

SectionDevice."Headset".0 {
	Comment "Blah Blah"
	EnableSequence [
		cdev "hw:AudioPCI"
		cset "name='PCM Capture Route' 1,1,1,1"
	]

	DisableSequence [
		cdev "hw:AudioPCI"
		cset "name='PCM Capture Route' 0,0,0,0"
	]

	# the hardware volume controls for this device
	PlaybackVolume "name='Master Playback Volume',index=2"
	PlaybackSwitch "name='Master Playback Switch',index=2"
}

SectionModifier."PlayTone".0 {
	Comment "Play tone to handset during music playback"
	SupportedDevice [
		"Headset.0"
	]

	EnableSequence [
		cdev "hw:AudioPCI"
		cset "name='Master Mono Playback Switch' 1"
		exec "echo pt headset"
	]

	DisableSequence [
		cdev "hw:AudioPCI"
		cset "name='Master Mono Playback Switch' 0"
	]

	# the PCM source for this modifier
	CapturePCM "hw:0,2"

	# the hardware volume controls for this device
	PlaybackVolume "name='Master Playback Volume',index=2"
	PlaybackSwitch "name='Master Playback Switch',index=2"
}

SectionDevice."Headset".1 {
	
	EnableSequence [
		cdev "hw:AudioPCI"
		cset "name='PCM Capture Route' 1,1,1,1"
	]

	DisableSequence [
		cdev "hw:AudioPCI"
		cset "name='PCM Capture Route' 0,0,0,0"
	]

	PlaybackVolume "name='Master Playback Volume',index=2"
	PlaybackSwitch "name='Master Playback Switch',index=2"
}

SectionModifier."PlayTone".1 {
	Comment "Play tone to headphones and ahndset during music playback"
	SupportedDevice [
		"Headphones.0"
	]

	EnableSequence [
		cdev "hw:AudioPCI"
		cset "name='Master Mono Playback Volume' 2"
		exec "echo pt headphones"
	]

	DisableSequence [
		cdev "hw:AudioPCI"
		cset "name='Master Mono Playback Volume' 0"
	]

	PlaybackPCM "hw:0,2"
	PlaybackVolume "name='Master Playback Volume',index=2"
	PlaybackSwitch "name='Master Playback Switch',index=2"
}


--=-lO0tc87jp2tSVouv1IuS
Content-Disposition: attachment; filename="AudioPCI.conf"
Content-Type: text/plain; name="AudioPCI.conf"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

SectionUseCase."HiFi" {
 		File "hifi"
 		Comment "Play and record HiFi quality Music."
}

# This file also store the default sound card state.

SectionDefaults [
cdev "hw:AudioPCI"
cset "name='Master Playback Switch' 1,1"
cset "name='Master Playback Volume' 10,25"
cset "name='Master Mono Playback Switch' 0"
cset "name='Master Mono Playback Volume' 0"
cset "name='PCM Switch' 1,1"
cset "name='PCM Volume' 25,25"
cset "name='PCM Playback Switch' 1,1"
cset "name='PCM Capture Switch' 0,0"
]


--=-lO0tc87jp2tSVouv1IuS
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--=-lO0tc87jp2tSVouv1IuS--
