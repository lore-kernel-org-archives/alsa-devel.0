From: Matt Redfearn <Matt.Redfearn@imgtec.com>
Subject: ASoC Multiple outputs
Date: Mon, 13 Jul 2015 07:39:33 +0000
Message-ID: <9FCBB1D1936B2F4DB2DD02BA3957FB50C2E9A0@LEMAIL01.le.imgtec.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailapp01.imgtec.com (mailapp01.imgtec.com [195.59.15.196])
 by alsa0.perex.cz (Postfix) with ESMTP id 10A4E2614DD
 for <alsa-devel@alsa-project.org>; Mon, 13 Jul 2015 09:39:35 +0200 (CEST)
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
 by Websense Email Security Gateway with ESMTPS id EB7CFF093D279
 for <alsa-devel@alsa-project.org>; Mon, 13 Jul 2015 08:39:31 +0100 (IST)
Content-Language: en-GB
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi list,
I am writing an ALSA driver for an SoC / board which has a single I2S source. The source may be connected internally to either a codec outputting to analogue headphones, or to an HDMI transmitter.
At the moment I have set up two snd_soc_dai_link within the same card connecting the source to each sink. 

static struct snd_soc_dai_link ci20_dai_link[] = {
	{
		.name = "ci20",
		.stream_name = "headphones",
		.cpu_dai_name = "jz4780-i2s",
		.platform_name = "jz4780-i2s",
		.codec_dai_name = "jz4780-hifi",
		.codec_name = "jz4780-codec",
		.init = ci20_init,
		.ops = &ci20_audio_dai_ops,
		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBM_CFM,
	},
	{
		.name = "ci20 HDMI",
		.stream_name = "hdmi",
		.cpu_dai_name = "jz4780-i2s",
		.platform_name = "jz4780-i2s",
		.codec_dai_name = "dw-hdmi-hifi",
		.codec_name = "dw-hdmi-audio",
		.init = ci20_hdmi_init,
		.ops = &ci20_audio_dai_ops,
		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBS_CFS,
	}
};

This works and creates 2 devices, and I am able to get mplayer to play sound out to either the headphones or HDMI using the argument "-ao alsa:device=hw=0.0" or "-ao alsa:device=hw=0.1"

aplay -l
**** List of PLAYBACK Hardware Devices ****
card 0: ci20 [ci20], device 0: headphones jz4780-hifi-0 []
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: ci20 [ci20], device 1: hdmi jz4780-hdmi-hifi-1 []
  Subdevices: 1/1
  Subdevice #0: subdevice #0

However, alsamixer does not show anything about the second device (HDMI), only the analogue output associated with device 0.
Please could someone advise what is the "correct" way to set up multiple links in such a system such that the headphones / HDMI outputs appear in the mixer and are available to pulseaudio. Should I create multiple cards? Should I create subdevices for the different outputs? If so, what structures should be set up within the driver to achieve this?
Suggestions of any documentation / websites that may help would be great!

Thanks!
Matt
