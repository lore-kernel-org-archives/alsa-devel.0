From: Manuel Lauss <manuel.lauss@googlemail.com>
Subject: [PATCH] MIPS/sound: DB1200 audio support depends on
	MIPS arch.
Date: Thu, 10 Nov 2011 12:20:59 +0100
Message-ID: <1320924059-4142-1-git-send-email-manuel.lauss__12469.5130893544$1320924089$gmane$org@googlemail.com>
References: <20111110122241.eed1e785e4c015a51b9ef585@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20111110122241.eed1e785e4c015a51b9ef585@canb.auug.org.au>
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
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Manuel Lauss <manuel.lauss@googlemail.com>, linux-next@vger.kernel.org, alsa-devel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

DB1200 audio support should only be visible if MIPS/Alchemy arch is
selected.  Fixes an x86-allmodconfig build failure in linux-next.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>
---
 sound/soc/au1x/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/au1x/Kconfig b/sound/soc/au1x/Kconfig
index c620cbf9..a561040 100644
--- a/sound/soc/au1x/Kconfig
+++ b/sound/soc/au1x/Kconfig
@@ -52,7 +52,7 @@ config SND_SOC_DB1000
 
 config SND_SOC_DB1200
 	tristate "DB1200/DB1300/DB1550 Audio support"
-	select SND_SOC_AU1XPSC
+	depends on SND_SOC_AU1XPSC
 	select SND_SOC_AU1XPSC_AC97
 	select SND_SOC_AC97_CODEC
 	select SND_SOC_WM9712
-- 
1.7.7.2

