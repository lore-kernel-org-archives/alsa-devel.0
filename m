From: pavel.hofman@ivitera.com
Subject: [PATCH 5/7] ice1724 - pro-rate-locking makes sense
	only for internal clock mode
Date: Wed, 16 Sep 2009 00:39:54 +0200
Message-ID: <1253054396-7978-5-git-send-email-pavel.hofman@ivitera.com>
References: <1253054396-7978-1-git-send-email-pavel.hofman@ivitera.com>
	<1253054396-7978-2-git-send-email-pavel.hofman@ivitera.com>
	<1253054396-7978-3-git-send-email-pavel.hofman@ivitera.com>
	<1253054396-7978-4-git-send-email-pavel.hofman@ivitera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1253054396-7978-4-git-send-email-pavel.hofman@ivitera.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: Pavel Hofman <pavel.hofman@ivitera.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Pavel Hofman <pavel.hofman@ivitera.com>

* pro-rate-locking applies to internal clock mode only
* required rate and current rate are compared for internal clock mode only

Signed-off-by: Pavel Hofman <pavel.hofman@ivitera.com>

diff --git a/pci/ice1712/ice1724.c b/pci/ice1712/ice1724.c
index 673edd5..94d1c52 100644
--- a/pci/ice1712/ice1724.c
+++ b/pci/ice1712/ice1724.c
@@ -118,9 +118,12 @@ static inline int stdclock_is_spdif_master(struct snd_ice1712 *ice)
 	return (inb(ICEMT1724(ice, RATE)) & VT1724_SPDIF_MASTER) ? 1 : 0;
 }
 
+/*
+ * locking rate makes sense only for internal clock mode
+ */
 static inline int is_pro_rate_locked(struct snd_ice1712 *ice)
 {
-	return ice->is_spdif_master(ice) || PRO_RATE_LOCKED;
+	return (!ice->is_spdif_master(ice)) && PRO_RATE_LOCKED;
 }
 
 /*
@@ -657,16 +660,22 @@ static int snd_vt1724_set_pro_rate(struct snd_ice1712 *ice, unsigned int rate,
 		return -EBUSY;
 	}
 	if (!force && is_pro_rate_locked(ice)) {
+		/* comparing required and current rate - makes sense for
+		 * internal clock only */
 		spin_unlock_irqrestore(&ice->reg_lock, flags);
 		return (rate == ice->cur_rate) ? 0 : -EBUSY;
 	}
 
-	old_rate = ice->get_rate(ice);
-	if (force || (old_rate != rate))
-		ice->set_rate(ice, rate);
-	else if (rate == ice->cur_rate) {
-		spin_unlock_irqrestore(&ice->reg_lock, flags);
-		return 0;
+	if (force || !ice->is_spdif_master(ice)) {
+		/* force means the rate was switched by ucontrol, otherwise
+		 * setting clock rate for internal clock mode */
+		old_rate = ice->get_rate(ice);
+		if (force || (old_rate != rate))
+			ice->set_rate(ice, rate);
+		else if (rate == ice->cur_rate) {
+			spin_unlock_irqrestore(&ice->reg_lock, flags);
+			return 0;
+		}
 	}
 
 	ice->cur_rate = rate;
-- 
1.5.6.3
