From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 2/2] simple_none.c needs '#include "config.h"'
Date: Mon, 16 Nov 2009 11:14:55 +0100
Message-ID: <1258366495-10815-3-git-send-email-mkl@pengutronix.de>
References: <1258366495-10815-1-git-send-email-mkl@pengutronix.de>
	<1258366495-10815-2-git-send-email-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id A99B8103897
	for <alsa-devel@alsa-project.org>; Mon, 16 Nov 2009 11:15:22 +0100 (CET)
In-Reply-To: <1258366495-10815-2-git-send-email-mkl@pengutronix.de>
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
Cc: Michael Olbrich <m.olbrich@pengutronix.de>, Marc Kleine-Budde <mkl@pengutronix.de>
List-Id: alsa-devel@alsa-project.org

From: Michael Olbrich <m.olbrich@pengutronix.de>

simple_none.c uses HAVE_SOFT_FLOAT it has to include config.h
for this to work properly.

Signed-off-by: Michael Olbrich <m.olbrich@pengutronix.de>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 src/mixer/simple_none.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/src/mixer/simple_none.c b/src/mixer/simple_none.c
index 9259a08..426f2d7 100644
--- a/src/mixer/simple_none.c
+++ b/src/mixer/simple_none.c
@@ -40,6 +40,7 @@
 #include <limits.h>
 #include <alsa/asoundlib.h>
 #include "mixer_simple.h"
+#include "config.h"
 
 #ifndef DOC_HIDDEN
 
-- 
1.6.5.2
