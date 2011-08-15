From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: soc-cache: Remove unneeded codec_drv
 pointer variable in snd_soc_flat_cache_init
Date: Mon, 15 Aug 2011 22:52:45 +0900
Message-ID: <20110815135242.GB5890@opensource.wolfsonmicro.com>
References: <1313241121.12301.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 380CE2464B
	for <alsa-devel@alsa-project.org>;
	Mon, 15 Aug 2011 15:52:52 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1313241121.12301.2.camel@phoenix>
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
Cc: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Sat, Aug 13, 2011 at 09:12:01PM +0800, Axel Lin wrote:
> Since commit d779fce5d79525d66269c8f6e430e1515d697f3d
> "ASoC: soc-cache: Ensure flat compression uses a copy of the defaults cache",
> the codec_drv pointer variable is not used any more.

Applied, thanks.
