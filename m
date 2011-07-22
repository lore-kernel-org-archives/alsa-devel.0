From: Manuel Lauss <manuel.lauss@googlemail.com>
Subject: Re: [PATCH V2 1/2] ALSA: Alchemy AC97C/I2SC audio
	support
Date: Fri, 22 Jul 2011 09:56:28 +0200
Message-ID: <CAOLZvyHfe+a694NKPt2+_PGtw_8JAAsvksFH=HFBYfSZ6odTMg@mail.gmail.com>
References: <1311266050-22199-1-git-send-email-manuel.lauss@googlemail.com>
	<1311266050-22199-2-git-send-email-manuel.lauss@googlemail.com>
	<4E28BC1F.50804@metafoo.de>
	<CAOLZvyGxPB1oCKg4BtvBjiuKTb=8urq6L8YQHYbMfmQQigo0kA@mail.gmail.com>
	<4E292984.5020708@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <4E292984.5020708@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Linux-MIPS <linux-mips@linux-mips.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Jul 22, 2011 at 9:40 AM, Lars-Peter Clausen <lars@metafoo.de> wrote:
> On 07/22/2011 08:54 AM, Manuel Lauss wrote:
>> On Fri, Jul 22, 2011 at 1:54 AM, Lars-Peter Clausen <lars@metafoo.de> wr=
ote:
>>>> diff --git a/sound/soc/au1x/db1000.c b/sound/soc/au1x/db1000.c
>>>> + =A0 =A0 ret =3D -ENOMEM;
>>>> + =A0 =A0 db1000_asoc97_dev =3D platform_device_alloc("soc-audio", 0);
>>>
>>> New drivers shouldn't user soc-audio anymore, just register a normal pl=
atform
>>> device driver.
>>
>> Can you point to an example of the new way?
>>
>
> sound/soc/samsung/speyside.c

Thanks,



>>>> diff --git a/sound/soc/au1x/dma.c b/sound/soc/au1x/dma.c
>>>> new file mode 100644
>>>> index 0000000..0f7d90a
>>>> --- /dev/null
>>>> +++ b/sound/soc/au1x/dma.c
>>>> @@ -0,0 +1,470 @@
>>>> [...]
>>>> +
>>>> +static struct platform_driver alchemy_ac97pcm_driver =3D {
>>>> + =A0 =A0 .driver =3D {
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =3D AC97C_DMANAME,
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 .owner =A0=3D THIS_MODULE,
>>>> + =A0 =A0 },
>>>> + =A0 =A0 .probe =A0 =A0 =A0 =A0 =A0=3D alchemy_pcm_drvprobe,
>>>> + =A0 =A0 .remove =A0 =A0 =A0 =A0 =3D __devexit_p(alchemy_pcm_drvremov=
e),
>>>> +};
>>>> +
>>>> +static struct platform_driver alchemy_i2spcm_driver =3D {
>>>> + =A0 =A0 .driver =3D {
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =3D I2SC_DMANAME,
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 .owner =A0=3D THIS_MODULE,
>>>> + =A0 =A0 },
>>>> + =A0 =A0 .probe =A0 =A0 =A0 =A0 =A0=3D alchemy_pcm_drvprobe,
>>>> + =A0 =A0 .remove =A0 =A0 =A0 =A0 =3D __devexit_p(alchemy_pcm_drvremov=
e),
>>>> +};
>>>
>>> You shouldn't really have to register two identical drivers for this. I=
f you
>>> really want to be able to instantiate the driver with two different nam=
es use
>>> platform_device_id. But in my opinion it should be enough to just have =
one
>>> generic name, since there is nothing AC97 or I2S specific in this drive=
r.
>>
>> I need a unique name for the DMA device in soc_dai_link. =A0This was the
>> easiest way. Especially since both ac97 and i2s can be active at
>> runtime.
>
> If you want to instantiate two pcm drivers you can just give the devices
> different ids. As there is nothing I2C or AC97 specific in the pcm driver=
 it
> should not matter which one is used for what, if two devices are active a=
t the
> same time.
> Right now you need to know which one is which, because you instantiate the
> driver with either the I2C or AC97 DMA addresses, but if you use
> snd_soc_dai_get_dma_data as described below and pass the DMA address at r=
untime
> this issue will go away.

so instead of "alchemy-pcm-{ac97|i2s}" i'd have "alchemy-pcm.[01]". Not rea=
lly
much clearer in my book.  And I still need to know the correct suffix for
dai link.

Or am I missing something fundamentally?



>>>> [...]
>>>> +
>>>> +struct platform_device *alchemy_pcm_add(struct platform_device *pdev,=
 int type)
>>>> +{
>>> + =A0 =A0 =A0 struct resource *res, *r;
>>> + =A0 =A0 =A0 struct platform_device *pd;
>>> + =A0 =A0 =A0 char *pdevname;
>>> + =A0 =A0 =A0 int id[2];
>>> + =A0 =A0 =A0 int ret;
>>> +
>>> + =A0 =A0 =A0 r =3D platform_get_resource(pdev, IORESOURCE_DMA, 0);
>>> + =A0 =A0 =A0 if (!r)
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return NULL;
>>> + =A0 =A0 =A0 id[0] =3D r->start;
>>> +
>>> + =A0 =A0 =A0 r =3D platform_get_resource(pdev, IORESOURCE_DMA, 1);
>>> + =A0 =A0 =A0 if (!r)
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return NULL;
>>> + =A0 =A0 =A0 id[1] =3D r->start;
>>> +
>>> + =A0 =A0 =A0 res =3D kzalloc(sizeof(struct resource) * 2, GFP_KERNEL);
>>> + =A0 =A0 =A0 if (!res)
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return NULL;
>>> +
>>> + =A0 =A0 =A0 res[0].start =3D res[0].end =3D id[0];
>>> + =A0 =A0 =A0 res[1].start =3D res[1].end =3D id[1];
>>> + =A0 =A0 =A0 res[0].flags =3D res[1].flags =3D IORESOURCE_DMA;
>>> +
>>> + =A0 =A0 =A0 /* "alchemy-pcm-ac97" or "alchemy-pcm-i2s" */
>>> + =A0 =A0 =A0 pdevname =3D (type =3D=3D 0) ? AC97C_DMANAME : I2SC_DMANA=
ME;
>>> + =A0 =A0 =A0 pd =3D platform_device_alloc(pdevname, -1);
>>> + =A0 =A0 =A0 if (!pd)
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>>> +
>>> + =A0 =A0 =A0 pd->resource =3D res;
>>> + =A0 =A0 =A0 pd->num_resources =3D 2;
>>> +
>>> + =A0 =A0 =A0 ret =3D platform_device_add(pd);
>>> + =A0 =A0 =A0 if (!ret)
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return pd;
>>> +
>>> + =A0 =A0 =A0 platform_device_put(pd);
>>> +out:
>>> + =A0 =A0 =A0 kfree(res);
>>> + =A0 =A0 =A0 return NULL;
>>>> +}
>>>
>>> This function looks a bit fishy. The pcm driver should be registered by=
 the
>>> platform code file as well. If you need different DMA regions for I2C a=
nd AC97
>>> use snd_soc_dai_set_dma_data and snd_soc_dai_get_dma_data to pass them =
to the
>>> PCM driver from the I2S or AC97 driver.
>>
>> I like to pass the DMA id's along with the ac97/i2s resource
>> information (since they
>> belong together anyway). As an added benefit I get a sensibly named dma =
device
>> with the correct DMA information, all by simply registering the ac97
>> platform device.
>
> There is nothing wrong with passing the DMA ids along with the other AC97=
/I2C
> resources. At least for the AC97 and I2C driver. But the PCM driver shoul=
d use
> snd_soc_dai_get_dma_data to get the DMA addresses at runtime rather then =
during
> device instantiation. Take a look at how other platforms handle this.


The ac97/i2s units know they need dma and therefore register the
device themselves.
Having the board code register an "empty" dma device along with the
ac97/i2s devices
seems like a waste of code and a source of potential bugs.  I'll change my =
code.

Thank you!
        Manuel Lauss
