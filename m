From: linux@audioscience.com
Subject: [PATCH] Allow mux to have up to 256 sources. Log
 warning and return index 0 rather than error if DSP returns invalid value.
 (amixer fails if error returned on get)
Date: Fri, 05 Feb 2010 12:50:40 +1300
Message-ID: <1265327440-6672-1-git-send-email-linux@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
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
Cc: Eliot Blennerhassett <eblennerhassett@audioscience.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Eliot Blennerhassett <eblennerhassett@audioscience.com>

Signed-off-by: Eliot Blennerhassett <eblennerhassett@audioscience.com>
---
 pci/asihpi/asihpi.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/pci/asihpi/asihpi.c b/pci/asihpi/asihpi.c
index 0c7b4fb..4f82e9f 100644
--- a/pci/asihpi/asihpi.c
+++ b/pci/asihpi/asihpi.c
@@ -2187,7 +2187,7 @@ static int snd_asihpi_mux_get(struct snd_kcontrol *kcontrol,
 	HPI_HandleError(HPI_Multiplexer_GetSource(phSubSys, hControl,
 				&wSourceType, &wSourceIndex));
 	/* Should cache this search result! */
-	for (s = 0; s < 16; s++) {
+	for (s = 0; s < 256; s++) {
 		if (HPI_Multiplexer_QuerySource(phSubSys, hControl, s,
 					    &wSrcNodeType, &wSrcNodeIndex))
 			break;
@@ -2198,7 +2198,10 @@ static int snd_asihpi_mux_get(struct snd_kcontrol *kcontrol,
 			return 0;
 		}
 	}
-	return -EINVAL;
+	snd_printd(KERN_WARNING "Control %x failed to match mux source %hu %hu\n",
+			hControl, wSourceType, wSourceIndex);
+	ucontrol->value.enumerated.item[0] = 0;
+	return 0;
 }
 
 static int snd_asihpi_mux_put(struct snd_kcontrol *kcontrol,
-- 
1.7.0.rc0.8.ge3f67d
