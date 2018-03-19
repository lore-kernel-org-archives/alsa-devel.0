From: Oleksandr Andrushchenko <andr2000@gmail.com>
Subject: [Xen-devel][PATCH v3 2/5] sndif: Fix missed "reserved"
	fields in comments
Date: Mon, 19 Mar 2018 09:22:21 +0200
Message-ID: <1521444144-12451-3-git-send-email-andr2000@gmail.com>
References: <1521444144-12451-1-git-send-email-andr2000@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lf0-f68.google.com (mail-lf0-f68.google.com
 [209.85.215.68])
 by alsa0.perex.cz (Postfix) with ESMTP id 75387267299
 for <alsa-devel@alsa-project.org>; Mon, 19 Mar 2018 08:22:38 +0100 (CET)
Received: by mail-lf0-f68.google.com with SMTP id o102-v6so1255884lfg.8
 for <alsa-devel@alsa-project.org>; Mon, 19 Mar 2018 00:22:38 -0700 (PDT)
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

Some of the request descriptions have "reserved" fields
missed: fix this by adding corresponidng entries.

Signed-off-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
---
 xen/include/public/io/sndif.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/xen/include/public/io/sndif.h b/xen/include/public/io/sndif.h
index 667e610fda2b..916be1d3a13f 100644
--- a/xen/include/public/io/sndif.h
+++ b/xen/include/public/io/sndif.h
@@ -680,6 +680,8 @@ struct xensnd_rw_req {
  * +----------------+----------------+----------------+----------------+
  * |                              length                               | 16
  * +----------------+----------------+----------------+----------------+
+ * |                             reserved                              | 20
+ * +----------------+----------------+----------------+----------------+
  * |/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/|
  * +----------------+----------------+----------------+----------------+
  * |                             reserved                              | 32
@@ -720,6 +722,8 @@ struct xensnd_rw_req {
  * +----------------+----------------+----------------+----------------+
  * |                              length                               | 16
  * +----------------+----------------+----------------+----------------+
+ * |                             reserved                              | 20
+ * +----------------+----------------+----------------+----------------+
  * |/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/|
  * +----------------+----------------+----------------+----------------+
  * |                             reserved                              | 32
-- 
2.7.4
