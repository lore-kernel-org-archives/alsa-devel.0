Return-Path: <alsa-devel-bounces@alsa-project.org>
From: Henrik Austad <henrik@austad.us>
Date: Sun, 12 Jun 2016 01:01:36 +0200
Message-Id: <1465686096-22156-9-git-send-email-henrik@austad.us>
In-Reply-To: <1465686096-22156-1-git-send-email-henrik@austad.us>
References: <1465686096-22156-1-git-send-email-henrik@austad.us>
Subject: [alsa-devel] [very-RFC 8/8] MAINTAINERS: add TSN/AVB-entries
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Henrik Austad <haustad@cisco.com>, netdev@vger.kernel.org, henrk@austad.us, alsa-devel@vger.kernel.org, linux-media@vger.kernel.org
List-ID: <alsa-devel@alsa-project.org>

From: Henrik Austad <haustad@cisco.com>

Not sure how relevant this is other than making a point about
maintaining it.

Signed-off-by: Henrik Austad <haustad@cisco.com>
---
 MAINTAINERS | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ed42cb6..ef5d926 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11634,6 +11634,20 @@ T:	git git://linuxtv.org/anttip/media_tree.git
 S:	Maintained
 F:	drivers/media/tuners/tua9001*
 
+TSN CORE DRIVER
+M:	Henrik Austad <haustad@cisco.com>
+L:	linux-kernel@vger.kernel.org
+S:	Supported
+F:	drivers/net/tsn/
+F:	include/linux/tsn.h
+F:	include/trace/events/tsn.h
+
+TSN_AVB_DRIVER
+M:	Henrik Austad <haustad@cisco.com>
+L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
+S:	Supported
+F:	drivers/media/avb/
+
 TULIP NETWORK DRIVERS
 L:	netdev@vger.kernel.org
 L:	linux-parisc@vger.kernel.org
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe alsa-devel" in

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
