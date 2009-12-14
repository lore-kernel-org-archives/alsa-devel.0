From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: fsi-ak4642: Remove
	ak4642_add_i2c_device
Date: Mon, 14 Dec 2009 11:41:20 +0000
Message-ID: <20091214114119.GE21066@rakim.wolfsonmicro.main>
References: <ur5qychhv.wl%morimoto.kuninori@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 581FC24572
	for <alsa-devel@alsa-project.org>; Mon, 14 Dec 2009 12:41:21 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <ur5qychhv.wl%morimoto.kuninori@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Dec 14, 2009 at 01:22:04PM +0900, Kuninori Morimoto wrote:
> I2C devices should be registered when platform board setting
> in latest ASoC.

> Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>

It'd be better to do a single patch which updates both ASoC and MIPS
trees simultaneously in order to ensure that bisection continues to
work.  Of course, if the MIPS side has been updated separately then we
should just apply this code - has that happened?
