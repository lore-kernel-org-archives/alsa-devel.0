From: Daniel Mack <zonque@gmail.com>
Subject: Re: ASoC: BeagleBoard driver development (PCM3168)
Date: Thu, 04 Apr 2013 15:29:05 +0200
Message-ID: <515D8021.9070603@gmail.com>
References: <CAGxc5aCJisVLrC09YsWAoh3U9_kKGKwFqiK4KM-u7JZ7SpW58w@mail.gmail.com>
 <5118F700.90006@ti.com>
 <CAGxc5aCZarD+-4EqSA9QZx_RvXRvJuGpKXtp=RiUPdcATuxFng@mail.gmail.com>
 <51235D8E.7040705@ti.com>
 <CAGxc5aDQ5btyvhcEnCcvNJZhRuCZWz8XS9SxOqcgmgBSx+bYZQ@mail.gmail.com>
 <5124D1EB.9030404@ti.com> <514DBE3A.3040502@gmail.com>
 <514DD0D9.1080800@gmail.com>
 <CAGxc5aA+HDDoMOQk_PGLdMN4XVoERtdhMyFBw-DvuY9uO9y+oA@mail.gmail.com>
 <514E44EF.5020004@gmail.com> <515D7CD9.3040902@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f47.google.com (mail-bk0-f47.google.com
 [209.85.214.47])
 by alsa0.perex.cz (Postfix) with ESMTP id 88326265EBA
 for <alsa-devel@alsa-project.org>; Thu,  4 Apr 2013 15:29:00 +0200 (CEST)
Received: by mail-bk0-f47.google.com with SMTP id ik5so1484733bkc.20
 for <alsa-devel@alsa-project.org>; Thu, 04 Apr 2013 06:28:58 -0700 (PDT)
In-Reply-To: <515D7CD9.3040902@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Wendelin Klimann <wklimann@gmail.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

there's something badly wrong with your mail client. Please do not send
HTML emails and configure your client for proper quoting.

On 04.04.2013 15:15, Wendelin Klimann wrote:
>     On 23.03.2013 22:56, wendelin klimann wrote:
> 
>>     The cleaned up files are added, if there are still mixes between the
>>     codec- and machine-driver i would be glad if you could tell me. 
> 
>     It looks much better already, but your codec functions are currently
>     just stubs. So you need to fill them with logic that actually sets up
>     the hardware of course, and you should use regmap for abstracting the
>     registers.
> 
> Do you mean that i should setup the audiocodec over i2c/spi or miss i
> something else?

Yes, you need to tell the codec which format and frequency it runs on.
Also, you might want to control some volume registers, mute flags or
other mixer switches. As I said, just use regmap for that, which
abstracts the register access for you.

>      Also, the codec driver has to become a i2c/spi driver rather than a
>     platform device. There are tons of other drivers for reference.
> 
> I am trying to add support for i2c but can not find how to setup the
> correct i2c -> that one which will be used for the communication (i2c-2
> in my case)
> It would be nice if you could give me an hint how to find that. 

That is of course not codec driver specific. Why would you want to alter
the codec driver if you want to re-use it on a different platform, where
the chip is wired to some other controller?

This information is configured on the platform side - in board support
files for legacy kernels, in device-tree for newer versions.

Just grep through some board files
(arch/arm/mach-omap2/board-omap3beagle.c for instance) and look for
"i2c_board_info".

>     There are many smaller things to comment on, but you can submit the
>     codec driver first once you're finished, so it can be reviewed
>     independently from the rest. Note, however, that all new drivers have to
>     be written in a device-tree aware fashion.
> 
> I give my best to learn from other device drivers :-)
> 
> Acctually i am stuck at a point where i get just 4 channels instead of 8
> channels audio output on my audio codec (PCM3168 from TI)
> i get every second channel on the audio codec 
> (alsa channel 1 -> to audio codec channel 1;
>  alsa channel 3 -> to audio codec channel 2;
>  alsa channel 5 -> to audio codec channel 3;
>  alsa channel 7 -> to audio codec channel 4)
> 
> The audio codec is setup to use I2S-TDM (24Bit (32Bit frame), 48kHz)
> mode and i test the system with:
> 
> soc/omap# speaker-test -Dhw:1,0 -c8 -twav
> 
>     speaker-test 1.0.25
> 
>     Playback device is hw:1,0
>     Stream parameters are 48000Hz, S16_LE, 8 channels
>     WAV file(s)
>     [  657.989562] omap-dma-engine omap-dma-engine: allocating channel
>     for 17
>     Rate set to 48000Hz (requested 48000Hz)
>     Buffer size range from 16 to 8192
>     Period size range from 2 to 4096
>     Using max buffer size 8192
>     Periods = 4
>     was set period_size = 2048
>     was set buffer_size = 8192
>      0 - Front Left
>      4 - Center
>      1 - Front Right
>      7 - Side Right
>      3 - Rear Right
>      2 - Rear Left
>      6 - Side Left
>      5 - LFE
>     Time per period = 11.223022
> 
> When i meassure the digital signal with an osziloscope i see that alsa
> send all 8 channels (16Bit) on just half of the LRCKL
> 
>  ________________________________
> |                                |                              |
> |                                |                              |  LRCKL
> - AD/DA
> |                                |                              |
> |                                |______________________________|      
> 
> |       all 8 channels           |           nothing            |  AudioCodec-IN  / Alsa-OUT
> 

This has nothing to do with the codec driver of course.

You should trace which audio format is selected on the CPU side.

> static int pcm3168_hw_params(struct snd_pcm_substream *substream,
>                 struct snd_pcm_hw_params *params,
>                 struct snd_soc_dai *dai)
> {
>     struct snd_soc_pcm_runtime *rtd = substream->private_data;
>     struct snd_soc_codec *codec = rtd->codec;
> 
>     dev_dbg(codec->dev, "Sample format 0x%X\n", params_format(params));
>     dev_dbg(codec->dev, "Channels %d\n", params_channels(params));
>     dev_dbg(codec->dev, "Rate %d\n", params_rate(params));
> 
>     return 0;
> }

Again - you have to tell the chip about your runtime configuration when
this function is called.

> 
> static int pcm3168_set_dai_fmt(struct snd_soc_dai *codec_dai,
>                   unsigned int fmt)
> {
>     struct snd_soc_codec *codec = codec_dai->codec;
> 
>     /* codec role */
>     switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
>     case SND_SOC_DAIFMT_CBM_CFM:
>         dev_dbg(codec->dev, "Codec is master\n");
>         break;
>     case SND_SOC_DAIFMT_CBS_CFS:
>         dev_dbg(codec->dev, "Codec is slave\n");
>         break;
>     default:
>         return -EINVAL;
>     }
> 
>     /* DAI format */
>     dev_dbg(codec->dev, "DAI format 0x%X",
>         fmt & SND_SOC_DAIFMT_FORMAT_MASK);
> 
>     /* Bit clock and frame sync polarities */
>     dev_dbg(codec->dev, "Clock polarities 0x%X\n",
>         fmt & SND_SOC_DAIFMT_INV_MASK);
> 
>     return 0;
> }

Dito. Your driver cannot work until you fill these functions with life.


Daniel
