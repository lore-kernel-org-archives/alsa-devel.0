From: ext-eero.nurkkala@nokia.com
Subject: [RFC 2/2] ASoC: refactor snd_soc_update_bits()
Date: Fri, 30 Oct 2009 13:34:03 +0200
Message-ID: <1256902443-15492-3-git-send-email-ext-eero.nurkkala@nokia.com>
References: <1256902443-15492-1-git-send-email-ext-eero.nurkkala@nokia.com>
	<1256902443-15492-2-git-send-email-ext-eero.nurkkala@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id CBF33103889
	for <alsa-devel@alsa-project.org>; Fri, 30 Oct 2009 12:35:46 +0100 (CET)
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx06.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id
	n9UBZdFj020414
	for <alsa-devel@alsa-project.org>; Fri, 30 Oct 2009 13:35:45 +0200
In-Reply-To: <1256902443-15492-2-git-send-email-ext-eero.nurkkala@nokia.com>
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
Cc: Eero Nurkkala <ext-eero.nurkkala@nokia.com>
List-Id: alsa-devel@alsa-project.org

From: Eero Nurkkala <ext-eero.nurkkala@nokia.com>

Introduce a wrapper call snd_soc_update_bits_locked()
that will take the codec mutex. This call is used
when the codec mutex is not already taken.

Drivers calling snd_soc_update_bits() may wish to
make sure the codec mutex is taken from the driver.

Signed-off-by: Eero Nurkkala <ext-eero.nurkkala@nokia.com>
---
 sound/soc/soc-core.c |   36 ++++++++++++++++++++++++++++++------
 1 files changed, 30 insertions(+), 6 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 1f42d46..abeb5fb 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1371,6 +1371,30 @@ int snd_soc_update_bits(struct snd_soc_codec *codec, unsigned short reg,
 EXPORT_SYMBOL_GPL(snd_soc_update_bits);
 
 /**
+ * snd_soc_update_bits_locked - update codec register bits
+ * @codec: audio codec
+ * @reg: codec register
+ * @mask: register mask
+ * @value: new value
+ *
+ * Writes new register value, and takes the codec mutex.
+ *
+ * Returns 1 for change else 0.
+ */
+static int snd_soc_update_bits_locked(struct snd_soc_codec *codec,
+				unsigned short reg, unsigned int mask,
+				unsigned int value)
+{
+	int change;
+
+	mutex_lock(&codec->mutex);
+	change = snd_soc_update_bits(codec, reg, mask, value);
+	mutex_unlock(&codec->mutex);
+
+	return change;
+}
+
+/**
  * snd_soc_test_bits - test register for change
  * @codec: audio codec
  * @reg: codec register
@@ -1721,7 +1745,7 @@ int snd_soc_put_enum_double(struct snd_kcontrol *kcontrol,
 		mask |= (bitmask - 1) << e->shift_r;
 	}
 
-	return snd_soc_update_bits(codec, e->reg, mask, val);
+	return snd_soc_update_bits_locked(codec, e->reg, mask, val);
 }
 EXPORT_SYMBOL_GPL(snd_soc_put_enum_double);
 
@@ -1795,7 +1819,7 @@ int snd_soc_put_value_enum_double(struct snd_kcontrol *kcontrol,
 		mask |= e->mask << e->shift_r;
 	}
 
-	return snd_soc_update_bits(codec, e->reg, mask, val);
+	return snd_soc_update_bits_locked(codec, e->reg, mask, val);
 }
 EXPORT_SYMBOL_GPL(snd_soc_put_value_enum_double);
 
@@ -1956,7 +1980,7 @@ int snd_soc_put_volsw(struct snd_kcontrol *kcontrol,
 		val_mask |= mask << rshift;
 		val |= val2 << rshift;
 	}
-	return snd_soc_update_bits(codec, reg, val_mask, val);
+	return snd_soc_update_bits_locked(codec, reg, val_mask, val);
 }
 EXPORT_SYMBOL_GPL(snd_soc_put_volsw);
 
@@ -2062,11 +2086,11 @@ int snd_soc_put_volsw_2r(struct snd_kcontrol *kcontrol,
 	val = val << shift;
 	val2 = val2 << shift;
 
-	err = snd_soc_update_bits(codec, reg, val_mask, val);
+	err = snd_soc_update_bits_locked(codec, reg, val_mask, val);
 	if (err < 0)
 		return err;
 
-	err = snd_soc_update_bits(codec, reg2, val_mask, val2);
+	err = snd_soc_update_bits_locked(codec, reg2, val_mask, val2);
 	return err;
 }
 EXPORT_SYMBOL_GPL(snd_soc_put_volsw_2r);
@@ -2145,7 +2169,7 @@ int snd_soc_put_volsw_s8(struct snd_kcontrol *kcontrol,
 	val = (ucontrol->value.integer.value[0]+min) & 0xff;
 	val |= ((ucontrol->value.integer.value[1]+min) & 0xff) << 8;
 
-	return snd_soc_update_bits(codec, reg, 0xffff, val);
+	return snd_soc_update_bits_locked(codec, reg, 0xffff, val);
 }
 EXPORT_SYMBOL_GPL(snd_soc_put_volsw_s8);
 
-- 
1.6.0.4
