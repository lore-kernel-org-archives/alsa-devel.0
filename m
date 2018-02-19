From: Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 0/2] ASoC: Add support for max9759 Amplifier
	Driver
Date: Mon, 19 Feb 2018 14:45:56 +0100
Message-ID: <1519047958-22583-1-git-send-email-narmstrong@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f67.google.com (mail-wm0-f67.google.com [74.125.82.67])
 by alsa0.perex.cz (Postfix) with ESMTP id 99CE3266D7D
 for <alsa-devel@alsa-project.org>; Mon, 19 Feb 2018 14:46:10 +0100 (CET)
Received: by mail-wm0-f67.google.com with SMTP id k87so15289340wmi.0
 for <alsa-devel@alsa-project.org>; Mon, 19 Feb 2018 05:46:10 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Neil Armstrong <narmstrong@baylibre.com>
List-Id: alsa-devel@alsa-project.org

The MAX9759 is a gpio controlled speaker amplifier, this patchset
add the DT Bindings and the corresponding ASoC component driver.

Neil Armstrong (2):
  ASoC: Add DT bindings documentation for max9759 amplifier
  ASoC: max9759: Add Amplifier Driver

 .../devicetree/bindings/sound/maxim,max9759.txt    |  18 ++
 sound/soc/codecs/Kconfig                           |   5 +
 sound/soc/codecs/Makefile                          |   2 +
 sound/soc/codecs/max9759.c                         | 207 +++++++++++++++++++++
 4 files changed, 232 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/maxim,max9759.txt
 create mode 100644 sound/soc/codecs/max9759.c

-- 
2.7.4
