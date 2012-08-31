From: Raffaele Recalcati <lamiaposta71@gmail.com>
Subject: double dai question and analog paths
Date: Fri, 31 Aug 2012 19:11:34 +0200
Message-ID: <CAFU7RzOo14teckc404GP+Q2SdTMn93xDeTNPGUnwtWAws7eRGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qa0-f51.google.com (mail-qa0-f51.google.com
 [209.85.216.51])
 by alsa0.perex.cz (Postfix) with ESMTP id E8D73266485
 for <alsa-devel@alsa-project.org>; Fri, 31 Aug 2012 19:11:35 +0200 (CEST)
Received: by qadz3 with SMTP id z3so1208839qad.17
 for <alsa-devel@alsa-project.org>; Fri, 31 Aug 2012 10:11:35 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I can play succesfully each of the following substreams:

static struct snd_soc_dai_link omap3baia_dai[] = {
        {
                .name = "TLV320AIC31",
                .stream_name = "AIC31",
                .cpu_dai_name = "omap-mcbsp-dai.3",
                .codec_dai_name = "tlv320aic3x-hifi",
                .platform_name = "omap-pcm-audio",
                .codec_name = "tlv320aic3x-codec.2-0018",
                .init = omap3baia_tlvaic31_init,
                .ops = &omap3baia_tlvaic31_ops,
        },
        {
                .name = "TWL4030",
                .stream_name = "TWL4030",
                .cpu_dai_name = "omap-mcbsp-dai.1",
                .platform_name = "omap-pcm-audio",
                .codec_dai_name = "twl4030-hifi",
                .codec_name = "twl4030-codec",
                .init = omap3baia_twl4030_init,
                .ops = &omap3baia_twl4030_ops,
        },
};

I have also some analog connections between TWL4030 and TLV320AIC31
and I'd like to create an automatic audio path (for example from
TWL4030 HFL to TLV320AIC31 LINE2L), but I obtain
"Failed to add route Virtual Tps to Tlv->LINE2L"

static const struct snd_soc_dapm_route audio_map_twl4030[] = {
        {"Virtual Tps to Tlv", NULL, "HFL"}, /* from tps to tlv */
        {"LINE2L", NULL, "Virtual Tps to Tlv"}, /* from tps to tlv */
};

Because LINE2L is obviously defined inside TWL4030 codec.

static const struct snd_soc_dapm_widget dapm_widgets_twl4030[] = {
        SND_SOC_DAPM_OUTPUT("Virtual Tps to Tlv"),
};

Is there a clean way to manage this situation?
I have also tried without "Virtual Tps to Tlv" but the problem is the same.

Thx,
Raffaele
