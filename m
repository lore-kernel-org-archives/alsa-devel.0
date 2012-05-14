From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 04/15] ALSA: hda - Clear the power-saving
	states properly at reset
Date: Mon, 14 May 2012 17:31:55 +0200
Message-ID: <1337009526-26256-5-git-send-email-tiwai@suse.de>
References: <1337009526-26256-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by alsa0.perex.cz (Postfix) with ESMTP id 4025124A25
	for <alsa-devel@alsa-project.org>;
	Mon, 14 May 2012 17:32:18 +0200 (CEST)
Received: from relay1.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id E67138FFDD
	for <alsa-devel@alsa-project.org>;
	Mon, 14 May 2012 17:32:17 +0200 (CEST)
In-Reply-To: <1337009526-26256-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Some power-saving states have been left unchanged in
snd_hda_codec_reset(), and this is a potential danger because the
function may be called in various situations including the continuous
operation after that call.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_codec.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index e134e72..8bd3432 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -2265,6 +2265,9 @@ int snd_hda_codec_reset(struct hda_codec *codec)
 
 #ifdef CONFIG_SND_HDA_POWER_SAVE
 	cancel_delayed_work(&codec->power_work);
+	codec->power_on = 0;
+	codec->power_transition = 0;
+	codec->power_jiffies = jiffies;
 	flush_workqueue(codec->bus->workq);
 #endif
 	snd_hda_ctls_clear(codec);
-- 
1.7.9.2
