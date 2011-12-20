From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Remove export of s3c_pcm_dai
Date: Tue, 20 Dec 2011 00:48:07 +0000
Message-ID: <20111220004807.GI2860@opensource.wolfsonmicro.com>
References: <1323861206.16636.0.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 67914103A3B
	for <alsa-devel@alsa-project.org>; Tue, 20 Dec 2011 01:48:10 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1323861206.16636.0.camel@phoenix>
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
Cc: Sangbeom Kim <sbkim73@samsung.com>, alsa-devel@alsa-project.org, Kukjin Kim <kgene.kim@samsung.com>, Liam Girdwood <lrg@ti.com>, Jaswinder Singh <jassi.brar@samsung.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Dec 14, 2011 at 07:13:26PM +0800, Axel Lin wrote:
> We don't need to export s3c_pcm_dai after multi-component patch.
> Thus remove export of s3c_pcm_dai and make it static.

Applied, thanks.
