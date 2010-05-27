From: linux@audioscience.com
Subject: [PATCH 3/5] Remove support for old ASI8800 family. Fix
 imbalanced lock path in hw_message.
Date: Thu, 27 May 2010 17:53:53 +1200
Message-ID: <1274939635-1370-3-git-send-email-linux@audioscience.com>
References: <1274939635-1370-1-git-send-email-linux@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-reply-to: <1274939635-1370-1-git-send-email-linux@audioscience.com>
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
Cc: tiwai@suse.de, Eliot Blennerhassett <eblennerhassett@audioscience.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Eliot Blennerhassett <eblennerhassett@audioscience.com>

Signed-off-by: Eliot Blennerhassett <eblennerhassett@audioscience.com>
---
 sound/pci/asihpi/hpi6000.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/pci/asihpi/hpi6000.c b/sound/pci/asihpi/hpi6000.c
index 839ecb2..12dab5e 100644
--- a/sound/pci/asihpi/hpi6000.c
+++ b/sound/pci/asihpi/hpi6000.c
@@ -691,9 +691,6 @@ static short hpi6000_adapter_boot_load_dsp(struct hpi_adapter_obj *pao,
 	case 0x6200:
 		boot_load_family = HPI_ADAPTER_FAMILY_ASI(0x6200);
 		break;
-	case 0x8800:
-		boot_load_family = HPI_ADAPTER_FAMILY_ASI(0x8800);
-		break;
 	default:
 		return HPI6000_ERROR_UNHANDLED_SUBSYS_ID;
 	}
@@ -1775,7 +1772,6 @@ static void hw_message(struct hpi_adapter_obj *pao, struct hpi_message *phm,
 	u16 error = 0;
 	u16 dsp_index = 0;
 	u16 num_dsp = ((struct hpi_hw_obj *)pao->priv)->num_dsp;
-	hpios_dsplock_lock(pao);
 
 	if (num_dsp < 2)
 		dsp_index = 0;
@@ -1796,6 +1792,8 @@ static void hw_message(struct hpi_adapter_obj *pao, struct hpi_message *phm,
 			}
 		}
 	}
+
+	hpios_dsplock_lock(pao);
 	error = hpi6000_message_response_sequence(pao, dsp_index, phm, phr);
 
 	/* maybe an error response */
-- 
1.7.0.4
