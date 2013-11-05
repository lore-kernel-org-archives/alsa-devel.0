From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/5] ALSA: ctxfi: Use WARN_ON() instead of
	BUG_ON()
Date: Tue,  5 Nov 2013 18:10:39 +0100
Message-ID: <1383671443-13707-2-git-send-email-tiwai@suse.de>
References: <1383671443-13707-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 15B33265083
 for <alsa-devel@alsa-project.org>; Tue,  5 Nov 2013 18:10:47 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id DC885A67E8
 for <alsa-devel@alsa-project.org>; Tue,  5 Nov 2013 18:10:46 +0100 (CET)
In-Reply-To: <1383671443-13707-1-git-send-email-tiwai@suse.de>
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

BUG_ON() is rather useless for debugging as it leads to panic().
Use WARN_ON() and handle the error cases accordingly.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/ctxfi/cthardware.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/pci/ctxfi/cthardware.c b/sound/pci/ctxfi/cthardware.c
index 110b8ace6d8a..a689f2552706 100644
--- a/sound/pci/ctxfi/cthardware.c
+++ b/sound/pci/ctxfi/cthardware.c
@@ -69,7 +69,8 @@ unsigned int get_field(unsigned int data, unsigned int field)
 {
 	int i;
 
-	BUG_ON(!field);
+	if (WARN_ON(!field))
+		return 0;
 	/* @field should always be greater than 0 */
 	for (i = 0; !(field & (1 << i)); )
 		i++;
@@ -81,7 +82,8 @@ void set_field(unsigned int *data, unsigned int field, unsigned int value)
 {
 	int i;
 
-	BUG_ON(!field);
+	if (WARN_ON(!field))
+		return;
 	/* @field should always be greater than 0 */
 	for (i = 0; !(field & (1 << i)); )
 		i++;
-- 
1.8.4.2
