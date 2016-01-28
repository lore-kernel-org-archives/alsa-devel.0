From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v2] amixer: skip showing asoc tlv byte controls
Date: Thu, 28 Jan 2016 10:19:42 +0530
Message-ID: <1453956582-27254-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 77FC3260A59
 for <alsa-devel@alsa-project.org>; Thu, 28 Jan 2016 05:45:53 +0100 (CET)
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
Cc: liam.r.girdwood@linux.intel.com, tiwai@suse.de, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>, patches.audio@intel.com
List-Id: alsa-devel@alsa-project.org

ASoC TLV Byte controls are very large size controls so we should add new
options for these. So skip dumping contents for these.

$amixer -c0 cget numid=16
numid=16,iface=MIXER,name='mdl params'
  ; type=BYTES,access=-----RW-,values=30336
  : ASoC TLV Byte control, skipping bytes dump

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 amixer/amixer.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/amixer/amixer.c b/amixer/amixer.c
index db1849333da3..9ae75bfa3632 100644
--- a/amixer/amixer.c
+++ b/amixer/amixer.c
@@ -682,6 +682,12 @@ static int show_control(const char *space, snd_hctl_elem_t *elem,
 	      __skip_read:
 		if (!snd_ctl_elem_info_is_tlv_readable(info))
 			goto __skip_tlv;
+		/* skip show for ASoC TLV Byte controls */
+		if (type == SND_CTL_ELEM_TYPE_BYTES) {
+			printf("%s: ASoC TLV Byte control, skipping bytes dump\n", space);
+			goto __skip_tlv;
+		}
+
 		tlv = malloc(4096);
 		if ((err = snd_hctl_elem_tlv_read(elem, tlv, 4096)) < 0) {
 			error("Control %s element TLV read error: %s\n", card, snd_strerror(err));
-- 
1.9.1
