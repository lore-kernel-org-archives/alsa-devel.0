From: Oleksandr Andrushchenko <andr2000@gmail.com>
Subject: [PATCH 2/5] xen/sndif: Fix missed "reserved" fields in
	comments
Date: Thu, 12 Apr 2018 19:00:59 +0300
Message-ID: <20180412160102.15833-3-oleksandr_andrushchenko@epam.com>
References: <20180412160102.15833-1-oleksandr_andrushchenko@epam.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lf0-f67.google.com (mail-lf0-f67.google.com
 [209.85.215.67])
 by alsa0.perex.cz (Postfix) with ESMTP id BD4B82673A2
 for <alsa-devel@alsa-project.org>; Thu, 12 Apr 2018 18:01:28 +0200 (CEST)
Received: by mail-lf0-f67.google.com with SMTP id o102-v6so8446883lfg.8
 for <alsa-devel@alsa-project.org>; Thu, 12 Apr 2018 09:01:28 -0700 (PDT)
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

Some of the request descriptions have "reserved" fields
missed: fix this by adding corresponidng entries.

Signed-off-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
---
 include/xen/interface/io/sndif.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/xen/interface/io/sndif.h b/include/xen/interface/io/sndif.h
index fc1752cf5a16..b775df96f021 100644
--- a/include/xen/interface/io/sndif.h
+++ b/include/xen/interface/io/sndif.h
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
2.17.0
