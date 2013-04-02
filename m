From: Mihail Zenkov <mihail.zenkov@gmail.com>
Subject: Re: [PATCH] salsa-lib: Fix error on jack compilation
 with salsa
Date: Tue, 2 Apr 2013 11:59:20 +0000
Message-ID: <CAD-m0i8xSqVK2Tk6XVoJVa+z0iAA=Ct2Qi0fCorMcMc+mxL_gw@mail.gmail.com>
References: <CAD-m0i9iOmziNL=d0xGaVhb-mj-YjpeHBaitDHUYEgp7yQ5BDw@mail.gmail.com>
 <s5hr4jagh8v.wl%tiwai@suse.de> <515738DF.3040301@gmail.com>
 <s5hd2ud8dt8.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f44.google.com (mail-pa0-f44.google.com
 [209.85.220.44])
 by alsa0.perex.cz (Postfix) with ESMTP id DC9052651C7
 for <alsa-devel@alsa-project.org>; Tue,  2 Apr 2013 13:59:21 +0200 (CEST)
Received: by mail-pa0-f44.google.com with SMTP id bi5so258551pad.3
 for <alsa-devel@alsa-project.org>; Tue, 02 Apr 2013 04:59:20 -0700 (PDT)
In-Reply-To: <s5hd2ud8dt8.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, "Gabriel M. Beddingfield" <gabrbedd@gmail.com>
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
