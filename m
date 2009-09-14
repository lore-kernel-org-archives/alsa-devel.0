From: pavel.hofman@ivitera.com
Subject: [PATCH 2/2] Infrasonic Quartet build support
Date: Tue, 15 Sep 2009 00:48:11 +0200
Message-ID: <1252968491-31517-2-git-send-email-pavel.hofman@ivitera.com>
References: <1252968491-31517-1-git-send-email-pavel.hofman@ivitera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1252968491-31517-1-git-send-email-pavel.hofman@ivitera.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: Pavel Hofman <pavel.hofman@ivitera.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Pavel Hofman <pavel.hofman@ivitera.com>


Signed-off-by: Pavel Hofman <pavel.hofman@ivitera.com>

diff --git a/pci/ice1712/quartet.c b/pci/ice1712/quartet.c
new file mode 100644
index 0000000..634fd17
--- /dev/null
+++ b/pci/ice1712/quartet.c
@@ -0,0 +1,3 @@
+#define __NO_VERSION__
+#include "adriver.h"
+#include "../../alsa-kernel/pci/ice1712/quartet.c"
-- 
1.5.6.3
