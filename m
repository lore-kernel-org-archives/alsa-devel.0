From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v5] ASoC: Add Freescale SGTL5000 codec
	support
Date: Mon, 28 Feb 2011 14:45:26 +0000
Message-ID: <20110228144526.GG13869@opensource.wolfsonmicro.com>
References: <1298484501-3993-1-git-send-email-zhaoming.zeng@freescale.com>
	<20110225120906.GE28980@opensource.wolfsonmicro.com>
	<AANLkTikpBB5vVKj+Y2EfbjfC=6aigeCjaqZ9mz9+qWuF@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 176D410385E
	for <alsa-devel@alsa-project.org>; Mon, 28 Feb 2011 15:45:11 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <AANLkTikpBB5vVKj+Y2EfbjfC=6aigeCjaqZ9mz9+qWuF@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Zeng Zhaoming <zengzm.kernel@gmail.com>
Cc: alsa-devel@alsa-project.org, s.hauer@pengutronix.de, timur.tabi@gmail.com, xiao-lizhang@freescale.com, zhaoming.zeng@freescale.com, lrg@slimlogic.co.uk, arnaud.patard@rtp-net.org, linuxzsc@gmail.com
List-Id: alsa-devel@alsa-project.org

On Fri, Feb 25, 2011 at 11:56:52PM +0800, Zeng Zhaoming wrote:
> On Fri, Feb 25, 2011 at 8:09 PM, Mark Brown

> > This is going to fail on systems without voltage readback capabilities,
> > including systems which have the regulator API disabled and stubbed out.

> if the regulator driver not allow readback, I have no way to get the
> voltage of vdda and vddio,
> the voltage levels are critical  to codec initialization.

> Can you shed some light on howto around this?

If you can't read the data back you need to guess what the configuration
is somehow; I'd suggest just picking values and warning about what
you're doing.

> >> + =A0 =A0 memcpy((void *)(&sgtl5000_regs[0] + (SGTL5000_DAP_REG_OFFSET=
 >> 1)),
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sgtl5000_dap_regs,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 SGTL5000_MAX_REG_OFFSET - SG=
TL5000_DAP_REG_OFFSET);

> > As has been pointed out on previous revisions of the patch there is no
> > need to cast away from void in C and it can be actively harmful.

> I have not remove void* since my toolchain ( gcc 4.4.4) complains
> about the type mismatch, I will test
> it with other version toolchain to confirm.

As Timur indicated the reason this is complaining is that you're
memcpy() is writing to const data.  This is *clearly* buggy - the fact
that casting away removes the warning is an example of why you should
never have casts like this.

You should take a copy of the array and modify that, having the defaults
as const is correct.
