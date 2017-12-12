From: Ikey Doherty <ikey@solus-project.com>
Subject: [PATCH] alsactl: Only start restore service when
	asoundrc file exists
Date: Tue, 12 Dec 2017 13:32:34 +0000
Message-ID: <20171212133234.20712-1-ikey@solus-project.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f67.google.com (mail-wm0-f67.google.com [74.125.82.67])
 by alsa0.perex.cz (Postfix) with ESMTP id 16C1B266E6C
 for <alsa-devel@alsa-project.org>; Tue, 12 Dec 2017 14:32:36 +0100 (CET)
Received: by mail-wm0-f67.google.com with SMTP id b199so16987455wme.1
 for <alsa-devel@alsa-project.org>; Tue, 12 Dec 2017 05:32:36 -0800 (PST)
Received: from localhost.localdomain ([2001:bb6:51c8:e258:71f5:fb89:d10e:b99])
 by smtp.gmail.com with ESMTPSA id
 g20sm8090492edb.75.2017.12.12.05.32.35
 for <alsa-devel@alsa-project.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 12 Dec 2017 05:32:35 -0800 (PST)
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

This solves the chicken and egg problem on fresh installations whereby
the alsa state file does not yet exist, and alsa-restore unit attempted
to launch without first having a state file.

Signed-off-by: Ikey Doherty <ikey@solus-project.com>
---
 alsactl/Makefile.am             | 1 +
 alsactl/alsa-restore.service.in | 1 +
 2 files changed, 2 insertions(+)

diff --git a/alsactl/Makefile.am b/alsactl/Makefile.am
index 90fab9d..aaaf74e 100644
--- a/alsactl/Makefile.am
+++ b/alsactl/Makefile.am
@@ -41,6 +41,7 @@ edit = \
 	$(SED) -r -e 's,@sbindir\@,$(sbindir),g' \
 		  -e 's,@mydatadir\@,$(mydatadir),g' \
 		  -e 's,@daemonswitch\@,$(ALSACTL_DAEMONSWITCH),g' \
+		  -e 's,@asoundrcfile\@,$(ASOUND_STATE_DIR)/asound.state,g' \
 							< $< > $@ || rm $@
 
 alsa-state.service: alsa-state.service.in
diff --git a/alsactl/alsa-restore.service.in b/alsactl/alsa-restore.service.in
index 80fd5fd..a84c2e8 100644
--- a/alsactl/alsa-restore.service.in
+++ b/alsactl/alsa-restore.service.in
@@ -7,6 +7,7 @@
 Description=Save/Restore Sound Card State
 ConditionPathExists=!@daemonswitch@
 ConditionPathExistsGlob=/dev/snd/control*
+ConditionPathExists=@asoundrcfile@
 
 [Service]
 Type=oneshot
-- 
2.15.1
