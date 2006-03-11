From: Adrian Bunk <bunk@stusta.de>
Subject: [2.6 patch] sound/core/: fix 3 off-by-one errors
Date: Sat, 11 Mar 2006 04:43:10 +0100
Message-ID: <20060311034310.GK21864@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mailout.stusta.mhn.de (emailhub.stusta.mhn.de [141.84.69.5])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id AEB94129
	for <alsa-devel@alsa-project.org>; Sat, 11 Mar 2006 04:43:09 +0100 (MET)
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: perex@suse.cz
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

This patch fixes three off-by-one errors found by the Coverity checker.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 sound/core/sound.c     |    4 ++--
 sound/core/sound_oss.c |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

--- linux-2.6.16-rc5-mm3-full/sound/core/sound.c.old	2006-03-11 03:03:04.000000000 +0100
+++ linux-2.6.16-rc5-mm3-full/sound/core/sound.c	2006-03-11 03:04:59.000000000 +0100
@@ -121,7 +121,7 @@ void *snd_lookup_minor_data(unsigned int
 	struct snd_minor *mreg;
 	void *private_data;
 
-	if (minor > ARRAY_SIZE(snd_minors))
+	if (minor >= ARRAY_SIZE(snd_minors))
 		return NULL;
 	mutex_lock(&sound_mutex);
 	mreg = snd_minors[minor];
@@ -140,7 +140,7 @@ static int snd_open(struct inode *inode,
 	const struct file_operations *old_fops;
 	int err = 0;
 
-	if (minor > ARRAY_SIZE(snd_minors))
+	if (minor >= ARRAY_SIZE(snd_minors))
 		return -ENODEV;
 	mptr = snd_minors[minor];
 	if (mptr == NULL) {
--- linux-2.6.16-rc5-mm3-full/sound/core/sound_oss.c.old	2006-03-11 03:05:48.000000000 +0100
+++ linux-2.6.16-rc5-mm3-full/sound/core/sound_oss.c	2006-03-11 03:06:01.000000000 +0100
@@ -46,7 +46,7 @@ void *snd_lookup_oss_minor_data(unsigned
 	struct snd_minor *mreg;
 	void *private_data;
 
-	if (minor > ARRAY_SIZE(snd_oss_minors))
+	if (minor >= ARRAY_SIZE(snd_oss_minors))
 		return NULL;
 	mutex_lock(&sound_oss_mutex);
 	mreg = snd_oss_minors[minor];



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
