From: Juan Linietsky <coding@reduz.com.ar>
Subject: Alsa MIDI device description extension proposal.
Date: Fri, 22 Mar 2002 22:16:29 -0300
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020322221629.57fa7159.coding@reduz.com.ar>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received: from john.anime.com.ar ([64.113.39.216])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id CAA14528
	for <alsa-devel@alsa-project.org>; Sat, 23 Mar 2002 02:15:06 +0100
Received: from server (c00lius@OL16-140.fibertel.com.ar [24.232.140.16])
	by john.anime.com.ar (8.9.3/8.9.3) with SMTP id VAA24611
	for <alsa-devel@alsa-project.org>; Fri, 22 Mar 2002 21:14:46 -0400
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I have a proposal in mind, which should make much easier for programs to use the devices in a less-blind way, and standarize patch naming and device descriptions. I think it would be great if authors of existing apps have the chance to modify their programs to take advantage of this, saving us both users and programmers a lot of effort.

I really think this is a very important issue that hasnt been addressed,
And, if no one is interested in workig on this, I'd like to work on this myself, so i'll have the chance to learn.


----Proposal follows----

Basically, the idea is this, since midi is by default a 1-way protocol, there's no standard way to retrieve info from a device, this means that if we do have a midi port, we have no standard way to know which banks does it have or the names of the patches. The only work around to this, in midi sequencing programs is to create propertary (to the program itself) files describing the patch layout. This is very annoying when we, for example, use some external synth and we have to create all the sample definitions for a program, or when we use a soundfont and we have to manually create the definitions to each instrument, when it comes in the soundfont itself
Or if we use some random sofstynth and we get to create some a sound
or bank, we have to yet again recreate the instrument definitions for
our sequencing apps.

To avoid this instrument naming madness, i propose to add an extension
to both the alsa user interface, driver interface, and sequencer client inerface which could work this way:

from the program side:

-ability to poll the midi port for amount of banks and their parameters (or default bank if no banks). 
-ability to poll for patch names in a bank
-ability to poll the midi port for rynth channels/patches (default is channel 10, i know, but some synths use channel 16 or more than one rynth channel), or to poll if a certain patch number is a rythm patch (some synths use a certain patch number for the drums)
-ability to poll for changes in the devices (or a callback manybe?) so they can be retrieved and updated
-ability to poll DEFAULT VALUES of patches (such as controller values, poly/mono, portamento, sustain, expression, volume etc) which the patch
sets to when selected. This is extremely useful in external synth modules/keyboards.

from driver/synth client side:

-if the driver supports it (such as, for exampe, a sblive or sbawe, opl3 (sbi loading), or alike, or a sequencer client which can hold the patch names itself, such as timidity, saturno, iiwusynth, smurf, etc then the driver itself will take care of answering the client request.
-if the driver doesnt support this, (for example, an external midi uart)
 then it should be possible to create a STANDARD instrument definition file for this device, which alsa-lib will take care of, like for example:

djleet@myworkstation:/etc/alsa/definitions$ vi my_trance_machine.def

device {

	name = " r0x0r tranc3m4chine "
	port = "MIDI 0-1"

}

bank {

	name = "rezocool phasers"

	msb = 31
	lsb = 22

	patch_1 = " super acid pad "
	patch_2 = " cool juicy 303 thing "
        patch_2_control_default = 55,20
	patch_3 = " temple of doom "

}

bank {

	name "basses"

	msb = 32
	lsb = 22

	patch_1 = " super six poles filtered FM bass "
	patch 2 = " pick bass "

}

etc.



---

This should basically avoid us users and programmers to do all this work from the sequencer program side, and also ending up with a hundred of incompatible formats.


As I said before, this would be extensions to the current ALSA sequencer
system, so I think nothing should become incompatible with the current
alsa version.


thanks for reading this!

Juan Linietsky

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
