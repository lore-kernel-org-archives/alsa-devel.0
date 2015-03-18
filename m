From: Shawn Embedded <programassem@gmail.com>
Subject: Re: Support two wm8962 codec in i.mx6 board.
Date: Wed, 18 Mar 2015 12:48:24 +0800
Message-ID: <CAOaGyfUWROtRSfYf5JLbSWqJMUbqmEpyDE6SuELkcvZ2SHidJw@mail.gmail.com>
References: <CAOaGyfUHS90nKcSxpQZm7X3Lgwtb_9V4xLzyObhd5v=diGHJLw@mail.gmail.com>
 <20150317005503.GA5480@Asurada-GSX>
 <CAOaGyfUBoQLpa0YZjKEtZXmhRL_p=zGq3XEJ9oZHbHrVr1SQ8w@mail.gmail.com>
 <20150317180006.GA5336@Asurada>
 <CAOaGyfUk6LLkZhLXpLVE_akGTD3Ekk0TX_u1Gzw5y3oidBMQOg@mail.gmail.com>
 <20150318013301.GA6432@Asurada-GSX>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f46.google.com (mail-oi0-f46.google.com
 [209.85.218.46])
 by alsa0.perex.cz (Postfix) with ESMTP id 8BD4526041D
 for <alsa-devel@alsa-project.org>; Wed, 18 Mar 2015 05:48:25 +0100 (CET)
Received: by oibu204 with SMTP id u204so27145469oib.0
 for <alsa-devel@alsa-project.org>; Tue, 17 Mar 2015 21:48:24 -0700 (PDT)
In-Reply-To: <20150318013301.GA6432@Asurada-GSX>
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

Hi Nicolin,

On Wed, Mar 18, 2015 at 9:33 AM, Nicolin Chen <nicoleotsuka@gmail.com> wrote:
> On Wed, Mar 18, 2015 at 09:12:19AM +0800, Shawn Embedded wrote:
>
>>    Yes, it's and old version, without support of device tree.
>>    For AUDMUX configuration, is the code below enough, snippet 1 and 2?
>
> I think so.
>
>>     And here I have another question about clock source sharing
>> between the two codecs.
>>     The two wm8962 codecs use the same clock source from imx6, in my
>> case, clko, as the code mentioned below,
>
>> Since the two codecs share the same clock source, clko, and we donot
>> know when mxc_wm8962_init() and wm8962_clk_enable() will be called by
>> using the function pointer exactly, do you think it's necessary to
>> make NULL to init, make wm8962_clk_enable_do_nothing to clock_enable,
>> and manually calling mxc_wm8962_init() and wm8962_clk_enable() in the
>> xxx_board_init() function instead?
>
> I don't think you need to change this part.

   If donot change it, what will happen to the working codec if the
clock_enable is called caused by stopping the other codec? the working
codec will not be affected?

>
>> 2. In imx-wm8962.c:
>>
>> static int __devinit imx_wm8962_probe(struct platform_device *pdev)
>> {
>>     ....
>>     imx_audmux_config(src, ext);    // should keep the same, not need
>> to change, right?
>>     ....
>> }
>
> No, you don't need to.
>
>>   But there is a question here.
>>   How should I track the  card_priv and its copy for the two codecs repectively.
>>   They are used heavily.
>>    In order to make the functions run without problems, seems
>> necessary to differentiate the function call is for which codec of the
>> two, right?
>>   The same situation may exist for other just copied global variables
>> in imx-wm8962.c.
>
> Each dai-link will create an individual sound card during system
> boot-up. Use 'aplay -l', you will see they are different devices.
>

   I know what you mean.
   But let me paste a snippet of code here, for two codecs on board,
do'not you think it's necessary to setup 2 structure imx_priv to track
the two codecs respectively?

In imx-wm8962.c

static struct imx_priv card_priv;

static void imx_hifi_shutdown(struct snd_pcm_substream *substream)
{
     struct snd_soc_pcm_runtime *rtd = substream->private_data;
     struct snd_soc_dai *codec_dai = rtd->codec_dai;
     struct imx_priv *priv = &card_priv;
     struct mxc_audio_platform_data *plat = priv->pdev->dev.platform_data;

     if (!codec_dai->active)
          plat->clock_enable(0);

     return;
}

/*
 * This function will register the snd_soc_pcm_link drivers.
 */
static int __devinit imx_wm8962_probe(struct platform_device *pdev)
{

     struct mxc_audio_platform_data *plat = pdev->dev.platform_data;
     struct imx_priv *priv = &card_priv;
     int ret = 0;

     priv->pdev = pdev;

     imx_audmux_config(plat->src_port, plat->ext_port);

     if (plat->init && plat->init()) {
          ret = -EINVAL;
     return ret;
     }

     priv->sysclk = plat->sysclk;

     priv->sdev.name = "h2w";
     ret = switch_dev_register(&priv->sdev);
     if (ret < 0) {
          ret = -EINVAL;
     return ret;
     }

     if (plat->hp_gpio != -1) {
          priv->hp_status = gpio_get_value(plat->hp_gpio);

          if (priv->hp_status != plat->hp_active_low)
               switch_set_state(&priv->sdev, 2);
          else
               switch_set_state(&priv->sdev, 0);
     }
     priv->first_stream = NULL;
     priv->second_stream = NULL;

     return ret;
}


Thank you.

Best Regards,
Shawn
