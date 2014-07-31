From: Mark Brown <broonie@kernel.org>
Subject: [PATCH] MAINTAINERS: Add entry for Realtek CODECs
Date: Thu, 31 Jul 2014 12:44:00 +0100
Message-ID: <1406807040-3084-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 4A798264F10
 for <alsa-devel@alsa-project.org>; Thu, 31 Jul 2014 13:44:11 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

Help ensure that patches get sent to the Realtek developers for review by
adding an explicit MAINTAINERS entry for them.

Signed-off-by: Mark Brown <broonie@linaro.org>
---

Bard, Oder - are you OK with this being added?

 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index fcdcaf0fd486..9f72e72a604d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7533,6 +7533,13 @@ F:	drivers/rtc/
 F:	include/linux/rtc.h
 F:	include/uapi/linux/rtc.h
 
+REALTEK AUDIO CODECS
+M:	Bard Liao <bardliao@realtek.com>
+M:	Oder Chiou <oder_chiou@realtek.com>
+S:	Maintained
+F:	sound/soc/codecs/rt*
+F:	include/sound/rt*.h
+
 REISERFS FILE SYSTEM
 L:	reiserfs-devel@vger.kernel.org
 S:	Supported
-- 
2.0.1
