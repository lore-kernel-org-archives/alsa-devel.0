From: Roel Kluin <roel.kluin@gmail.com>
Subject: Re: [PATCH] sound/oss/pss: Fix test of unsigned in
 pss_reset_dsp() and pss_download_boot()
Date: Wed, 16 Dec 2009 16:54:43 +0100
Message-ID: <4B2902C3.3080606@gmail.com>
References: <4B28085A.6020101@gmail.com> <s5hr5qvf7rt.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f217.google.com (mail-bw0-f217.google.com
	[209.85.218.217])
	by alsa0.perex.cz (Postfix) with ESMTP id A7C991037EA
	for <alsa-devel@alsa-project.org>; Wed, 16 Dec 2009 16:52:50 +0100 (CET)
Received: by bwz9 with SMTP id 9so1765168bwz.32
	for <alsa-devel@alsa-project.org>; Wed, 16 Dec 2009 07:52:50 -0800 (PST)
In-Reply-To: <s5hr5qvf7rt.wl%tiwai@suse.de>
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
Cc: LKML <linux-kernel@vger.kernel.org>, alsa-devel@alsa-project.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: alsa-devel@alsa-project.org

limit and jiffies are unsigned so the test did not work.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
Found using coccinelle: http://coccinelle.lip6.fr/

>> -	for (i = 0; i < 32768 && (limit-jiffies >= 0); i++)
>> +	for (i = 0; i < 32768 && (limit >= jiffies); i++)
> 
> No, it should use time_after_eq(limit, jiffies) instead.
> 
> 
> thanks,
> 
> Takashi
> 

Ok,

diff --git a/sound/oss/pss.c b/sound/oss/pss.c
index 83f5ee2..e19dd5d 100644
--- a/sound/oss/pss.c
+++ b/sound/oss/pss.c
@@ -269,7 +269,7 @@ static int pss_reset_dsp(pss_confdata * devc)
 	unsigned long   i, limit = jiffies + HZ/10;
 
 	outw(0x2000, REG(PSS_CONTROL));
-	for (i = 0; i < 32768 && (limit-jiffies >= 0); i++)
+	for (i = 0; i < 32768 && time_after_eq(limit, jiffies); i++)
 		inw(REG(PSS_CONTROL));
 	outw(0x0000, REG(PSS_CONTROL));
 	return 1;
@@ -369,11 +369,11 @@ static int pss_download_boot(pss_confdata * devc, unsigned char *block, int size
 		outw(0, REG(PSS_DATA));
 
 		limit = jiffies + HZ/10;
-		for (i = 0; i < 32768 && (limit - jiffies >= 0); i++)
+		for (i = 0; i < 32768 && time_after_eq(limit, jiffies); i++)
 			val = inw(REG(PSS_STATUS));
 
 		limit = jiffies + HZ/10;
-		for (i = 0; i < 32768 && (limit-jiffies >= 0); i++)
+		for (i = 0; i < 32768 && time_after_eq(limit, jiffies); i++)
 		{
 			val = inw(REG(PSS_STATUS));
 			if (val & 0x4000)
