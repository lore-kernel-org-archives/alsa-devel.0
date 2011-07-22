From: linux@audioscience.com
Subject: [PATCH 06/15] Remove spurious adapter index check
Date: Fri, 22 Jul 2011 15:52:47 +1200
Message-ID: <1311306785-23116-13-git-send-email-linux@audioscience.com>
References: <1311306785-23116-1-git-send-email-linux@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-reply-to: <1311306785-23116-1-git-send-email-linux@audioscience.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: tiwai@suse.de, Eliot Blennerhassett <eblennerhassett@audioscience.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Eliot Blennerhassett <eblennerhassett@audioscience.com>

Subsystem requests don't have or need a valid adapter index.

Signed-off-by: Eliot Blennerhassett <eblennerhassett@audioscience.com>
---
 sound/pci/asihpi/hpioctl.c |    7 +------
 1 files changed, 1 insertions(+), 6 deletions(-)

diff --git a/sound/pci/asihpi/hpioctl.c b/sound/pci/asihpi/hpioctl.c
index d8e7047..53e3506 100644
--- a/sound/pci/asihpi/hpioctl.c
+++ b/sound/pci/asihpi/hpioctl.c
@@ -1,7 +1,7 @@
 /*******************************************************************************
 
     AudioScience HPI driver
-    Copyright (C) 1997-2010  AudioScience Inc. <support@audioscience.com>
+    Copyright (C) 1997-2011  AudioScience Inc. <support@audioscience.com>
 
     This program is free software; you can redistribute it and/or modify
     it under the terms of version 2 of the GNU General Public License as
@@ -157,11 +157,6 @@ long asihpi_hpi_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 		goto out;
 	}
 
-	if (hm->h.adapter_index >= HPI_MAX_ADAPTERS) {
-		err = -EINVAL;
-		goto out;
-	}
-
 	switch (hm->h.function) {
 	case HPI_SUBSYS_CREATE_ADAPTER:
 	case HPI_ADAPTER_DELETE:
-- 
1.7.0.4
