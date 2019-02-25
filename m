From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda: Extend i915 component bind timeout
Date: Mon, 25 Feb 2019 17:02:57 +0100
Message-ID: <20190225160257.31560-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id F296DF89643
 for <alsa-devel@alsa-project.org>; Mon, 25 Feb 2019 17:03:00 +0100 (CET)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
Cc: Paul Menzel <pmenzel+alsa-devel@molgen.mpg.de>
List-Id: alsa-devel@alsa-project.org

I set 10 seconds for the timeout of the i915 audio component binding
with a hope that recent machines are fast enough to handle all probe
tasks in that period, but I was too optimistic.  The binding may take
longer than that, and this caused a problem on the machine with both
audio and graphics driver modules loaded in parallel, as Paul Menzel
experienced.  This problem haven't hit so often just because the KMS
driver is loaded in initrd on most machines.

As a simple workaround, extend the timeout to 60 seconds.

Fixes: f9b54e1961c7 ("ALSA: hda/i915: Allow delayed i915 audio component binding")
Reported-by: Paul Menzel <pmenzel+alsa-devel@molgen.mpg.de>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/hda/hdac_i915.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/hda/hdac_i915.c b/sound/hda/hdac_i915.c
index 617ff1aa818f..27eb0270a711 100644
--- a/sound/hda/hdac_i915.c
+++ b/sound/hda/hdac_i915.c
@@ -144,9 +144,9 @@ int snd_hdac_i915_init(struct hdac_bus *bus)
 		return -ENODEV;
 	if (!acomp->ops) {
 		request_module("i915");
-		/* 10s timeout */
+		/* 60s timeout */
 		wait_for_completion_timeout(&bind_complete,
-					    msecs_to_jiffies(10 * 1000));
+					    msecs_to_jiffies(60 * 1000));
 	}
 	if (!acomp->ops) {
 		dev_info(bus->dev, "couldn't bind with audio component\n");
-- 
2.16.4
