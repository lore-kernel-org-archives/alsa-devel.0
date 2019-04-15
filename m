From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH 0/2] soundwire: fix Kconfig select/depend
 issues
Date: Mon, 15 Apr 2019 07:50:42 -0500
Message-ID: <7a2378b1-24d5-f60b-b32a-53e2d378d824@linux.intel.com>
References: <20190411192814.10663-1-pierre-louis.bossart@linux.intel.com>
 <20190414101347.GJ28103@vkoul-mobl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190414101347.GJ28103@vkoul-mobl>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Vinod Koul <vkoul@kernel.org>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, liam.r.girdwood@linux.intel.com, broonie@kernel.org, srinivas.kandagatla@linaro.org, jank@cadence.com, joe@perches.com
List-Id: alsa-devel@alsa-project.org



On 4/14/19 5:13 AM, Vinod Koul wrote:
> On 11-04-19, 14:28, Pierre-Louis Bossart wrote:
>> 0-day/Kbuild starts complaining about missed module dependencies and
>> compilation issues. Since codecs and soc drivers need to be compilable
>> independently, let's fix this using the following model:
> 
> I have not seen a build report on this one, is this some internal Intel
> report or on upstream tree?

0day/kbuild generated this on my work tree:

tree:   https://github.com/plbossart/sound fix/soundwire-dev
head:   d59242993bef53c301c0badda162c6bb3a5f15cb
commit: 24fe4a80b2435446c52197cb828f4475aa817c79 [22/25] skl change for sdw
config: x86_64-randconfig-l1-04110213 (attached as .config)
compiler: gcc-5 (Debian 5.5.0-3) 5.4.1 20171010
reproduce:
         git checkout 24fe4a80b2435446c52197cb828f4475aa817c79
         # save the attached .config to linux build tree
         make ARCH=x86_64

All errors (new ones prefixed by >>):

    sound/soc/intel/skylake/skl-pcm.o: In function 
`skl_platform_pcm_prepare':
>> sound/soc/intel/skylake/skl-pcm.c:1364: undefined reference to `sdw_prepare_stream'
    sound/soc/intel/skylake/skl-pcm.o: In function 
`skl_platform_pcm_hw_free':
>> sound/soc/intel/skylake/skl-pcm.c:1339: undefined reference to `sdw_deprepare_stream'
    sound/soc/intel/skylake/skl-pcm.o: In function `skl_platform_shutdown':
>> sound/soc/intel/skylake/skl-pcm.c:1314: undefined reference to `sdw_release_stream'
    sound/soc/intel/skylake/skl-pcm.o: In function `skl_sdw_stream_trigger':
>> sound/soc/intel/skylake/skl-pcm.c:1266: undefined reference to `sdw_enable_stream'
>> sound/soc/intel/skylake/skl-pcm.c:1278: undefined reference to `sdw_disable_stream'
    sound/soc/intel/skylake/skl-pcm.o: In function `skl_platform_open':
>> sound/soc/intel/skylake/skl-pcm.c:1136: undefined reference to `sdw_alloc_stream'
    sound/soc/intel/skylake/skl-pcm.c:1163: undefined reference to 
`sdw_release_stream'
    sound/soc/intel/skylake/cnl-sst.o: In function `skl_sdw_init':
>> sound/soc/intel/skylake/cnl-sst.c:514: undefined reference to `sdw_intel_init'
