From: linux@audioscience.com
Subject: [PATCH 06/15] ALSA: asihpi - Remove spurious adapter
	index check
Date: Fri, 22 Jul 2011 15:52:46 +1200
Message-ID: <1311306785-23116-12-git-send-email-linux@audioscience.com>
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
The adapter index is already checked further on, before it is used to index
the adapters array. (Reverts 4a122c10f)

Signed-off-by: Eliot Blennerhassett <eblennerhassett@audioscience.com>
---
 sound/pci/asihpi/hpioctl.c |   10 +++-------
 1 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/sound/pci/asihpi/hpioctl.c b/sound/pci/asihpi/hpioctl.c
index d8e7047..65fcf47 100644
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
@@ -187,7 +182,6 @@ long asihpi_hpi_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 		/* -1=no data 0=read from user mem, 1=write to user mem */
 		int wrflag = -1;
 		u32 adapter = hm->h.adapter_index;
-		pa = &adapters[adapter];
 
 		if ((adapter > HPI_MAX_ADAPTERS) || (!pa->type)) {
 			hpi_init_response(&hr->r0, HPI_OBJ_ADAPTER,
@@ -203,6 +197,8 @@ long asihpi_hpi_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 			goto out;
 		}
 
+		pa = &adapters[adapter];
+
 		if (mutex_lock_interruptible(&adapters[adapter].mutex)) {
 			err = -EINTR;
 			goto out;
-- 
1.7.0.4
