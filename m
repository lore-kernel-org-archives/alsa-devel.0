From: Axel Lin <axel.lin@gmail.com>
Subject: ASoC: tegra_wm8903 build error
Date: Thu, 22 Dec 2011 11:26:56 +0800
Message-ID: <1324524416.13224.7.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
	[209.85.160.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 09C02103C29
	for <alsa-devel@alsa-project.org>; Thu, 22 Dec 2011 04:27:04 +0100 (CET)
Received: by ghbz2 with SMTP id z2so706067ghb.38
	for <alsa-devel@alsa-project.org>; Wed, 21 Dec 2011 19:27:02 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Brown <broonie@opensource.wolfsonmicro.com>, Stephen Warren <swarren@nvidia.com>, Liam Girdwood <lrg@ti.com>, Mark@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Seems we need below patch to fix the build error:
http://mailman.alsa-project.org/pipermail/alsa-devel/2011-December/047403.html

  CC      sound/soc/tegra/tegra_wm8903.o
sound/soc/tegra/tegra_wm8903.c: In function 'tegra_wm8903_driver_probe':
sound/soc/tegra/tegra_wm8903.c:411: error: 'struct snd_soc_dai_link' has no member named 'codec_of_node'
sound/soc/tegra/tegra_wm8903.c:413: error: 'struct snd_soc_dai_link' has no member named 'codec_of_node'
sound/soc/tegra/tegra_wm8903.c:421: error: 'struct snd_soc_dai_link' has no member named 'cpu_dai_of_node'
sound/soc/tegra/tegra_wm8903.c:423: error: 'struct snd_soc_dai_link' has no member named 'cpu_dai_of_node'
make[3]: *** [sound/soc/tegra/tegra_wm8903.o] Error 1
make[2]: *** [sound/soc/tegra] Error 2
make[1]: *** [sound/soc] Error 2
make: *** [sound] Error 2

Regards,
Axel
