From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCH 2/3] ALSA: hdspm - Use enums in
	hdspm_tco_ltc_frames()
Date: Mon, 19 Aug 2013 17:20:31 +0200
Message-ID: <1376925632-5831-3-git-send-email-adi@drcomp.erfurt.thur.de>
References: <1376925632-5831-1-git-send-email-adi@drcomp.erfurt.thur.de>
 <1376925632-5831-2-git-send-email-adi@drcomp.erfurt.thur.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1376925632-5831-2-git-send-email-adi@drcomp.erfurt.thur.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: Adrian Knoth <adi@drcomp.erfurt.thur.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This patch doesn't change functionality, it only improves readability
and fixes a copy&paste error in a comment.

Signed-off-by: Adrian Knoth <adi@drcomp.erfurt.thur.de>

diff --git a/sound/pci/rme9652/hdspm.c b/sound/pci/rme9652/hdspm.c
index e4d76a6..3cde55b 100644
--- a/sound/pci/rme9652/hdspm.c
+++ b/sound/pci/rme9652/hdspm.c
@@ -3173,19 +3173,19 @@ static int hdspm_tco_ltc_frames(struct hdspm *hdspm)
 					HDSPM_TCO1_LTC_Format_MSB)) {
 		case 0:
 			/* 24 fps */
-			ret = 1;
+			ret = fps_24;
 			break;
 		case HDSPM_TCO1_LTC_Format_LSB:
 			/* 25 fps */
-			ret = 2;
+			ret = fps_25;
 			break;
 		case HDSPM_TCO1_LTC_Format_MSB:
-			/* 25 fps */
-			ret = 3;
+			/* 29.97 fps */
+			ret = fps_2997;
 			break;
 		default:
 			/* 30 fps */
-			ret = 4;
+			ret = fps_30;
 			break;
 		}
 	}
-- 
1.8.3.2
