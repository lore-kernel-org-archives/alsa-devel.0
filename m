From: Axel Lin <axel.lin@gmail.com>
Subject: ASoC: snd_soc_codec_set_cache_io does not set codec->hw_write
 callback now
Date: Tue, 04 Oct 2011 17:24:32 +0800
Message-ID: <1317720272.2536.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,
I just found that after commit be3ea3b9e
"SoC: Use new register map API for ASoC generic physical I/O",
snd_soc_codec_set_cache_io does not set codec->hw_write any more.

It is still used in some drivers. e.g.
In wm8988_resume, we call codec->hw_write(codec->control_data, data, 2);

For the drivers that is using snd_soc_codec_set_cache_io now,
where is the place to set codec->hw_write callback now? 

Regards,
Axel
