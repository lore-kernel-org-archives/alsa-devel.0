From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCHv2 20/31] ALSA: hdspm - Enable AES32 in
	hdspm_get_tco_sample_rate
Date: Fri,  5 Jul 2013 11:28:12 +0200
Message-ID: <1373016503-9474-21-git-send-email-adi@drcomp.erfurt.thur.de>
References: <1373016503-9474-1-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-2-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-3-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-4-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-5-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-6-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-7-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-8-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-9-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-10-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-11-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-12-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-13-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-14-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-15-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-16-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-17-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-18-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-19-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-20-git-send-email-adi@drcomp.erfurt.thur.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1373016503-9474-20-git-send-email-adi@drcomp.erfurt.thur.de>
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

This patch adds AES32 specific code to hdspm_get_tco_sample_rate to
query the TCO sample rate.

Signed-off-by: Adrian Knoth <adi@drcomp.erfurt.thur.de>

diff --git a/sound/pci/rme9652/hdspm.c b/sound/pci/rme9652/hdspm.c
index a69957c..c0143cf 100644
--- a/sound/pci/rme9652/hdspm.c
+++ b/sound/pci/rme9652/hdspm.c
@@ -2204,6 +2204,9 @@ static int hdspm_get_tco_sample_rate(struct hdspm *hdspm)
 			status = hdspm_read(hdspm, HDSPM_RD_STATUS_1);
 			return (status >> 20) & 0xF;
 			break;
+		case AES32:
+			status = hdspm_read(hdspm, HDSPM_statusRegister);
+			return (status >> 1) & 0xF;
 		default:
 			break;
 		}
-- 
1.8.3.1
