From: Colin Guthrie <gmane@colin.guthr.ie>
Subject: HDA: Problem with sound becoming corrupted
Date: Wed, 09 Mar 2011 15:10:18 +0000
Message-ID: <il858r$kce$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id D786D1039B6
	for <alsa-devel@alsa-project.org>; Wed,  9 Mar 2011 16:10:31 +0100 (CET)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1PxL1z-0006RR-Gk
	for alsa-devel@alsa-project.org; Wed, 09 Mar 2011 16:10:31 +0100
Received: from brent.tribalogic.net ([78.86.109.144])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Wed, 09 Mar 2011 16:10:31 +0100
Received: from gmane by brent.tribalogic.net with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Wed, 09 Mar 2011 16:10:31 +0100
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

Hi,

I've been dealing with this issue for several months (from memory I'm
pretty sure it's affected me since 2.6.36, possibly before, but I'll
have to do some deeper digging to say for sure).

The problem is that the sound suddenly goes nuts and starts sounding
awful. It's like some buffer pointer is just a little bit out for some
reason.

I can fix the issue by closing and reopening the PCM device (as I use
PA, this is just a simple "pasuspender echo" away).

The problem is very easy to reproduce - it happens about 20+ times a day
to me - to the extent that I have added a panel launcher with the above fix.


We discussed this issue during the meeting but it seems not to be a PA
problem (my other PA devices work fine FWIW - various USB things etc,
and recording from the monitor source when the sound is odd also records
good sounds).

You can hear the sounds here (recorded via mic):
http://colin.guthr.ie/weird-sound/

And our discussion is here:
http://colin.guthr.ie/meetings/pulseaudio-meeting/2011/pulseaudio-meeting.2011-02-24-21.02.log.html#l-409

My alsa-info is here:
http://colin.guthr.ie/alsa-info.txt


This mail is really just about finding out if this is a known problem? I
know others suffer from the same problem too as I've had bug reports
confirming this.

Cheers

Col
-- 

Colin Guthrie
gmane(at)colin.guthr.ie
http://colin.guthr.ie/

Day Job:
  Tribalogic Limited [http://www.tribalogic.net/]
Open Source:
  Mageia Contributor [http://www.mageia.org/]
  PulseAudio Hacker [http://www.pulseaudio.org/]
  Trac Hacker [http://trac.edgewall.org/]
