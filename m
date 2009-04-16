From: Ron Cococcia <ron.cococcia@request.com>
Subject: /dev/snd/timer behavior
Date: Thu, 16 Apr 2009 17:54:51 -0400
Message-ID: <49E7A92B.6050003@request.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from exprod7og107.obsmtp.com (exprod7og107.obsmtp.com [64.18.2.167])
	by alsa0.perex.cz (Postfix) with SMTP id C99C610380A
	for <alsa-devel@alsa-project.org>;
	Thu, 16 Apr 2009 23:56:12 +0200 (CEST)
Received: by qw-out-1920.google.com with SMTP id 5so443829qwf.8
	for <alsa-devel@alsa-project.org>; Thu, 16 Apr 2009 14:56:10 -0700 (PDT)
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

Hello,

We have been attempting to debug an issue that we have been having for a 
few weeks related to audio playback.  Specifically, over time, the 
playback of audio gets 'stuck' for a while (60 seconds or so), then 
quickly advances forward again (for about 60 seconds), then gets stuck 
again.  It continues to repeat this until I either stop playback or 
pause/play.  We have dubbed it 'skip-lock' as it skips ahead, then locks 
for a bit.  It takes a while to reproduce this behavior, typically 
around 6 hours.

We have about 30 of these systems setup, each with the same hardware 
configuration.  They have a VIA C7 CPU (1.5GHz), 1GB RAM, and they are 
using the VIA 8233A AC97 controller with an ALC655 codec.  The system is 
SATA based (using sata_via), and an RTL8110 gigabit ethernet controller 
(using rtl8169).

For the OS, we are using Debian Etch with the 2.6.29 kernel, and we have 
tested a number of these units with 2.6.24-etchnhalf as well.  ALSA lib 
1.0.13 (from the install) is still in use, but I am trying out 1.0.19 on 
a few of the units to see if it helps.  The player we use is called 
BlueTune, which we have used in older systems for years without 
trouble.  I plan on trying to set up another player app to do the same 
testing, but haven't had the time to do that yet.  On most of the 
systems, the player is using the default alsa output.  I have configured 
a few systems to use plughw:0,0,0 for playback (mainly so that 
/dev/snd/timer is not used), and they have not had any playback issues 
so far (about 24 hours so far).

After a bunch of other tests, we started to run strace against the 
player.  We saw that it was repeatedly getting EAGAIN when reading from 
/dev/snd/timer during the 'stuck' phase.  I have started to poke around 
a bit more in the timer code and see why EAGAIN is repeatedly being 
generated (in snd_timer_user_read, tu->qused is stuck at 0 for a 
while).  I figured that if anybody had some things to try or places to 
look, it might save a bit of time in finding the cause of this issue.

Thanks!
Ron

PS:  I apologize if this is the wrong place to post this.  I had posted 
a not-terribly-detailed message to alsa-user a few weeks ago, but have 
gained more data that I felt fit better here.
