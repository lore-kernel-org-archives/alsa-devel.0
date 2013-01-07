From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 2/4] ALSA: pxa27x: fix ac97 warm reset bug
	work-around	code
Date: Mon, 7 Jan 2013 11:06:55 +0000
Message-ID: <20130107110655.GB3222@n2100.arm.linux.org.uk>
References: <1357499640-13871-1-git-send-email-mikedunn@newsguy.com>
 <1357499640-13871-3-git-send-email-mikedunn@newsguy.com>
 <50EA9607.7050408@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
 [78.32.30.218]) by alsa0.perex.cz (Postfix) with ESMTP id 0C53F2650D4
 for <alsa-devel@alsa-project.org>; Mon,  7 Jan 2013 12:07:16 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <50EA9607.7050408@compulab.co.il>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: Marek Vasut <marex@denx.de>, alsa-devel@alsa-project.org, Eric Miao <eric.y.miao@gmail.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Mike Dunn <mikedunn@newsguy.com>, Robert Jarzmik <robert.jarzmik@free.fr>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Mon, Jan 07, 2013 at 11:31:51AM +0200, Igor Grinberg wrote:
> On 01/06/13 21:13, Mike Dunn wrote:
> > +/* these enable a work-around for a hw bug in pxa27x during ac97 warm reset */
> > +#define GPIO113_AC97_nRESET_GPIO_HIGH MFP_CFG_OUT(GPIO113, AF0, DRIVE_HIGH)
> > +#define GPIO95_AC97_nRESET_GPIO_HIGH MFP_CFG_OUT(GPIO95, AF0, DRIVE_HIGH)
> 
> Do we really need to change the LPM? Because DRIVE_* only affect LPM.

Also, be very careful about driving output pins to peripherals high
during sleep modes, especially if the peripherals are powered down.
If they are powered down, you will drain power through the output
into the peripheral to the extent that you _can_ cause it to remain
partially powered up.
