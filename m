From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: Support two wm8962 codec in i.mx6 board.
Date: Tue, 17 Mar 2015 11:00:07 -0700
Message-ID: <20150317180006.GA5336@Asurada>
References: <CAOaGyfUHS90nKcSxpQZm7X3Lgwtb_9V4xLzyObhd5v=diGHJLw@mail.gmail.com>
 <20150317005503.GA5480@Asurada-GSX>
 <CAOaGyfUBoQLpa0YZjKEtZXmhRL_p=zGq3XEJ9oZHbHrVr1SQ8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f46.google.com (mail-pa0-f46.google.com
 [209.85.220.46])
 by alsa0.perex.cz (Postfix) with ESMTP id 4786626501B
 for <alsa-devel@alsa-project.org>; Tue, 17 Mar 2015 19:00:16 +0100 (CET)
Received: by pacwe9 with SMTP id we9so16265358pac.1
 for <alsa-devel@alsa-project.org>; Tue, 17 Mar 2015 11:00:15 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAOaGyfUBoQLpa0YZjKEtZXmhRL_p=zGq3XEJ9oZHbHrVr1SQ8w@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Shawn Embedded <programassem@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Mar 17, 2015 at 09:51:22AM +0800, Shawn Embedded wrote:

>    Actually I donot know much about dai-link. I just got started
> recently to working on this requirement.
>    You mean to create the same platform device as the now-working one
> in board-xxx.c. Sure I can do that.

Are you using old kernel version that's not included Device Tree yet?

If so, yes, you need to add a similar platform device as the original
one but you need to assign a different AUDMUX port.

>    Since the two wm8962 codecs are on different I2C buses, so I just
> need to update the corresponding i2c's i2c_board_info structure to
> support the second one as a I2C device?

Exactly.

> > Supposing two WM8962 chips on one board, there should be two WM8962
> > nodes hanging to the I2C node with different I2C slave addresses.
> 
>   Yes, but the I2C slave addresses should be the same, IIRC, only on
> different I2C buses.

No problem for this. You can use same slave address but connecting to
different I2C buses. As long as you system probes two different CODECs,
that's fine.

>   What do you mean by "two wm8962 nodes" ?

If you are not using code from Linux Mainline, just forget about it.

>   In my experience, the corresponding files are board-xxx.c,
> imx-wm8962.c, wm8962.c.
> 
>   I looked at the wm8962.c, which is the codec driver file, very independent.
>   There comes the wm8962_i2c_probe() and wm8962_probe().
>   In wm8962_i2c_probe(), snd_soc_register_codec() is called, so a new
> codec structure will be created when there comes another i2c device
> named "wm8962".
>   Seems no need to change anything in wm8962.c, if the external
> hardware signals of the second wm8962 are connected in the same way as
> the first now-working one, right?

No, you don't need to. Just register it in the board level driver.

>   Do you think any changes should be made to imx-wm8962.c which is the
> machine driver file for wm8962 on imx6?

Ideally, You only need to append a new platform device in the board
level driver, same as you do for WM8962 CODECs.

> static struct snd_soc_dai_link imx_dai[] = {
> {
> .name = "HiFi",
> .stream_name = "HiFi",
> .codec_dai_name = "wm8962",
> .codec_name = "wm8962.0-001a",
> .cpu_dai_name = "imx-ssi.1",
> .platform_name = "imx-pcm-audio.1",
> .init = imx_wm8962_init,
> .ops = &imx_hifi_ops,
> },
> };

Okay...this one looks like you are using an old version BSP, other
than the code from Linux Mainline.

> in imx-wm8962.c, should I copy them to create a new copy of them
> respectively? Or no need to do this?

In this case, yes, because the structure has hard code. Otherwise,
you new dai-link will not be successfully connected.

> In board-xxx.c, do I just need to copy declarations related to wm8962?
> Is that enough?

I think so.

>   Again, could you tell me how to make two different dai-link nodes?
>   Sorry for knowing not much about this.

That's for Device Tree which you are not using.

Nicolin
