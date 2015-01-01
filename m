From: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
Subject: [PATCH] sound: drivers: portman2x4.c: Remove some
	unused functions
Date: Thu,  1 Jan 2015 16:12:45 +0100
Message-ID: <1420125165-26527-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f169.google.com (mail-wi0-f169.google.com
 [209.85.212.169])
 by alsa0.perex.cz (Postfix) with ESMTP id 96D662604D0
 for <alsa-devel@alsa-project.org>; Thu,  1 Jan 2015 16:09:45 +0100 (CET)
Received: by mail-wi0-f169.google.com with SMTP id r20so28156307wiv.2
 for <alsa-devel@alsa-project.org>; Thu, 01 Jan 2015 07:09:45 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
List-Id: alsa-devel@alsa-project.org

Removes some functions that are not used anywhere:
portman_read_data() portman_read_command()

This was partially found by using a static code analysis program called cppcheck.

Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
---
 sound/drivers/portman2x4.c |   10 ----------
 1 file changed, 10 deletions(-)

diff --git a/sound/drivers/portman2x4.c b/sound/drivers/portman2x4.c
index 78ccfa4..b5b6b4e 100644
--- a/sound/drivers/portman2x4.c
+++ b/sound/drivers/portman2x4.c
@@ -198,21 +198,11 @@ static inline void portman_write_command(struct portman *pm, u8 value)
 	parport_write_control(pm->pardev->port, value);
 }
 
-static inline u8 portman_read_command(struct portman *pm)
-{
-	return parport_read_control(pm->pardev->port);
-}
-
 static inline u8 portman_read_status(struct portman *pm)
 {
 	return parport_read_status(pm->pardev->port);
 }
 
-static inline u8 portman_read_data(struct portman *pm)
-{
-	return parport_read_data(pm->pardev->port);
-}
-
 static inline void portman_write_data(struct portman *pm, u8 value)
 {
 	parport_write_data(pm->pardev->port, value);
-- 
1.7.10.4
