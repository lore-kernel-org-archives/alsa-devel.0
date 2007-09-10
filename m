From: Rene Herman <rene.herman@gmail.com>
Subject: [PATCH] ad1848: replace HZ calculus with
	msecs_to_jiffies()
Date: Mon, 10 Sep 2007 20:43:12 +0200
Message-ID: <46E59040.8090707@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------070902000102070505020504"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq1.groni1.gr.home.nl (smtpq1.groni1.gr.home.nl
	[213.51.130.200])
	by alsa0.perex.cz (Postfix) with ESMTP id 17977103827
	for <alsa-devel@alsa-project.org>;
	Mon, 10 Sep 2007 20:50:13 +0200 (CEST)
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
Cc: Krzysztof Helt <krzysztof.h1@gmail.com>, ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------070902000102070505020504
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Hi Takashi.

If I'm not mistaken, any (new) use of HZ these days is considered a bug so 
while I'm there...

Signed-off-by: Rene Herman <rene.herman@gmail.com>

Rene.

--------------070902000102070505020504
Content-Type: text/plain;
 name="ad1848_msecs_to_jiffies.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ad1848_msecs_to_jiffies.diff"

diff --git a/sound/isa/ad1848/ad1848_lib.c b/sound/isa/ad1848/ad1848_lib.c
index dcd4435..161da11 100644
--- a/sound/isa/ad1848/ad1848_lib.c
+++ b/sound/isa/ad1848/ad1848_lib.c
@@ -237,7 +237,7 @@ static void snd_ad1848_mce_down(struct snd_ad1848 *chip)
 #if 0
 	printk("(2) jiffies = %li\n", jiffies);
 #endif
-	time = HZ / 4;
+	time = msecs_to_jiffies(250);
 	while (snd_ad1848_in(chip, AD1848_TEST_INIT) & AD1848_CALIB_IN_PROGRESS) {
 		spin_unlock_irqrestore(&chip->reg_lock, flags);
 		if (time <= 0) {
@@ -250,7 +250,7 @@ static void snd_ad1848_mce_down(struct snd_ad1848 *chip)
 #if 0
 	printk("(3) jiffies = %li\n", jiffies);
 #endif
-	time = HZ / 10;
+	time = msecs_to_jiffies(100);
 	while (inb(AD1848P(chip, REGSEL)) & AD1848_INIT) {
 		spin_unlock_irqrestore(&chip->reg_lock, flags);
 		if (time <= 0) {

--------------070902000102070505020504
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------070902000102070505020504--
