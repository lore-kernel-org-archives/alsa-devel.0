From: Vinod Koul <vinod.koul@linux.intel.com>
Subject: Re: [RFC PATCH 2/2] ASoC: add compress stream support
Date: Mon, 06 Aug 2012 11:02:01 +0530
Message-ID: <1344231121.1726.14448.camel@vkoul-udesk3>
References: <1343716900-23491-1-git-send-email-vinod.koul@linux.intel.com>
 <1343716900-23491-3-git-send-email-vinod.koul@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id A75C326531F
 for <alsa-devel@alsa-project.org>; Mon,  6 Aug 2012 07:00:55 +0200 (CEST)
In-Reply-To: <1343716900-23491-3-git-send-email-vinod.koul@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: broonie@opensource.wolfsonmicro.com, namartax.kohli@intel.com, lrg@ti.com, ramesh.babu@intel.com, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org

On Tue, 2012-07-31 at 12:11 +0530, Vinod Koul wrote:
> diff --git a/sound/soc/Makefile b/sound/soc/Makefile
> index 00a555a..c126400 100644
> --- a/sound/soc/Makefile
> +++ b/sound/soc/Makefile
> @@ -1,5 +1,5 @@
>  snd-soc-core-objs := soc-core.o soc-dapm.o soc-jack.o soc-cache.o
> soc-utils.o
> -snd-soc-core-objs += soc-pcm.o soc-io.o
> +snd-soc-core-objs += soc-pcm.o soc-compress.o soc-io.o 
Mark,

I am planning to add a symbol, SND_SOC_COMPRESS_OFFLOAD and compile this
file and other changes under this flag.
This will select SND_COMPRESS_OFFLOAD and users should select this
symbol when using compressed offload...

Let me know if its fine and will send patch for this.

Thanks
-- 
~Vinod
