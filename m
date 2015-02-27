From: "Jie, Yang" <yang.jie@intel.com>
Subject: Re: ASoC: rt286: add jack detection disable with NULL
	jack passed
Date: Fri, 27 Feb 2015 02:40:42 +0000
Message-ID: <E7B1D079BA13FB44A978CC8F69C7D6A901BBD3C2@SHSMSX101.ccr.corp.intel.com>
References: <20150226081454.GA28947@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 243802606D7
 for <alsa-devel@alsa-project.org>; Fri, 27 Feb 2015 03:40:54 +0100 (CET)
In-Reply-To: <20150226081454.GA28947@mwanda>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


Hi Dan Carpenter,

Thanks for reminding, you are right, it should be AND here, will send out patch to fix it soon.

~Keyon

> -----Original Message-----
> From: Dan Carpenter [mailto:dan.carpenter@oracle.com]
> Sent: Thursday, February 26, 2015 4:15 PM
> To: Jie, Yang
> Cc: alsa-devel@alsa-project.org
> Subject: re: ASoC: rt286: add jack detection disable with NULL jack passed
> 
> Hello Jie Yang,
> 
> The patch e2cef68d5903: "ASoC: rt286: add jack detection disable with NULL
> jack passed" from Feb 10, 2015, leads to the following static checker warning:
> 
> 	sound/soc/codecs/rt286.c:400 rt286_mic_detect()
> 	warn: suspicious bitop condition
> 
> sound/soc/codecs/rt286.c
>    392  int rt286_mic_detect(struct snd_soc_codec *codec, struct
> snd_soc_jack *jack)
>    393  {
>    394          struct rt286_priv *rt286 = snd_soc_codec_get_drvdata(codec);
>    395
>    396          rt286->jack = jack;
>    397
>    398          if (jack) {
>    399                  /* enable IRQ */
>    400                  if (rt286->jack->status | SND_JACK_HEADPHONE)
>                                                 ^^^^^^^^^^^^^^^^^^^^ You probably intended
> bitwise AND here?  Bitwise OR is always true.
> 
>    401                          snd_soc_dapm_force_enable_pin(&codec->dapm,
> "LDO1");
>    402                  regmap_update_bits(rt286->regmap, RT286_IRQ_CTRL, 0x2,
> 0x2);
>    403                  /* Send an initial empty report */
>    404                  snd_soc_jack_report(rt286->jack, rt286->jack->status,
>    405                          SND_JACK_MICROPHONE | SND_JACK_HEADPHONE);
>    406          } else {
>    407                  /* disable IRQ */
>    408                  regmap_update_bits(rt286->regmap, RT286_IRQ_CTRL, 0x2,
> 0x0);
>    409                  snd_soc_dapm_disable_pin(&codec->dapm, "LDO1");
>    410          }
>    411          snd_soc_dapm_sync(&codec->dapm);
>    412
>    413          return 0;
>    414  }
> 
> regards,
> dan carpenter
