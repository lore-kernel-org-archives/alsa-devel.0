From: Mihail Zenkov <mihail.zenkov@gmail.com>
Subject: [PATCH] salsa-lib: Fix error on jack compilation with
	salsa
Date: Sun, 17 Mar 2013 15:13:00 +0000
Message-ID: <CAD-m0i9iOmziNL=d0xGaVhb-mj-YjpeHBaitDHUYEgp7yQ5BDw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-da0-f48.google.com (mail-da0-f48.google.com
 [209.85.210.48])
 by alsa0.perex.cz (Postfix) with ESMTP id D3B07265192
 for <alsa-devel@alsa-project.org>; Sun, 17 Mar 2013 16:13:01 +0100 (CET)
Received: by mail-da0-f48.google.com with SMTP id p8so10141dan.21
 for <alsa-devel@alsa-project.org>; Sun, 17 Mar 2013 08:13:00 -0700 (PDT)
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

Fix error on jack compilation with salsa:
/usr/include/alsa/ctl_macros.h:251:48: error: invalid conversion from
'void*' to 'snd_ctl_elem_id_t* {aka snd_ctl_elem_id*}' [-fpermissive]

--- salsa-lib-a55ce0c348cd16e7853dae11e8e0e1b5a101d884/src/ctl_macros.h
+++ salsa-lib-a55ce0c348cd16e7853dae11e8e0e1b5a101d884-1/src/ctl_macros.h
@@ -248,7 +248,7 @@
 				  unsigned int entries)
 {
 	free(obj->pids);
-	obj->pids = calloc(entries, sizeof(*obj->pids));
+	obj->pids = (snd_ctl_elem_id_t*)calloc(entries, sizeof(*obj->pids));
 	if (!obj->pids) {
 		obj->space = 0;
 		return -ENOMEM;
