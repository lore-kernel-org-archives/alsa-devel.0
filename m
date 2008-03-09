From: Mike Gorse <mgorse@mgorse.dhs.org>
Subject: [patch] dmix skipping first set of samples
Date: Sun, 9 Mar 2008 18:20:47 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0803091816001.10825@mgorse.dhs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from QMTA06.emeryville.ca.mail.comcast.net
	(qmta06.emeryville.ca.mail.comcast.net [76.96.30.56])
	by alsa0.perex.cz (Postfix) with ESMTP id 7047310381A
	for <alsa-devel@alsa-project.org>; Sun,  9 Mar 2008 23:20:17 +0100 (CET)
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

There was a change in alsa-lib 1.0.16 which looks like it was designed to 
make dmix skip samples in the case of underruns, but it causes the first 
sample to be skipped since dmix->slave_hw_ptr == dmix->slave_appl_ptr. 
The following patch fixes this and fixes a small typo in the comment:

--- src/pcm/pcm_dmix.c.orig	2008-01-18 20:00:10.000000000 -0500
+++ src/pcm/pcm_dmix.c	2008-03-09 18:01:13.000000000 -0400
@@ -311,9 +311,9 @@
  	if (size >= pcm->boundary / 2)
  		size = pcm->boundary - size;

-	/* the slave_app_ptr can be far behing the slave_hw_ptr */
+	/* the slave_app_ptr can be far behind the slave_hw_ptr */
  	/* reduce mixing and errors here - just skip not catched writes */
-	if (dmix->slave_hw_ptr < dmix->slave_appl_ptr)
+	if (dmix->slave_hw_ptr <= dmix->slave_appl_ptr)
  		slave_size = dmix->slave_appl_ptr - dmix->slave_hw_ptr;
  	else
  		slave_size = dmix->slave_appl_ptr + (dmix->slave_boundary - dmix->slave_hw_ptr);

Thanks,
-- Mike Gorse / AIM:linvortex / http://mgorse.freeshell.org --
