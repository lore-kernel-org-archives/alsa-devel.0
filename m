From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH - alsa-lib 3/3] tlv: Remove tailing tab after
	snd_ctl_get_dB_range function
Date: Mon, 19 Jul 2010 10:14:06 +0300
Message-ID: <1279523646-4987-4-git-send-email-peter.ujfalusi@nokia.com>
References: <1279523646-4987-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id 0F23A10388D
	for <alsa-devel@alsa-project.org>;
	Mon, 19 Jul 2010 09:14:43 +0200 (CEST)
In-Reply-To: <1279523646-4987-1-git-send-email-peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Cosmetic fix.
There was a tab instead of new line after snd_ctl_get_dB_range
function.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 src/control/tlv.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/control/tlv.c b/src/control/tlv.c
index 1767118..ddc4517 100644
--- a/src/control/tlv.c
+++ b/src/control/tlv.c
@@ -439,7 +439,7 @@ int snd_ctl_get_dB_range(snd_ctl_t *ctl, const snd_ctl_elem_id_t *id,
 	return snd_tlv_get_dB_range(info.tlv, info.minval, info.maxval,
 				    min, max);
 }
-	
+
 /**
  * \brief Convert the volume value to dB on the given control element
  * \param ctl the control handler
-- 
1.7.1.1
