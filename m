From: khalasa@piap.pl (Krzysztof =?utf-8?Q?Ha=C5=82asa?=)
Subject: SEGFAULT in ALSA lib 1.0.27.1 pcm_direct parser
Date: Fri, 14 Jun 2013 13:59:38 +0200
Message-ID: <m3obb8kimt.fsf@t19.piap.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ni.piap.pl (ni.piap.pl [195.187.100.4])
 by alsa0.perex.cz (Postfix) with ESMTP id 98F252651B9
 for <alsa-devel@alsa-project.org>; Fri, 14 Jun 2013 14:01:10 +0200 (CEST)
Received: from ni.piap.pl (localhost.localdomain [127.0.0.1])
 by ni.piap.pl (Postfix) with ESMTP id 2C419440D1C
 for <alsa-devel@alsa-project.org>; Fri, 14 Jun 2013 14:01:10 +0200 (CEST)
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

Hi,

Fixes a segfault when getgrnam_r() returns 0 and still sets pgrp to NULL
when the group simply doesn't exist.

--- alsa-lib/src/pcm/pcm_direct.c	2013-05-21 10:48:28.000000000 +0200
+++ alsa-lib/src/pcm/pcm_direct.c	2013-06-14 13:31:28.981013646 +0200
@@ -1636,7 +1636,7 @@
 				if (buffer == NULL)
 					return -ENOMEM;
 				int st = getgrnam_r(group, &grp, buffer, len, &pgrp);
-				if (st != 0) {
+				if (st != 0 || !pgrp) {
 					SNDERR("The field ipc_gid must be a valid group (create group %s)", group);
 					free(buffer);
 					return -EINVAL;

-- 
Krzysztof Halasa

Research Institute for Automation and Measurements PIAP
Al. Jerozolimskie 202, 02-486 Warsaw, Poland
