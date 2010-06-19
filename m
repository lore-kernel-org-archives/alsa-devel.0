From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] eukrea-tlv320: add support for our i.MX25
	board
Date: Sat, 19 Jun 2010 01:29:38 +0100
Message-ID: <20100619002937.GB2463@opensource.wolfsonmicro.com>
References: <1276782241-9407-1-git-send-email-eric@eukrea.com>
	<20100618005637.GA3333@opensource.wolfsonmicro.com>
	<4C1B1BE9.9040802@eukrea.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B542224494
	for <alsa-devel@alsa-project.org>;
	Sat, 19 Jun 2010 02:29:25 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4C1B1BE9.9040802@eukrea.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Eric =?iso-8859-1?Q?B=E9nard?= <eric@eukrea.com>
Cc: alsa-devel@alsa-project.org, s.hauer@pengutronix.de, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Fri, Jun 18, 2010 at 09:10:33AM +0200, Eric B=E9nard wrote:

> This Kconfig seems to have unecessary things into it :
> - config SND_MXC_SOC_SSI :
> 	not used in the kernel

That's supposed to be being used to build the SSI driver as a separate
module.

> - 1st board :

It'd be helpful to use actual names to make your mails legible,
otherwise it's like Outlook style mail.

> 	depends on SND_IMX_SOC
> 	select SND_MXC_SOC_SSI
> - 2nd board :
> 	select SND_MXC_SOC_SSI
> 	but doesn't depends on SND_IMX_SOC
> - 3rd board :
> 	select SND_IMX_SOC
> =

> Do you have any idea what SND_MXC_SOC_SSI is used for ?
> =

> Please find attached a patch which should clean this Kconfig. If
> it's ok for you, I'll submit it the right way.

This isn't the best approach, converting things so SND_IMX_SOC is a menu
and we don't need to reference that at all from the individual items
would be nicer since it saves having to do per-board handling.
