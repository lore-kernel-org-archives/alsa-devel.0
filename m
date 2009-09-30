From: Stefan Schmidt <stefan@datenfreihafen.org>
Subject: [PATCH 2/2] alisp: Comment out an unused function to
	avoid compiler warnings.
Date: Wed, 30 Sep 2009 12:36:14 +0200
Message-ID: <1254306974-26016-2-git-send-email-stefan@datenfreihafen.org>
References: <1254306974-26016-1-git-send-email-stefan@datenfreihafen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sirius.lasnet.de (sirius.lasnet.de [78.47.116.19])
	by alsa0.perex.cz (Postfix) with ESMTP id 88B5910389C
	for <alsa-devel@alsa-project.org>;
	Wed, 30 Sep 2009 12:36:30 +0200 (CEST)
In-Reply-To: <1254306974-26016-1-git-send-email-stefan@datenfreihafen.org>
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
Cc: Stefan Schmidt <stefan@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

From: Stefan Schmidt <stefan@slimlogic.co.uk>

The function should be useful later so keep it in place and just comment it out
until it is actually used.

Signed-off-by: Stefan Schmidt <stefan@slimlogic.co.uk>
---
 src/alisp/alisp.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/src/alisp/alisp.c b/src/alisp/alisp.c
index 4ad1d09..f3580f9 100644
--- a/src/alisp/alisp.c
+++ b/src/alisp/alisp.c
@@ -233,6 +233,9 @@ static struct alisp_object * incref_tree(struct alisp_instance *instance, struct
 	return incref_object(instance, p);
 }
 
+/* Function not used yet. Leave it commented out until we actually use it to
+ * avoid compiler complaints */
+#if 0
 static struct alisp_object * incref_tree_explicit(struct alisp_instance *instance, struct alisp_object * p, struct alisp_object * e)
 {
 	if (p == NULL)
@@ -250,6 +253,7 @@ static struct alisp_object * incref_tree_explicit(struct alisp_instance *instanc
 		return incref_object(instance, p);
 	return p;
 }
+#endif
 
 static void free_objects(struct alisp_instance *instance)
 {
-- 
1.6.4.3
