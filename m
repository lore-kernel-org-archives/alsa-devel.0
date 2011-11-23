From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2] ASoC: cs42l51: Fix off-by-one for
	reg_cache_size
Date: Wed, 23 Nov 2011 11:37:02 +0000
Message-ID: <20111123113702.GM21073@opensource.wolfsonmicro.com>
References: <1322023485.6782.2.camel@phoenix> <1322023571.6782.4.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 01BB7103D1E
	for <alsa-devel@alsa-project.org>; Wed, 23 Nov 2011 12:37:04 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1322023571.6782.4.camel@phoenix>
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Timur Tabi <timur@freescale.com>, "Arnaud Patard (Rtp)" <arnaud.patard@rtp-net.org>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 23, 2011 at 12:46:11PM +0800, Axel Lin wrote:
> Just checking the code in cs42l51_fill_cache():
> The cache pointer points to codec->reg_cache + 1.
> I think it is because CS42L51_FIRSTREG is 0x01,
> so codec->reg_cache[0] is not used here.

Applied, thanks.
