From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: [PATCH v2 0/3] ASoC: topology: Add support for FE
 DAI & DAI links
Date: Mon, 25 Jan 2016 11:37:50 +0000
Message-ID: <1453721870.2557.28.camel@loki>
References: <cover.1452844210.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 2CDEA2604D6
 for <alsa-devel@alsa-project.org>; Mon, 25 Jan 2016 12:37:54 +0100 (CET)
In-Reply-To: <cover.1452844210.git.mengdong.lin@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: mengdong.lin@linux.intel.com
Cc: alsa-devel@alsa-project.org, Vaibhav Agarwal <vaibhav.agarwal@linaro.org>, Takashi Iwai <tiwai@suse.de>, mengdong.lin@intel.com, vinod.koul@intel.com, Mark Brown <broonie@kernel.org>, jeeja.kp@intel.com, subhransu.s.prusty@intel.com
List-Id: alsa-devel@alsa-project.org

On Fri, 2016-01-15 at 16:11 +0800, mengdong.lin@linux.intel.com wrote:
> From: Mengdong Lin <mengdong.lin@linux.intel.com>
> 
> This series allows topology to create FE DAI and DAI links from the PCM
> topology objects defined by the user space.
> 
> History:
> v2: Remove first 2 patches in v1 that were accepted.
>     Add Ack by Takashi to patch 'ALSA: pcm: Add snd_pcm_rate_range_to_bits()'
>     and add his comments on the function's assumption to c file.
> 
> Mengdong Lin (3):
>   ALSA: pcm: Add snd_pcm_rate_range_to_bits()
>   ASoC: topology: Add FE DAIs dynamically
>   ASoC: topology: Add FE DAI links dynamically
> 

Acked-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>

Mengdong, it might be easier to split this patch into 1/3 and 2,3/3
since 1/3 will be in Takashi's tree, but then that might not be needed
it Takashi and Mark agree.

Liam
