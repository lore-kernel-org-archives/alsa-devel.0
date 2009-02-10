From: Brendan Pike <spike@spykes.net>
Subject: Re: Software mixer at kernel level
Date: Tue, 10 Feb 2009 01:50:54 -0500
Message-ID: <20090210015054.24a5f522@darius>
References: <BAY121-W2620F292F939B826EEDC6DFBBD0@phx.gbl>
	<74eb1fe20902091827w7f6020e2r58f0ba27f651de1f@mail.gmail.com>
	<4990FB35.8050205@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.spykes.net (dsl.spykes.net [76.10.173.13])
	by alsa0.perex.cz (Postfix) with ESMTP id C3410103814
	for <alsa-devel@alsa-project.org>; Tue, 10 Feb 2009 07:50:53 +0100 (CET)
In-Reply-To: <4990FB35.8050205@cox.net>
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

Sean McNamara wrote:
> 
> You are welcome to do whatever you want on your system, but don't assume that everyone wants what you want.
> </rant>
> _______________________________________________


Or you could just avoid all this mess with Linux audio for the time
being and use a hardware mixing device instead. I realize laptop users
are going to bitchslap me for saying that but its true.

The whole buggy software mixing situation with regards to applications
not working correctly or as intended is frustrating. OSS4 does it at
the kernel level because it tries to be transparent to all the
applications which think the device has hardware mixing capabilities. I
realize OSS4 can be buggy for some but its implementation is far more
compatible instead of the cocktail of sound servers and software
mixing routines we have in ALSA right now.

Some apps out there require direct access to /dev/dsp or whatever, what
are we going to do? Hope somebody updates the program? (usually not
going to happen with older closed source games or whatnot). Take UT99
for example, rarely does this ever work with any software mixing period.
