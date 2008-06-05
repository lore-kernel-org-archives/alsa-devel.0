From: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Subject: [ANNOUNCE] ALSA scenario manager library
Date: Thu, 05 Jun 2008 18:09:18 +0100
Message-ID: <1212685758.3480.64.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8DF1F2462E
	for <alsa-devel@alsa-project.org>;
	Thu,  5 Jun 2008 19:09:19 +0200 (CEST)
Received: from [172.20.21.6] (lumison.wolfsonmicro.com [87.246.78.27])
	by opensource2.wolfsonmicro.com (Postfix) with ESMTP id AB6CC110179
	for <alsa-devel@alsa-project.org>; Thu,  5 Jun 2008 18:09:18 +0100 (BST)
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

I've now released the first version (v0.1) of an ALSA scenario (or use
case) manager. It's currently a stand alone library that can either be
linked against alsa-lib or salsa (not tested - afaik I've not used any
alsa-lib only symbols). This library is designed to provide userspace
applications (e.g. Pulse Audio) with a generic API to change the audio
*hardware* scenario or use case.

Features:-

* scenario get() and set()
* scenario list()
* scenario dump() (dumps all sound card control settings)
* mixer aliasing (master hardware volumes and switches can be found in
each scenario - they may be different kcontrols)

API header is here :-

http://opensource.wolfsonmicro.com/cgi-bin/gitweb.cgi?p=alsa-scenario;a=blob;f=include/ascenario.h;h=fd341133a601e121978054d5b2064a7a1b2d78b7;hb=633aaccc37f845146e490090dbd2a1ebb8064fd6


The library saves each scenario in a simple file i.e.

1:'Master Playback Switch':1:1
2:'Master Playback Volume':2:0,0
3:'Headphone Playback Switch':1:1
4:'Headphone Playback Volume':2:17,17

This differs from the format used by alsactl in order to support
salsa-lib. There is a utility called scndump (in the examples directory)
to dump the sound cards current state in this format.

Each sound card also needs a master file describing supported scenario
information i.e.

# Test scenario configuration for Machine X
# Author: Joe Bloggs <joe@bloggs.com>
# lines beginning with # are comments 

Section "Scenario"

# scenario unique name (mandatory)
	Identifier = "playback speaker"

# scenario file name (mandatory)
	File = "playback_spk"

# scenario audio quality of service (optional) - HIFI, VOICE or SYSTEM
	QoS = HIFI

# alias for master playback volume (optional)
	MasterPlaybackVolume = 8

# alias for master playback switch (optional)
	MasterPlaybackSwitch = 2

# alias for master capture volume (optional)
	MasterCaptureVolume = 3

# alias for master capture switch (optional)
	MasterCaptureSwitch = 4
EndSection

Section "Scenario"

# scenario unique name (mandatory)
	Identifier = "playback headphones"

# scenario file name (mandatory)
	File = "playback_hp"

# scenario audio quality of service (optional) - HIFI, VOICE or SYSTEM
	QoS = HIFI

# alias for master playback volume (optional)
	MasterPlaybackVolume = 10

# alias for master playback switch (optional)
	MasterPlaybackSwitch = 20

# alias for master capture volume (optional)
	MasterCaptureVolume = 30

# alias for master capture switch (optional)
	MasterCaptureSwitch = 40
EndSection

This file provides information to the library about each supported
scenario. The library needs both a master file and scenario kcontrol
files in order to change between scenarios.

There is still some work todo (i.e QoS, locking, auto* cleanup,
sequencer, etc) and it obviously needs more testing and cleanup. I'm not
really in the position to continue working on this in the near future.
Ideally, it would be good to have another developer(s) with spare time
involved. I can provide git access.

Fwiw, I'd ideally like to merge this into alsa-lib and salsa when things
are mature. It useful code for embedded devices and laptops (maybe PC's
too).

Source tarball is here :-

http://opensource.wolfsonmicro.com/~lg/alsa-scenario/scenario-lib-0.1.0.tar.bz2

Git here :-

http://opensource.wolfsonmicro.com/cgi-bin/gitweb.cgi?p=alsa-scenario;a=summary


More info here :-

http://opensource.wolfsonmicro.com/node/14

Feedback and patches welcome.

Liam
