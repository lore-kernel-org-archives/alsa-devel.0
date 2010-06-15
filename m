From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] soc/sh: Fix I2C dependency for
	SND_FSI_AK4642
Date: Tue, 15 Jun 2010 16:19:13 +0100
Message-ID: <20100615151913.GJ14510@rakim.wolfsonmicro.main>
References: <201006141739.42346.PeterHuewe@gmx.de>
	<20100614161034.GF14604@rakim.wolfsonmicro.main>
	<201006151649.07554.PeterHuewe@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A10052453A
	for <alsa-devel@alsa-project.org>;
	Tue, 15 Jun 2010 17:19:14 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <201006151649.07554.PeterHuewe@gmx.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter =?iso-8859-1?Q?H=FCwe?= <PeterHuewe@gmx.de>
Cc: alsa-devel@alsa-project.org, linux-sh@vger.kernel.org, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, Kuninori Morimoto <morimoto.kuninori@renesas.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, Jun 15, 2010 at 04:49:07PM +0200, Peter H=FCwe wrote:

> So maybe even move the dependency up to SND_SOC_SH4_FSI =

> since both codecs rely on I2C?

No, while the two boards in mainline currently may need I2C obviously
other board designs with other control interfaces are possible so it
should be on the individual boards.
