From: Mark Hills <mark@pogo.org.uk>
Subject: [PATCH 4/5] snd-usb-caiaq: Remove duplicate A8DJ
	control
Date: Wed,  4 Feb 2009 22:34:33 +0000
Message-ID: <1233786874-16373-4-git-send-email-mark@pogo.org.uk>
References: <1233786874-16373-1-git-send-email-mark@pogo.org.uk>
	<1233786874-16373-2-git-send-email-mark@pogo.org.uk>
	<1233786874-16373-3-git-send-email-mark@pogo.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metheny.ijneb.com (mailout.ijneb.com [212.13.201.26])
	by alsa0.perex.cz (Postfix) with ESMTP id 76BB32440A
	for <alsa-devel@alsa-project.org>; Wed,  4 Feb 2009 23:34:35 +0100 (CET)
In-Reply-To: <1233786874-16373-3-git-send-email-mark@pogo.org.uk>
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
Cc: Daniel Mack <daniel@caiaq.de>
List-Id: alsa-devel@alsa-project.org

Remove a duplicate control which causes an error when it is registered,
and causes later controls to not be registered. The device does not have
a fourth ground lift control.

Signed-off-by: Mark Hills <mark@pogo.org.uk>
Acked-by: Daniel Mack <daniel@caiaq.de>
---
 usb/caiaq/caiaq-control.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/usb/caiaq/caiaq-control.c b/usb/caiaq/caiaq-control.c
index 136ef34..e92c2bb 100644
--- a/usb/caiaq/caiaq-control.c
+++ b/usb/caiaq/caiaq-control.c
@@ -270,7 +270,6 @@ static struct caiaq_controller a8dj_controller[] = {
 	{ "GND lift for TC Vinyl mode", 	24 + 0 		},
 	{ "GND lift for TC CD/Line mode", 	24 + 1 		},
 	{ "GND lift for phono mode", 		24 + 2 		},
-	{ "GND lift for TC Vinyl mode", 	24 + 3 		},
 	{ "Software lock", 			40 		}
 };
 
-- 
1.6.1.2
