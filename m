From: Zwane Mwaikambo <zwane@holomorphy.com>
Subject: Re: Oops when removing snd-timer
Date: Mon, 18 Nov 2002 11:12:15 -0500 (EST)
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.44.0211181110000.1538-100000@montezuma.mastecende.com>
References: <20021118152748.GA8143@hatchling.taral.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <20021118152748.GA8143@hatchling.taral.net>
To: Taral <taral@taral.net>
Cc: alsa-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Mon, 18 Nov 2002, Taral wrote:

> On Mon, Nov 18, 2002 at 04:07:17AM -0500, Zwane Mwaikambo wrote:
> > Looks like you loaded ens137x.c and then that driver got unloaded leaving 
> > the callback still valid, then the core timer code decided to walk off a 
> > cliff using that pointer.
> 
> I don't have ens137x.c compiled, much less loaded. What makes you think
> this?

It was a guess, i presumed you were using one of the ac97 cards. Anyway 
it's irrelevant right now. You could of course make your problem report 
more descriptive wrt to what you loaded/unloaded, which order etc, so that 
reproducing and walking through the code paths is easier.

	Zwane
-- 
function.linuxpower.ca
