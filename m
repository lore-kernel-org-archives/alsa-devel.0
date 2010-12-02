From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: [PATCH 0/3] ASoC: Laying the groundwork for
	compress_type overriding
Date: Thu,  2 Dec 2010 14:53:00 +0000
Message-ID: <1291301583-15491-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 9CECC103840
	for <alsa-devel@alsa-project.org>; Thu,  2 Dec 2010 15:53:10 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

This patch series is to prepare ASoC for allowing the compress_type of the
codec to be overriden by the machine driver.  Typically this will be done by
providing an snd_soc_codec_conf struct which will contain the new compress_type
in the machine driver.

Dimitris Papastamos (3):
  ASoC: Add compress_type as a member to snd_soc_codec
  ASoC: Change the base value of compress_type
  ASoC: soc-core: Generalize snd_soc_prefix_map and rename to
    snd_soc_codec_conf
