From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCH 5/8] hdspmixer: Provide headphones out on
	Multiface/Digiface
Date: Mon,  7 Mar 2011 19:03:06 +0100
Message-ID: <1299520989-14273-6-git-send-email-adi@drcomp.erfurt.thur.de>
References: <1299520989-14273-1-git-send-email-adi@drcomp.erfurt.thur.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1299520989-14273-1-git-send-email-adi@drcomp.erfurt.thur.de>
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
Cc: Adrian Knoth <adi@drcomp.erfurt.thur.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Both, Multiface and Digiface feature a separate headphone submix, so
reflect this additional pair of channels in the corresponding maps.

Signed-off-by: Adrian Knoth <adi@drcomp.erfurt.thur.de>

diff --git a/hdspmixer/src/channelmap.cxx b/hdspmixer/src/channelmap.cxx
index f2f0585..598be56 100644
--- a/hdspmixer/src/channelmap.cxx
+++ b/hdspmixer/src/channelmap.cxx
@@ -54,15 +54,18 @@ char channel_map_mf_ss[26] = {
 	0, 1, 2, 3, 4, 5, 6, 7,		/* Line in */
 	16, 17, 18, 19, 20, 21, 22, 23, /* ADAT */
 	24, 25,				/* SPDIF */
-	-1, -1, -1, -1, -1, -1, -1, -1
+	26, 27,             /* Phones L+R, only a destination channel */
+	-1, -1, -1, -1, -1, -1
 };
 
 // Digiface/Multiface
 
 char meter_map_ds[26] = {
-	0, 1, 2, 3, 8, 9, 10, 11, 16, 17, 18, 19,
-	24, 25,
-	-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1
+	0, 1, 2, 3, 8, 9, 10, 11, /* analog 1-8 on Multiface, ADAT1+2 on Digiface*/
+	16, 17, 18, 19, /* ADAT on Multiface, ADAT3 on Digiface */
+	24, 25, /* SPDIF */
+	26, 27, /* Headphones */
+	-1, -1, -1, -1, -1, -1, -1, -1, -1, -1
 };
 
 char channel_map_ds[26] = {
-- 
1.7.4.1
