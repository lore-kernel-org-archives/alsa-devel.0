From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Fix reg_cache_size for stac9766
Date: Mon, 5 Dec 2011 14:18:04 +0000
Message-ID: <20111205141803.GQ11150@opensource.wolfsonmicro.com>
References: <1323050764.6086.1.camel@phoenix>
	<20111205133128.GN11150@opensource.wolfsonmicro.com>
	<CAF+7xWnNKSAS764jeZJGc9enXhSA2snX2b0pbWAaVOB=QXKN8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id BFD0A2417B
	for <alsa-devel@alsa-project.org>; Mon,  5 Dec 2011 15:18:05 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <CAF+7xWnNKSAS764jeZJGc9enXhSA2snX2b0pbWAaVOB=QXKN8g@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Dec 05, 2011 at 10:12:51PM +0800, Axel Lin wrote:

> Actually, the register values are 16 bits.
> static const u16 stac9766_reg[] = {

Oh dear, looked at the wrong sta... driver, sorry.
