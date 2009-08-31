From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH V2 2/3] add set_tdm_slot in tdm dai to
 define the relationship between audio channel and tdm slot
Date: Mon, 31 Aug 2009 13:01:31 +0100
Message-ID: <1251720091.4254.8.camel@finisterre.sirena.org.uk>
References: <1250137511-24034-1-git-send-email-21cnbao@gmail.com>
	<20090817175010.GA19707@rakim.wolfsonmicro.main>
	<3c17e3570908171953l65c9d04i99ad6fa72b88d001@mail.gmail.com>
	<20090818131117.GA12512@rakim.wolfsonmicro.main>
	<3c17e3570908181834q6dd0e0c5n157697bd02836b35@mail.gmail.com>
	<20090819113400.GC18285@rakim.wolfsonmicro.main>
	<3c17e3570908191937h53f5bcf0mb9c753b94402e3f5@mail.gmail.com>
	<1251463341.5039.28.camel@finisterre.sirena.org.uk>
	<3c17e3570908302014n2cdd62fdga2642b7f968b0e65@mail.gmail.com>
	(sfid-20090831_041522_076628_FA2A0FEC)
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 7B4D4246C5
	for <alsa-devel@alsa-project.org>;
	Mon, 31 Aug 2009 14:01:54 +0200 (CEST)
In-Reply-To: <3c17e3570908302014n2cdd62fdga2642b7f968b0e65@mail.gmail.com>
	(sfid-20090831_041522_076628_FA2A0FEC)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Barry Song <21cnbao@gmail.com>
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, 2009-08-31 at 11:14 +0800, Barry Song wrote:
> On Fri, Aug 28, 2009 at 8:42 PM, Mark
> Brown<broonie@opensource.wolfsonmicro.com> wrote:

> > Send a patch that allows selection of the active slots without rewriting

> Sorry. I am not sure about your meaning yet. The problem is the slot
> order, the match between slot number and channel number, not only
> which slot is active, and which is not active.

As I previously said I think we should add another API for that rather
than try to add the feature into the TDM slot API.

> > Although thinking about it I'm not sure if the driver is actually
> > implementing TDM or not - does the CPU actually get configured to stop
> > driving the data line during an inactive slot (so something else can
> > drive it) or is it simply sending zeros on those slots?

> It's the later. The hardware signal is still active but no valid data
> in inactive slot.

This is part of the reason - data slot reordering needn't mean actual
support for TDM (where the data lines are left undriven during idle
timeslots so that other devices can transmit in those slots). Indeed, as
your implementation shows it should be possible to provide a soft
implementation above the driver layer. Since Blackfin needs to copy the
data anyway there's an advantage to implementing in the Blackfin driver
but for most other devices there's no particular advantage in driver
support.
