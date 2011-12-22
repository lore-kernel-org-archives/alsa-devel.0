From: linux@audioscience.com
Subject: [PATCH 19/21] Correct headers in cached control
	responses.
Date: Thu, 22 Dec 2011 13:38:49 +1300
Message-ID: <1324514331-22570-20-git-send-email-linux@audioscience.com>
References: <1324514331-22570-1-git-send-email-linux@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp4.clear.net.nz (smtp4.clear.net.nz [203.97.37.64])
	by alsa0.perex.cz (Postfix) with ESMTP id ED0AB103C3D
	for <alsa-devel@alsa-project.org>; Thu, 22 Dec 2011 01:40:20 +0100 (CET)
Received: from localhost.localdomain
	(121-72-250-62.cable.telstraclear.net [121.72.250.62])
	by smtp4.clear.net.nz (CLEAR Net Mail)
	with ESMTP id <0LWK00D3EXTHNQ40@smtp4.clear.net.nz> for
	alsa-devel@alsa-project.org; Thu, 22 Dec 2011 13:39:33 +1300 (NZDT)
In-reply-to: <1324514331-22570-1-git-send-email-linux@audioscience.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: Eliot Blennerhassett <eblennerhassett@audioscience.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Eliot Blennerhassett <eblennerhassett@audioscience.com>

Previously, only payload and size were correct, sufficient for reading,
but other fields produced spurious debug output.

Signed-off-by: Eliot Blennerhassett <eblennerhassett@audioscience.com>
---
 sound/pci/asihpi/hpicmn.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/sound/pci/asihpi/hpicmn.c b/sound/pci/asihpi/hpicmn.c
index c54a49f..7ed5c26 100644
--- a/sound/pci/asihpi/hpicmn.c
+++ b/sound/pci/asihpi/hpicmn.c
@@ -324,6 +324,8 @@ short hpi_check_control_cache(struct hpi_control_cache *p_cache,
 	}
 
 	phr->error = 0;
+	phr->specific_error = 0;
+	phr->version = 0;
 
 	/* set the default response size */
 	response_size =
@@ -531,8 +533,12 @@ short hpi_check_control_cache(struct hpi_control_cache *p_cache,
 		found ? "Cached" : "Uncached", phm->adapter_index,
 		pI->control_index, pI->control_type, phm->u.c.attribute);
 
-	if (found)
+	if (found) {
 		phr->size = (u16)response_size;
+		phr->type = HPI_TYPE_RESPONSE;
+		phr->object = phm->object;
+		phr->function = phm->function;
+	}
 
 	return found;
 }
-- 
1.7.0.4
