From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: [PATCH 3/3] topology: add support for adding bytes
	controls to widgets
Date: Fri,  7 Aug 2015 17:03:54 +0100
Message-ID: <1438963434-6407-4-git-send-email-liam.r.girdwood@linux.intel.com>
References: <1438963434-6407-1-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id DB0C926066D
 for <alsa-devel@alsa-project.org>; Fri,  7 Aug 2015 18:04:04 +0200 (CEST)
In-Reply-To: <1438963434-6407-1-git-send-email-liam.r.girdwood@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>, Mengdong Lin <mengdong.lin@intel.com>, Mark Brown <broonie@kernel.org>, Liam Girdwood <liam.r.girdwood@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@intel.com>

Widgets can now contain byte controls.

Signed-off-by: Mengdong Lin <mengdong.lin@intel.com>
Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
---
 src/topology/dapm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/src/topology/dapm.c b/src/topology/dapm.c
index 25d11d7..4217211 100644
--- a/src/topology/dapm.c
+++ b/src/topology/dapm.c
@@ -160,6 +160,10 @@ static int tplg_build_widget(snd_tplg_t *tplg,
 				err = copy_dapm_control(elem, ref->elem);
 			break;
 
+		case SND_TPLG_TYPE_BYTES:
+			if (!ref->elem)
+				ref->elem = tplg_elem_lookup(&tplg->bytes_ext_list,
+						ref->id, SND_TPLG_TYPE_BYTES);
 			if (ref->elem)
 				err = copy_dapm_control(elem, ref->elem);
 			break;
-- 
2.1.4
