From: linux@audioscience.com
Subject: [PATCH 16/28] Replace adapter list with single item in
	subsys response.
Date: Thu, 10 Feb 2011 17:26:09 +1300
Message-ID: <1297311981-30448-17-git-send-email-linux@audioscience.com>
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
 pci/asihpi/hpi6000.c      |    3 +--
 pci/asihpi/hpi6205.c      |    3 +--
 pci/asihpi/hpi_internal.h |    7 ++++---
 pci/asihpi/hpicmn.c       |    5 ++---
 pci/asihpi/hpifunc.c      |    3 ++-
 pci/asihpi/hpioctl.c      |    2 +-
 6 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/pci/asihpi/hpi6000.c b/pci/asihpi/hpi6000.c
index 9a05672..3e3c2ef 100644
--- a/pci/asihpi/hpi6000.c
+++ b/pci/asihpi/hpi6000.c
@@ -458,9 +458,8 @@ static void subsys_create_adapter(struct hpi_message *phm,
 		phw->ado[dsp_index].pa_parent_adapter = pao;
 	}
 
-	phr->u.s.aw_adapter_list[ao.index] = ao.adapter_type;
+	phr->u.s.adapter_type = ao.adapter_type;
 	phr->u.s.adapter_index = ao.index;
-	phr->u.s.num_adapters++;
 	phr->error = 0;
 }
 
diff --git a/pci/asihpi/hpi6205.c b/pci/asihpi/hpi6205.c
index eefe459..971c593 100644
--- a/pci/asihpi/hpi6205.c
+++ b/pci/asihpi/hpi6205.c
@@ -488,9 +488,8 @@ static void subsys_create_adapter(struct hpi_message *phm,
 		return;
 	}
 
-	phr->u.s.aw_adapter_list[ao.index] = ao.adapter_type;
+	phr->u.s.adapter_type = ao.adapter_type;
 	phr->u.s.adapter_index = ao.index;
-	phr->u.s.num_adapters++;
 	phr->error = 0;
 }
 
diff --git a/pci/asihpi/hpi_internal.h b/pci/asihpi/hpi_internal.h
index 9f003a4..10de7e0 100644
--- a/pci/asihpi/hpi_internal.h
+++ b/pci/asihpi/hpi_internal.h
@@ -626,10 +626,11 @@ struct hpi_subsys_msg {
 
 struct hpi_subsys_res {
 	u32 version;
-	u32 data;		/* used to return extended version */
-	u16 num_adapters;	/* number of adapters */
+	u32 data;		/* extended version */
+	u16 num_adapters;
 	u16 adapter_index;
-	u16 aw_adapter_list[HPI_MAX_ADAPTERS];
+	u16 adapter_type;
+	u16 pad16;
 };
 
 union hpi_adapterx_msg {
diff --git a/pci/asihpi/hpicmn.c b/pci/asihpi/hpicmn.c
index 4d696ab..e0a08f6 100644
--- a/pci/asihpi/hpicmn.c
+++ b/pci/asihpi/hpicmn.c
@@ -164,11 +164,10 @@ static void subsys_get_adapter(struct hpi_message *phm,
 
 	if (index < HPI_MAX_ADAPTERS) {
 		phr->u.s.adapter_index = adapters.adapter[index].index;
-		phr->u.s.aw_adapter_list[0] =
-			adapters.adapter[index].adapter_type;
+		phr->u.s.adapter_type = adapters.adapter[index].adapter_type;
 	} else {
 		phr->u.s.adapter_index = 0;
-		phr->u.s.aw_adapter_list[0] = 0;
+		phr->u.s.adapter_type = 0;
 		phr->error = HPI_ERROR_BAD_ADAPTER_NUMBER;
 	}
 }
diff --git a/pci/asihpi/hpifunc.c b/pci/asihpi/hpifunc.c
index 28e98dd..53924e4 100644
--- a/pci/asihpi/hpifunc.c
+++ b/pci/asihpi/hpifunc.c
@@ -153,7 +153,8 @@ u16 hpi_subsys_get_adapter(int iterator, u32 *padapter_index,
 	hm.obj_index = (u16)iterator;
 	hpi_send_recv(&hm, &hr);
 	*padapter_index = (int)hr.u.s.adapter_index;
-	*pw_adapter_type = hr.u.s.aw_adapter_list[0];
+	*pw_adapter_type = hr.u.s.adapter_type;
+
 	return hr.error;
 }
 
diff --git a/pci/asihpi/hpioctl.c b/pci/asihpi/hpioctl.c
index 4bd3278..0ea9aae 100644
--- a/pci/asihpi/hpioctl.c
+++ b/pci/asihpi/hpioctl.c
@@ -389,7 +389,7 @@ int __devinit asihpi_adapter_probe(struct pci_dev *pci_dev,
 	}
 
 	adapter.index = hr.u.s.adapter_index;
-	adapter.type = hr.u.s.aw_adapter_list[adapter.index];
+	adapter.type = hr.u.s.adapter_type;
 	hm.adapter_index = adapter.index;
 
 	err = hpi_adapter_open(adapter.index);
-- 
1.7.0.4
