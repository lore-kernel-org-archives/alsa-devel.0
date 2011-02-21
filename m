From: Timur Tabi <timur.tabi@gmail.com>
Subject: Re: [PATCH v4] ASoC: Add Freescale SGTL5000 codec
	support
Date: Mon, 21 Feb 2011 13:38:53 -0600
Message-ID: <AANLkTimesMugUCF-5cjq4TgYo59J8wg9yv9bxJzwtgcF@mail.gmail.com>
References: <1298246965-22575-1-git-send-email-zhaoming.zeng@freescale.com>
	<AANLkTinVCB5RdcB9Um+d5La9-_0x6zKmH-9V5He+wJ+z@mail.gmail.com>
	<20110221184732.GC5192@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by alsa0.perex.cz (Postfix) with ESMTP id C1138103838
	for <alsa-devel@alsa-project.org>; Mon, 21 Feb 2011 20:39:33 +0100 (CET)
Received: by fxm11 with SMTP id 11so1550533fxm.38
	for <alsa-devel@alsa-project.org>; Mon, 21 Feb 2011 11:39:33 -0800 (PST)
In-Reply-To: <20110221184732.GC5192@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, s.hauer@pengutronix.de, zengzm.kernel@gmail.com, zhaoming.zeng@freescale.com, linuxzsc@gmail.com, arnaud.patard@rtp-net.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Mon, Feb 21, 2011 at 12:47 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:

> Not for mosts CODEC drivers, these should be selected by the machine
> drivers which use them rather than enabled directly by users so they are
> not expected to have help text, except in the unusual case that they're
> set up for use with OpenFirmware without bindings.

Looks like I need to eat my own words, since I do the same thing:

# Cirrus Logic CS4270 Codec
config SND_SOC_CS4270
	tristate

# Cirrus Logic CS4270 Codec VD = 3.3V Errata
# Select if you are affected by the errata where the part will not function
# if MCLK divide-by-1.5 is selected and VD is set to 3.3V.  The driver will
# not select any sample rates that require MCLK to be divided by 1.5.
config SND_SOC_CS4270_VD33_ERRATA
	bool
	depends on SND_SOC_CS4270

I could have sworn I had real help text in there, but I guess not.

-- 
Timur Tabi
Linux kernel developer at Freescale
