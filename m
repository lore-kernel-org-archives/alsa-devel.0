From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: [PATCH 0/3] alsa-lib: UCM - Use Case Manager
Date: Mon, 23 Aug 2010 17:17:16 +0100
Message-ID: <1282580239-10549-1-git-send-email-lrg@slimlogic.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id 15C5A243E6
	for <alsa-devel@alsa-project.org>;
	Mon, 23 Aug 2010 18:17:26 +0200 (CEST)
Received: by wyb42 with SMTP id 42so6848722wyb.38
	for <alsa-devel@alsa-project.org>; Mon, 23 Aug 2010 09:17:25 -0700 (PDT)
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
Cc: Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

This patch series follows on from the RFC and adds sound card hardware Use Case
Management support to alsa-lib. 
 
The main features of UCM are :-

 o Abstraction of sound card hardware routing and controls into high level
   use case verbs, devices and modifiers.
 o Discovery of source/sink PCMs for each use case.
 o Discovery of hardware master volume controls for each use case.

It's intended UCM will provide clients (like pulseaudio) complete control over
hardware signal routing within a sound card without any knowledge of the
sound card hardware.

Use case definintions are stored in text files (per sound card) and are now
divided into three components as descibed in the RFC. 

A working use case definition file can be found here :-

http://git.slimlogic.co.uk/cgi-bin/cgit.cgi/alsa-ucm-conf.git/tree/cards/SDP4430/hifi

The three components of a use case are now :-

1) Verb (or action). This is mandatory and describes (in terms of ALSA
control settings) the system use case action. e.g "Phone Call", "Music
Playback".

2) Device. This is also mandatory and describes the audio playback or
capture device. e.g. "Handset", "Bluetooth", "Headset".

3) Modifier. This is optional and is used to modify the current use case
verb. i.e. The user could be listening to music when an incoming phone
call requires that a ring tone is played. In this case the use case verb
would be set to "Music Playback" when the music playback started and
then the "Tone Playback" modifier could be enabled to play the ring
tone. The use case verb would then be changed to "Voice Call" if the
call was accepted. 

Patch 2/3 is a little on the large side so, I've included a link if it gets
bounced by the list.

http://git.slimlogic.co.uk/cgi-bin/cgit.cgi/alsa-lib.git/commit/?h=ucm-upstream&id=15d5f619deba20f87075e7c711e6331115fd836d

Liam Girdwood (3):
  ucm: header - ALSA Use Case Manager
  ucm: core - Add initial Use Case Manager support.
  ucm: build - add build support for Use Case Manager

 doc/doxygen.cfg.in  |    1 +
 include/Makefile.am |    2 +-
 include/use-case.h  |  427 +++++++
 src/Makefile.am     |    2 +-
 src/use-case.c      | 3515 +++++++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 3945 insertions(+), 2 deletions(-)
 create mode 100644 include/use-case.h
 create mode 100644 src/use-case.c
