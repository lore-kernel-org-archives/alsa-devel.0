From: stan <stanl@cox.net>
Subject: Re: Install of alsa 1.0.14.final on Fedora 7
Date: Sun, 15 Jul 2007 12:47:00 -0700
Message-ID: <20070715124700.4d35d20e@localhost.localdomain>
References: <20070713124843.59729a4b@localhost.localdomain>
	<20070714000931.hqd2n4icam20ow8g@webmail.dsl-only.net>
	<20070714072701.057106a3@localhost.localdomain>
	<20070714081537.ayf2b2byrxq88kok@webmail.dsl-only.net>
	<20070714154121.0f7c834c@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fed1rmmtao104.cox.net (fed1rmmtao104.cox.net [68.230.241.42])
	by alsa0.perex.cz (Postfix) with ESMTP id 8EC09243A3
	for <alsa-devel@alsa-project.org>;
	Sun, 15 Jul 2007 21:47:02 +0200 (CEST)
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao104.cox.net
	(InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
	id <20070715194702.TBYV1393.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>
	for <alsa-devel@alsa-project.org>; Sun, 15 Jul 2007 15:47:02 -0400
In-Reply-To: <20070714154121.0f7c834c@localhost.localdomain>
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

On Sat, 14 Jul 2007 15:41:21 -0700
stan <stanl@cox.net> wrote:
> And the sound is missing from my app whether I use default or
> plughw:0,0 now. The plughw:0,0 seems to setup OK and the app shows
> that it continues to send output, it just doesn't sound. Seems like
> it is just a small glitch somewhere.  Could be leftovers from the
> cleaned up install too.

Couldn't get this to work as long as I was using time based buffer
allocation.  As soon as I switched back to using size based buffer
allocation, sound was working again.  And as a bonus, the original
problem I reported about high data rates not working under 1.0.14.rc3
went away.  I suspect something somewhere got updated with 1.0.14.final
and is still there despite my efforts to remove everything.  And it
works for both plughw:0,0 and default, though there is some speed
degradation using default compared to plughw:0,0.  I can run
plughw:0,0 at 96000 without underruns, but default has a few underruns
at that rate on the test file.
