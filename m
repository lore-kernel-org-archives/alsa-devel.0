From: "Agrawal, Akshu" <Akshu.Agrawal@amd.com>
Subject: Re: [PATCH 2/2] ASoC: AMD: Enable/Disable auxiliary
 clock via common clock framework
Date: Wed, 11 Apr 2018 15:37:47 +0530
Message-ID: <341e4879-ec6b-8ea9-dd97-a79e4508f8e1@amd.com>
References: <1522404297-7555-1-git-send-email-akshu.agrawal@amd.com>
 <1522404297-7555-2-git-send-email-akshu.agrawal@amd.com>
 <CAGS+omDqWEjEm0b3H5-pwd2Nrf_pEbQTAU_dPKVmXi5vsDxKLw@mail.gmail.com>
 <cc2ee422-edf6-5a01-1482-8152d896b1b3@amd.com>
 <CAGS+omCLJnXcqL=r7ijp+csk7_dBko0pyBG9MHtPPGAd2AgJgA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-cys01nam02on0087.outbound.protection.outlook.com [104.47.37.87])
 by alsa0.perex.cz (Postfix) with ESMTP id 227472673E8
 for <alsa-devel@alsa-project.org>; Wed, 11 Apr 2018 12:08:15 +0200 (CEST)
In-Reply-To: <CAGS+omCLJnXcqL=r7ijp+csk7_dBko0pyBG9MHtPPGAd2AgJgA@mail.gmail.com>
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
To: Daniel Kurtz <djkurtz@chromium.org>
Cc: tiwai@suse.de, Alexander.Deucher@amd.com, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org



On 4/10/2018 11:13 AM, Daniel Kurtz wrote:
>> On 4/4/2018 12:27 AM, Daniel Kurtz wrote:
>>> Hi Akshu,
>>>
>>> On Fri, Mar 30, 2018 at 4:05 AM Akshu Agrawal <akshu.agrawal@amd.com>
> wrote:
>>>
>>>> This enables/disables and sets auxiliary clock at 25Mhz. It uses
>>>> common clock framework for proper ref counting. This approach will
>>>> save power in comparison to keeping it always On in firmware.
>>>
>>> I have some general concern with the approach in this patch:
>>>
>>> (1) The 25 MHz clock being created here is a general system clock
>>> resource.  I think it should be created in an SoC clock driver, rather
> than
>>> here in an audio machine driver.   This has several advantages:
>>>      (a) the clock resource would be available for other boards that use
> it but
>>> don't use this particular audio machine driver
>>>      (b) the clock would be instantiated at boot, rather than at machine
> driver
>>> load.
>>>      (c) the machine driver would not then need the additional clkdev
> code
>>>
>>> (2) The oscout1 clock is a pretty standard clk_gate with a clk_mux.  We
> can
>>> use some standard helpers to better model the clock tree rather than
>>> rewriting them:
>>>
>>> static struct clk *clk_48m;
>>> static struct clk *clk_25m;
>>> static struct clk *clk_oscout1_mux;
>>> static struct clk *clk_oscout1;
>>>
>>> static const char *clk_oscout1_parents[] = { "clk48MHz", "clk25MHz" };
>>>
>>> {
>>>       clk_48m = clk_register_fixed_rate(dev, "clk48MHz", NULL, 0,
> 48000000);
>>>       clk_25m = clk_register_fixed_rate(dev, "clk25MHz", NULL, 0,
> 25000000);
>>>
>>>       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>>       res_base = devm_ioremap_nocache(dev, res->start,
> resource_size(res));
>>>
>>>       clk_oscout1_mux = clk_register_mux(dev, "oscout1_mux",
>>>           clk_oscout1_parents, ARRAY_SIZE(clk_oscout1_parents),
>>>           0, res_base + CLKDRVSTR2, OSCOUT1CLK25MHZ, 3, 0, NULL);
>>>
>>>       clk_set_parent(clk_oscout1_mux, clk_25m);
>>>
>>>       clk_oscout1 = clk_register_gate(dev, "oscout1", "oscout1_mux", 0,
>>>             res_base + MISCCLKCNTL1, OSCCLKENB, 0, NULL);
>>>
>>>
>>> (3) IIUC, the 25 MHz clock (oscout1) is actually the da7219's mclk.  The
>>> da7219 already
>>> has infrastructure to enable/disable its mclk as needed.  Once we
> establish
>>> the system clock,
>>> we can then wire this clock up to the da7219 via ACPI / devicetree
>>> properties.
>>>
>> The above design is something used in almost all ARM based platform
>> where we define all mux, pll, divider and gate and then each device uses
>> them though the devicetree.
>> The clock here are controlled in firmware. Enable/disable is handled in
>> firmware, where this being the exception case. Hence, I don't think it
>> will be of much value add.
> 
> The value add to properly modeling the SoC's clock tree is highlighted
> above.
> In addition to making the code more understandable, and the SoC easier to
> use for other designs in the future, the clock tree as expressed via
> debugfs (/sys/kernel/debug/clk/clk_summary) will make more sense.
> In the particular case of the acp-da7219-max98357a.c machine driver and
> da7219 codec driver, properly modeling the oscout1 clock tree as a
> fixed_clks+mux+gate and then passing it to da7219 as its mclk will allow
> the mclk driver to do what it expects using its existing code - set the
> mclk rate (via oscout1's parent mux selector) and then enable/disable as
> needed.
> 
>> For ST/CZ we have other platforms which do not use this clock. They have
>> a dedicated Oscillator for the codec.
> 
> Exactly, such platforms will just not use this machine driver and this
> clock will be defined properly, but remain in the state programmed by
> firmware.
> 
>> If you think its beneficial for other platform based on ST/CZ then maybe
>> we can take this as a separate activity. Where we move the clocks to a
>> common file and use the same framework.
> 
> Moving the clock configuration out of acp-da7219-max98357a.c allows this
> system clock to be available independent of when this machine driver kernel
> module is loaded.
> 

I understand the advantages of having it moved to drivers/clk and also 
connecting it to d7219's mclk. This is good to have feature for other 
ST/CZ platforms. Would take it up this as a separate activity.

> [snip]
> 
>>>> +struct cz_clock {
>>>> +       const char* acp_clks_name;
>>>
>>> I still think you should remove acp_clks_name, acp_clks_lookup and
> acp_clks
>>> from the struct since they are used locally during
>>> register_acpd7219_clocks, and, afaict, never referenced again.
>>>
>> I don't think putting in struct is bad. Plus it helps me get res_base
>> value on clk_enable using clk_hw.
> 
> Yes, you can use a struct to store the fields that are needed, like
> res_base.  However, fields that are only used locally in a single function
> waste memory and confuse driver reviewers, since storing them in the struct
> implies that the field is state that must be preserved, when in fact the
> field's use is transitory.
> 
> Please remove the extraneous fields from the struct: acp_clk_name,
> acp_clk_lookup, and acp_clk (unless you write an unregister that releases
> this clock, and therefore needs this).
> 
>> +struct cz_clock {
>> +     const char* acp_clk_name;
>> +     struct clk_hw acp_clk_hw;
>> +     struct clk_lookup *acp_clk_lookup;
>> +     struct clk *acp_clk;
>> +     void __iomem *res_base;
>> +};
> 
Accepted.

> [snip]
> 
>>>
>>> Enable on hw_params() and disable on hw_free() doesn't sound balanced?
>>> Will there always be exactly one hw_free() for every hw_params()?
>>>
>> Yes, all resources allocated by hw_paramns are freed in hw_free.
> 
> Right, but is it possible for hw_params() to get called mulitple times
> *without* hw_free()?
> This would cause more enables than disables.
> 
> Documentation/sound/kernel-api/writing-an-alsa-driver.rst says:
> """
> Note that this and ``prepare`` callbacks may be called multiple times
> per initialization. For example, the OSS emulation may call these
> callbacks at each change via its ioctl.
> 
> Thus, you need to be careful not to allocate the same buffers many
> times, which will lead to memory leaks! Calling the helper function
> above many times is OK. It will release the previous buffer
> automatically when it was already allocated.
> """
> 
I get there is a remote possibility that hw_params maybe called multiple 
times without hw_free (though I haven't come across it in my testing).
The other option was to use trigger. But, that is not possible as kernel 
crashes when we call clk_prepare_enable(da7219_dai_clk) from trigger 
registered to a non da7219 codec, like of max98357

3>[   45.690976] BUG: sleeping function called from invalid context at 
/mnt/host/source/src/third_party/kernel/v4.14/kernel/locking/mutex.c:23
8
<3>[   45.690988] in_atomic(): 1, irqs_disabled(): 1, pid: 2104, name: aplay
<4>[   45.690996] CPU: 1 PID: 2104 Comm: aplay Not tainted 4.14.31 #7
<4>[   45.691001] Hardware name: Google Grunt/Grunt, BIOS 
Google_Grunt.10531.0.0 03/30/2018
<4>[   45.691005] Call Trace:
<4>[   45.691022]  dump_stack+0x4d/0x63
<4>[   45.691033]  ___might_sleep+0x11f/0x12e
<4>[   45.691040]  mutex_lock+0x20/0x42
<4>[   45.691049]  regmap_update_bits_base+0x35/0x7c
<4>[   45.691056]  snd_soc_component_update_bits+0x39/0x67
<4>[   45.691064]  ? __mutex_trylock_or_owner+0x4d/0x6a
<4>[   45.691073]  da7219_dai_clks_prepare+0x27/0x2b [snd_soc_da7219]
<4>[   45.691081]  clk_core_prepare+0xa8/0x122
<4>[   45.691088]  clk_prepare+0x21/0x2d
<4>[   45.691095]  cz_da7219_trigger+0x45/0xfb 
[snd_soc_acp_da7219mx98357_mach]
<4>[   45.691101]  soc_pcm_trigger+0xf6/0x112

> [snip]
> 
>>>> +static int register_acpd7219_clocks(struct platform_device *pdev)
>>>
>>> Where is the corresponding unregister?  Isn't this a module that can be
>>> unloaded?
>>>
>> I see none of the machine driver have registered a remove callback, I
>> wonder why?
> 
> I don't know, either?  Perhaps because they don't instantiate anything that
> won't be cleaned up by devm_ on unload?
> This patch as written is currently instantiating clocks, though, so should
> really clean that up when removed.
> 
Accepted.

> -Dan
> 

Regards,
Akshu
