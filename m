From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCH 1/1] ALSA: hdspm - Fix sync check reporting on
	RME RayDAT
Date: Wed,  7 Nov 2012 18:00:09 +0100
Message-ID: <1352307609-20485-2-git-send-email-adi@drcomp.erfurt.thur.de>
References: <1352307609-20485-1-git-send-email-adi@drcomp.erfurt.thur.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1352307609-20485-1-git-send-email-adi@drcomp.erfurt.thur.de>
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

The RayDAT reports the sync status of its inputs in consecutive bit
positions, so all we do in hdspm_s1_sync_check is to iterate over idx:

    status = hdspm_read(hdspm, HDSPM_RD_STATUS_1);

    lock = (status & (0x1<<idx)) ? 1 : 0;
    sync = (status & (0x100<<idx)) ? 1 : 0;

The index is given in kcontrol->private_value:

    HDSPM_SYNC_CHECK("WC SyncCheck", 0),
    HDSPM_SYNC_CHECK("AES SyncCheck", 1),
    HDSPM_SYNC_CHECK("SPDIF SyncCheck", 2),
    HDSPM_SYNC_CHECK("ADAT1 SyncCheck", 3),
    HDSPM_SYNC_CHECK("ADAT2 SyncCheck", 4),
    HDSPM_SYNC_CHECK("ADAT3 SyncCheck", 5),
    HDSPM_SYNC_CHECK("ADAT4 SyncCheck", 6),
    HDSPM_SYNC_CHECK("TCO SyncCheck", 7),
    HDSPM_SYNC_CHECK("SYNC IN SyncCheck", 8),

The patch corrects the indicated sync flags by passing the proper index
value to hdspm_s1_sync_check().

Signed-off-by: Adrian Knoth <adi@drcomp.erfurt.thur.de>
---
 sound/pci/rme9652/hdspm.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/pci/rme9652/hdspm.c b/sound/pci/rme9652/hdspm.c
index 35bb213..d7cc911 100644
--- a/sound/pci/rme9652/hdspm.c
+++ b/sound/pci/rme9652/hdspm.c
@@ -3977,7 +3977,8 @@ static int snd_hdspm_get_sync_check(struct snd_kcontrol *kcontrol,
 		case 8: /* SYNC IN */
 			val = hdspm_sync_in_sync_check(hdspm); break;
 		default:
-			val = hdspm_s1_sync_check(hdspm, ucontrol->id.index-1);
+			val = hdspm_s1_sync_check(hdspm,
+					kcontrol->private_value-1);
 		}
 		break;
 
-- 
1.7.10.4
