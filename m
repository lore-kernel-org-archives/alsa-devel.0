From: Guneshwor Singh <guneshwor.o.singh@intel.com>
Subject: [alsa-lib][PATCH] topology: Fix to skip writing of
	header for compound elements
Date: Tue,  2 Jan 2018 10:50:01 +0530
Message-ID: <20180102052001.6952-1-guneshwor.o.singh@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 89DC4266FDE
 for <alsa-devel@alsa-project.org>; Tue,  2 Jan 2018 06:19:51 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: ALSA <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>
Cc: Patches Audio <patches.audio@intel.com>, Guneshwor Singh <guneshwor.o.singh@intel.com>, GuruprasadX Pawse <guruprasadx.pawse@intel.com>, "Subhransu S . Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

From: GuruprasadX Pawse <guruprasadx.pawse@intel.com>

While calculating the size of data to be written into the topology
binary file, the size of the compound elements is added as well. This
results in wrong file offset calculation and topology build failure.

The compound elements shouldn't be written to the topology as these are
already embedded as part of other elements. So, skip adding the size of
compound elements to the file offset size calculation.

Signed-off-by: GuruprasadX Pawse <guruprasadx.pawse@intel.com>
Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Guneshwor Singh <guneshwor.o.singh@intel.com>
---
 src/topology/builder.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/src/topology/builder.c b/src/topology/builder.c
index 997df0c7..5ae3ae89 100644
--- a/src/topology/builder.c
+++ b/src/topology/builder.c
@@ -95,6 +95,10 @@ static int write_elem_block(snd_tplg_t *tplg,
 	list_for_each(pos, base) {
 		/* find elems with the same index to make a block */
 		elem = list_entry(pos, struct tplg_elem, list);
+
+		if (elem->compound_elem)
+			continue;
+
 		elem_next = list_entry(pos->next, struct tplg_elem, list);
 		block_size += elem->size;
 		count++;
-- 
2.15.1
