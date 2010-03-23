From: linux@audioscience.com
Subject: [PATCH 1/7] Remove obsolete comment Signed-off-by:
 Eliot Blennerhassett <eblennerhassett@audioscience.com>
Date: Tue, 23 Mar 2010 21:14:21 +1300
Message-ID: <1269332067-25959-2-git-send-email-linux@audioscience.com>
References: <1269332067-25959-1-git-send-email-linux@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-reply-to: <1269332067-25959-1-git-send-email-linux@audioscience.com>
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

---
 pci/asihpi/hpioctl.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/pci/asihpi/hpioctl.c b/pci/asihpi/hpioctl.c
index 247d5e9..dacef35 100644
--- a/pci/asihpi/hpioctl.c
+++ b/pci/asihpi/hpioctl.c
@@ -320,9 +320,6 @@ int __devinit asihpi_adapter_probe(
 	adapter.pci = pci_dev;
 
 	nm = HPI_MAX_ADAPTER_MEM_SPACES;
-	/* temporary for DM648, handled in hpi1000 */
-	if (pci_dev->device == 0xB003)
-		nm = 0;	/* don't map any for this device */
 
 	for (idx = 0; idx < nm; idx++) {
 		HPI_DEBUG_LOG(INFO, "Resource %d %s %08llx-%08llx %04llx\n",
-- 
1.7.0.rc0.8.ge3f67d
