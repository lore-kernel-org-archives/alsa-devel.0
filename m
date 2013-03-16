From: Mihail Zenkov <mihail.zenkov@gmail.com>
Subject: [PATCH] salsa-lib: Fix mistakes after refactoring
	pcm_params.c
Date: Sat, 16 Mar 2013 19:50:22 +0000
Message-ID: <CAD-m0i_ZAT8DwFF4Ubxr=wL_jtCKmhPfh696L64x0a4j0SbRWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pb0-f49.google.com (mail-pb0-f49.google.com
 [209.85.160.49])
 by alsa0.perex.cz (Postfix) with ESMTP id 3A471265117
 for <alsa-devel@alsa-project.org>; Sat, 16 Mar 2013 20:50:24 +0100 (CET)
Received: by mail-pb0-f49.google.com with SMTP id xa12so5261755pbc.36
 for <alsa-devel@alsa-project.org>; Sat, 16 Mar 2013 12:50:22 -0700 (PDT)
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

Fix some regressions after refactoring pcm_params.c
These mistakes don't allow snd_pcm_hw_param_set_near to establish correct value.

--- salsa-lib-a55ce0c348cd16e7853dae11e8e0e1b5a101d884/src/pcm_params.c
+++ salsa-lib-a55ce0c348cd16e7853dae11e8e0e1b5a101d884-1/src/pcm_params.c
@@ -590,11 +590,9 @@

 	save = *params;
 	err = hw_param_set_max(params, var, *val, dir ? *dir : 0);
-	if (!err) {
-		err = hw_param_update_var(pcm, params, var, err);
-		if (!err)
-			return _snd_pcm_hw_param_get_max(params, var, val, dir);
-	}
+	err = hw_param_update_var(pcm, params, var, err);
+	if (!err)
+		return _snd_pcm_hw_param_get_max(params, var, val, dir);
 	*params = save;
 	return err;
 }
@@ -683,7 +681,7 @@
 	snd_pcm_hw_params_t save = *params;
 	int err = hw_param_set(params, var, val, dir);
 	err = hw_param_update_var(pcm, params, var, err);
-	if (err)
+	if (err < 0)
 		*params = save;
 	return err;
 }
@@ -712,7 +710,7 @@
 	save = *params;
 	i->integer = 1;
 	err = hw_param_update_var(pcm, params, var, 1);
-	if (err)
+	if (err < 0)
 		*params = save;
 	return err;
 }
@@ -827,7 +825,7 @@
 	else if (valdir == 0)
 		maxdir = -1;
 	else {
-		valdir = 1;
+		maxdir = 1;
 		max--;
 	}
 	save = *params;
