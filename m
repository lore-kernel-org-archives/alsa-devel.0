From: Stefan Schmidt <stefan@datenfreihafen.org>
Subject: [PATCH 3/3] control: Remove unused variable.
Date: Tue, 29 Sep 2009 23:48:21 +0200
Message-ID: <1254260901-1161-4-git-send-email-stefan@datenfreihafen.org>
References: <1254260901-1161-1-git-send-email-stefan@datenfreihafen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sirius.lasnet.de (sirius.lasnet.de [78.47.116.19])
	by alsa0.perex.cz (Postfix) with ESMTP id A04E22434E
	for <alsa-devel@alsa-project.org>;
	Tue, 29 Sep 2009 23:48:38 +0200 (CEST)
In-Reply-To: <1254260901-1161-1-git-send-email-stefan@datenfreihafen.org>
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

Signed-off-by: Stefan Schmidt <stefan@slimlogic.co.uk>
---
 src/control/control.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/control/control.c b/src/control/control.c
index ae70e76..51628ba 100644
--- a/src/control/control.c
+++ b/src/control/control.c
@@ -675,7 +675,7 @@ int snd_ctl_wait(snd_ctl_t *ctl, int timeout)
 {
 	struct pollfd *pfd;
 	unsigned short revents;
-	int i, npfds, err, err_poll;
+	int npfds, err, err_poll;
 
 	npfds = snd_ctl_poll_descriptors_count(ctl);
 	if (npfds <= 0 || npfds >= 16) {
-- 
1.6.4.3
