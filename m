From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: [PATCH 001] fix a race in dynamic power managment
Date: Mon, 3 Sep 2007 15:16:12 +0300
Message-ID: <200709031516.12768.maximlevitsky@gmail.com>
References: <200709031514.57875.maximlevitsky@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fk-out-0910.google.com (fk-out-0910.google.com [209.85.128.190])
	by alsa0.perex.cz (Postfix) with ESMTP id E7A7810390D
	for <alsa-devel@alsa-project.org>;
	Mon,  3 Sep 2007 15:17:30 +0200 (CEST)
Received: by fk-out-0910.google.com with SMTP id f40so1482713fka
	for <alsa-devel@alsa-project.org>; Mon, 03 Sep 2007 06:17:30 -0700 (PDT)
In-Reply-To: <200709031514.57875.maximlevitsky@gmail.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, mranostay@embeddedalley.com
List-Id: alsa-devel@alsa-project.org

>From 90380fbb9865dda45a5be8085ef556f3ce203244 Mon Sep 17 00:00:00 2001
From: Maxim Levitsky <maximlevitsky@gmail.com>
Date: Mon, 3 Sep 2007 14:01:52 +0300
Subject: [PATCH] fix a race in dynamic power managment

codec->power_transition is supposed to be true while codec is going to be shut off
if in the mean time somebody calls snd_hda_power_up, hda_power_work will not shut down the codec,
but nether will clear codec->power_transition, thus it stays on forever. Fix this

Signed-off-by: Maxim Levitsky <maximlevitsky@gmail.com>
---
 pci/hda/hda_codec.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/pci/hda/hda_codec.c b/pci/hda/hda_codec.c
index 46d4253..08104e2 100644
--- a/pci/hda/hda_codec.c
+++ b/pci/hda/hda_codec.c
@@ -2195,8 +2195,10 @@ static void hda_power_work(struct work_struct *work)
 	struct hda_codec *codec =
 		container_of(work, struct hda_codec, power_work.work);
 
-	if (!codec->power_on || codec->power_count)
+	if (!codec->power_on || codec->power_count) {
+		codec->power_transition = 0;
 		return;
+	}
 
 	hda_call_codec_suspend(codec);
 	if (codec->bus->ops.pm_notify)
-- 
1.5.2.3
