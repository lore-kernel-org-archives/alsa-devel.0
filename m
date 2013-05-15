From: Jordi Mallach <jordi@debian.org>
Subject: [PATCH 1/8] Make usx2yloader work with udev.
Date: Wed, 15 May 2013 19:19:04 +0200
Message-ID: <1368638351-29200-2-git-send-email-jordi@debian.org>
References: <1368638351-29200-1-git-send-email-jordi@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tempesta.oskuro.net (tempesta.oskuro.net [92.243.30.96])
 by alsa0.perex.cz (Postfix) with ESMTP id 82B29261723
 for <alsa-devel@alsa-project.org>; Wed, 15 May 2013 19:19:20 +0200 (CEST)
In-Reply-To: <1368638351-29200-1-git-send-email-jordi@debian.org>
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

From: Elimar Riesebieter <riesebie@lxtec.de>

Signed-off-by: Jordi Mallach <jordi@debian.org>
---
 usx2yloader/Makefile.am |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/usx2yloader/Makefile.am b/usx2yloader/Makefile.am
index 4cc9a70..4dd26a2 100644
--- a/usx2yloader/Makefile.am
+++ b/usx2yloader/Makefile.am
@@ -11,8 +11,8 @@ usx2yloader_SOURCES = usx2yloader.c
 
 EXTRA_DIST = gitcompile depcomp tascam_fw.usermap tascam_fw.in tascam_fpga.in
 
-hotplug_files = tascam_fw.usermap tascam_fw tascam_fpga
-hotplugdir = /etc/hotplug/usb
+hotplug_files = tascam_fw tascam_fpga
+hotplugdir = /lib/udev
 hotplug_SCRIPTS = $(hotplug_files)
 
 
-- 
1.7.10.4
