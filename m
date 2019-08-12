From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v3 4/4] ASoC: codecs: add wsa881x amplifier support
Date: Mon, 12 Aug 2019 10:05:05 +0100
Message-ID: <a89e6a52-35da-15bf-6561-c58cb3453178@linaro.org>
References: <20190809133407.25918-5-srinivas.kandagatla@linaro.org>
 <201908121031.HBxXaLjU%lkp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201908121031.HBxXaLjU%lkp@intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, vkoul@kernel.org, broonie@kernel.org, bgoswami@codeaurora.org, plai@codeaurora.org, pierre-louis.bossart@linux.intel.com, robh+dt@kernel.org, devicetree@vger.kernel.org, lgirdwood@gmail.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Thanks for reporting this,

On 12/08/2019 03:46, kbuild test robot wrote:
> Hi Srinivas,
> 
> I love your patch! Yet something to improve:
> 
> [auto build test ERROR on linus/master]
> [cannot apply to v5.3-rc4 next-20190809]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Srinivas-Kandagatla/ASoC-codecs-Add-WSA881x-Smart-Speaker-amplifier-support/20190812-080612
> config: m68k-allmodconfig (attached as .config)
> compiler: m68k-linux-gcc (GCC) 7.4.0
> reproduce:
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # save the attached .config to linux build tree
>          GCC_VERSION=7.4.0 make.cross ARCH=m68k
> 
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>>> ERROR: "sdw_unregister_driver" [sound/soc/codecs/snd-soc-wsa881x.ko] undefined!
>>> ERROR: "sdw_write" [sound/soc/codecs/snd-soc-wsa881x.ko] undefined!
>>> ERROR: "__sdw_register_driver" [sound/soc/codecs/snd-soc-wsa881x.ko] undefined!
>>> ERROR: "sdw_write" [drivers/base/regmap/regmap-sdw.ko] undefined!
>>> ERROR: "sdw_read" [drivers/base/regmap/regmap-sdw.ko] undefined!
> 


There are changes in SoundWire Kconfigs 
(https://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git/commit/?h=fixes&id=8676b3ca4673517650fd509d7fa586aff87b3c28) 
which are not available in linux/master yet so this error!

Once this patch lands then below errors should disappear.


thanks,
srini
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
> 
