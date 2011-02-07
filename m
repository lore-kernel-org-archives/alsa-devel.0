From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 6/7] ASoC: Samsung: neo1973_gta02: Fix
 bluetooth DAI registration
Date: Mon, 7 Feb 2011 18:17:02 +0000
Message-ID: <20110207181702.GR10564@opensource.wolfsonmicro.com>
References: <1297033463-14577-1-git-send-email-lars@metafoo.de>
	<1297033463-14577-6-git-send-email-lars@metafoo.de>
	<20110207115906.GD10564@opensource.wolfsonmicro.com>
	<4D5023A4.3020209@metafoo.de>
	<20110207170213.GP10564@opensource.wolfsonmicro.com>
	<4D502DBF.3050205@metafoo.de>
	<20110207174950.GQ10564@opensource.wolfsonmicro.com>
	<4D50355A.60500@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B21F7244DB
	for <alsa-devel@alsa-project.org>; Mon,  7 Feb 2011 19:17:04 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4D50355A.60500@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Once more I've reflowed your text.  *Please* fix this, it's really
hurting the legibility of your mail.

On Mon, Feb 07, 2011 at 07:09:30PM +0100, Lars-Peter Clausen wrote:
> On 02/07/2011 06:49 PM, Mark Brown wrote:

> > The card is only registering one DAI, all the other DAIs are attached to
> > other devices in the system.

> Isn't the card the combination of these other devices?

Well, yes...

> > The bluetooth chip is an actual device which I can point to on the
> > board and schematic, having a struct device to represent a device that's
> > actually present doesn't seem like a great leap.

> Well, there is an actual device representing the bt device, but since
> this is the standard bt usb device I have no idea how we would get an
> reference to it from within the sound board driver.

If you've got a real device and a driver binding to it then you can make
the driver for that device register the DAI from its probe function, no
need for the machine driver to get involved.

> > It does mean it's named after the board.

> Ok. Could you please explain how snd_soc_register_machine would work
> and how it would effekt the naming of the dai? I couldn't find any
> reference to it.

Sorry, snd_soc_register_card().  This skips the soc-audio device and
allows the card to be registered from a regular device, meaning you can
do things like pass platform data in sanely and handle multiple boards
in a kernel without machine_is_() faff.
