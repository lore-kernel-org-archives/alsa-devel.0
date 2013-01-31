From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v2] ASoC: soc-compress: Add support for not
 memory mapped	DSPs
Date: Wed, 30 Jan 2013 19:02:32 -0800
Message-ID: <20130131030232.GB3143@intel.com>
References: <1359104400-18527-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <20130128040416.GJ26562@intel.com>
 <20130128045609.GA5683@opensource.wolfsonmicro.com>
 <20130128060914.GM26562@intel.com>
 <20130128064440.GB5683@opensource.wolfsonmicro.com>
 <20130128093449.GO26562@intel.com>
 <20130128104910.GB14418@opensource.wolfsonmicro.com>
 <20130129185116.GA27083@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 7641C2615ED
 for <alsa-devel@alsa-project.org>; Thu, 31 Jan 2013 04:27:31 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20130129185116.GA27083@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, vinod.koul@linux.jf.intel.com, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

On Tue, Jan 29, 2013 at 06:51:16PM +0000, Charles Keepax wrote:
> The ASoC compressed API did not implement the copy callback in its
> compressed ops which is required for DSPs that are not memory mapped.
> This patch adds a second set of compressed ops which does implement the
> copy callback and uses that when copy is defined in the platform
> compressed ops, ie. when the DSP is not memory mapped.
> 
> Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
> ---
> @@ -335,14 +352,23 @@ int soc_new_compress(struct snd_soc_pcm_runtime *rtd, int num)
>  		return -ENOMEM;
>  	}
>  
> -	compr->ops = &soc_compr_ops;
> +	compr->ops = kmemdup(&soc_compr_ops, sizeof(soc_compr_ops), GFP_KERNEL);
You forgot to free this memory when device is destoryed

--
~Vinod
