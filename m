From: Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH v2 0/3] Add device tree support for mxs audio
Date: Fri, 11 May 2012 22:24:15 +0800
Message-ID: <1336746258-23970-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f51.google.com (mail-pz0-f51.google.com
	[209.85.210.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 8DDAC104066
	for <alsa-devel@alsa-project.org>;
	Fri, 11 May 2012 16:24:46 +0200 (CEST)
Received: by dajt11 with SMTP id t11so4207686daj.38
	for <alsa-devel@alsa-project.org>; Fri, 11 May 2012 07:24:45 -0700 (PDT)
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-arm-kernel@lists.infradead.org, Dong Aisheng <dong.aisheng@linaro.org>
List-Id: alsa-devel@alsa-project.org

Changes since v1:
* Rebased on sound/for-3.5, and consequently the patch of devm_clk_get
  is dropped.
* Fixed the issues caught by Dong (Thanks to Dong).

Shawn Guo (3):
      ASoC: mxs: mxs-pcm does not need to be a plaform_driver
      ASoC: mxs: add device tree support for mxs-saif
      ASoC: mxs: add device tree support for mxs-sgtl5000

 .../bindings/sound/mxs-audio-sgtl5000.txt          |   17 ++++
 .../devicetree/bindings/sound/mxs-saif.txt         |   36 ++++++++
 sound/soc/mxs/mxs-pcm.c                            |   24 ++----
 sound/soc/mxs/mxs-pcm.h                            |    3 +
 sound/soc/mxs/mxs-saif.c                           |   90 +++++++++++++-------
 sound/soc/mxs/mxs-saif.h                           |    1 -
 sound/soc/mxs/mxs-sgtl5000.c                       |   50 +++++++++++-
 7 files changed, 168 insertions(+), 53 deletions(-)
