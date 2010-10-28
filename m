From: Victor Rodriguez <vm.rod25@gmail.com>
Subject: Re: New SoC layer codec registration problem
Date: Thu, 28 Oct 2010 09:07:01 -0500
Message-ID: <AANLkTi=wCBkw7v7xMwbcf7F_qQSyD6zb=HTnqeD+EGHM@mail.gmail.com>
References: <1288257140.2098.41.camel@r60e>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
	[209.85.160.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 70692244C9
	for <alsa-devel@alsa-project.org>;
	Thu, 28 Oct 2010 16:07:05 +0200 (CEST)
Received: by gyg8 with SMTP id 8so1413495gyg.38
	for <alsa-devel@alsa-project.org>; Thu, 28 Oct 2010 07:07:02 -0700 (PDT)
In-Reply-To: <1288257140.2098.41.camel@r60e>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alexander <subaparts@yandex.ru>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Oct 28, 2010 at 4:12 AM, Alexander <subaparts@yandex.ru> wrote:
> I'm trying to implement new SoC codec in linux-next-20101025 kernel.
>
> Part of the code:
> ---
> #if defined(CONFIG_SPI_MASTER)
> static int __devinit cs4271_spi_probe(struct spi_device *spi)
> {
> =A0 =A0 =A0 =A0struct cs4271_private *cs4271;
> =A0 =A0 =A0 =A0int ret;
>
> =A0 =A0 =A0 =A0cs4271 =3D kzalloc(sizeof *cs4271, GFP_KERNEL);
> =A0 =A0 =A0 =A0if (!cs4271)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -ENOMEM;
>
> =A0 =A0 =A0 =A0spi_set_drvdata(spi, cs4271);
> =A0 =A0 =A0 =A0cs4271->control_data =3D spi;
> =A0 =A0 =A0 =A0cs4271->bus_type =3D SND_SOC_SPI;
>
> =A0 =A0 =A0 =A0ret =3D snd_soc_register_codec(&spi->dev, &soc_codec_dev_c=
s4271,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &=
cs4271_dai, 1);

Sorry for this maybe I am wrong but shouldn't this bee with {}
> =A0 =A0 =A0 =A0if (ret < 0) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0kfree(cs4271);
> =A0 =A0 =A0 =A0        return ret;
          }
Thanks

Victor Rodriguez

> }
>
> static int __devexit cs4271_spi_remove(struct spi_device *spi)
> {
> =A0 =A0 =A0 =A0snd_soc_unregister_codec(&spi->dev);
> =A0 =A0 =A0 =A0kfree(spi_get_drvdata(spi));
> =A0 =A0 =A0 =A0return 0;
> }
>
> static struct spi_driver cs4271_spi_driver =3D {
> =A0 =A0 =A0 =A0.driver =3D {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.name =A0 =3D "cs4271-codec",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.owner =A0=3D THIS_MODULE,
> =A0 =A0 =A0 =A0},
> =A0 =A0 =A0 =A0.probe =A0 =A0 =A0 =A0 =A0=3D cs4271_spi_probe,
> =A0 =A0 =A0 =A0.remove =A0 =A0 =A0 =A0 =3D __devexit_p(cs4271_spi_remove),
> };
> #endif /* defined(CONFIG_SPI_MASTER) */
> ---
>
> So, codec name I expect is "cs4271-codec", but codec registered with
> name "spi0.0"
>
> Here is boot log:
> ---
> Jan =A01 00:00:04 miniCio user.debug kernel: cs4271-codec spi0.0: codec
> register spi0.0
> Jan =A01 00:00:04 miniCio user.debug kernel: cs4271-codec spi0.0: dai
> register spi0.0 #1
> Jan =A01 00:00:04 miniCio user.debug kernel: Registered DAI 'cs4271-hifi'
> Jan =A01 00:00:04 miniCio user.debug kernel: Registered codec 'spi0.0'
> Jan =A01 00:00:04 miniCio user.info kernel: Codec driver for CS4271
> registered
> Jan =A01 00:00:04 miniCio user.debug kernel: ep93xx-pcm-audio
> ep93xx-pcm-audio: platform register ep93xx-pcm-audio
> Jan =A01 00:00:04 miniCio user.debug kernel: Registered platform
> 'ep93xx-pcm-audio'
> Jan =A01 00:00:04 miniCio user.debug kernel: ep93xx-i2s ep93xx-i2s: dai
> register ep93xx-i2s
> Jan =A01 00:00:04 miniCio user.debug kernel: Registered DAI 'ep93xx-i2s'
> Jan =A01 00:00:04 miniCio user.debug kernel: soc-audio soc-audio: binding
> CS4271 at idx 0
> Jan =A01 00:00:04 miniCio user.debug kernel: soc-audio soc-audio: CODEC
> cs4271-codec not registered
> Jan =A01 00:00:04 miniCio user.debug kernel: soc-audio soc-audio:
> Registered card 'EDB93XX'
> Jan =A01 00:00:04 miniCio user.info kernel: EDB93xx Machine ALSA Driver
> Jan =A01 00:00:04 miniCio user.info kernel: ALSA device list:
> Jan =A01 00:00:04 miniCio user.info kernel: =A0 No soundcards found.
> ---
>
> What am I doing wrong?
>
> Alexander.
>
>
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
