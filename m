From: Joe Perches <joe@perches.com>
Subject: [PATCH] sound: max98090: Remove executable bit
Date: Tue, 19 Mar 2013 14:58:43 -0700
Message-ID: <1363730323.16270.11.camel@joe-AO722>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Source files shouldn't have the executable bit set.

Signed-off-by: Joe Perches <joe@perches.com>
---
 include/sound/max98090.h    | 0
 sound/soc/codecs/max98090.c | 0
 sound/soc/codecs/max98090.h | 0
 3 files changed, 0 insertions(+), 0 deletions(-)

diff --git a/include/sound/max98090.h b/include/sound/max98090.h
old mode 100755
new mode 100644
diff --git a/sound/soc/codecs/max98090.c b/sound/soc/codecs/max98090.c
old mode 100755
new mode 100644
diff --git a/sound/soc/codecs/max98090.h b/sound/soc/codecs/max98090.h
old mode 100755
new mode 100644
