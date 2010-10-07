From: Davyd McColl <davydm@gmail.com>
Subject: Headphone jack and auto-mute of speak output
Date: Thu, 7 Oct 2010 13:55:14 +0200
Message-ID: <AANLkTi=ZhMVY1abcpxviy50yfSbdc1vABCtKa9jJXfig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f179.google.com (mail-qy0-f179.google.com
	[209.85.216.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 0849D24490
	for <alsa-devel@alsa-project.org>;
	Thu,  7 Oct 2010 13:55:35 +0200 (CEST)
Received: by qyk8 with SMTP id 8so656065qyk.17
	for <alsa-devel@alsa-project.org>; Thu, 07 Oct 2010 04:55:35 -0700 (PDT)
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

Good day

I'm new to this list (though I've done some searching, I'm sure I could have
missed something), so please bear with me.

I filed a bug report recently against Ubuntu with respect to the problem I'm
experiencing (as per the subject: jacking in my headphones doesn't mute the
speaker output) and was informed that the decision had been made upstream as
a design intention. I was linked off to:
http://mailman.alsa-project.org/pipermail/alsa-devel/2010-August/030071.html
with respect to the thread on this topic. I'd like to raise it again though,
perhaps as a configurable feature, for the following reasons:

1) headphones muting the speakers used to work some time ago (before Ubuntu
9.04, iirc), so we have an established user expectation even under Linux
distros.
2) headphones mute the built-in speakers of my laptop (windows and ubuntu)
-- why the inconsistent behaviour for a desktop? Just because the speakers
in the laptop are bolted into the frame of the machine?
3) Windows "gets it right": plugging in headphones mutes external speakers
-- it's convenient (Though I think you can disable that feature if you
want). I'm told by a person at work that his Mac does the same. Again, the
user expectation is unmet under a newish Linux distro.
4) The user expectation theory is held up by the number of bug reports
against this design choice on Ubuntu Launchpad alone (I haven't looked at
other bug lists). The average user is not expecting the current behaviour,
obviously
5) For people without hardware volume controls on their speakers, the
problem is exacerbated: instead of being able to plug in headphones to
disturb others around them less (ie: contain their music/noises), they have
to unplug their speakers too -- which may not be trivial since speakers are
normally plugged in at the back of the machine, not at the front where the
headphone jack would be found. On a machine in an enclosure, this is
especially troublesome.

So I'd really like to know if it would be possible to allow the behaviour
most users are expecting. Sometimes it's useful to be able to output to both
speakers and headphones, but I would say that the average user doesn't want
both at the same time.

-d


-- 
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
The competent programmer is fully aware of the limited size of his own
skull. He therefore approaches his task with full humility, and avoids
clever tricks like the plague.
- Djikstra.
