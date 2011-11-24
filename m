From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] ASoC: Convert blackfin directory to
	module_platform_driver
Date: Thu, 24 Nov 2011 08:35:16 +0100
Message-ID: <4ECDF3B4.8020102@metafoo.de>
References: <1322117092.19406.3.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-165.synserver.de (smtp-out-168.synserver.de
	[212.40.185.168])
	by alsa0.perex.cz (Postfix) with SMTP id 7E8DC103B61
	for <alsa-devel@alsa-project.org>; Thu, 24 Nov 2011 08:34:36 +0100 (CET)
In-Reply-To: <1322117092.19406.3.camel@phoenix>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Barry Song <21cnbao@gmail.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On 11/24/2011 07:44 AM, Axel Lin wrote:
> Factor out some boilerplate code.
> 
> Signed-off-by: Axel Lin <axel.lin@gmail.com>

Acked-by: Lars-Peter Clausen <lars@metafoo.de>

> ---
>  sound/soc/blackfin/bf5xx-ac97-pcm.c     |   12 +-----------
>  sound/soc/blackfin/bf5xx-ac97.c         |   13 +------------
>  sound/soc/blackfin/bf5xx-i2s-pcm.c      |   12 +-----------
>  sound/soc/blackfin/bf5xx-i2s.c          |   13 +------------
>  sound/soc/blackfin/bf5xx-tdm-pcm.c      |   12 +-----------
>  sound/soc/blackfin/bf5xx-tdm.c          |   12 +-----------
>  sound/soc/blackfin/bfin-eval-adau1373.c |   12 +-----------
>  sound/soc/blackfin/bfin-eval-adau1701.c |   12 +-----------
>  sound/soc/blackfin/bfin-eval-adav80x.c  |   12 +-----------
>  9 files changed, 9 insertions(+), 101 deletions(-)
> 
