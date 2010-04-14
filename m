From: Colin Guthrie <gmane@colin.guthr.ie>
Subject: Re: pulseaudio eats 19% CPU power in Fedora 12
Date: Wed, 14 Apr 2010 09:31:50 +0100
Message-ID: <hq3uhm$mtp$1@dough.gmane.org>
References: <20100414075658.GA26283@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id 8FDDE24488
	for <alsa-devel@alsa-project.org>;
	Wed, 14 Apr 2010 10:32:03 +0200 (CEST)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1O1y0t-0002yW-H0
	for alsa-devel@alsa-project.org; Wed, 14 Apr 2010 10:31:59 +0200
Received: from brent.tribalogic.net ([78.86.109.144])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Wed, 14 Apr 2010 10:31:59 +0200
Received: from gmane by brent.tribalogic.net with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Wed, 14 Apr 2010 10:31:59 +0200
In-Reply-To: <20100414075658.GA26283@localhost>
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
Cc: pulseaudio-discuss@mail.0pointer.de
List-Id: alsa-devel@alsa-project.org

'Twas brillig, and Wu Fengguang at 14/04/10 08:56 did gyre and gimble:
> Hi Lennart,
> 
> We found that pulseaudio eats CPU ~19% CPU time, a little more than
> mplayer when playing video. This is horrible for laptop batteries.
> 
> Can we make it just work -- in green CPU mode? I can find many users
> complaining about this, and it seems like some fix is available in
> this link:
> https://bugs.launchpad.net/ubuntu/+source/pulseaudio/+bug/207135

Things to check:
 1. Is it your driver providing bad timing information to PA: Check by
enabling tsched=0 for module-udev-detect in default.pa
 2. What is the native sample rate of your h/w. PA uses 44.1kHz by
default but perhaps your h/w is using 48kHz only? If so set
default-sample-rate = 48000 in daemon.conf
 3. Do your videos require resampling. If you prefer battery life over
sound quality, try using a less CPU intensive, but lower quality,
resampler. See the settings in daemon.conf.

Or do you just mean that when on battery, the resampler should be
changed? e.g. when on battery, use trivial, when on AC use <whatever>.

It would be relatively easy to create a module that did that I believe...

Col

-- 

Colin Guthrie
gmane(at)colin.guthr.ie
http://colin.guthr.ie/

Day Job:
  Tribalogic Limited [http://www.tribalogic.net/]
Open Source:
  Mandriva Linux Contributor [http://www.mandriva.com/]
  PulseAudio Hacker [http://www.pulseaudio.org/]
  Trac Hacker [http://trac.edgewall.org/]
