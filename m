From: Shawn Embedded <programassem@gmail.com>
Subject: Re: Support two wm8962 codec in i.mx6 board.
Date: Tue, 17 Mar 2015 09:51:22 +0800
Message-ID: <CAOaGyfUBoQLpa0YZjKEtZXmhRL_p=zGq3XEJ9oZHbHrVr1SQ8w@mail.gmail.com>
References: <CAOaGyfUHS90nKcSxpQZm7X3Lgwtb_9V4xLzyObhd5v=diGHJLw@mail.gmail.com>
 <20150317005503.GA5480@Asurada-GSX>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f180.google.com (mail-ob0-f180.google.com
 [209.85.214.180])
 by alsa0.perex.cz (Postfix) with ESMTP id 0B9DC261A03
 for <alsa-devel@alsa-project.org>; Tue, 17 Mar 2015 02:51:24 +0100 (CET)
Received: by obbgg8 with SMTP id gg8so49693221obb.1
 for <alsa-devel@alsa-project.org>; Mon, 16 Mar 2015 18:51:23 -0700 (PDT)
In-Reply-To: <20150317005503.GA5480@Asurada-GSX>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello Nicolin,


On Tue, Mar 17, 2015 at 8:55 AM, Nicolin Chen <nicoleotsuka@gmail.com> wrote:
> Hi Shawn,
>
> On Mon, Mar 16, 2015 at 03:30:49PM +0800, Shawn Embedded wrote:
>
>>     Now there is a wm8962 on the i.mx6 board, running well, and we
>> want to add an extra wm8962 to the board, connected to i.mx6 on
>> another SSI port through a different i.mx6's AUDMUX port. The two
>> wm8962 will work independently completely, at the same time possiblly.
>
> I'm not sure if your requirement is to create another dai-link. But
> have you tried to simply add a new device node for the new dai-link?

   Actually I donot know much about dai-link. I just got started
recently to working on this requirement.
   You mean to create the same platform device as the now-working one
in board-xxx.c. Sure I can do that.
   Since the two wm8962 codecs are on different I2C buses, so I just
need to update the corresponding i2c's i2c_board_info structure to
support the second one as a I2C device?

>
> Supposing two WM8962 chips on one board, there should be two WM8962
> nodes hanging to the I2C node with different I2C slave addresses.

  Yes, but the I2C slave addresses should be the same, IIRC, only on
different I2C buses.
  This should be OK for I2C architecture.
  What do you mean by "two wm8962 nodes" ?

  In my experience, the corresponding files are board-xxx.c,
imx-wm8962.c, wm8962.c.

  I looked at the wm8962.c, which is the codec driver file, very independent.
  There comes the wm8962_i2c_probe() and wm8962_probe().
  In wm8962_i2c_probe(), snd_soc_register_codec() is called, so a new
codec structure will be created when there comes another i2c device
named "wm8962".
  Seems no need to change anything in wm8962.c, if the external
hardware signals of the second wm8962 are connected in the same way as
the first now-working one, right?

  Do you think any changes should be made to imx-wm8962.c which is the
machine driver file for wm8962 on imx6?

For

static struct platform_device *imx_snd_device;

and

static struct snd_soc_dai_link imx_dai[] = {
{
.name = "HiFi",
.stream_name = "HiFi",
.codec_dai_name = "wm8962",
.codec_name = "wm8962.0-001a",
.cpu_dai_name = "imx-ssi.1",
.platform_name = "imx-pcm-audio.1",
.init = imx_wm8962_init,
.ops = &imx_hifi_ops,
},
};

and

static struct snd_soc_card snd_soc_card_imx = {
.name = "wm8962-audio",
.dai_link = imx_dai,
.num_links = ARRAY_SIZE(imx_dai),
};

in imx-wm8962.c, should I copy them to create a new copy of them
respectively? Or no need to do this?

Or any changes you think I should make?

In board-xxx.c, do I just need to copy declarations related to wm8962?
Is that enough?

>
> So you may need two different dai-link nodes for each of the WM8962
> i2c nodes as well. And, of course, you need to specify different SSIs
> and different AUDMUX ports for two dai-link nodes.

  Again, could you tell me how to make two different dai-link nodes?
  Sorry for knowing not much about this.

>
> Then you will get two sound card in the system.
>
> Nicolin



Thank you.

--------------------
Best Regards,
Shawn
