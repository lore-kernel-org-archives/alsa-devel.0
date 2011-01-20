From: =?UTF-8?q?Diego=20Elio=20Petten=C3=B2?= <flameeyes@gmail.com>
Subject: [PATCH 2/4] Add missing no-undefined parameter.
Date: Thu, 20 Jan 2011 04:45:14 +0100
Message-ID: <1295495116-19937-2-git-send-email-flameeyes@gmail.com>
References: <1295495116-19937-1-git-send-email-flameeyes@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 6F0BF1039E4
	for <alsa-devel@alsa-project.org>; Thu, 20 Jan 2011 04:46:27 +0100 (CET)
Received: by mail-wy0-f179.google.com with SMTP id 11so167690wyi.38
	for <alsa-devel@alsa-project.org>; Wed, 19 Jan 2011 19:46:27 -0800 (PST)
In-Reply-To: <1295495116-19937-1-git-send-email-flameeyes@gmail.com>
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

---
 arcam-av/Makefile.am |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arcam-av/Makefile.am b/arcam-av/Makefile.am
index 5c7855f..a5da61b 100644
--- a/arcam-av/Makefile.am
+++ b/arcam-av/Makefile.am
@@ -3,7 +3,7 @@ asound_module_ctl_arcam_av_LTLIBRARIES = libasound_module_ctl_arcam_av.la
 asound_module_ctl_arcam_avdir = @ALSA_PLUGIN_DIR@
 
 AM_CFLAGS = -Wall -g @ALSA_CFLAGS@
-AM_LDFLAGS = -module -avoid-version -export-dynamic -no-undefined
+AM_LDFLAGS = -module -avoid-version -export-dynamic -no-undefined $(LDFLAGS_NOUNDEFINED)
 
 libasound_module_ctl_arcam_av_la_SOURCES = ctl_arcam_av.c arcam_av.c arcam_av.h
 libasound_module_ctl_arcam_av_la_LIBADD = @ALSA_LIBS@
-- 
1.7.4.rc2
