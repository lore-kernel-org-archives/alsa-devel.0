From: Mike Rapoport <mike@compulab.co.il>
Subject: [PATCH] fix patch_ucb1400 for proper resume
Date: Wed, 02 Jul 2008 13:19:23 +0300
Message-ID: <486B562B.9040709@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sa15.bezeqint.net (sa15.bezeqint.net [192.115.104.30])
	by alsa0.perex.cz (Postfix) with ESMTP id 725B8245C1
	for <alsa-devel@alsa-project.org>;
	Wed,  2 Jul 2008 12:20:12 +0200 (CEST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by sa15.bezeqint.net (Bezeq International SMTP out Mail Server) with
	ESMTP id CC30928161
	for <alsa-devel@alsa-project.org>; Wed,  2 Jul 2008 13:24:32 +0300 (IDT)
Received: from sa15.bezeqint.net ([127.0.0.1])
	by localhost (sa15.bezeqint.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FfKiDH1bXDgS for <alsa-devel@alsa-project.org>;
	Wed,  2 Jul 2008 13:24:31 +0300 (IDT)
Received: from mail.linux-boards.com (mail.linux-boards.com [192.114.83.142])
	by sa15.bezeqint.net (Bezeq International SMTP out Mail Server) with
	ESMTP
	for <alsa-devel@alsa-project.org>; Wed,  2 Jul 2008 13:23:52 +0300 (IDT)
Received: from [10.1.1.95] (mike-pc.compulab.local [10.1.1.95])
	by mail.linux-boards.com (8.12.5/8.12.8) with ESMTP id m6298Y2F014882
	for <alsa-devel@alsa-project.org>; Wed, 2 Jul 2008 12:08:34 +0300
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
List-Id: alsa-devel@alsa-project.org

Replace 'snd_ac97_write' with snd_ac97_write_cache' in pacth_ucb1400 to allow
proper codec wakeup.


Signed-off-by: Mike Rapoport <mike@compulab.co.il>

diff --git a/sound/pci/ac97/ac97_patch.c b/sound/pci/ac97/ac97_patch.c
index 1292dce..b821874 100644
--- a/sound/pci/ac97/ac97_patch.c
+++ b/sound/pci/ac97/ac97_patch.c
@@ -3633,7 +3633,7 @@ static int patch_ucb1400(struct snd_ac97 * ac97)
 {
 	ac97->build_ops = &patch_ucb1400_ops;
 	/* enable headphone driver and smart low power mode by default */
-	snd_ac97_write(ac97, 0x6a, 0x0050);
-	snd_ac97_write(ac97, 0x6c, 0x0030);
+	snd_ac97_write_cache(ac97, 0x6a, 0x0050);
+	snd_ac97_write_cache(ac97, 0x6c, 0x0030);
 	return 0;
 }

-- 
Sincerely yours,
Mike.
