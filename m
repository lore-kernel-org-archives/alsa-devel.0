From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH 3/6] ALSA: seq: fix off-by-one error in port
	limit check
Date: Sun, 25 Jan 2015 14:35:24 +0100
Message-ID: <54C4F11C.1090903@ladisch.de>
References: <54C4F0A1.2000907@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id C654B260444
 for <alsa-devel@alsa-project.org>; Sun, 25 Jan 2015 14:35:23 +0100 (CET)
In-Reply-To: <54C4F0A1.2000907@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Clemens Ladisch <clemens@ladisch.de>
---
 sound/core/seq/seq_ports.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/core/seq/seq_ports.c b/sound/core/seq/seq_ports.c
index 794a341..52b279b 100644
--- a/sound/core/seq/seq_ports.c
+++ b/sound/core/seq/seq_ports.c
@@ -134,7 +134,7 @@ struct snd_seq_client_port *snd_seq_create_port(struct snd_seq_client *client,
 	if (snd_BUG_ON(!client))
 		return NULL;

-	if (client->num_ports >= SNDRV_SEQ_MAX_PORTS - 1) {
+	if (client->num_ports >= SNDRV_SEQ_MAX_PORTS) {
 		pr_warn("ALSA: seq: too many ports for client %d\n", client->number);
 		return NULL;
 	}
