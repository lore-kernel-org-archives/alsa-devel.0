From: =?ISO-8859-1?Q?Benny_Sj=F6strand?= <gorm@cucumelo.org>
Subject: [PATCH] Re: [Alsa-user] Hercules Gametheater XP (cs46xx)
Date: Sun, 16 Feb 2003 15:33:38 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E4FA142.3010406@cucumelo.org>
References: <3E4E98B5.7030409@dsl.pipex.com> <3E4EFA55.8090804@cucumelo.org> <3E4F8839.9070701@dsl.pipex.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060402080500090102010209"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Johan Groth <jgroth@dsl.pipex.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------060402080500090102010209
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

> Sorry, but latest CVS does not work. Sound is still very distorted. 
> CVS from 2002-12-09 12:00 works well though, which is what I'm using 
> now :) It is using version 1.37 alsa-kernel/pci/cs46xx/cs46xx_lib.cc.

Current CVS still seems to be broken. The hercules_init(...) function 
will reset the EGPIO's to default state  turning of the amplifier. This 
patch changes the initialization order calling amplifier_ctrl(...) after 
mixer_init.

/Benny

--------------060402080500090102010209
Content-Type: text/plain;
 name="cs46xx.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cs46xx.patch"

--- cs46xx_lib.c.orig	2003-02-16 15:28:21.000000000 +0100
+++ cs46xx_lib.c	2003-02-16 15:28:34.000000000 +0100
@@ -2516,9 +2516,6 @@
 	strcpy(id.name, "External Amplifier Power Down");
 	chip->eapd_switch = snd_ctl_find_id(chip->card, &id);
     
-	/* turn on amplifier */
-	chip->amplifier_ctrl(chip, 1);
-
 #ifdef CONFIG_SND_CS46XX_NEW_DSP
 	/* do soundcard specific mixer setup */
 	if (chip->mixer_init) {
@@ -2526,6 +2523,9 @@
 		chip->mixer_init(chip);
 	}
 #endif
+
+ 	/* turn on amplifier */
+	chip->amplifier_ctrl(chip, 1);
     
 	return 0;
 }

--------------060402080500090102010209--



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
