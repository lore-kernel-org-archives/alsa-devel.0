From: Mark Brown <broonie@kernel.org>
Subject: [PATCH] MAINTAINERS: Add entry for Cirrus CODEC drivers
Date: Tue,  4 Feb 2014 20:30:05 +0000
Message-ID: <1391545805-6746-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 0935E261AA4
 for <alsa-devel@alsa-project.org>; Tue,  4 Feb 2014 21:30:15 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Brian Austin <brian.austin@cirrus.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

I noticed that some recent patches hadn't been CCed to the Cirrus people
- add an entry in MAINTAINERS to help make that happen.

Signed-off-by: Mark Brown <broonie@linaro.org>
---

Brian, Paul - are you OK with this?

 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b97ce2594f16..5ef6c0277075 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2200,6 +2200,13 @@ L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
 S:	Odd Fixes
 F:	sound/soc/codecs/cs4270*
 
+CIRRUS LOGIC AUDIO CODEC DRIVERS
+M:	Brian Austin <brian.austin@cirrus.com>
+M:	Paul Handrigan <Paul.Handrigan@cirrus.com>
+L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
+S:	Maintained
+F:	sound/soc/codecs/cs*
+
 CLEANCACHE API
 M:	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
 L:	linux-kernel@vger.kernel.org
-- 
1.9.rc1
