From: Christian Hartmann <cornogle@googlemail.com>
Subject: Re: [WM5102/ARIZONA] spi driver needs to support ACPI
Date: Tue, 2 Jun 2015 10:34:25 +0200
Message-ID: <CAKor6TdCBoh91XoGMKj1qWAAx0AV8MnPb_Oq8T7YsCj1m7rycA@mail.gmail.com>
References: <CAKor6TdtBEf9cN-EFw0BpRd4EbAKYXgfWh_PbSiG5=EhC1peew@mail.gmail.com>
 <555A1357.3090905@linux.intel.com>
 <CAKor6TerixSeaVYUs6uprcPwUvoNkkPhHx8Ap9apTbPW+1o4aA@mail.gmail.com>
 <CAKor6TfK_m2LLAKsCwaHq47wQCfK_g6ps_tAWr5CRVqnbfsrNw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qg0-f42.google.com (mail-qg0-f42.google.com
 [209.85.192.42])
 by alsa0.perex.cz (Postfix) with ESMTP id 46C9A26042F
 for <alsa-devel@alsa-project.org>; Tue,  2 Jun 2015 10:34:26 +0200 (CEST)
Received: by qgg60 with SMTP id 60so56265459qgg.2
 for <alsa-devel@alsa-project.org>; Tue, 02 Jun 2015 01:34:25 -0700 (PDT)
In-Reply-To: <CAKor6TfK_m2LLAKsCwaHq47wQCfK_g6ps_tAWr5CRVqnbfsrNw@mail.gmail.com>
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
List-Id: alsa-devel@alsa-project.org

hi list again,

I have patched the torvalds/master branch currently rc6
and I have no NULL pointer exception anymore.

I will send each patch separately

Of course no (working) soundcard yet..

so let be try to describe what is actually open or resolved for me:

* the spi master 37622 (pxa2xx) does not fail to add the SPI slave spi-WM510205
pxa2xx-spi 80860F0E:00: registered child spi-WM510205:00

* ALSA device list: no soundcards found
* in dmesg I found two message indicating that something seems to be
missing yet:

sst-acpi 80860F28:00: No matching ASoC machine driver found
intel-sst-acpi 80860F28:00: No matching machine driver found


snip of dmesg 4.1.0.42-rc6


[    6.075170] sst-acpi 80860F28:00: No matching ASoC machine driver found
[    6.106787] pxa2xx-spi 80860F0E:00: no DMA channels available, using PIO
[    6.106865] pxa2xx-spi 80860F0E:00: registered master spi32766 (dynamic)
[    6.107058] spi spi-WM510205:00: 8333333 Hz actual, PIO
[    6.107065] spi spi-WM510205:00: setup mode 0, 8 bits/w, 8000000 Hz max --> 0
[    6.107151] pxa2xx-spi 80860F0E:00: registered child spi-WM510205:00
[    6.114510] rfkill_gpio LNV4752:00: GPIO lookup for consumer reset
[    6.114519] rfkill_gpio LNV4752:00: using ACPI for GPIO lookup
[    6.114526] acpi LNV4752:00: GPIO: looking up reset-gpios
[    6.114533] acpi LNV4752:00: GPIO: _DSD returned LNV4752:00 3 0 0 0
[    6.114607] no flags found for reset
[    6.114619] rfkill_gpio LNV4752:00: GPIO lookup for consumer shutdown
[    6.114623] rfkill_gpio LNV4752:00: using ACPI for GPIO lookup
[    6.114628] acpi LNV4752:00: GPIO: looking up shutdown-gpios
[    6.114633] acpi LNV4752:00: GPIO: _DSD returned LNV4752:00 3 1 0 0
[    6.114669] acpi LNV4752:00: GPIO: looking up shutdown-gpio
[    6.114675] acpi LNV4752:00: GPIO: looking up 0 in _CRS
[    6.114711] gpio-411 (reset): gpiod_request: status -16
[    6.114849] rfkill_gpio LNV4752:00: LNV4752:00 device registered.
[    6.247784] intel_sst_acpi 80860F28:00: No matching machine driver found


I have grepped the string 80860F28 in the ACPI DSDT table (->
dsdt.dsl) and found

    {
        Device (LPEA)
        {
            Name (_ADR, Zero)  // _ADR: Address
            Name (_HID, "80860F28" /* Intel SST Audio DSP */)  //
_HID: Hardware ID
            Name (_CID, "80860F28" /* Intel SST Audio DSP */)  //
_CID: Compatible ID
            Name (_DDN, "Intel(R) Low Power Audio Controller -
80860F28")  // _DDN: DOS Device Name
            Name (_SUB, "17AA7004")  // _SUB: Subsystem ID
            Name (_UID, One)  // _UID: Unique ID
            Name (_DEP, Package (0x01)  // _DEP: Dependencies
            {
                ^SPI1.AUDI
            })
            Name (_PR0, Package (0x01)  // _PR0: Power Resources for D0
            {
                PLPE
            })
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                If (LAnd (LEqual (LPEE, 0x02), LEqual (LPED, Zero)))
                {
                    Return (0x0F)
                }

                Return (Zero)
            }

So how to bind the intel_sst_acpi with the WM5102 arizona coded and
its hub named arizone ???

Any suggestions or new directions?
....


cheers
chris


2015-05-19 15:39 GMT+02:00 Christian Hartmann <cornogle@googlemail.com>:
> Hi,
>
> at the moment I am totally confused. I thought adding an ACPI ID is
> trivial, but it is not.
>
> I have again a null pointer exception in arizona_spi_probe()
>
> could it be with the new num_chipselect value in spi-pxa2xx.c ??
> I attach the trace of the last try
>
> Any hints or tips are welcome.
>
> cheers
> chris
>
> 2015-05-19 11:04 GMT+02:00 Christian Hartmann <cornogle@googlemail.com>:
>> Hi,
>>
>> so the ACPI id string, which I want to add to arizona-spi.c should be
>>
>> WM510205 ??
>>
>> I have changed the ACPI string to
>>
>> {"WM510205", WM5102},
>>
>> now and give it a try.
>>
>> cheers
>> chris
>>
>> 2015-05-18 18:29 GMT+02:00 Pierre-Louis Bossart
>> <pierre-louis.bossart@linux.intel.com>:
>>> On 5/15/15 4:16 AM, Christian Hartmann wrote:
>>>>
>>>> Hi list,
>>>>
>>>>
>>>> I need ACPI support for the arizona-core / arizona-spi driver for the
>>>> ACPI ID WM5102.
>>>> This audio codec is build into the Lenovo Yoga 851F. This device is a
>>>> 32Bit (UEFI) system
>>>>
>>>>
>>>> http://support.lenovo.com/de/de/products/tablets/yoga-series/yoga-tablet-2-851
>>>>
>>>>
>>>> I have tested with vanilla kernels from kernel.org 3.19.y ,4.0.y and
>>>> master (from torvalds) currently its 4.1.0-rc3. As distribution I am
>>>> working with Fedora / Fedlet was the initial install image.
>>>>
>>>> With all vanilla kernels I got at first an error message from spi32766:
>>>>
>>>> [ 0.296297] pxa2xx-spi 80860F0E:00: cs1 >= max 1
>>>> [ 0.296311] spi_master spi32766: failed to add SPI device
>>>> WM510205:00 from ACPI
>>>>
>>>> so I have at first patched as suggested by broonie the arizona-core
>>>>
>>>> commit 48203a0fede057d6a8c5f6872c53326395350f45
>>>> Author: somebody anybody <somebody@foobar.com>
>>>> Date:   Mon May 11 13:35:43 2015 +0200
>>>>
>>>>      spi-pxa2xx : raise chipselect
>>>>
>>>>      Signed-off-by: somebody anybody <somebody@foobar.com>
>>>>
>>>> diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
>>>> index e3223ac..9c919ea 100644
>>>> --- a/drivers/spi/spi-pxa2xx.c
>>>> +++ b/drivers/spi/spi-pxa2xx.c
>>>> @@ -1279,7 +1279,7 @@ pxa2xx_spi_acpi_get_pdata(struct platform_device
>>>> *pdev)
>>>>          if (adev->pnp.unique_id && !kstrtoint(adev->pnp.unique_id, 0,
>>>> &devid))
>>>>                  ssp->port_id = devid;
>>>>
>>>> -       pdata->num_chipselect = 1;
>>>> +       pdata->num_chipselect = 20;
>>>>          pdata->enable_dma = true;
>>>>
>>>>          return pdata;
>>>>
>>>> This leds the spi master do the further ACPI configuration and inital
>>>> setup for the arizona-spi device, but adding the ACPI ID to it
>>>> does not work yet as expected:
>>>>
>>>> The current last patchset on top of master is
>>>>
>>>>
>>>> Author: somebody anybody <somebody@foobar.com>
>>>> Date:   Wed May 13 11:36:25 2015 +0200
>>>>
>>>>      arizona : added ACPI id of wm5102 to SPI driver, too
>>>>
>>>>      Signed-off-by: somebody anybody <somebody@foobar.com>
>>>>
>>>> diff --git a/drivers/mfd/arizona-spi.c b/drivers/mfd/arizona-spi.c
>>>> index 1e845f6..c19a4c1 100644
>>>> --- a/drivers/mfd/arizona-spi.c
>>>> +++ b/drivers/mfd/arizona-spi.c
>>>> @@ -17,6 +17,7 @@
>>>>   #include <linux/regulator/consumer.h>
>>>>   #include <linux/slab.h>
>>>>   #include <linux/spi/spi.h>
>>>> +#include <linux/acpi.h>
>>>>   #include <linux/of.h>
>>>>
>>>>   #include <linux/mfd/arizona/core.h>
>>>> @@ -82,6 +83,15 @@ static int arizona_spi_remove(struct spi_device *spi)
>>>>          return 0;
>>>>   }
>>>>
>>>> +#ifdef CONFIG_ACPI
>>>> +static struct acpi_device_id wm5102_acpi_match[] = {
>>>> +               { "WM5102", 0},
>>>> +               { "WM510205", 0},
>>>> +               { },
>>>> +};
>>>> +MODULE_DEVICE_TABLE(acpi, wm5102_acpi_match);
>>>> +#endif
>>>> +
>>>>   static const struct spi_device_id arizona_spi_ids[] = {
>>>>          { "wm5102", WM5102 },
>>>>          { "wm5110", WM5110 },
>>>> @@ -96,6 +106,9 @@ static struct spi_driver arizona_spi_driver = {
>>>>                  .owner  = THIS_MODULE,
>>>>                  .pm     = &arizona_pm_ops,
>>>>                  .of_match_table = of_match_ptr(arizona_of_match),
>>>> +#ifdef CONFIG_ACPI
>>>> +               .acpi_match_table = ACPI_PTR(wm5102_acpi_match),
>>>> +#endif
>>>>          },
>>>>          .probe          = arizona_spi_probe,
>>>>          .remove         = arizona_spi_remove,
>>>>
>>>>
>>>>
>>>>
>>>> commit 268e21d29c942205e40f749c6d71c77839dc67da
>>>> Author: somebody anybody <somebody@foobar.com>
>>>> Date:   Wed May 13 11:36:04 2015 +0200
>>>>
>>>>      arizona : added ACPI id of wm5102 to i2c driver
>>>>
>>>>      Signed-off-by: somebody anybody <somebody@foobar.com>
>>>>
>>>> diff --git a/drivers/mfd/arizona-i2c.c b/drivers/mfd/arizona-i2c.c
>>>> index ff782a5..45ece1b 100644
>>>> --- a/drivers/mfd/arizona-i2c.c
>>>> +++ b/drivers/mfd/arizona-i2c.c
>>>> @@ -18,6 +18,7 @@
>>>>   #include <linux/regulator/consumer.h>
>>>>   #include <linux/slab.h>
>>>>   #include <linux/of.h>
>>>> +#include <linux/acpi.h>
>>>>
>>>>   #include <linux/mfd/arizona/core.h>
>>>>
>>>> @@ -85,6 +86,15 @@ static int arizona_i2c_remove(struct i2c_client *i2c)
>>>>          return 0;
>>>>   }
>>>>
>>>> +#ifdef CONFIG_ACPI
>>>> +static struct acpi_device_id wm5102_acpi_match[] = {
>>>> +               { "WM5102", 0},
>>>> +               { "WM510205", 0},
>>>> +               { },
>>>
>>>
>>> Those IDs don't really look like ACPI ones? Isn't there a rule that the _HID
>>> is represented by a 4-letter vendor ID followed by part ID? see
>>> http://www.uefi.org/PNP_ACPI_Registry
>>>
>>>
>>>> +};
>>>> +MODULE_DEVICE_TABLE(acpi, wm5102_acpi_match);
>>>> +#endif
>>>> +
>>>>   static const struct i2c_device_id arizona_i2c_id[] = {
>>>>          { "wm5102", WM5102 },
>>>>          { "wm5110", WM5110 },
>>>> @@ -100,6 +110,9 @@ static struct i2c_driver arizona_i2c_driver = {
>>>>                  .owner  = THIS_MODULE,
>>>>                  .pm     = &arizona_pm_ops,
>>>>                  .of_match_table = of_match_ptr(arizona_of_match),
>>>> +#ifdef CONFIG_ACPI
>>>> +               .acpi_match_table = ACPI_PTR(wm5102_acpi_match),
>>>> +#endif
>>>>          },
>>>>          .probe          = arizona_i2c_probe,
>>>>          .remove         = arizona_i2c_remove,
>>>>
>>>>
>>>>
>>>> with these two patches the local master branch compiles fine, but at
>>>> initialzing the arizona-spi driver gots a NULL pointer exception.
>>>>
>>>> I attach the whole dmesg of 4.1.0-rc3 (build 4.1.0.24-rc3).
>>>>
>>>> I need some assistance or hints to the right direction, I am looking
>>>> myself and I also try what I can, but I think it would be easy peasy
>>>> with some experts like here on this list :)
>>>>
>>>>
>>>> PS: the message : spi_master spi32766: raised num_chipselect to 20 for
>>>> WM510205:00
>>>>
>>>> is a dev_err() line added to the function static acpi_status
>>>> acpi_spi_add_device(), there I had raised the num_chipselect first
>>>> (that was wrong, the raise is now done as in the first patch above.
>>>> this is only a debug message and will be removed soon)
>>>>
>>>>
>>>> PPS: for me it seems that there is a missing 'link' from WM5102 to the
>>>> sst-acpi 80860F28:00 device, which complaints NOW / the first time
>>>> with the three patches applied on top on master.... will have a look
>>>> into it.
>>>>
>>>> I hope I got this device working with some more help from you.
>>>>
>>>> cheers
>>>> chris
>>>>
>>>>
>>>>
>>>> _______________________________________________
>>>> Alsa-devel mailing list
>>>> Alsa-devel@alsa-project.org
>>>> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>>>>
>>
