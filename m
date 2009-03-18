From: Giuliano Pochini <pochini@shiny.it>
Subject: [PATCH 1/1] echomixer: little bug fix
Date: Thu, 19 Mar 2009 00:15:44 +0100
Message-ID: <20090319001544.62d06c63.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out25.alice.it (smtp-out25.alice.it [85.33.2.25])
	by alsa0.perex.cz (Postfix) with ESMTP id BD737103803
	for <alsa-devel@alsa-project.org>; Thu, 19 Mar 2009 00:15:32 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

This patch fixes a stupid bug that was introduced in the last change.


Signed-off-by: Giuliano Pochini <pochini@shiny.it>

--- alsa-tools-1.0.19/echomixer/echomixer.c__orig	2009-03-18 23:08:45.000000000 +0100
+++ alsa-tools-1.0.19/echomixer/echomixer.c	2009-03-18 23:54:49.000000000 +0100
@@ -1247,7 +1247,7 @@ void Vmixer_volume_changed(GtkWidget *wi
   int o, v;
 
   channel=(int)(long)ch;
-  val=INVERT((int)GTK_ADJUSTMENT(widget)->value);
+  val=rval=INVERT((int)GTK_ADJUSTMENT(widget)->value);
 
 #ifdef REVERSE
   v=channel;



--
Giuliano.
