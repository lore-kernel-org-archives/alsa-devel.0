From: Oleksandr Andrushchenko <andr2000@gmail.com>
Subject: [PATCH 1/5] xen/sndif: Introduce protocol version
Date: Thu, 12 Apr 2018 19:00:58 +0300
Message-ID: <20180412160102.15833-2-oleksandr_andrushchenko@epam.com>
References: <20180412160102.15833-1-oleksandr_andrushchenko@epam.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lf0-f65.google.com (mail-lf0-f65.google.com
 [209.85.215.65])
 by alsa0.perex.cz (Postfix) with ESMTP id A2657266FD1
 for <alsa-devel@alsa-project.org>; Thu, 12 Apr 2018 18:01:25 +0200 (CEST)
Received: by mail-lf0-f65.google.com with SMTP id d20-v6so8467038lfe.3
 for <alsa-devel@alsa-project.org>; Thu, 12 Apr 2018 09:01:25 -0700 (PDT)
In-Reply-To: <20180412160102.15833-1-oleksandr_andrushchenko@epam.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Cc: jgross@suse.com, iurii.konovalenko@globallogic.com, konrad.wilk@oracle.com, tiwai@suse.de, oleksandr.dmytryshyn@globallogic.com, andr2000@gmail.com, boris.ostrovsky@oracle.com
List-Id: alsa-devel@alsa-project.org

Protocol version was referenced in the protocol description,
but missed its definition. Fix this by adding a constant
for current protocol version.

Signed-off-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
---
 include/xen/interface/io/sndif.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/xen/interface/io/sndif.h b/include/xen/interface/io/sndif.h
index 5c918276835e..fc1752cf5a16 100644
--- a/include/xen/interface/io/sndif.h
+++ b/include/xen/interface/io/sndif.h
@@ -36,6 +36,13 @@
 #include "ring.h"
 #include "../grant_table.h"
 
+/*
+ ******************************************************************************
+ *                           Protocol version
+ ******************************************************************************
+ */
+#define XENSND_PROTOCOL_VERSION	1
+
 /*
  ******************************************************************************
  *                  Feature and Parameter Negotiation
-- 
2.17.0
