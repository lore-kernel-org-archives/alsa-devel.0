From: Shawn Embedded <programassem@gmail.com>
Subject: Re: Support two wm8962 codec in i.mx6 board.
Date: Wed, 18 Mar 2015 09:12:19 +0800
Message-ID: <CAOaGyfUk6LLkZhLXpLVE_akGTD3Ekk0TX_u1Gzw5y3oidBMQOg@mail.gmail.com>
References: <CAOaGyfUHS90nKcSxpQZm7X3Lgwtb_9V4xLzyObhd5v=diGHJLw@mail.gmail.com>
 <20150317005503.GA5480@Asurada-GSX>
 <CAOaGyfUBoQLpa0YZjKEtZXmhRL_p=zGq3XEJ9oZHbHrVr1SQ8w@mail.gmail.com>
 <20150317180006.GA5336@Asurada>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f177.google.com (mail-ob0-f177.google.com
 [209.85.214.177])
 by alsa0.perex.cz (Postfix) with ESMTP id 4EB50265062
 for <alsa-devel@alsa-project.org>; Wed, 18 Mar 2015 02:12:20 +0100 (CET)
Received: by obcjt1 with SMTP id jt1so1041924obc.2
 for <alsa-devel@alsa-project.org>; Tue, 17 Mar 2015 18:12:19 -0700 (PDT)
In-Reply-To: <20150317180006.GA5336@Asurada>
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

On Wed, Mar 18, 2015 at 2:00 AM, Nicolin Chen <nicoleotsuka@gmail.com> wrote:
> On Tue, Mar 17, 2015 at 09:51:22AM +0800, Shawn Embedded wrote:
>
>>    Actually I donot know much about dai-link. I just got started
>> recently to working on this requirement.
>>    You mean to create the same platform device as the now-working one
>> in board-xxx.c. Sure I can do that.
>
> Are you using old kernel version that's not included Device Tree yet?
>
> If so, yes, you need to add a similar platform device as the original
> one but you need to assign a different AUDMUX port.
>

   Yes, it's and old version, without support of device tree.
   For AUDMUX configuration, is the code below enough, snippet 1 and 2?

1. In mach-mx6/board-xxx.c:

static struct mxc_audio_platform_data wm8962_data = {
.ssi_num = MY_SSI_NUM,
.src_port = MY_SRC_PORT,
.ext_port = 6,
.hp_gpio = -1, /*MX6S_GPT4_HEADPHONE_DET, */
.hp_active_low = 1,
.mic_gpio = -1, /*MX6S_GPT4_MICROPHONE_DET,*/
.mic_active_low = 1,
.init = mxc_wm8962_init,
.clock_enable = wm8962_clk_enable,
};

    And here I have another question about clock source sharing
between the two codecs.
    The two wm8962 codecs use the same clock source from imx6, in my
case, clko, as the code mentioned below,

static int wm8962_clk_enable(int enable)
{
    if (enable)
        clk_enable(clko);
    else
        clk_disable(clko);

     return 0;
}

static int mxc_wm8962_init(void)
{
     int rate;

     clko = clk_get(NULL, "clko_clk");


     if (IS_ERR(clko)) {
          pr_err("can't get CLKO clock.\n");
          return PTR_ERR(clko);
     }

     /* both audio codec and comera use CLKO clk*/
     rate = clk_round_rate(clko, 24000000);
     clk_set_rate(clko, rate);

     wm8962_data.sysclk = rate;

     return 0;
}

Since the two codecs share the same clock source, clko, and we donot
know when mxc_wm8962_init() and wm8962_clk_enable() will be called by
using the function pointer exactly, do you think it's necessary to
make NULL to init, make wm8962_clk_enable_do_nothing to clock_enable,
and manually calling mxc_wm8962_init() and wm8962_clk_enable() in the
xxx_board_init() function instead?

2. In imx-wm8962.c:

static int __devinit imx_wm8962_probe(struct platform_device *pdev)
{
    ....
    imx_audmux_config(src, ext);    // should keep the same, not need
to change, right?
    ....
}

>>    Since the two wm8962 codecs are on different I2C buses, so I just
>> need to update the corresponding i2c's i2c_board_info structure to
>> support the second one as a I2C device?
>
> Exactly.
>
>> > Supposing two WM8962 chips on one board, there should be two WM8962
>> > nodes hanging to the I2C node with different I2C slave addresses.
>>
>>   Yes, but the I2C slave addresses should be the same, IIRC, only on
>> different I2C buses.
>
> No problem for this. You can use same slave address but connecting to
> different I2C buses. As long as you system probes two different CODECs,
> that's fine.
>
>>   What do you mean by "two wm8962 nodes" ?
>
> If you are not using code from Linux Mainline, just forget about it.

   Ok.
>
>>   In my experience, the corresponding files are board-xxx.c,
>> imx-wm8962.c, wm8962.c.
>>
>>   I looked at the wm8962.c, which is the codec driver file, very independent.
>>   There comes the wm8962_i2c_probe() and wm8962_probe().
>>   In wm8962_i2c_probe(), snd_soc_register_codec() is called, so a new
>> codec structure will be created when there comes another i2c device
>> named "wm8962".
>>   Seems no need to change anything in wm8962.c, if the external
>> hardware signals of the second wm8962 are connected in the same way as
>> the first now-working one, right?
>
> No, you don't need to. Just register it in the board level driver.
>
>>   Do you think any changes should be made to imx-wm8962.c which is the
>> machine driver file for wm8962 on imx6?
>
> Ideally, You only need to append a new platform device in the board
> level driver, same as you do for WM8962 CODECs.
>
>> static struct snd_soc_dai_link imx_dai[] = {
>> {
>> .name = "HiFi",
>> .stream_name = "HiFi",
>> .codec_dai_name = "wm8962",
>> .codec_name = "wm8962.0-001a",
>> .cpu_dai_name = "imx-ssi.1",
>> .platform_name = "imx-pcm-audio.1",
>> .init = imx_wm8962_init,
>> .ops = &imx_hifi_ops,
>> },
>> };
>
> Okay...this one looks like you are using an old version BSP, other
> than the code from Linux Mainline.

   Yes, it's Linux-Kernel 3.0.x from Freescale.

>
>> in imx-wm8962.c, should I copy them to create a new copy of them
>> respectively? Or no need to do this?
>
> In this case, yes, because the structure has hard code. Otherwise,
> you new dai-link will not be successfully connected.

  It seems I just need to copy some global variables, and change all
the functions that reference the global variables just changed.

  But there is a question here.
  How should I track the  card_priv and its copy for the two codecs repectively.
  They are used heavily.
   In order to make the functions run without problems, seems
necessary to differentiate the function call is for which codec of the
two, right?
  The same situation may exist for other just copied global variables
in imx-wm8962.c.

>
>> In board-xxx.c, do I just need to copy declarations related to wm8962?
>> Is that enough?
>
> I think so.
>
>>   Again, could you tell me how to make two different dai-link nodes?
>>   Sorry for knowing not much about this.
>
> That's for Device Tree which you are not using.
>
> Nicolin

Thank you for your patience.


Best Regards,
Shawn
