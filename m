From: "Harsha, Priya" <priya.harsha@intel.com>
Subject: regarding references taken on platform and codec
	driver modules
Date: Mon, 3 Jan 2011 16:30:35 +0530
Message-ID: <98769532B4BB14429434178695419EAE053BF51941@bgsmsx501.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by alsa0.perex.cz (Postfix) with ESMTP id 38AE72437F
	for <alsa-devel@alsa-project.org>; Mon,  3 Jan 2011 12:00:49 +0100 (CET)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,

I have 4 dai_link instances as below. (the codec_name and platform_name are 
the same for all the 4 instances)

struct snd_soc_dai_link mfld_msic_dailink[] = {
        {
                .name = "Intel MSIC Headset",
                .stream_name = "Codec",
                .cpu_dai_name = "Headset-cpu-dai",
                .codec_dai_name = "Intel MSIC Headset",
                .codec_name = "mid-msic-codec",
                .platform_name = "mid-audio-platform",
                .init = msic_init,
        },
        {
                .name = "Intel MSIC Speaker",
                .stream_name = "Speaker",
                .cpu_dai_name = "Speaker-cpu-dai",
                .codec_dai_name = "Intel MSIC Speaker",
                .codec_name = "mid-msic-codec",
                .platform_name = "mid-audio-platform",
                .init = NULL,
        },
        {
                .name = "Intel MSIC Vibra",
                .stream_name = "Vibra1",
                .cpu_dai_name = "Vibra 1-cpu-dai",
                .codec_dai_name = "Intel MSIC Vibra",
                .codec_name = "mid-msic-codec",
                .platform_name = "mid-audio-platform",
                .init = NULL,
        },
        {
                .name = "Intel MSIC Haptic",
                .stream_name = "Vibra2",
                .cpu_dai_name = "Vibra 2-cpu-dai",
                .codec_dai_name = "Intel MSIC Haptic",
                .codec_name =  "mid-msic-codec",
                .platform_name = "mid-audio-platform",
                .init = NULL,
        },
};

When the soc_bind_dai_link is called
  For every dai_link instance, reference to codec, platform and cpu_dai are taken

When soc_remove_dai_link is called, the reference is released as follows
  For cpu_dai after checking if cpu_dai->probed is 1
 
  For codec and platform, it checks for codec->probed and platform->probed
  So for the first instance of dai_link, the reference of codec and platform are
  removed correctly but for the other instances, it finds that codec->probed and
  platform->probed are 0 and does not remove the reference. As a result, the
  reference count of codec and platform drivers remain as 3 and the rmmod on
  those driver modules fail.

Is there anything that I am doing wrong here or missing out?

Thanks,
Harsha
