From: Christian Hartmann <cornogle@googlemail.com>
Subject: Re: [WM5102/ARIZONA] spi driver needs to support ACPI
Date: Tue, 19 May 2015 15:39:59 +0200
Message-ID: <CAKor6TfK_m2LLAKsCwaHq47wQCfK_g6ps_tAWr5CRVqnbfsrNw@mail.gmail.com>
References: <CAKor6TdtBEf9cN-EFw0BpRd4EbAKYXgfWh_PbSiG5=EhC1peew@mail.gmail.com>
 <555A1357.3090905@linux.intel.com>
 <CAKor6TerixSeaVYUs6uprcPwUvoNkkPhHx8Ap9apTbPW+1o4aA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001a113b37445e68c205166f72a0
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qk0-f175.google.com (mail-qk0-f175.google.com
 [209.85.220.175])
 by alsa0.perex.cz (Postfix) with ESMTP id 92DD426528B
 for <alsa-devel@alsa-project.org>; Tue, 19 May 2015 15:40:02 +0200 (CEST)
Received: by qkgw4 with SMTP id w4so9465266qkg.3
 for <alsa-devel@alsa-project.org>; Tue, 19 May 2015 06:40:00 -0700 (PDT)
In-Reply-To: <CAKor6TerixSeaVYUs6uprcPwUvoNkkPhHx8Ap9apTbPW+1o4aA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--001a113b37445e68c205166f72a0
Content-Type: text/plain; charset=UTF-8

Hi,

at the moment I am totally confused. I thought adding an ACPI ID is
trivial, but it is not.

I have again a null pointer exception in arizona_spi_probe()

could it be with the new num_chipselect value in spi-pxa2xx.c ??
I attach the trace of the last try

Any hints or tips are welcome.

cheers
chris

2015-05-19 11:04 GMT+02:00 Christian Hartmann <cornogle@googlemail.com>:
> Hi,
>
> so the ACPI id string, which I want to add to arizona-spi.c should be
>
> WM510205 ??
>
> I have changed the ACPI string to
>
> {"WM510205", WM5102},
>
> now and give it a try.
>
> cheers
> chris
>
> 2015-05-18 18:29 GMT+02:00 Pierre-Louis Bossart
> <pierre-louis.bossart@linux.intel.com>:
>> On 5/15/15 4:16 AM, Christian Hartmann wrote:
>>>
>>> Hi list,
>>>
>>>
>>> I need ACPI support for the arizona-core / arizona-spi driver for the
>>> ACPI ID WM5102.
>>> This audio codec is build into the Lenovo Yoga 851F. This device is a
>>> 32Bit (UEFI) system
>>>
>>>
>>> http://support.lenovo.com/de/de/products/tablets/yoga-series/yoga-tablet-2-851
>>>
>>>
>>> I have tested with vanilla kernels from kernel.org 3.19.y ,4.0.y and
>>> master (from torvalds) currently its 4.1.0-rc3. As distribution I am
>>> working with Fedora / Fedlet was the initial install image.
>>>
>>> With all vanilla kernels I got at first an error message from spi32766:
>>>
>>> [ 0.296297] pxa2xx-spi 80860F0E:00: cs1 >= max 1
>>> [ 0.296311] spi_master spi32766: failed to add SPI device
>>> WM510205:00 from ACPI
>>>
>>> so I have at first patched as suggested by broonie the arizona-core
>>>
>>> commit 48203a0fede057d6a8c5f6872c53326395350f45
>>> Author: somebody anybody <somebody@foobar.com>
>>> Date:   Mon May 11 13:35:43 2015 +0200
>>>
>>>      spi-pxa2xx : raise chipselect
>>>
>>>      Signed-off-by: somebody anybody <somebody@foobar.com>
>>>
>>> diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
>>> index e3223ac..9c919ea 100644
>>> --- a/drivers/spi/spi-pxa2xx.c
>>> +++ b/drivers/spi/spi-pxa2xx.c
>>> @@ -1279,7 +1279,7 @@ pxa2xx_spi_acpi_get_pdata(struct platform_device
>>> *pdev)
>>>          if (adev->pnp.unique_id && !kstrtoint(adev->pnp.unique_id, 0,
>>> &devid))
>>>                  ssp->port_id = devid;
>>>
>>> -       pdata->num_chipselect = 1;
>>> +       pdata->num_chipselect = 20;
>>>          pdata->enable_dma = true;
>>>
>>>          return pdata;
>>>
>>> This leds the spi master do the further ACPI configuration and inital
>>> setup for the arizona-spi device, but adding the ACPI ID to it
>>> does not work yet as expected:
>>>
>>> The current last patchset on top of master is
>>>
>>>
>>> Author: somebody anybody <somebody@foobar.com>
>>> Date:   Wed May 13 11:36:25 2015 +0200
>>>
>>>      arizona : added ACPI id of wm5102 to SPI driver, too
>>>
>>>      Signed-off-by: somebody anybody <somebody@foobar.com>
>>>
>>> diff --git a/drivers/mfd/arizona-spi.c b/drivers/mfd/arizona-spi.c
>>> index 1e845f6..c19a4c1 100644
>>> --- a/drivers/mfd/arizona-spi.c
>>> +++ b/drivers/mfd/arizona-spi.c
>>> @@ -17,6 +17,7 @@
>>>   #include <linux/regulator/consumer.h>
>>>   #include <linux/slab.h>
>>>   #include <linux/spi/spi.h>
>>> +#include <linux/acpi.h>
>>>   #include <linux/of.h>
>>>
>>>   #include <linux/mfd/arizona/core.h>
>>> @@ -82,6 +83,15 @@ static int arizona_spi_remove(struct spi_device *spi)
>>>          return 0;
>>>   }
>>>
>>> +#ifdef CONFIG_ACPI
>>> +static struct acpi_device_id wm5102_acpi_match[] = {
>>> +               { "WM5102", 0},
>>> +               { "WM510205", 0},
>>> +               { },
>>> +};
>>> +MODULE_DEVICE_TABLE(acpi, wm5102_acpi_match);
>>> +#endif
>>> +
>>>   static const struct spi_device_id arizona_spi_ids[] = {
>>>          { "wm5102", WM5102 },
>>>          { "wm5110", WM5110 },
>>> @@ -96,6 +106,9 @@ static struct spi_driver arizona_spi_driver = {
>>>                  .owner  = THIS_MODULE,
>>>                  .pm     = &arizona_pm_ops,
>>>                  .of_match_table = of_match_ptr(arizona_of_match),
>>> +#ifdef CONFIG_ACPI
>>> +               .acpi_match_table = ACPI_PTR(wm5102_acpi_match),
>>> +#endif
>>>          },
>>>          .probe          = arizona_spi_probe,
>>>          .remove         = arizona_spi_remove,
>>>
>>>
>>>
>>>
>>> commit 268e21d29c942205e40f749c6d71c77839dc67da
>>> Author: somebody anybody <somebody@foobar.com>
>>> Date:   Wed May 13 11:36:04 2015 +0200
>>>
>>>      arizona : added ACPI id of wm5102 to i2c driver
>>>
>>>      Signed-off-by: somebody anybody <somebody@foobar.com>
>>>
>>> diff --git a/drivers/mfd/arizona-i2c.c b/drivers/mfd/arizona-i2c.c
>>> index ff782a5..45ece1b 100644
>>> --- a/drivers/mfd/arizona-i2c.c
>>> +++ b/drivers/mfd/arizona-i2c.c
>>> @@ -18,6 +18,7 @@
>>>   #include <linux/regulator/consumer.h>
>>>   #include <linux/slab.h>
>>>   #include <linux/of.h>
>>> +#include <linux/acpi.h>
>>>
>>>   #include <linux/mfd/arizona/core.h>
>>>
>>> @@ -85,6 +86,15 @@ static int arizona_i2c_remove(struct i2c_client *i2c)
>>>          return 0;
>>>   }
>>>
>>> +#ifdef CONFIG_ACPI
>>> +static struct acpi_device_id wm5102_acpi_match[] = {
>>> +               { "WM5102", 0},
>>> +               { "WM510205", 0},
>>> +               { },
>>
>>
>> Those IDs don't really look like ACPI ones? Isn't there a rule that the _HID
>> is represented by a 4-letter vendor ID followed by part ID? see
>> http://www.uefi.org/PNP_ACPI_Registry
>>
>>
>>> +};
>>> +MODULE_DEVICE_TABLE(acpi, wm5102_acpi_match);
>>> +#endif
>>> +
>>>   static const struct i2c_device_id arizona_i2c_id[] = {
>>>          { "wm5102", WM5102 },
>>>          { "wm5110", WM5110 },
>>> @@ -100,6 +110,9 @@ static struct i2c_driver arizona_i2c_driver = {
>>>                  .owner  = THIS_MODULE,
>>>                  .pm     = &arizona_pm_ops,
>>>                  .of_match_table = of_match_ptr(arizona_of_match),
>>> +#ifdef CONFIG_ACPI
>>> +               .acpi_match_table = ACPI_PTR(wm5102_acpi_match),
>>> +#endif
>>>          },
>>>          .probe          = arizona_i2c_probe,
>>>          .remove         = arizona_i2c_remove,
>>>
>>>
>>>
>>> with these two patches the local master branch compiles fine, but at
>>> initialzing the arizona-spi driver gots a NULL pointer exception.
>>>
>>> I attach the whole dmesg of 4.1.0-rc3 (build 4.1.0.24-rc3).
>>>
>>> I need some assistance or hints to the right direction, I am looking
>>> myself and I also try what I can, but I think it would be easy peasy
>>> with some experts like here on this list :)
>>>
>>>
>>> PS: the message : spi_master spi32766: raised num_chipselect to 20 for
>>> WM510205:00
>>>
>>> is a dev_err() line added to the function static acpi_status
>>> acpi_spi_add_device(), there I had raised the num_chipselect first
>>> (that was wrong, the raise is now done as in the first patch above.
>>> this is only a debug message and will be removed soon)
>>>
>>>
>>> PPS: for me it seems that there is a missing 'link' from WM5102 to the
>>> sst-acpi 80860F28:00 device, which complaints NOW / the first time
>>> with the three patches applied on top on master.... will have a look
>>> into it.
>>>
>>> I hope I got this device working with some more help from you.
>>>
>>> cheers
>>> chris
>>>
>>>
>>>
>>> _______________________________________________
>>> Alsa-devel mailing list
>>> Alsa-devel@alsa-project.org
>>> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>>>
>>
>
>
>
> --
> --
> ......oooO..............
> .....(....).....Oooo...
> ......)../.....(....)....
> .....(_/.......)../.....
> ...............(_/.......
> ... I WAS ..............
> .......... HERE...... ;)



-- 
--
......oooO..............
.....(....).....Oooo...
......)../.....(....)....
.....(_/.......)../.....
...............(_/.......
... I WAS ..............
.......... HERE...... ;)

--001a113b37445e68c205166f72a0
Content-Type: text/plain; charset=US-ASCII; name="bug.txt"
Content-Disposition: attachment; filename="bug.txt"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_i9vd6w8p0

WyAgICA1Ljc3MjIxNl0gQlVHOiB1bmFibGUgdG8gaGFuZGxlIGtlcm5lbCBOVUxMIHBvaW50ZXIg
ZGVyZWZlcmVuY2UgYXQgMDAwMDAwMjAKWyAgICA1Ljc3OTYyNV0gSVA6IFs8ZjdlOWEwNDM+XSBh
cml6b25hX3NwaV9wcm9iZSsweDIzLzB4ZjQgW2FyaXpvbmFfc3BpXQpbICAgIDUuNzg3MDE2XSAq
cGRlID0gMDAwMDAwMDAgClsgICAgNS43OTQzNTFdIE9vcHM6IDAwMDAgWyMxXSBTTVAgClsgICAg
NS44MDE2NjhdIE1vZHVsZXMgbGlua2VkIGluOiBpbnQzNDAzX3RoZXJtYWwoKykgaW50MzQwMF90
aGVybWFsKCspIGFjcGlfdGhlcm1hbF9yZWwgYXJpem9uYV9zcGkoKykgaW50MzQweF90aGVybWFs
X3pvbmUgcHdtX2xwc3NfcGxhdGZvcm0gcmZraWxsX2dwaW8gcHdtX2xwc3MgYXJpem9uYV9pMmMg
c25kX3NvY19zc3RfYWNwaSBpMmNfZGVzaWdud2FyZV9wbGF0Zm9ybSgrKSBhY3BpX3BhZCByZmtp
bGwgaTJjX2Rlc2lnbndhcmVfY29yZSBheDg4MTc5XzE3OGEgdXNibmV0IG1paQpbICAgIDUuODE3
MTI0XSBDUFU6IDEgUElEOiA0MjkgQ29tbTogc3lzdGVtZC11ZGV2ZCBOb3QgdGFpbnRlZCA0LjEu
MC4yOC1yYzQgIzEzNwpbICAgIDUuODI0OTQ0XSBIYXJkd2FyZSBuYW1lOiBMRU5PVk8gNjAwNzIv
SU5WQUxJRCwgQklPUyAwMldUMThXVyAwOC8wMS8yMDE0ClsgICAgNS44MzI4MjJdIHRhc2s6IGY0
MWY4MDAwIHRpOiBmNDEzNjAwMCB0YXNrLnRpOiBmNDEzNjAwMApbICAgIDUuODQwNjk1XSBFSVA6
IDAwNjA6WzxmN2U5YTA0Mz5dIEVGTEFHUzogMDAwMTAyNDYgQ1BVOiAxClsgICAgNS44NDg1NzJd
IEVJUCBpcyBhdCBhcml6b25hX3NwaV9wcm9iZSsweDIzLzB4ZjQgW2FyaXpvbmFfc3BpXQpbICAg
IDUuODU2NDU2XSBFQVg6IDAwMDAwMDAwIEVCWDogZjRiYmI4MDAgRUNYOiBmN2U5YzAxMCBFRFg6
IGY3ZTliMGM4ClsgICAgNS44NjQzNzVdIEVTSTogMDAwMDAwMDAgRURJOiBmN2U5YzAwMCBFQlA6
IGY0MTM3Y2U4IEVTUDogZjQxMzdjY2MKWyAgICA1Ljg3MjI3Nl0gIERTOiAwMDdiIEVTOiAwMDdi
IEZTOiAwMGQ4IEdTOiAwMGUwIFNTOiAwMDY4ClsgICAgNS44ODAxODddIENSMDogODAwNTAwMzMg
Q1IyOiAwMDAwMDAyMCBDUjM6IDM2ZDlhMDAwIENSNDogMDAxMDA3ZDAKWyAgICA1Ljg4ODEzNF0g
U3RhY2s6ClsgICAgNS44OTYwMjNdICBmNDEzN2NlMCBjMDc0NDE5MiBmNGJiYjgwMCBmNGJiYjgw
MCAwMDAwMDAwMCBmNGJiYjgwMCBmN2U5YzAwMCBmNDEzN2NmYwpbICAgIDUuOTA0MDkwXSAgYzA5
MWI1MzQgZjRiYmI4MDAgZjdlOWMwMTAgMDAwMDAwMDAgZjQxMzdkMzAgYzA4YTE1NmEgZjdlOWMw
NjAgZjdlOWMwMTAKWyAgICA1LjkxMjIyN10gIGY0MTM3ZDFjIGMwNzQ2NWU3IDY2NmI5NjQ3IGY0
YmJiODM0IDAwMDAwMDE0IGY0YmJiODM0IGY0YmJiODAwIGY3ZTljMDEwClsgICAgNS45MjA0MDdd
IENhbGwgVHJhY2U6ClsgICAgNS45Mjg1MTBdICBbPGMwNzQ0MTkyPl0gPyBhY3BpX2Rldl9wbV9h
dHRhY2grMHg1Ny8weDc5ClsgICAgNS45MzY2NjZdICBbPGMwOTFiNTM0Pl0gc3BpX2Rydl9wcm9i
ZSsweDM0LzB4NjAKWyAgICA1Ljk0NDgzNl0gIFs8YzA4YTE1NmE+XSBkcml2ZXJfcHJvYmVfZGV2
aWNlKzB4MWJhLzB4NDAwClsgICAgNS45NTMwNDFdICBbPGMwNzQ2NWU3Pl0gPyBhY3BpX2RyaXZl
cl9tYXRjaF9kZXZpY2UrMHgzNi8weDNmClsgICAgNS45NjEyNzVdICBbPGMwOGExODYxPl0gX19k
cml2ZXJfYXR0YWNoKzB4NzEvMHg4MApbICAgIDUuOTY5NTEyXSAgWzxjMDhhMTdmMD5dID8gX19k
ZXZpY2VfYXR0YWNoKzB4NDAvMHg0MApbICAgIDUuOTc3NzQ4XSAgWzxjMDg5ZjgyNz5dIGJ1c19m
b3JfZWFjaF9kZXYrMHg1Ny8weGEwClsgICAgNS45ODU5OTVdICBbPGMwOGEwZjRlPl0gZHJpdmVy
X2F0dGFjaCsweDFlLzB4MjAKWyAgICA1Ljk5NDIzNF0gIFs8YzA4YTE3ZjA+XSA/IF9fZGV2aWNl
X2F0dGFjaCsweDQwLzB4NDAKWyAgICA2LjAwMjQ3Nl0gIFs8YzA4YTBiOTc+XSBidXNfYWRkX2Ry
aXZlcisweDE1Ny8weDIzMApbICAgIDYuMDEwNzE1XSAgWzxmN2U5ZjAwMD5dID8gMHhmN2U5ZjAw
MApbICAgIDYuMDE4OTMyXSAgWzxmN2U5ZjAwMD5dID8gMHhmN2U5ZjAwMApbICAgIDYuMDI3MTQ2
XSAgWzxjMDhhMWY2OT5dIGRyaXZlcl9yZWdpc3RlcisweDU5LzB4ZTAKWyAgICA2LjAzNTQyMF0g
IFs8YzA2ZDM4MjA+XSA/IGt2YXNwcmludGYrMHg0MC8weDUwClsgICAgNi4wNDM2OTVdICBbPGMw
OTFiNGIxPl0gc3BpX3JlZ2lzdGVyX2RyaXZlcisweDQxLzB4NTAKWyAgICA2LjA1MTk5MV0gIFs8
ZjdlOWYwMGQ+XSBhcml6b25hX3NwaV9kcml2ZXJfaW5pdCsweGQvMHgxMDAwIFthcml6b25hX3Nw
aV0KWyAgICA2LjA2MDM2MF0gIFs8YzA0MDA0NzI+XSBkb19vbmVfaW5pdGNhbGwrMHhjMi8weDFm
MApbICAgIDYuMDY4NzI4XSAgWzxmN2U5ZjAwMD5dID8gMHhmN2U5ZjAwMApbICAgIDYuMDc3MDg0
XSAgWzxjMDUyYjNiMz5dID8gZnJlZV9wYWdlc19wcmVwYXJlKzB4MWMzLzB4MzYwClsgICAgNi4w
ODU0ODJdICBbPGMwNTY5ZDdkPl0gPyBrbWVtX2NhY2hlX2FsbG9jX3RyYWNlKzB4MTdkLzB4MWUw
ClsgICAgNi4wOTM4NzhdICBbPGMwNTY5NGJmPl0gPyBrZnJlZSsweGNmLzB4MTAwClsgICAgNi4x
MDIyNDBdICBbPGMwYjJlM2RlPl0gPyBkb19pbml0X21vZHVsZSsweDI0LzB4MWFlClsgICAgNi4x
MTA1NjNdICBbPGMwYjJlNDBkPl0gZG9faW5pdF9tb2R1bGUrMHg1My8weDFhZQpbICAgIDYuMTE4
ODIzXSAgWzxjMDRjNGVlND5dIGxvYWRfbW9kdWxlKzB4MTAzNC8weDE2YjAKWyAgICA2LjEyNzAx
Nl0gIFs8YzA0YzFlZjk+XSA/IGNvcHlfbW9kdWxlX2Zyb21fZmQuaXNyYS40OCsweDEwOS8weDFh
MApbICAgIDYuMTM1MjgxXSAgWzxjMDRjNTc0ZD5dIFN5U19maW5pdF9tb2R1bGUrMHg4ZC8weGQw
ClsgICAgNi4xNDM1NDVdICBbPGMwNTNmMTQzPl0gPyB2bV9tbWFwX3Bnb2ZmKzB4OTMvMHhiMApb
ICAgIDYuMTUxODEzXSAgWzxjMGIzYjM4Zj5dIHN5c2VudGVyX2RvX2NhbGwrMHgxMi8weDEyClsg
ICAgNi4xNjAwOTddIENvZGU6IDAwIDAwIDhkIGJmIDAwIDAwIDAwIDAwIDU1IDg5IGU1IDU3IDU2
IDUzIDgzIGVjIDEwIDNlIDhkIDc0IDI2IDAwIDg5IGMzIGU4IGRiIDIzIGE4IGM4IDg1IGRiIDg5
IGM2IDc0IDM1IDhiIDgzIDcwIDAxIDAwIDAwIDg1IGMwIDw4Yj4gNDYgMjAgNzQgMmIgODkgNDQg
MjQgMDggYzcgNDQgMjQgMDQgMjQgYjAgZTkgZjcgODkgMWMgMjQgZTgKWyAgICA2LjE3NzU5N10g
RUlQOiBbPGY3ZTlhMDQzPl0gYXJpem9uYV9zcGlfcHJvYmUrMHgyMy8weGY0IFthcml6b25hX3Nw
aV0gU1M6RVNQIDAwNjg6ZjQxMzdjY2MKWyAgICA2LjE4NjI5OF0gQ1IyOiAwMDAwMDAwMDAwMDAw
MDIwClsgICAgNi45OTg3MjBdIGludGVsX3NzdF9hY3BpIDgwODYwRjI4OjAwOiBObyBtYXRjaGlu
ZyBtYWNoaW5lIGRyaXZlciBmb3VuZAo=
--001a113b37445e68c205166f72a0
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--001a113b37445e68c205166f72a0--
