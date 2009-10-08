From: Li Bo <liboat@gmail.com>
Subject: Re: [PATCH 30/31] HDA patch_via.c: comments: update
	copyright, code 	description, changeset
Date: Thu, 8 Oct 2009 13:51:17 +0800
Message-ID: <16685ee0910072251u1b5df682x78f8e97191c5c33d@mail.gmail.com>
References: <16685ee0910050728w73895bddyf076e9e603b9411c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f225.google.com (mail-bw0-f225.google.com
	[209.85.218.225])
	by alsa0.perex.cz (Postfix) with ESMTP id 6095D103A0F
	for <alsa-devel@alsa-project.org>;
	Thu,  8 Oct 2009 07:51:17 +0200 (CEST)
Received: by mail-bw0-f225.google.com with SMTP id 25so1488839bwz.32
	for <alsa-devel@alsa-project.org>; Wed, 07 Oct 2009 22:51:17 -0700 (PDT)
In-Reply-To: <16685ee0910050728w73895bddyf076e9e603b9411c@mail.gmail.com>
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
Cc: tiwai@suse.de, LoganLi@viatech.com.cn, HaraldWelte@viatech.com, lydiawang@viatech.com.cn
List-Id: alsa-devel@alsa-project.org

[ALSA] HDA VIA: comments: update copyright, code description, changeset

Signed-off-by: Lydia Wang <lydiawang@viatech.com.cn>

---
 sound/pci/hda/patch_via.c |   11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

--- a/sound/pci/hda/patch_via.c
+++ b/sound/pci/hda/patch_via.c
@@ -1,10 +1,10 @@
 /*
  * Universal Interface for Intel High Definition Audio Codec
  *
- * HD audio interface patch for VIA VT1702/VT1708/VT1709 codec
+ * HD audio interface patch for VIA VT17xx/VT20xx codec
  *
- * Copyright (c) 2006-2008 Lydia Wang <lydiawang@viatech.com>
- *			   Takashi Iwai <tiwai@suse.de>
+ *  (C) 2006-2009 VIA Technology, Inc.
+ *  (C) 2006-2008 Takashi Iwai <tiwai@suse.de>
  *
  *  This driver is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
@@ -36,6 +36,11 @@
 /* 2008-04-09  Lydia Wang  Add Independent HP feature                        */
 /* 2008-05-28  Lydia Wang  Add second S/PDIF Out support for VT1702	     */
 /* 2008-09-15  Logan Li    Add VT1708S Mic Boost workaround/backdoor	     */
+/* 2009-02-16  Logan Li	   Add support for VT1718S			     */
+/* 2009-03-13  Logan Li	   Add support for VT1716S			     */
+/* 2009-04-14  Lydai Wang  Add support for VT1828S and VT2020		     */
+/* 2009-07-08  Lydia Wang  Add support for VT2002P			     */
+/* 2009-07-21  Lydia Wang  Add support for VT1812			     */
 /*                                                                           */
 /* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
