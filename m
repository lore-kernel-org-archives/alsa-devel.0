From: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
Subject: [PATCH] sound: firewire: fireworks: fireworks_command:
	Remove unused function
Date: Sat, 10 Jan 2015 17:53:00 +0100
Message-ID: <1420908780-31468-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f180.google.com (mail-wi0-f180.google.com
 [209.85.212.180])
 by alsa0.perex.cz (Postfix) with ESMTP id 0E330260415
 for <alsa-devel@alsa-project.org>; Sat, 10 Jan 2015 17:49:54 +0100 (CET)
Received: by mail-wi0-f180.google.com with SMTP id n3so7691830wiv.1
 for <alsa-devel@alsa-project.org>; Sat, 10 Jan 2015 08:49:54 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>, Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Takashi Sakamoto <o-takashi@sakamocchi.jp>, linux-kernel@vger.kernel.org, Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
List-Id: alsa-devel@alsa-project.org

Remove the function snd_efw_command_set_resp_addr() that is not used anywhere.

This was partially found by using a static code analysis program called cppcheck.

Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
---
 sound/firewire/fireworks/fireworks.h         |    2 --
 sound/firewire/fireworks/fireworks_command.c |   21 ---------------------
 2 files changed, 23 deletions(-)

diff --git a/sound/firewire/fireworks/fireworks.h b/sound/firewire/fireworks/fireworks.h
index 4f0201a..693b76b 100644
--- a/sound/firewire/fireworks/fireworks.h
+++ b/sound/firewire/fireworks/fireworks.h
@@ -189,8 +189,6 @@ enum snd_efw_transport_mode {
 	SND_EFW_TRANSPORT_MODE_WINDOWS	= 0,
 	SND_EFW_TRANSPORT_MODE_IEC61883	= 1,
 };
-int snd_efw_command_set_resp_addr(struct snd_efw *efw,
-				  u16 addr_high, u32 addr_low);
 int snd_efw_command_set_tx_mode(struct snd_efw *efw,
 				enum snd_efw_transport_mode mode);
 int snd_efw_command_get_hwinfo(struct snd_efw *efw,
diff --git a/sound/firewire/fireworks/fireworks_command.c b/sound/firewire/fireworks/fireworks_command.c
index 166f805..e0cc467 100644
--- a/sound/firewire/fireworks/fireworks_command.c
+++ b/sound/firewire/fireworks/fireworks_command.c
@@ -175,27 +175,6 @@ end:
 }
 
 /*
- * The address in host system for transaction response is changable when the
- * device supports. struct hwinfo.flags includes its flag. The default is
- * MEMORY_SPACE_EFW_RESPONSE.
- */
-int snd_efw_command_set_resp_addr(struct snd_efw *efw,
-				  u16 addr_high, u32 addr_low)
-{
-	__be32 addr[2];
-
-	addr[0] = cpu_to_be32(addr_high);
-	addr[1] = cpu_to_be32(addr_low);
-
-	if (!efw->resp_addr_changable)
-		return -ENOSYS;
-
-	return efw_transaction(efw, EFC_CAT_HWCTL,
-			       EFC_CMD_HWINFO_SET_RESP_ADDR,
-			       addr, sizeof(addr), NULL, 0);
-}
-
-/*
  * This is for timestamp processing. In Windows mode, all 32bit fields of second
  * CIP header in AMDTP transmit packet is used for 'presentation timestamp'. In
  * 'no data' packet the value of this field is 0x90ffffff.
-- 
1.7.10.4
