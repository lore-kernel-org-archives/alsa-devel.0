From: Pavel Kysilka <pavelk@bsys.cz>
Subject: cs46xx thinkpad resume fix - #bug1946
Date: Sat, 14 Jul 2007 17:55:52 +0200
Message-ID: <20070714155552.GA2896@prog3>
Reply-To: Pavel Kysilka <pavelk@bsys.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="VbJkn9YxBvnuCH5J"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rak.bsys.cz (bsys.cz [88.86.106.116])
	by alsa0.perex.cz (Postfix) with ESMTP id 28D6D10389E
	for <alsa-devel@alsa-project.org>;
	Sat, 14 Jul 2007 17:55:54 +0200 (CEST)
Received: from rak.bsys.cz (localhost [127.0.0.1])
	by rak.bsys.cz (Postfix) with ESMTP id E38D580479
	for <alsa-devel@alsa-project.org>;
	Sat, 14 Jul 2007 17:55:53 +0200 (CEST)
Received: from prog3.hq.bsys.cz (r5k42.net.upc.cz [86.49.10.42])
	by rak.bsys.cz (Postfix) with ESMTP id B937180478
	for <alsa-devel@alsa-project.org>;
	Sat, 14 Jul 2007 17:55:53 +0200 (CEST)
Received: from prog3.hq.bsys.cz (goldenfish@localhost [127.0.0.1])
	by prog3.hq.bsys.cz (8.13.8/8.13.8/Debian-3) with ESMTP id
	l6EFtqMS003093
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <alsa-devel@alsa-project.org>; Sat, 14 Jul 2007 17:55:52 +0200
Received: (from goldenfish@localhost)
	by prog3.hq.bsys.cz (8.13.8/8.13.8/Submit) id l6EFtquO003092
	for alsa-devel@alsa-project.org; Sat, 14 Jul 2007 17:55:52 +0200
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
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=utf8
Content-Disposition: inline

   Hi,

attached patch fix resume on thinkpad notebooks with cs46xx chip.
Tested with Thinkpad A21m.

Patch is opposite latest linus git 2.6.22.

Bug #1946 may be closed.

Signed-off-by: Pavel Kysilka <pavelk@bsys.cz>

 Pavel Kysilka



________ Information from NOD32 ________
This message was checked by NOD32 Antivirus System for Linux Mail Servers.
http://www.eset.com
--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=utf8
Content-Disposition: attachment; filename="cs46xx_thinkpad_resume_fix.diff"

diff --git a/sound/pci/cs46xx/cs46xx_lib.c b/sound/pci/cs46xx/cs46xx_lib.c
index bef1f6d..73f66d7 100644
--- a/sound/pci/cs46xx/cs46xx_lib.c
+++ b/sound/pci/cs46xx/cs46xx_lib.c
@@ -3715,6 +3715,7 @@ int snd_cs46xx_resume(struct pci_dev *pci)
 	chip->active_ctrl(chip, 1); /* force to on */
 
 	snd_cs46xx_chip_init(chip);
+	snd_cs46xx_start_dsp(chip); /* upload dsp code */
 
 #if 0
 	snd_cs46xx_codec_write(chip, BA0_AC97_GENERAL_PURPOSE, 

--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--VbJkn9YxBvnuCH5J--
