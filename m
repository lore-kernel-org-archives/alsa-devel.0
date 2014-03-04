From: RongJun Ying <rjying@gmail.com>
Subject: Re: [PATCH v4-resend 1/7] ASoC: sirf: Add SiRF
 internal audio codec driver
Date: Tue, 4 Mar 2014 13:11:50 +0800
Message-ID: <CAByv0RPTqUrB_8ojMWKAXk8H_GChryWHuK0NW+e=-Srx2L31sA@mail.gmail.com>
References: <1393399342-31177-1-git-send-email-rongjun.ying@csr.com>
 <1393399342-31177-2-git-send-email-rongjun.ying@csr.com>
 <20140227053339.GU9383@sirena.org.uk>
 <86130EF012BDF348AA0D464A4F449478012AE51755@SHAASIEXM01.ASIA.ROOT.PRI>
 <20140301031646.GJ29849@sirena.org.uk>
 <86130EF012BDF348AA0D464A4F449478012AE52440@SHAASIEXM01.ASIA.ROOT.PRI>
 <20140303050745.GP2411@sirena.org.uk>
 <CAGsJ_4xjCsVuySJdarevvJ5qgMxKFNyDZi_nb_Gh6+DBd4uKrQ@mail.gmail.com>
 <20140304045815.GL2411@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qa0-f53.google.com (mail-qa0-f53.google.com
 [209.85.216.53])
 by alsa0.perex.cz (Postfix) with ESMTP id 6D65F2656CE
 for <alsa-devel@alsa-project.org>; Tue,  4 Mar 2014 06:11:51 +0100 (CET)
Received: by mail-qa0-f53.google.com with SMTP id w8so2957721qac.40
 for <alsa-devel@alsa-project.org>; Mon, 03 Mar 2014 21:11:50 -0800 (PST)
In-Reply-To: <20140304045815.GL2411@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, Barry Song <21cnbao@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, DL-SHA-WorkGroupLinux <workgroup.linux@csr.com>, Rongjun Ying <Rongjun.Ying@csr.com>
List-Id: alsa-devel@alsa-project.org

2014-03-04 12:58 GMT+08:00 Mark Brown <broonie@kernel.org>:
> On Mon, Mar 03, 2014 at 03:48:02PM +0800, Barry Song wrote:
>
>> here the clock is an internal clock in the internal codec. the
>> external clock of audio controller is managed in system suspend/resume
>> as you see. but they are not managed in runtime suspend/resume here
>> because the external clock is always enabled to make sure the charge
>> pump to be working to make the board have stable current and voltage.
>> otherwise, touchscreen ADC will not be accurate.
>
> Why aren't these drivers keeping the clock enabled themselves?

The charge pump register is a part of  the audio controller.
But this register is impacted the touchscreen ADC stable.
So when the audio codec driver probe, It always enable the audio
controller's clock,
and must be set the charge pump register.

         ret = clk_prepare_enable(sirf_audio_codec->clk);
         if (ret) {
                dev_err(&pdev->dev, "Enable clock failed.\n");
                 return ret;
         }
         .....
         /*
          * Always open charge pump, if not, when the charge pump closed the
          * adc will not stable
          */
         regmap_update_bits(sirf_audio_codec->regmap, AUDIO_IC_CODEC_CTRL0,
                 IC_CPFREQ, IC_CPFREQ);

         if (of_device_is_compatible(pdev->dev.of_node,
"sirf,atlas6-audio-codec"))
                 regmap_update_bits(sirf_audio_codec->regmap,
                                 AUDIO_IC_CODEC_CTRL0, IC_CPEN, IC_CPEN);

Thanks
RongJun Ying
-- 
------------------------------
Rongjun Ying
