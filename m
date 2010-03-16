From: Dan Carpenter <error27@gmail.com>
Subject: [patch] sequencer: clean up remove bogus check
Date: Tue, 16 Mar 2010 09:46:23 +0300
Message-ID: <20100316064623.GA5331@bicker>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f220.google.com (mail-bw0-f220.google.com
	[209.85.218.220])
	by alsa0.perex.cz (Postfix) with ESMTP id BFF9A24661
	for <alsa-devel@alsa-project.org>; Tue, 16 Mar 2010 07:46:38 +0100 (CET)
Received: by bwz20 with SMTP id 20so9812304bwz.32
	for <alsa-devel@alsa-project.org>; Mon, 15 Mar 2010 23:46:36 -0700 (PDT)
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
To: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

A few lines earlier bend is limited to 2399.  So semitones is always
less than 24 here.

Signed-off-by: Dan Carpenter <error27@gmail.com>

diff --git a/sound/oss/sequencer.c b/sound/oss/sequencer.c
index c798746..e85789e 100644
--- a/sound/oss/sequencer.c
+++ b/sound/oss/sequencer.c
@@ -1631,8 +1631,6 @@ unsigned long compute_finetune(unsigned long base_freq, int bend, int range,
 	}
 
 	semitones = bend / 100;
-	if (semitones > 99)
-		semitones = 99;
 	cents = bend % 100;
 
 	amount = (int) (semitone_tuning[semitones] * multiplier * cent_tuning[cents]) / 10000;
