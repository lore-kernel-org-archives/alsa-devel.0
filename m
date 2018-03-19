From: Oleksandr Andrushchenko <andr2000@gmail.com>
Subject: [Xen-devel][PATCH v3 1/5] sndif: Introduce protocol
	version
Date: Mon, 19 Mar 2018 09:22:20 +0200
Message-ID: <1521444144-12451-2-git-send-email-andr2000@gmail.com>
References: <1521444144-12451-1-git-send-email-andr2000@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lf0-f65.google.com (mail-lf0-f65.google.com
 [209.85.215.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 2C06F267299
 for <alsa-devel@alsa-project.org>; Mon, 19 Mar 2018 08:22:36 +0100 (CET)
Received: by mail-lf0-f65.google.com with SMTP id y2-v6so21699404lfc.5
 for <alsa-devel@alsa-project.org>; Mon, 19 Mar 2018 00:22:36 -0700 (PDT)
In-Reply-To: <1521444144-12451-1-git-send-email-andr2000@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, xen-devel@lists.xenproject.org, konrad.wilk@oracle.com, tiwai@suse.de
Cc: andr2000@gmail.com, Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
List-Id: alsa-devel@alsa-project.org

From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>

Protocol version was referenced in the protocol description,
but missed its definition. Fix this by adding a constant
for current protocol version.

Signed-off-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
---
 xen/include/public/io/sndif.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/xen/include/public/io/sndif.h b/xen/include/public/io/sndif.h
index c5c1978406b3..667e610fda2b 100644
--- a/xen/include/public/io/sndif.h
+++ b/xen/include/public/io/sndif.h
@@ -38,6 +38,13 @@
 
 /*
  ******************************************************************************
+ *                           Protocol version
+ ******************************************************************************
+ */
+#define XENSND_PROTOCOL_VERSION         1
+
+/*
+ ******************************************************************************
  *                  Feature and Parameter Negotiation
  ******************************************************************************
  *
-- 
2.7.4
