From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: Re: Splitting up the HDA-INTEL modules
Date: Wed, 16 Jan 2008 09:26:39 +1030 (CST)
Message-ID: <200801152256.m0FMud1b032184@turbo.physics.adelaide.edu.au>
References: <mailman.344.1200429836.2119.alsa-devel@alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelphi.physics.adelaide.edu.au
	(adelphi.physics.adelaide.edu.au [129.127.102.1])
	by alsa0.perex.cz (Postfix) with ESMTP id 0DDD624446
	for <alsa-devel@alsa-project.org>; Tue, 15 Jan 2008 23:56:43 +0100 (CET)
In-Reply-To: <mailman.344.1200429836.2119.alsa-devel@alsa-project.org> from
	"alsa-devel-request@alsa-project.org" at Jan 15, 2008 09:43:56 PM
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
Cc: marco@harddisk.is-a-geek.org, Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
List-Id: alsa-devel@alsa-project.org

Marco Schuster wrote:
> when I looked today through the files of the snd-hda-intel module, I
> was a bit shocked by this complex amount of code (patch_realtek.c for
> example). I would think about splitting up the code in a way each
> chipset gets its own .c file - which will make debugging, patching or
> editing a lot easier IMO, and for second people can then comment on
> just their specific chipset in config.

The problem with such a split is, as Tobin went on to say, that there are a
lot of interdependencies and shared code within each chipset's family:

> I don't think that it would be very easy, as there are several instances
> where code relies on other codec definitions.

One could argue that therefore we have toplevel realtek/sigmatek/etc
"librarys" which are used by each chipset-specific driver but IMHO that is
hardly going to count as a simplification.

Tobin then said:
> In all actuality, what is needed is a more generic driver that is driven
> by userspace tools. ... Maybe we can get a core group together and
> actually define and implement an API for this.

I think this idea has merit and may be worth pursuing.  I would be
interested in assisting and providing input to the process although I
haven't time at present to take a lead role.

> My idea is a driver that takes settings from a config file that are
> either 32bit register values (aka Sigmatel), or individual Node
> parameters (Realtek, Conexant, etc).  This way we can define model
> config files, and associate their PCI Quirk in a central config file
> that can be edited in userspace.  This would be much easier to support,
> for users, distro vendors, hardware vendors, and us.

Agreed, at least in theory.  There may be complications due to the varying
topography of the chips; the userspace API may have to be relatively
complex to support things like record source switch options (which are
vastly different for diffenent chips).  Even so, if we can get this to work
the ongoing support effort for HDA will be much reduced so it's probably
worth the effort.

> I'll try to write up a proposal in the next few weeks, if we can get
> others on board to work on this.

I think this would be worth looking at.

Regards
  jonathan
