From: Manuel Lauss <manuel.lauss@googlemail.com>
Subject: Re: [PATCH V2 1/2] ALSA: Alchemy AC97C/I2SC audio
	support
Date: Fri, 22 Jul 2011 08:54:00 +0200
Message-ID: <CAOLZvyGxPB1oCKg4BtvBjiuKTb=8urq6L8YQHYbMfmQQigo0kA@mail.gmail.com>
References: <1311266050-22199-1-git-send-email-manuel.lauss@googlemail.com>
	<1311266050-22199-2-git-send-email-manuel.lauss@googlemail.com>
	<4E28BC1F.50804@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <4E28BC1F.50804@metafoo.de>
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

On Fri, Jul 22, 2011 at 1:54 AM, Lars-Peter Clausen <lars@metafoo.de> wrote:
>> diff --git a/sound/soc/au1x/db1000.c b/sound/soc/au1x/db1000.c
>> + =A0 =A0 ret =3D -ENOMEM;
>> + =A0 =A0 db1000_asoc97_dev =3D platform_device_alloc("soc-audio", 0);
>
> New drivers shouldn't user soc-audio anymore, just register a normal plat=
form
> device driver.

Can you point to an example of the new way?


>> diff --git a/sound/soc/au1x/dma.c b/sound/soc/au1x/dma.c
>> new file mode 100644
>> index 0000000..0f7d90a
>> --- /dev/null
>> +++ b/sound/soc/au1x/dma.c
>> @@ -0,0 +1,470 @@
>> [...]
>> +
>> +static struct platform_driver alchemy_ac97pcm_driver =3D {
>> + =A0 =A0 .driver =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =3D AC97C_DMANAME,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .owner =A0=3D THIS_MODULE,
>> + =A0 =A0 },
>> + =A0 =A0 .probe =A0 =A0 =A0 =A0 =A0=3D alchemy_pcm_drvprobe,
>> + =A0 =A0 .remove =A0 =A0 =A0 =A0 =3D __devexit_p(alchemy_pcm_drvremove),
>> +};
>> +
>> +static struct platform_driver alchemy_i2spcm_driver =3D {
>> + =A0 =A0 .driver =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =3D I2SC_DMANAME,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .owner =A0=3D THIS_MODULE,
>> + =A0 =A0 },
>> + =A0 =A0 .probe =A0 =A0 =A0 =A0 =A0=3D alchemy_pcm_drvprobe,
>> + =A0 =A0 .remove =A0 =A0 =A0 =A0 =3D __devexit_p(alchemy_pcm_drvremove),
>> +};
>
> You shouldn't really have to register two identical drivers for this. If =
you
> really want to be able to instantiate the driver with two different names=
 use
> platform_device_id. But in my opinion it should be enough to just have one
> generic name, since there is nothing AC97 or I2S specific in this driver.

I need a unique name for the DMA device in soc_dai_link.  This was the
easiest way. Especially since both ac97 and i2s can be active at
runtime.


>> [...]
>> +
>> +struct platform_device *alchemy_pcm_add(struct platform_device *pdev, i=
nt type)
>> +{
> + =A0 =A0 =A0 struct resource *res, *r;
> + =A0 =A0 =A0 struct platform_device *pd;
> + =A0 =A0 =A0 char *pdevname;
> + =A0 =A0 =A0 int id[2];
> + =A0 =A0 =A0 int ret;
> +
> + =A0 =A0 =A0 r =3D platform_get_resource(pdev, IORESOURCE_DMA, 0);
> + =A0 =A0 =A0 if (!r)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return NULL;
> + =A0 =A0 =A0 id[0] =3D r->start;
> +
> + =A0 =A0 =A0 r =3D platform_get_resource(pdev, IORESOURCE_DMA, 1);
> + =A0 =A0 =A0 if (!r)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return NULL;
> + =A0 =A0 =A0 id[1] =3D r->start;
> +
> + =A0 =A0 =A0 res =3D kzalloc(sizeof(struct resource) * 2, GFP_KERNEL);
> + =A0 =A0 =A0 if (!res)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return NULL;
> +
> + =A0 =A0 =A0 res[0].start =3D res[0].end =3D id[0];
> + =A0 =A0 =A0 res[1].start =3D res[1].end =3D id[1];
> + =A0 =A0 =A0 res[0].flags =3D res[1].flags =3D IORESOURCE_DMA;
> +
> + =A0 =A0 =A0 /* "alchemy-pcm-ac97" or "alchemy-pcm-i2s" */
> + =A0 =A0 =A0 pdevname =3D (type =3D=3D 0) ? AC97C_DMANAME : I2SC_DMANAME;
> + =A0 =A0 =A0 pd =3D platform_device_alloc(pdevname, -1);
> + =A0 =A0 =A0 if (!pd)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> +
> + =A0 =A0 =A0 pd->resource =3D res;
> + =A0 =A0 =A0 pd->num_resources =3D 2;
> +
> + =A0 =A0 =A0 ret =3D platform_device_add(pd);
> + =A0 =A0 =A0 if (!ret)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return pd;
> +
> + =A0 =A0 =A0 platform_device_put(pd);
> +out:
> + =A0 =A0 =A0 kfree(res);
> + =A0 =A0 =A0 return NULL;
>> +}
>
> This function looks a bit fishy. The pcm driver should be registered by t=
he
> platform code file as well. If you need different DMA regions for I2C and=
 AC97
> use snd_soc_dai_set_dma_data and snd_soc_dai_get_dma_data to pass them to=
 the
> PCM driver from the I2S or AC97 driver.

I like to pass the DMA id's along with the ac97/i2s resource
information (since they
belong together anyway). As an added benefit I get a sensibly named dma dev=
ice
with the correct DMA information, all by simply registering the ac97
platform device.

I'll think about a way to change it.


Thank you!
      Manuel Lauss
