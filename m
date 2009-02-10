From: stan <ghjeold_i_mwee@cox.net>
Subject: Re: Software mixer at kernel level
Date: Mon, 09 Feb 2009 20:57:41 -0700
Message-ID: <4990FB35.8050205@cox.net>
References: <BAY121-W2620F292F939B826EEDC6DFBBD0@phx.gbl>
	<74eb1fe20902091827w7f6020e2r58f0ba27f651de1f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fed1rmmtao104.cox.net (fed1rmmtao104.cox.net [68.230.241.42])
	by alsa0.perex.cz (Postfix) with ESMTP id C2BF810383D
	for <alsa-devel@alsa-project.org>; Tue, 10 Feb 2009 04:57:48 +0100 (CET)
In-Reply-To: <74eb1fe20902091827w7f6020e2r58f0ba27f651de1f@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sean McNamara <smcnam@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Sean McNamara wrote:
> Hi,
> 

> 
> However, the point about "everybody needs it" is a valid one. If I had
> my druthers, it would be impossible for anyone in usermode to
> initialize an ALSA pcm in a mode which does not provide software
> mixing. We can still provide the software mixing in usermode, but my
> reasoning is that
> 

<rant>
I disagree.  I have one of those applications that doesn't do softwae mixing, deliberately because I want it to have 
good sound (it's a brainwave entrainment app).  It calls functions in alsa that *can't* be accessed through pulse, and 
allows users to set the frame rate to any hardware rate their card supports (in pulse, one size fits all).

Pulse is great for those who want its functionality, and I would love to see it replace dmix in alsa so that when it 
received a request for a function it doesn't support it would have the ability to step aside and allow the application 
to take over the sound device.

Linux is about freedom, and I think you are wanting to restrict that freedom for me to use my hardware the way I want. 
If you want to put a switch in place that does that, but allows it to be turned off, great, but not hard wired to only 
behave a single way.  Wait!  We already have such a switch, it's called /home/.asoundrc.

You are welcome to do whatever you want on your system, but don't assume that everyone wants what you want.
</rant>
