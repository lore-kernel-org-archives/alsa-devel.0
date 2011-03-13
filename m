From: Craig Bourne <craigbourne@gmail.com>
Subject: ALSA/pulseaudio problem workaround
Date: Sun, 13 Mar 2011 17:05:25 -0400
Message-ID: <AANLkTinGB1-Ft0B98_Z9TnFkL+Pqd8VPVKy4bEC57c8n@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
	[209.85.210.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 935771037EA
	for <alsa-devel@alsa-project.org>; Sun, 13 Mar 2011 22:05:27 +0100 (CET)
Received: by iym7 with SMTP id 7so4593702iym.38
	for <alsa-devel@alsa-project.org>; Sun, 13 Mar 2011 14:05:26 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Fernando Lopez-Lezcano <nando@ccrma.stanford.edu>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Here is a workaround for the problem I described in my email to you
yesterday:

Background My past experience with ALSA, JACK and many of the Linux audio
tools that depend on them is that often some few applications in the
tool-chain of a complex task will not work properly (or at all) unless
invoked with *root* privileges. One is now frustrated in getting such things
to work Fedora 14 as they have for the past decade or so in that the most
basic tools (e.g., alsactl, QjackCtl) no longer work for root. Indeed, audio
also does not work for unprivileged users on Fedora 14 either (though this
evidently fails at a different level and will be taken up in a subsequent
communication).

Symptoms alsactl fails carping about pulseaudio, audacity can be started on
its own but no longer wants to cooperate with JACK and ALSA resulting in
horribly distorted sound from something horked together in the background as
a "favor" to the user, QjackCtl runs, produces messages, and blinks its cute
little meter display but evidently does this off on the sidelines reporting
0 XRUNS even as every little jot and tiddle of computation produces a
surprising audio result.

Strategy Based on my observation that PULSEAUDIO is evidently being allowed
to interpose itself between the user (even the superuser) and ALSA, and
since this user has been kept largely ignorant of the workings of all this
and does not know the secret handshake, I will attempt to at least minimize
the damage to audio and regain some measure of control while not attempting
to disable the PULSEAUDIO/ALSA cabal.

Workaround

Install the following if they are not already on your system:

   - avahi
   - padevchooser
   - pulseaudio-libs-zeroconf
   - pulseaudio-module-zeroconf

Enable and start the Avahi Daemon

Create these two shell scripts (that will be used by QjackCtl), make them
executable, and place them in a directory where they will stay to be invoked
each time QjackCtl is started:


PAjack_startup

#!/bin/bash
# Name:  PAjack_startup

pulseaudio -D --system
#perhaps more fastidious than the above line is
#pulseaudio -D --system --disallow-exit --disallow-module-loading
padevchooser&


PAjack_shutdown

#!/bin/bash
#Name: PAjack_shutdown

pulseaudio --kill
killall padevchooser



Invoke QjackCtl
  click Setup
  select the Options tab
  tick the box "Execute script after Startup" and enter ~/bin/PAjack_startup
[Note: using, of course the path to your script]
  tick the box "Execute script on Shutdown" and enter ~/bin/PAjack_shutdown
[Note: as before, using your path to the file]


Quit QjackCtl --  your scripts will now be invoked the next time it is used.



A partial workaround for the unprivileged user, at least to the point of
getting QjackCtl and audacious working places a slightly modified
PAjack_startup script in a place where QjackCtl can find it when it starts
with the changes used above for root (e.g., insure that both acounts have a
subdirectory named "bin" in their home directory and have QjackCtl look for
~/bin/PAjack_startup when it is invoked).

Here is the script for unprivileged users:

#!/bin/bash
#Name: PAjack_startup

pulseaudio -D
padevchooser&


Limitations

This is not a general solution to the ALSA/PULSEAUDIO problems I am
experiencing but it is a workaround that at least allows me to have some
minimal functionality back from basic audio tools that I have come to rely
on in my work as a composer.

-- 
Comradely,

Craig Bourne
