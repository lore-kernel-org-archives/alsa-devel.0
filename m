From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: core: Use consistent byte ordering in
	snd_soc_bytes_get
Date: Fri, 29 Nov 2013 13:33:11 +0000
Message-ID: <1385731991-8401-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 056C1261AE7
 for <alsa-devel@alsa-project.org>; Fri, 29 Nov 2013 14:46:15 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

snd_soc_bytes_put treats the data in the binary control as big endian
words, however snd_soc_bytes_get uses the endian of the host machine.
This causes the two functions to be inconsistant with how the mask is
applied on little endian machines.

This patch applies the big_endian format used in snd_soc_bytes_put to
snd_soc_bytes_get.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/soc-core.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 4e53d87..a66783e 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -3212,11 +3212,11 @@ int snd_soc_bytes_get(struct snd_kcontrol *kcontrol,
 			break;
 		case 2:
 			((u16 *)(&ucontrol->value.bytes.data))[0]
-				&= ~params->mask;
+				&= cpu_to_be16(~params->mask);
 			break;
 		case 4:
 			((u32 *)(&ucontrol->value.bytes.data))[0]
-				&= ~params->mask;
+				&= cpu_to_be32(~params->mask);
 			break;
 		default:
 			return -EINVAL;
-- 
1.7.2.5
