From: Tobin Davis <tdavis@dsl-only.net>
Subject: Re: Splitting up the HDA-INTEL modules
Date: Tue, 15 Jan 2008 11:15:01 -0800
Message-ID: <1200424501.27806.101.camel@razman.gruemaster.com>
References: <478CFD32.50405@harddisk.is-a-geek.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from iron2.pdx.net (iron2.pdx.net [69.64.224.71])
	by alsa0.perex.cz (Postfix) with ESMTP id B20BD2438A
	for <alsa-devel@alsa-project.org>; Tue, 15 Jan 2008 20:15:04 +0100 (CET)
In-Reply-To: <478CFD32.50405@harddisk.is-a-geek.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Marco Schuster <marco@harddisk.is-a-geek.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I don't think that it would be very easy, as there are several instances
where code relies on other codec definitions.

In all actuality, what is needed is a more generic driver that is driven
by userspace tools.  Takashi and I worked on this a little last year,
but we have become too busy with new system influx (and I have other
projects outside Alsa consuming my time).  Maybe we can get a core group
together and actually define and implement an API for this.

My idea is a driver that takes settings from a config file that are
either 32bit register values (aka Sigmatel), or individual Node
parameters (Realtek, Conexant, etc).  This way we can define model
config files, and associate their PCI Quirk in a central config file
that can be edited in userspace.  This would be much easier to support,
for users, distro vendors, hardware vendors, and us.

I'll try to write up a proposal in the next few weeks, if we can get
others on board to work on this.

Tobin

On Tue, 2008-01-15 at 19:36 +0100, Marco Schuster wrote:

> Hi all,
> 
> when I looked today through the files of the snd-hda-intel module, I
> was a bit shocked by this complex amount of code (patch_realtek.c for
> example). I would think about splitting up the code in a way each
> chipset gets its own .c file - which will make debugging, patching or
> editing a lot easier IMO, and for second people can then comment on
> just their specific chipset in config.
> 
> What do you think about this?
> 
> Marco
> 
> PS: If there are no objections, I'll start working on realtek.c on
> weekend.
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

-- 
Tobin Davis  


forget this, i've misread my own code. how could i think i could be wrong? ;)

@cooker ML from Pixel
