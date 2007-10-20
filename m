From: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
Subject: snd-pcsp doesn't accept the index parameter
Date: Sat, 20 Oct 2007 17:07:10 +0600
Message-ID: <4719E15E.2070701@ums.usu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from relay4.usu.ru (relay4.usu.ru [194.226.235.39])
	by alsa0.perex.cz (Postfix) with ESMTP id 6FB3024459
	for <alsa-devel@alsa-project.org>;
	Sat, 20 Oct 2007 13:07:49 +0200 (CEST)
Received: from relay4.usu.ru (localhost [127.0.0.1])
	by relay4.usu.ru (PostSystem) with ESMTP id 890A417EFE
	for <alsa-devel@alsa-project.org>;
	Sat, 20 Oct 2007 17:07:54 +0600 (YEKST)
Received: from usu2.usu.ru (usu2.usu.ru [194.226.237.16])
	by relay4.usu.ru (PostSystem) with ESMTP id ECB5E17EFE
	for <alsa-devel@alsa-project.org>;
	Sat, 20 Oct 2007 17:07:53 +0600 (YEKST)
Received: from usu2.usu.ru (localhost.usu2.usu.ru [127.0.0.1])
	by usu2.usu.ru (Postfix) with ESMTP id 5215FA7E95
	for <alsa-devel@alsa-project.org>;
	Sat, 20 Oct 2007 17:07:45 +0600 (YEKST)
Received: from ums.usu.ru (ums.usu.ru [194.226.236.116])
	by usu2.usu.ru (Postfix) with ESMTP id 346EDA7A2F
	for <alsa-devel@alsa-project.org>;
	Sat, 20 Oct 2007 17:07:45 +0600 (YEKST)
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

It is impossible to put pcsp at a stable index without the trivial patch 
below.

Signed-Off-By: Alexander E. Patrakov <patrakov@ums.usu.ru>

--- pcsp.c
+++ pcsp.c
@@ -27,6 +27,8 @@
 static char *id = SNDRV_DEFAULT_STR1;	/* ID for this card */
 static int enable = SNDRV_DEFAULT_ENABLE1;	/* Enable this card */
 
+module_param(index, int, 0444);
+MODULE_PARM_DESC(index, "Index value for pcsp soundcard.");
 module_param(id, charp, 0444);
 MODULE_PARM_DESC(id, "ID string for pcsp soundcard.");
 module_param(enable, bool, 0444);


-- 
Alexander E. Patrakov
