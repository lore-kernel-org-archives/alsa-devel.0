From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v4 0/3] ASoC: topology: Improve hw_configs
Date: Wed, 4 Apr 2018 13:57:12 -0500
Message-ID: <1ff8e154-e76f-b57a-cd79-cd42fdecf92b@linux.intel.com>
References: <20180404041939.23317-1-k.marinushkin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by alsa0.perex.cz (Postfix) with ESMTP id 5B20826718D
 for <alsa-devel@alsa-project.org>; Wed,  4 Apr 2018 20:57:15 +0200 (CEST)
In-Reply-To: <20180404041939.23317-1-k.marinushkin@gmail.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kirill Marinushkin <k.marinushkin@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org, Pan Xiuli <xiuli.pan@linux.intel.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 4/3/18 11:19 PM, Kirill Marinushkin wrote:
> Hello Mark,
> 
> This patch series waits since 20th of February, because it modifies UAPI headers
> and should be done in sync with ALSA. I see that previously there was no clear
> understanding, how to do this in sync.
> 
> Two days ago I discussed with Takashi, and he suggested the following steps:
> 
> Step 1. A person from Intel, who knows the topic (Pierre), adds his
> "Reviewed-by" or "Acked-by" tags
> Step 2. I clarify with you to apply the Linux part (this patch series)
> Step 3. After that, I clarify with Takashi to apply the ALSA part (it is ready,
> but not sent untill we apply the Linux part)
> 
> The step 1 is done. Old patches are reviewed by Pierre, so they have his
> "Reviewed-by" tag. New patches are suggested by him, and we agreed on the
> implementation, so they have his "Acked-by" tag.

I just checked all the patches one more time and I am indeed good with 
the changes
Thanks Kirill for clarifying those misleading settings in 
backwards-compatible ways and indirectly helping on our SOF work.

> 
> Now we are on the step 2. If you don't have anything against this patch series,
> please apply it to Linux.
> 
> Best Regards,
> Kirill
> 
> Kirill Marinushkin (3):
>    ASoC: topology: Fix bclk and fsync inversion in set_link_hw_format()
>    ASoC: topology: Add missing clock gating parameter when parsing
>      hw_configs
>    ASoC: topology: Add definitions for mclk_direction values
> 
>   include/uapi/sound/asoc.h | 29 +++++++++++++++++++++++++----
>   sound/soc/soc-topology.c  | 19 ++++++++++++++-----
>   2 files changed, 39 insertions(+), 9 deletions(-)
> 
