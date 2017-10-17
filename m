From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH v2 1/2] ALSA: hda: Remove superfluous '-' added
	by printk conversion
Date: Tue, 17 Oct 2017 12:34:00 +0200
Message-ID: <20171017103401.5556-2-tiwai@suse.de>
References: <20171017103401.5556-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id EB10B2672B6
 for <alsa-devel@alsa-project.org>; Tue, 17 Oct 2017 12:34:06 +0200 (CEST)
In-Reply-To: <20171017103401.5556-1-tiwai@suse.de>
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
Cc: PaX Team <pageexec@freemail.hu>, Takashi Sakamoto <o-takashi@sakamocchi.jp>
List-Id: alsa-devel@alsa-project.org

While converting the error messages to the standard macros in the
commit 4e76a8833fac ("ALSA: hda - Replace with standard printk"), a
superfluous '-' slipped in the code mistakenly.  Its influence is
almost negligible, merely shows a dB value as negative integer instead
of positive integer (or vice versa) in the rare error message.
So let's kill this embarrassing byte to show more correct value.

Fixes: 4e76a8833fac ("ALSA: hda - Replace with standard printk")
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_codec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 3db26c451837..b6cf9684c2ec 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -1824,7 +1824,7 @@ static int get_kctl_0dB_offset(struct hda_codec *codec,
 			return -1;
 		if (*step_to_check && *step_to_check != step) {
 			codec_err(codec, "Mismatching dB step for vmaster slave (%d!=%d)\n",
--				   *step_to_check, step);
+				   *step_to_check, step);
 			return -1;
 		}
 		*step_to_check = step;
-- 
2.14.2
