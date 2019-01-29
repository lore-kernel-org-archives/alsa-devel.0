From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: linux-next: Tree for Jan 29 (SLIMbus & SND_SOC_WCD9335)
Date: Tue, 29 Jan 2019 16:57:56 +0000
Message-ID: <a849e598-da5b-bfc2-cd41-dab94fa79c87@linaro.org>
References: <20190129171143.3945af24@canb.auug.org.au>
 <2eaba760-96d5-5e0b-c1e6-c45fb24d89f2@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2eaba760-96d5-5e0b-c1e6-c45fb24d89f2@infradead.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Randy Dunlap <rdunlap@infradead.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Linux Next Mailing List <linux-next@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, moderated for non-subscribers <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org



https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git/commit/?h=for-5.1&id=a8233b6c1972e1959cf84a021aeb61ddcd23cc26

This should fix the issue! It should be in next today!

Thanks,
srini


On 29/01/2019 16:50, Randy Dunlap wrote:
> On 1/28/19 10:11 PM, Stephen Rothwell wrote:
>> Hi all,
>>
>> Changes since 20190125:
>>
> 
> on x86_64:
> 
> CONFIG_SND_SOC_WCD9335=m
> which selects REGMAP_SLIMBUS, but SLIMBUS is not set/enabled.
> 
> 
> ERROR: "slim_driver_unregister" [sound/soc/codecs/snd-soc-wcd9335.ko] undefined!
> ERROR: "__slim_driver_register" [sound/soc/codecs/snd-soc-wcd9335.ko] undefined!
> ERROR: "slim_read" [drivers/base/regmap/regmap-slimbus.ko] undefined!
> ERROR: "slim_write" [drivers/base/regmap/regmap-slimbus.ko] undefined!
> 
> 
> Full randconfig file is attached.
> 
