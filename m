From: Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH 0/2] ASoC: add es7241 support
Date: Fri, 29 Jun 2018 17:24:42 +0200
Message-ID: <20180629152444.21525-1-jbrunet@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f66.google.com (mail-wm0-f66.google.com [74.125.82.66])
 by alsa0.perex.cz (Postfix) with ESMTP id 343F42675C8
 for <alsa-devel@alsa-project.org>; Fri, 29 Jun 2018 17:25:03 +0200 (CEST)
Received: by mail-wm0-f66.google.com with SMTP id b188-v6so2613788wme.3
 for <alsa-devel@alsa-project.org>; Fri, 29 Jun 2018 08:25:03 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Jerome Brunet <jbrunet@baylibre.com>
List-Id: alsa-devel@alsa-project.org

Add support for the es7241 which is a simple 2 channels analog to
digital converter.

Jerome Brunet (2):
  ASoC: es7241: add dt-bindings documentation for the es7241 adc
  ASoC: es7241: add es7241 codec support

 .../devicetree/bindings/sound/everest,es7241.txt   |  23 ++
 sound/soc/codecs/Kconfig                           |   4 +
 sound/soc/codecs/Makefile                          |   2 +
 sound/soc/codecs/es7241.c                          | 307 +++++++++++++++++++++
 4 files changed, 336 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/everest,es7241.txt
 create mode 100644 sound/soc/codecs/es7241.c

-- 
2.14.4
