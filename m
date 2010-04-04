From: Risto Suominen <risto.suominen@gmail.com>
Subject: [PATCH - powermac] Add debug log
Date: Sun, 4 Apr 2010 08:00:29 +0300
Message-ID: <j2q46e1c7761004032200h444f8f46v8be98e277912f218@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f220.google.com (mail-bw0-f220.google.com
	[209.85.218.220])
	by alsa0.perex.cz (Postfix) with ESMTP id B1D9724404
	for <alsa-devel@alsa-project.org>;
	Sun,  4 Apr 2010 07:00:30 +0200 (CEST)
Received: by mail-bw0-f220.google.com with SMTP id 20so3454515bwz.32
	for <alsa-devel@alsa-project.org>; Sat, 03 Apr 2010 22:00:30 -0700 (PDT)
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
Cc: alsa-devel <alsa-devel@alsa-project.org>, "Risto.Suominen" <Risto.Suominen@gmail.com>
List-Id: alsa-devel@alsa-project.org

From: Risto Suominen <Risto.Suominen@gmail.com>

Add some debug log in tumbler.c.

Signed-off-by: Risto Suominen <Risto.Suominen@gmail.com>
---
Kernel version 2.6.32.9 (probably any 2.6), ALSA 1.0.22.1.

This patch is available here, too:
http://ristosu.wippiespace.com/pub/alsa-tumbler-1.0.22.1-p16d.diff

It has no effect, unless one changes '#undef DEBUG' to '#define DEBUG'
in the beginning of the file (and possibly in tumbler.patch, too).

--- a/alsa-kernel/ppc/tumbler.c-p15	2010-03-16 19:59:01.000000000 +0200
+++ b/alsa-kernel/ppc/tumbler.c	2010-03-23 21:34:46.000000000 +0200
@@ -246,6 +246,7 @@ static int tumbler_set_master_volume(str
 		snd_printk(KERN_ERR "failed to set volume \n");
 		return -EINVAL;
 	}
+	DBG("(I) succeeded to set volume (%u, %u)\n", left_vol, right_vol);
 	return 0;
 }

@@ -356,6 +357,7 @@ static int tumbler_set_drc(struct pmac_t
 		snd_printk(KERN_ERR "failed to set DRC\n");
 		return -EINVAL;
 	}
+	DBG("(I) succeeded to set DRC (%u, %u)\n", val[0], val[1]);
 	return 0;
 }

@@ -392,6 +394,7 @@ static int tumbler_set_drc(struct pmac_t
 		snd_printk(KERN_ERR "failed to set DRC\n");
 		return -EINVAL;
 	}
+	DBG("(I) succeeded to set DRC (%u, %u)\n", val[0], val[1]);
 	return 0;
 }
