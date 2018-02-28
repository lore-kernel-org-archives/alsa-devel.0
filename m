From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH 0/1] Re: Applied "ASoC: topology: Fix logical
 inversion in set_link_hw_format()" to the asoc tree
Date: Tue, 27 Feb 2018 22:31:23 -0800
Message-ID: <10bebc9d-3c16-c301-b71b-87786525da14@linux.intel.com>
References: <20180227155758.GD11822@sirena.org.uk>
 <20180227203317.17274-1-k.marinushkin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180227203317.17274-1-k.marinushkin@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Kirill Marinushkin <k.marinushkin@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: Pan Xiuli <xiuli.pan@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 2/27/18 12:33 PM, Kirill Marinushkin wrote:
> Hello Mark, Pierre-Louis, Pan, Liam,
> 
> As there are too much open questions regarding the bclk and fsync inversion in
> set_link_hw_format(), I would like to suggest the alternative solution.
> 
> This solution will fit both use-cases:
> 
> * existing use-cases (Broadwell, etc.)
> * new use-cases (Sound Open Firmware, etc.)
> 
> The solution includes 1 patch for linux + 1 patch for alsa-lib.
> I will send them to this mailing thread.

That looks acceptable to me, Xiuli can you test with with the matching 
change in the SOF topology macros (we can keep the 'slave' in M4 files 
but expand to 'codec_slave' in the .conf to avoid making this exception 
visible).

> 
> Signed-off-by: Kirill Marinushkin <k.marinushkin@gmail.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Cc: Pan Xiuli <xiuli.pan@linux.intel.com>
> Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: alsa-devel@alsa-project.org
> 
> Kirill Marinushkin (1):
>    ASoC: topology: Fix bclk and fsync inversion in set_link_hw_format()
> 
>   include/uapi/sound/asoc.h | 16 ++++++++++++++--
>   sound/soc/soc-topology.c  | 12 +++++++-----
>   2 files changed, 21 insertions(+), 7 deletions(-)
> 
