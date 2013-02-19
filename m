From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: ASoC: BeagleBoard driver development (PCM3168)
Date: Tue, 19 Feb 2013 12:10:06 +0100
Message-ID: <51235D8E.7040705@ti.com>
References: <CAGxc5aCJisVLrC09YsWAoh3U9_kKGKwFqiK4KM-u7JZ7SpW58w@mail.gmail.com>
 <5118F700.90006@ti.com>
 <CAGxc5aCZarD+-4EqSA9QZx_RvXRvJuGpKXtp=RiUPdcATuxFng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
 by alsa0.perex.cz (Postfix) with ESMTP id C58EF2651DC
 for <alsa-devel@alsa-project.org>; Tue, 19 Feb 2013 12:10:09 +0100 (CET)
In-Reply-To: <CAGxc5aCZarD+-4EqSA9QZx_RvXRvJuGpKXtp=RiUPdcATuxFng@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: wendelin klimann <wklimann@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 02/16/2013 01:05 PM, wendelin klimann wrote:
>     > I try to implement an PCM3168 audio codec from TI to the BeagleBoar=
d but
>     > actually i am stuck and it would be rally nice if one could help me=
 a
>     > little bit.
>     > My ALSA driver version is 1.0.24 and i use an 3.2.18 kernel.
>     > As a startingpoint i used the files

Is there any particular reason to use so ancient kernel and alsa-driver pac=
kage?

>     >     .codec_dai_name =3D "pcm3168-hifi",
>     >     .codec_name =3D "pcm3168-codec",
> =

>     codec name should be: pcm3168-codec.0
> =

> Thanks that helpt to get the (old machine-driver) driver to load correctl=
y and
> now i can start with the mcbsp and hardware-testing.

...

>     You should update you machine driver to use snd_soc_register_card() s=
ee other
>     machine drivers as example (omap-twl4030.c is in the same directory f=
or
>     example and it is really simple).
> =

> I took the omap3beagle.c (and the omap-twl4030.c with same results) file =
as
> template and adapted it. The driver can be compiled correctly but when i =
load
> it it is not inseting the corresponding codec (snd_soc_pcm3168.ko).
> Even if i load the snd_soc_pcm3168.ko driver manually and after load the
> snd_soc_pcm3168_soundcard.ko driver i do not find the soundcard and the c=
odec in:

I'm confused now. Previously you said it is working and now you are telling
that it is not...

> =

>  $/sys/kernel/debug/asoc$: ls
>        codecs       dais         omap3beagle      platforms
> =

>  $/sys/kernel/debug/asoc$: cat codecs
>        twl4030-codec      =


You do not have the codec loaded so the card is not going to come up.
What do you have in the kernel messages around this time?
Have you registered the platform device for your testing codec driver?


>     According to the datasheet the PCM3168 have I2C or SPI control interf=
ace. You
>     should have the driver as i2c/spi device so you can actually control =
it.
> =

> =

> As it is my first attempt to implement an audio codec i thought to start =
as
> simple as possible and do all the setup with the external pins and avoid =
to
> use the I2C or SPI at first. Of course i want to add it later on but i th=
ought
> it would be wise to test the hardware first.

The time to start the driver in a proper way will save you lots of time... =
You
don't need to write two drivers (platform driver for testing followed by a =
new
real driver).

-- =

P=E9ter
