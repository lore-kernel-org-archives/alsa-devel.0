From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: Re: [sound:for-next 174/174]
 sound/ppc/keywest.c:104:1: error: type defaults to 'int' in declaration of
 'MODULE_DEVICE_TABLE'
Date: Tue, 25 Aug 2015 14:11:57 +0200
Message-ID: <55DC5B8D.4010601@osg.samsung.com>
References: <201508251919.xL9c6697%fengguang.wu@intel.com>
 <55DC572E.3070701@osg.samsung.com> <s5hpp2bmv4t.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lists.s-osg.org (lists.s-osg.org [54.187.51.154])
 by alsa0.perex.cz (Postfix) with ESMTP id 058AC260557
 for <alsa-devel@alsa-project.org>; Tue, 25 Aug 2015 14:12:02 +0200 (CEST)
In-Reply-To: <s5hpp2bmv4t.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, kbuild test robot <fengguang.wu@intel.com>, kbuild-all@01.org
List-Id: alsa-devel@alsa-project.org

Hello Takashi,

On 08/25/2015 02:04 PM, Takashi Iwai wrote:
> On Tue, 25 Aug 2015 13:53:18 +0200,
> Javier Martinez Canillas wrote:
>>
>> On 08/25/2015 01:23 PM, kbuild test robot wrote:
>>> tree:   git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git for-next
>>> head:   a2bc2af66a5b656577fc2d71b6c277b73537777e
>>> commit: a2bc2af66a5b656577fc2d71b6c277b73537777e [174/174] ALSA: ppc: keywest: Export I2C module alias information
>>> config: powerpc-defconfig (attached as .config)
>>> reproduce:
>>>   wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
>>>   chmod +x ~/bin/make.cross
>>>   git checkout a2bc2af66a5b656577fc2d71b6c277b73537777e
>>>   # save the attached .config to linux build tree
>>>   make.cross ARCH=powerpc 
>>>
>>> All error/warnings (new ones prefixed by >>):
>>>
>>>>> sound/ppc/keywest.c:104:1: warning: data definition has no type or storage class
>>>     MODULE_DEVICE_TABLE(i2c, keywest_i2c_id);
>>>     ^
>>>>> sound/ppc/keywest.c:104:1: error: type defaults to 'int' in declaration of 'MODULE_DEVICE_TABLE' [-Werror=implicit-int]
>>>>> sound/ppc/keywest.c:104:1: warning: parameter names (without types) in function declaration
>>>    cc1: some warnings being treated as errors
>>>
>>> vim +104 sound/ppc/keywest.c
>>>
>>>     98	
>>>     99	static const struct i2c_device_id keywest_i2c_id[] = {
>>>    100		{ "MAC,tas3004", 0 },		/* instantiated by i2c-powermac */
>>>    101		{ "keywest", 0 },		/* instantiated by us if needed */
>>>    102		{ }
>>>    103	};
>>>  > 104	MODULE_DEVICE_TABLE(i2c, keywest_i2c_id);
>>>    105	
>>>    106	static struct i2c_driver keywest_driver = {
>>>    107		.driver = {
>>>
>>> ---
>>> 0-DAY kernel test infrastructure                Open Source Technology Center
>>> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
>>>
>>
>> Sigh, this is because it misses a <linux/module.h> include.
>>
>> I built test with make M=drivers but forgot that sound is outside drivers.
>>
>> So the following change is needed [0].
>>
>> Takashi,
>>
>> Should I re-spin a v2 adding the include or now that you applied, should
>> I send an incremental patch?
> 
> I already fixed it by myself, I just wanted to submit the fix to ML
> now :)
> 

Great, thanks a lot and sorry for the inconvenience.

> 
> thanks,
> 
> Takashi
> 
> 

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
