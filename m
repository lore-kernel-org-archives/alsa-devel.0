From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Fix reg_cache_size for stac9766
Date: Mon, 5 Dec 2011 13:31:28 +0000
Message-ID: <20111205133128.GN11150@opensource.wolfsonmicro.com>
References: <1323050764.6086.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 855CE103A9C
	for <alsa-devel@alsa-project.org>; Mon,  5 Dec 2011 14:31:30 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1323050764.6086.1.camel@phoenix>
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

On Mon, Dec 05, 2011 at 10:06:04AM +0800, Axel Lin wrote:
> reg_cache_size is supposed to be the number of elements in the register cache,
> not the size in bytes.

Applied, though note that in this case as the register values are 8 bits
the two numbers are exactly the same so this is a coding style fix only
(but still useful!).
