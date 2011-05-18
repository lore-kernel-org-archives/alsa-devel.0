From: Caleb Crome <caleb@crome.org>
Subject: Multiple codecs on one card (SOC)
Date: Wed, 18 May 2011 16:51:56 -0700
Message-ID: <BANLkTi=e10pF1upF8N19LtNaMDk0NmM78w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f51.google.com (mail-pz0-f51.google.com
	[209.85.210.51]) by alsa0.perex.cz (Postfix) with ESMTP id 1451B243FD
	for <alsa-devel@alsa-project.org>;
	Thu, 19 May 2011 01:51:58 +0200 (CEST)
Received: by pzk26 with SMTP id 26so1126526pzk.38
	for <alsa-devel@alsa-project.org>; Wed, 18 May 2011 16:51:57 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi again,
   I have a multi-codec board up and running, and need a little guidance.
 I've got 8 I2S codecs connected to a beagleboard.   I have the first codec
up and running, but I don't know how to add more codecs to the same alsa
card.

I have it set for multiple DAI links.  Is that the correct way to have
multiple codecs bound to the same card, and bound to eachother?  The struct
is below.

When I do this, I have the problem, that the codec driver, which registers
its mixer controls using macros like SOC_DOUBLE_R_TLV("PCM Playback Volume,
LDAC_VOL, RDAC_VOL,...), they fail when the 2nd codec is getting probed.

Am I supposed to use multiple snd_soc_dai_link declarations?  How do I end
up with a single 16-channel sound card built from multiple 2 channel
devices?

Do I use subdevices?  Substreams?  multiple dai_links?  How do i instantiate
them?

Any pointers would be greatly appreciated.

Thanks,

  -Caleb


static struct snd_soc_dai_link puppy_dai[] =
{
        {
                .name = "tlv320aic33-se-a",
                .stream_name = "tlv320aic33-se",
                .cpu_dai_name = "omap-mcbsp-dai.2",
                .platform_name = "omap-pcm-audio",
                .codec_dai_name = "tlv320aic3x-se-hifi",
                .codec_name = "tlv320aic3x-se-codec.2-0018",
                .ops = &puppy_ops,
                .symmetric_rates = 1, // I think this requires send and
receive be the same rate.
                .init = puppy_dai_link_init,
        },
        {
                .name = "tlv320aic33-se-b",
                .stream_name = "tlv320aic33-se",
                .cpu_dai_name = "omap-mcbsp-dai.2",
                .platform_name = "omap-pcm-audio",
                .codec_dai_name = "tlv320aic3x-se-hifi",
                .codec_name = "tlv320aic3x-se-codec.2-0019",
                .ops = &puppy_ops,
                .symmetric_rates = 1, // I think this requires send and
receive be the same rate.
                .init = puppy_dai_link_init,
},
};
