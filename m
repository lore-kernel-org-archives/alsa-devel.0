From: Mihail Zenkov <mihail.zenkov@gmail.com>
Subject: [PATCH] salsa-lib: define __SALSA_EXPORT_FUNC in
	version.h
Date: Tue, 12 Mar 2013 01:43:29 +0200
Message-ID: <CAD-m0i-T-H8bgdLYe3HDaTghjyUDkyqFvxfTgwOvwazXiQtzbQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qc0-f171.google.com (mail-qc0-f171.google.com
 [209.85.216.171])
 by alsa0.perex.cz (Postfix) with ESMTP id 25148265CBE
 for <alsa-devel@alsa-project.org>; Tue, 12 Mar 2013 00:43:30 +0100 (CET)
Received: by mail-qc0-f171.google.com with SMTP id d1so1799354qca.30
 for <alsa-devel@alsa-project.org>; Mon, 11 Mar 2013 16:43:29 -0700 (PDT)
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

We have to include "global.h" to define __SALSA_EXPORT_FUNC

--- salsa-lib-0.1.3/src/version.h.in
+++ salsa-lib-0.1.3-1/src/version.h.in
@@ -1,6 +1,8 @@
 #ifndef __ALSA_VERSION_H
 #define __ALSA_VERSION_H

+#include "global.h"
+
 #define SND_LIB_MAJOR		@SND_LIB_MAJOR@
 #define SND_LIB_MINOR		@SND_LIB_MINOR@
 #define SND_LIB_SUBMINOR	@SND_LIB_SUBMINOR@
