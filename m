From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 43/54] MAINTAINERS: Add file patterns for sound
	device tree bindings
Date: Sun, 22 May 2016 11:06:20 +0200
Message-ID: <1463907991-7916-44-git-send-email-geert@linux-m68k.org>
References: <1463907991-7916-1-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from michel.telenet-ops.be (michel.telenet-ops.be [195.130.137.88])
 by alsa0.perex.cz (Postfix) with ESMTP id B670926070F
 for <alsa-devel@alsa-project.org>; Sun, 22 May 2016 11:06:46 +0200 (CEST)
In-Reply-To: <1463907991-7916-1-git-send-email-geert@linux-m68k.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Submitters of device tree binding documentation may forget to CC
the subsystem maintainer if this is missing.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
---
Please apply this patch directly if you want to be involved in device
tree binding documentation for your subsystem.
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 139824579fa97c2c..9d81eff6577ff886 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10728,6 +10728,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git
 L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
 W:	http://alsa-project.org/main/index.php/ASoC
 S:	Supported
+F:	Documentation/devicetree/bindings/sound/
 F:	Documentation/sound/alsa/soc/
 F:	sound/soc/
 F:	include/sound/soc*
-- 
1.9.1
