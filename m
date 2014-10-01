From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: ASoC: ssm4567: Add driver for Analog Devices
	SSM4567 amplifier
Date: Wed, 1 Oct 2014 20:02:57 +0300
Message-ID: <20141001170257.GB11786@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
 by alsa0.perex.cz (Postfix) with ESMTP id F04E12604B6
 for <alsa-devel@alsa-project.org>; Wed,  1 Oct 2014 19:03:14 +0200 (CEST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: anatol.pomozov@gmail.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello Anatol Pomozov,

The patch 1ee44ce03011: "ASoC: ssm4567: Add driver for Analog Devices
SSM4567 amplifier" from Sep 26, 2014, leads to the following static
checker warning:

	sound/soc/codecs/ssm4567.c:176 ssm4567_hw_params()
	warn: we tested 'rate <= 96000' before and it was 'false'

sound/soc/codecs/ssm4567.c
   160  static int ssm4567_hw_params(struct snd_pcm_substream *substream,
   161          struct snd_pcm_hw_params *params, struct snd_soc_dai *dai)
   162  {
   163          struct snd_soc_codec *codec = dai->codec;
   164          struct ssm4567 *ssm4567 = snd_soc_codec_get_drvdata(codec);
   165          unsigned int rate = params_rate(params);
   166          unsigned int dacfs;
   167  
   168          if (rate >= 8000 && rate <= 12000)
   169                  dacfs = SSM4567_DAC_FS_8000_12000;
   170          else if (rate >= 16000 && rate <= 24000)
   171                  dacfs = SSM4567_DAC_FS_16000_24000;
   172          else if (rate >= 32000 && rate <= 48000)
   173                  dacfs = SSM4567_DAC_FS_32000_48000;
   174          else if (rate >= 64000 && rate <= 96000)
   175                  dacfs = SSM4567_DAC_FS_64000_96000;
   176          else if (rate >= 64000 && rate <= 96000)
   177                  dacfs = SSM4567_DAC_FS_64000_96000;

These two lines are a cut and paste error.  The intent is not clear.

   178          else if (rate >= 128000 && rate <= 192000)
   179                  dacfs = SSM4567_DAC_FS_128000_192000;
   180          else
   181                  return -EINVAL;
   182  
   183          return regmap_update_bits(ssm4567->regmap, SSM4567_REG_DAC_CTRL,
   184                                  SSM4567_DAC_FS_MASK, dacfs);
   185  }

regards,
dan carpenter
