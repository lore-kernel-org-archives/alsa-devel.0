From: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Subject: Re: ASOC v2 driver structure
Date: Mon, 28 Jan 2008 15:50:24 +0000
Message-ID: <1201535424.3551.150.camel@localhost.localdomain>
References: <9e4733910801270845i58b41269s708cb1ee58e7eba8@mail.gmail.com>
	<9e4733910801271115w576fcd61pec8a5586138744c5@mail.gmail.com>
	<1201525570.3551.47.camel@localhost.localdomain>
	<9e4733910801280614v3c8f4374jf130a704f440e493@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 02EC5103934
	for <alsa-devel@alsa-project.org>; Mon, 28 Jan 2008 16:50:26 +0100 (CET)
In-Reply-To: <9e4733910801280614v3c8f4374jf130a704f440e493@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jon Smirl <jonsmirl@gmail.com>
Cc: ALSA-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, 2008-01-28 at 09:14 -0500, Jon Smirl wrote:
> On 1/28/08, Liam Girdwood <liam.girdwood@wolfsonmicro.com> wrote:
> > On Sun, 2008-01-27 at 14:15 -0500, Jon Smirl wrote:
> > > On 1/27/08, Jon Smirl <jonsmirl@gmail.com> wrote:
> > > > I'm trying to write an asoc v2 driver for my powerpc based SOC
> > > > (mpc5200) hardware. We have two audio devices on the board, a WM8580
> > > > and a TAS5504.  How do you do this with asoc v2? The card is created
> > > > in snd_soc_machine_create(); there seems to be an assumption of a
> > > > single card per machine.
> >
> > This was the initial assumption in v1. To be honest we were only
> > catering for single codec devices. In v2 we are allowing multiple cards
> > - struct machine is being refactored atm to make this more obvious.
> 
> 
> What about the Efika? It has SOC audio with a STAC9766 but it also has
> a PCI slot.
> 

You can use a regular PCI audio driver and an ASoC driver on the same
device (they are both snd_cards).

Liam
