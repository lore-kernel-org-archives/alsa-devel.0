From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: soc-pcm: Remove unused global mutex
Date: Mon, 15 Aug 2011 22:53:16 +0900
Message-ID: <20110815135313.GD5890@opensource.wolfsonmicro.com>
References: <1313280012.4112.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 9E34924656
	for <alsa-devel@alsa-project.org>;
	Mon, 15 Aug 2011 15:53:24 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1313280012.4112.2.camel@phoenix>
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
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Sun, Aug 14, 2011 at 08:00:12AM +0800, Axel Lin wrote:
> Since commit b8c0dab9bf3373010e857a8d3f1b594c60a348dd
> "ASoC: core - PCM mutex per rtd",
> the global pcm_mutex is not being used any more.

Applied, thanks.
