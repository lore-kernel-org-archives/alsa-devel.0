From: linux@audioscience.com
Subject: [PATCH 02/28] Poison adapter_index in message. Remove
	unused function.
Date: Thu, 10 Feb 2011 17:25:55 +1300
Message-ID: <1297311981-30448-3-git-send-email-linux@audioscience.com>
References: <1297311981-30448-1-git-send-email-linux@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-reply-to: <1297311981-30448-1-git-send-email-linux@audioscience.com>
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
 pci/asihpi/hpimsginit.c |   18 ++----------------
 1 files changed, 2 insertions(+), 16 deletions(-)

diff --git a/pci/asihpi/hpimsginit.c b/pci/asihpi/hpimsginit.c
index 8e1d099..42f9182 100644
--- a/pci/asihpi/hpimsginit.c
+++ b/pci/asihpi/hpimsginit.c
@@ -32,21 +32,6 @@ static u16 res_size[HPI_OBJ_MAXINDEX + 1] = HPI_RESPONSE_SIZE_BY_OBJECT;
 static u16 gwSSX2_bypass;
 
 /** \internal
-  * Used by ASIO driver to disable SSX2 for a single process
-  * \param phSubSys Pointer to HPI subsystem handle.
-  * \param wBypass New bypass setting 0 = off, nonzero = on
-  * \return Previous bypass setting.
-  */
-u16 hpi_subsys_ssx2_bypass(const struct hpi_hsubsys *ph_subsys, u16 bypass)
-{
-	u16 old_value = gwSSX2_bypass;
-
-	gwSSX2_bypass = bypass;
-
-	return old_value;
-}
-
-/** \internal
   * initialize the HPI message structure
   */
 static void hpi_init_message(struct hpi_message *phm, u16 object,
@@ -65,7 +50,8 @@ static void hpi_init_message(struct hpi_message *phm, u16 object,
 	phm->object = object;
 	phm->function = function;
 	phm->version = 0;
-	/* Expect adapter index to be set by caller */
+	phm->adapter_index = 0xFFFF;
+	/* Expect actual adapter index to be set by caller */
 }
 
 /** \internal
-- 
1.7.0.4
