From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH alsa-lib] doxygen: Suppress timestamp
Date: Thu, 23 Jun 2016 16:30:52 +0200
Message-ID: <20160623143052.23654-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id B5FA8265361
 for <alsa-devel@alsa-project.org>; Thu, 23 Jun 2016 16:41:37 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id DA82BAAB7
 for <alsa-devel@alsa-project.org>; Thu, 23 Jun 2016 14:41:36 +0000 (UTC)
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

The build timestamp in the doc is bad for packaging in general, so
let's disable it as default.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 doc/doxygen.cfg.in | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/doc/doxygen.cfg.in b/doc/doxygen.cfg.in
index 92bd52ba67a2..11740d342596 100644
--- a/doc/doxygen.cfg.in
+++ b/doc/doxygen.cfg.in
@@ -124,3 +124,5 @@ TYPEDEF_HIDES_STRUCT = YES	# needed in doxygen >= 1.5.4
 
 #INPUT_FILTER	 = inputfilter
 #FILTER_SOURCE_FILES = YES
+
+HTML_TIMESTAMP = NO
-- 
2.9.0
