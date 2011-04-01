From: linux@audioscience.com
Subject: [snd-asihpi 5/8] Remove 2 unused functions.
Date: Fri, 01 Apr 2011 15:59:49 +1300
Message-ID: <1301626792-13705-6-git-send-email-linux@audioscience.com>
References: <1301626792-13705-1-git-send-email-linux@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-reply-to: <1301626792-13705-1-git-send-email-linux@audioscience.com>
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
 pci/asihpi/hpifunc.c |   27 ---------------------------
 1 files changed, 0 insertions(+), 27 deletions(-)

diff --git a/pci/asihpi/hpifunc.c b/pci/asihpi/hpifunc.c
index c38fc94..7397b16 100644
--- a/pci/asihpi/hpifunc.c
+++ b/pci/asihpi/hpifunc.c
@@ -105,33 +105,6 @@ u16 hpi_subsys_get_version_ex(u32 *pversion_ex)
 	return hr.error;
 }
 
-u16 hpi_subsys_create_adapter(const struct hpi_resource *p_resource,
-	u16 *pw_adapter_index)
-{
-	struct hpi_message hm;
-	struct hpi_response hr;
-
-	hpi_init_message_response(&hm, &hr, HPI_OBJ_SUBSYSTEM,
-		HPI_SUBSYS_CREATE_ADAPTER);
-	hm.u.s.resource = *p_resource;
-
-	hpi_send_recv(&hm, &hr);
-
-	*pw_adapter_index = hr.u.s.adapter_index;
-	return hr.error;
-}
-
-u16 hpi_subsys_delete_adapter(u16 adapter_index)
-{
-	struct hpi_message hm;
-	struct hpi_response hr;
-	hpi_init_message_response(&hm, &hr, HPI_OBJ_SUBSYSTEM,
-		HPI_SUBSYS_DELETE_ADAPTER);
-	hm.obj_index = adapter_index;
-	hpi_send_recv(&hm, &hr);
-	return hr.error;
-}
-
 u16 hpi_subsys_get_num_adapters(int *pn_num_adapters)
 {
 	struct hpi_message hm;
-- 
1.7.0.4
