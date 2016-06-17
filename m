From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH] ASoC: max9867: Fix unix permissions for source files.
Date: Fri, 17 Jun 2016 16:24:43 +0200
Message-ID: <1466173483-20147-1-git-send-email-enric.balletbo@collabora.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

Change file permissions of source files max9867.c/h from 0755 to 0644.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---
 sound/soc/codecs/max9867.c | 0
 sound/soc/codecs/max9867.h | 0
 2 files changed, 0 insertions(+), 0 deletions(-)
 mode change 100755 => 100644 sound/soc/codecs/max9867.c
 mode change 100755 => 100644 sound/soc/codecs/max9867.h

diff --git a/sound/soc/codecs/max9867.c b/sound/soc/codecs/max9867.c
old mode 100755
new mode 100644
diff --git a/sound/soc/codecs/max9867.h b/sound/soc/codecs/max9867.h
old mode 100755
new mode 100644
-- 
2.1.0
