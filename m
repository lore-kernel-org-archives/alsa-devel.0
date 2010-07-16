From: linux@audioscience.com
Subject: [PATCH 9/9] Avoid useless assignment of returned index
	values.
Date: Fri, 16 Jul 2010 17:51:01 +1200
Message-ID: <1279259461-21543-4-git-send-email-linux@audioscience.com>
References: <1279259461-21543-1-git-send-email-linux@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-reply-to: <1279259461-21543-1-git-send-email-linux@audioscience.com>
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
 pci/asihpi/hpifunc.c |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/pci/asihpi/hpifunc.c b/pci/asihpi/hpifunc.c
index 9c6958a..1e92eb6 100644
--- a/pci/asihpi/hpifunc.c
+++ b/pci/asihpi/hpifunc.c
@@ -2179,7 +2179,7 @@ u16 hpi_compander_get_attack_time_constant(const struct hpi_hsubsys
 	*ph_subsys, u32 h_control, unsigned int index, u32 *attack)
 {
 	return hpi_control_param_get(ph_subsys, h_control,
-		HPI_COMPANDER_ATTACK, 0, index, attack, &index);
+		HPI_COMPANDER_ATTACK, 0, index, attack, NULL);
 }
 
 u16 hpi_compander_set_decay_time_constant(const struct hpi_hsubsys *ph_subsys,
@@ -2193,7 +2193,7 @@ u16 hpi_compander_get_decay_time_constant(const struct hpi_hsubsys *ph_subsys,
 	u32 h_control, unsigned int index, u32 *decay)
 {
 	return hpi_control_param_get(ph_subsys, h_control,
-		HPI_COMPANDER_DECAY, 0, index, decay, &index);
+		HPI_COMPANDER_DECAY, 0, index, decay, NULL);
 
 }
 
@@ -2244,7 +2244,7 @@ u16 hpi_compander_get_ratio(const struct hpi_hsubsys *ph_subsys,
 	u32 h_control, u32 index, u32 *ratio100)
 {
 	return hpi_control_param_get(ph_subsys, h_control,
-		HPI_COMPANDER_RATIO, 0, index, ratio100, &index);
+		HPI_COMPANDER_RATIO, 0, index, ratio100, NULL);
 }
 
 u16 hpi_level_query_range(const struct hpi_hsubsys *ph_subsys, u32 h_control,
@@ -3258,8 +3258,7 @@ static inline size_t hpi_entity_item_count(struct hpi_entity *entity_ptr)
 static inline struct hpi_entity *hpi_entity_ptr_to_next(struct hpi_entity
 	*entity_ptr)
 {
-	return (void *)(((uint8_t *) entity_ptr) +
-		hpi_entity_size(entity_ptr));
+	return (void *)(((u8 *)entity_ptr) + hpi_entity_size(entity_ptr));
 }
 
 static inline u16 hpi_entity_check_type(const enum e_entity_type t)
-- 
1.7.0.4
