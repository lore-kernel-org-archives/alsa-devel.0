From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/5] ASoC: mxs: add .owner to struct
 snd_soc_card
Date: Sun, 11 Dec 2011 10:53:59 +0800
Message-ID: <20111211025358.GB2800@opensource.wolfsonmicro.com>
References: <cover.1323436034.git.LW@KARO-electronics.de>
	<555be1750dd09586d5eede6457f72310890274b0.1323436034.git.LW@KARO-electronics.de>
	<20111209141203.GH3327@pengutronix.de>
	<20194.7382.414612.182139@ipc1.ka-ro>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C29C324946
	for <alsa-devel@alsa-project.org>; Sun, 11 Dec 2011 03:54:54 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20194.7382.414612.182139@ipc1.ka-ro>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW@KARO-electronics.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, Dong Aisheng-B29396 <B29396@freescale.com>, Wolfram Sang <w.sang@pengutronix.de>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Fri, Dec 09, 2011 at 03:36:06PM +0100, Lothar Wa=DFmann wrote:
> Wolfram Sang writes:

> > I can't find any other instance setting owner in snd_soc_card?

> Then that other uses are most probably faulty too.

This needs to be fixed up generally, not just for a specific driver.
