From: linux@audioscience.com
Subject: [PATCH 01/15] Give more meaningful name to hpi request
	message type
Date: Fri, 22 Jul 2011 15:52:37 +1200
Message-ID: <1311306785-23116-3-git-send-email-linux@audioscience.com>
References: <1311306785-23116-1-git-send-email-linux@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-reply-to: <1311306785-23116-1-git-send-email-linux@audioscience.com>
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

Having a 'request message' makes more sense than a 'message message'

Signed-off-by: Eliot Blennerhassett <eblennerhassett@audioscience.com>
---
 sound/pci/asihpi/hpi6000.c      |    4 ++--
 sound/pci/asihpi/hpi6205.c      |    7 ++++---
 sound/pci/asihpi/hpi_internal.h |    2 +-
 sound/pci/asihpi/hpicmn.c       |    2 +-
 sound/pci/asihpi/hpimsginit.c   |    4 ++--
 sound/pci/asihpi/hpimsgx.c      |    2 +-
 6 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/sound/pci/asihpi/hpi6000.c b/sound/pci/asihpi/hpi6000.c
index df4aed5..c8db36e 100644
--- a/sound/pci/asihpi/hpi6000.c
+++ b/sound/pci/asihpi/hpi6000.c
@@ -359,7 +359,7 @@ void HPI_6000(struct hpi_message *phm, struct hpi_response *phr)
 			HPI_ERROR_PROCESSING_MESSAGE);
 
 	switch (phm->type) {
-	case HPI_TYPE_MESSAGE:
+	case HPI_TYPE_REQUEST:
 		switch (phm->object) {
 		case HPI_OBJ_SUBSYSTEM:
 			subsys_message(phm, phr);
@@ -538,7 +538,7 @@ static short create_adapter_obj(struct hpi_adapter_obj *pao,
 
 		HPI_DEBUG_LOG(VERBOSE, "send ADAPTER_GET_INFO\n");
 		memset(&hm, 0, sizeof(hm));
-		hm.type = HPI_TYPE_MESSAGE;
+		hm.type = HPI_TYPE_REQUEST;
 		hm.size = sizeof(struct hpi_message);
 		hm.object = HPI_OBJ_ADAPTER;
 		hm.function = HPI_ADAPTER_GET_INFO;
diff --git a/sound/pci/asihpi/hpi6205.c b/sound/pci/asihpi/hpi6205.c
index 9d5df54..faff9e3 100644
--- a/sound/pci/asihpi/hpi6205.c
+++ b/sound/pci/asihpi/hpi6205.c
@@ -392,7 +392,7 @@ void _HPI_6205(struct hpi_adapter_obj *pao, struct hpi_message *phm,
 
 	HPI_DEBUG_LOG(VERBOSE, "start of switch\n");
 	switch (phm->type) {
-	case HPI_TYPE_MESSAGE:
+	case HPI_TYPE_REQUEST:
 		switch (phm->object) {
 		case HPI_OBJ_SUBSYSTEM:
 			subsys_message(pao, phm, phr);
@@ -634,11 +634,12 @@ static u16 create_adapter_obj(struct hpi_adapter_obj *pao,
 
 		HPI_DEBUG_LOG(VERBOSE, "init ADAPTER_GET_INFO\n");
 		memset(&hm, 0, sizeof(hm));
-		hm.type = HPI_TYPE_MESSAGE;
+		/* wAdapterIndex == version == 0 */
+		hm.type = HPI_TYPE_REQUEST;
 		hm.size = sizeof(hm);
 		hm.object = HPI_OBJ_ADAPTER;
 		hm.function = HPI_ADAPTER_GET_INFO;
-		hm.adapter_index = 0;
+
 		memset(&hr, 0, sizeof(hr));
 		hr.size = sizeof(hr);
 
diff --git a/sound/pci/asihpi/hpi_internal.h b/sound/pci/asihpi/hpi_internal.h
index bf5eced..ce5d7cd 100644
--- a/sound/pci/asihpi/hpi_internal.h
+++ b/sound/pci/asihpi/hpi_internal.h
@@ -364,7 +364,7 @@ Used in DLL to indicate device not present
 #define HPI_ADAPTER_ASI(f)   (f)
 
 enum HPI_MESSAGE_TYPES {
-	HPI_TYPE_MESSAGE = 1,
+	HPI_TYPE_REQUEST = 1,
 	HPI_TYPE_RESPONSE = 2,
 	HPI_TYPE_DATA = 3,
 	HPI_TYPE_SSX2BYPASS_MESSAGE = 4
diff --git a/sound/pci/asihpi/hpicmn.c b/sound/pci/asihpi/hpicmn.c
index b15a02e..801dcd8 100644
--- a/sound/pci/asihpi/hpicmn.c
+++ b/sound/pci/asihpi/hpicmn.c
@@ -682,7 +682,7 @@ static void subsys_message(struct hpi_message *phm, struct hpi_response *phr)
 void HPI_COMMON(struct hpi_message *phm, struct hpi_response *phr)
 {
 	switch (phm->type) {
-	case HPI_TYPE_MESSAGE:
+	case HPI_TYPE_REQUEST:
 		switch (phm->object) {
 		case HPI_OBJ_SUBSYSTEM:
 			subsys_message(phm, phr);
diff --git a/sound/pci/asihpi/hpimsginit.c b/sound/pci/asihpi/hpimsginit.c
index 628376c..52400a6 100644
--- a/sound/pci/asihpi/hpimsginit.c
+++ b/sound/pci/asihpi/hpimsginit.c
@@ -46,7 +46,7 @@ static void hpi_init_message(struct hpi_message *phm, u16 object,
 	if (gwSSX2_bypass)
 		phm->type = HPI_TYPE_SSX2BYPASS_MESSAGE;
 	else
-		phm->type = HPI_TYPE_MESSAGE;
+		phm->type = HPI_TYPE_REQUEST;
 	phm->object = object;
 	phm->function = function;
 	phm->version = 0;
@@ -89,7 +89,7 @@ static void hpi_init_messageV1(struct hpi_message_header *phm, u16 size,
 	memset(phm, 0, sizeof(*phm));
 	if ((object > 0) && (object <= HPI_OBJ_MAXINDEX)) {
 		phm->size = size;
-		phm->type = HPI_TYPE_MESSAGE;
+		phm->type = HPI_TYPE_REQUEST;
 		phm->object = object;
 		phm->function = function;
 		phm->version = 1;
diff --git a/sound/pci/asihpi/hpimsgx.c b/sound/pci/asihpi/hpimsgx.c
index 7352a5f..111f774 100644
--- a/sound/pci/asihpi/hpimsgx.c
+++ b/sound/pci/asihpi/hpimsgx.c
@@ -315,7 +315,7 @@ void hpi_send_recv_ex(struct hpi_message *phm, struct hpi_response *phr,
 {
 	HPI_DEBUG_MESSAGE(DEBUG, phm);
 
-	if (phm->type != HPI_TYPE_MESSAGE) {
+	if (phm->type != HPI_TYPE_REQUEST) {
 		hpi_init_response(phr, phm->object, phm->function,
 			HPI_ERROR_INVALID_TYPE);
 		return;
-- 
1.7.0.4
