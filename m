From: "Alexander Aristov" <aristov.alexander@gmail.com>
Subject: fix typo in rme9652.c
Date: Fri, 27 Dec 2013 00:13:08 +0200
Message-ID: <036301cf0287$a90e2230$fb2a6690$@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ea0-f182.google.com (mail-ea0-f182.google.com
 [209.85.215.182])
 by alsa0.perex.cz (Postfix) with ESMTP id 7378A2619F0
 for <alsa-devel@alsa-project.org>; Thu, 26 Dec 2013 23:13:14 +0100 (CET)
Received: by mail-ea0-f182.google.com with SMTP id a15so3865141eae.41
 for <alsa-devel@alsa-project.org>; Thu, 26 Dec 2013 14:13:14 -0800 (PST)
Received: from AlexanderPC (82.193.103.158.ipnet.kiev.ua. [82.193.103.158])
 by mx.google.com with ESMTPSA id o1sm76391471eea.10.2013.12.26.14.13.12
 for <alsa-devel@alsa-project.org>
 (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Thu, 26 Dec 2013 14:13:13 -0800 (PST)
Content-Language: en-au
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--- a/sound/pci/rme9652/rme9652.c	2013-12-20 15:51:33.000000000 +0000
+++ b/sound/pci/rme9652/rme9652.c	2013-12-24 23:17:20.740138731 +0000
@@ -285,7 +285,7 @@
 	/* ADAT channels are remapped */
 	1, 3, 5, 7, 9, 11, 13, 15,
 	/* channels 8 and 9 are S/PDIF */
-	24, 25
+	24, 25,
 	/* others don't exist */
 	-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1
 };


Regards,
Alexander
