From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] ALSA: mips: avoid potential uninitialized variable use
Date: Mon, 16 Jan 2017 12:04:56 +0100
Message-ID: <20170116110517.3833976-1-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: linux-mips@linux-mips.org, Arnd Bergmann <arnd@arndb.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

MIPS allmodconfig results in this warning:

sound/mips/hal2.c: In function 'hal2_gain_get':
sound/mips/hal2.c:224:35: error: 'r' may be used uninitialized in this function [-Werror=maybe-uninitialized]
sound/mips/hal2.c:223:35: error: 'l' may be used uninitialized in this function [-Werror=maybe-uninitialized]
sound/mips/hal2.c: In function 'hal2_gain_put':
sound/mips/hal2.c:260:13: error: 'new' may be used uninitialized in this function [-Werror=maybe-uninitialized]
sound/mips/hal2.c:260:13: error: 'old' may be used uninitialized in this function [-Werror=maybe-uninitialized]

It's easy enough to avoid by adding a 'default' clause to the switch
statements here. I assume that in practice no other case can happen,
but adding a default puts us on the safe side and shuts up the warnings.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/mips/hal2.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/mips/hal2.c b/sound/mips/hal2.c
index ede449f0b50d..0af4f7a9b3e7 100644
--- a/sound/mips/hal2.c
+++ b/sound/mips/hal2.c
@@ -219,6 +219,9 @@ static int hal2_gain_get(struct snd_kcontrol *kcontrol,
 		l = (tmp >> H2I_C2_L_GAIN_SHIFT) & 15;
 		r = (tmp >> H2I_C2_R_GAIN_SHIFT) & 15;
 		break;
+	default:
+		l = 0;
+		r = 0;
 	}
 	ucontrol->value.integer.value[0] = l;
 	ucontrol->value.integer.value[1] = r;
@@ -256,6 +259,9 @@ static int hal2_gain_put(struct snd_kcontrol *kcontrol,
 		new |= (r << H2I_C2_R_GAIN_SHIFT);
 		hal2_i_write32(hal2, H2I_ADC_C2, new);
 		break;
+	default:
+		new = 0;
+		old = 0;
 	}
 	return old != new;
 }
-- 
2.9.0
