From: Adrian Bunk <bunk@stusta.de>
Subject: [2.6 patch] include/sound/gus.h: "extern inline" -> "static inline"
Date: Wed, 24 Aug 2005 17:55:34 +0200
Message-ID: <20050824155534.GE4851__2970.7727292136$1124899143$gmane$org@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mailout.stusta.mhn.de (mailout.stusta.mhn.de [141.84.69.5])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id A7D6324C
	for <alsa-devel@alsa-project.org>; Wed, 24 Aug 2005 17:55:35 +0200 (MEST)
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: perex@suse.cz
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

"extern inline" doesn't make much sense.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 include/sound/gus.h |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

--- linux-2.6.13-rc6-mm2-full/include/sound/gus.h.old	2005-08-24 16:53:29.000000000 +0200
+++ linux-2.6.13-rc6-mm2-full/include/sound/gus.h	2005-08-24 16:53:34.000000000 +0200
@@ -512,13 +512,13 @@
 
 extern void snd_gf1_write8(snd_gus_card_t * gus, unsigned char reg, unsigned char data);
 extern unsigned char snd_gf1_look8(snd_gus_card_t * gus, unsigned char reg);
-extern inline unsigned char snd_gf1_read8(snd_gus_card_t * gus, unsigned char reg)
+static inline unsigned char snd_gf1_read8(snd_gus_card_t * gus, unsigned char reg)
 {
 	return snd_gf1_look8(gus, reg | 0x80);
 }
 extern void snd_gf1_write16(snd_gus_card_t * gus, unsigned char reg, unsigned int data);
 extern unsigned short snd_gf1_look16(snd_gus_card_t * gus, unsigned char reg);
-extern inline unsigned short snd_gf1_read16(snd_gus_card_t * gus, unsigned char reg)
+static inline unsigned short snd_gf1_read16(snd_gus_card_t * gus, unsigned char reg)
 {
 	return snd_gf1_look16(gus, reg | 0x80);
 }
@@ -532,12 +532,12 @@
 extern void snd_gf1_i_write8(snd_gus_card_t * gus, unsigned char reg, unsigned char data);
 extern unsigned char snd_gf1_i_look8(snd_gus_card_t * gus, unsigned char reg);
 extern void snd_gf1_i_write16(snd_gus_card_t * gus, unsigned char reg, unsigned int data);
-extern inline unsigned char snd_gf1_i_read8(snd_gus_card_t * gus, unsigned char reg)
+static inline unsigned char snd_gf1_i_read8(snd_gus_card_t * gus, unsigned char reg)
 {
 	return snd_gf1_i_look8(gus, reg | 0x80);
 }
 extern unsigned short snd_gf1_i_look16(snd_gus_card_t * gus, unsigned char reg);
-extern inline unsigned short snd_gf1_i_read16(snd_gus_card_t * gus, unsigned char reg)
+static inline unsigned short snd_gf1_i_read16(snd_gus_card_t * gus, unsigned char reg)
 {
 	return snd_gf1_i_look16(gus, reg | 0x80);
 }



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
