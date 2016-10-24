From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: [PATCH 4/7] ASoC: sti: clean unused include
Date: Mon, 24 Oct 2016 16:42:54 +0200
Message-ID: <1477320177-30130-5-git-send-email-arnaud.pouliquen@st.com>
References: <1477320177-30130-1-git-send-email-arnaud.pouliquen@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [62.209.51.94]) by alsa0.perex.cz (Postfix) with ESMTP id F07BA266CBD
 for <alsa-devel@alsa-project.org>; Mon, 24 Oct 2016 16:43:16 +0200 (CEST)
In-Reply-To: <1477320177-30130-1-git-send-email-arnaud.pouliquen@st.com>
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
Cc: kernel@stlinux.com, Takashi Iwai <tiwai@suse.de>, arnaud.pouliquen@st.com, lgirdwood@gmail.com, broonie@kernel.org, Moise Gergaud <moise.gergaud@st.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
 sound/soc/sti/uniperif_player.c | 1 -
 sound/soc/sti/uniperif_reader.c | 3 ---
 2 files changed, 4 deletions(-)

diff --git a/sound/soc/sti/uniperif_player.c b/sound/soc/sti/uniperif_player.c
index d59ec90..60ae31a 100644
--- a/sound/soc/sti/uniperif_player.c
+++ b/sound/soc/sti/uniperif_player.c
@@ -6,7 +6,6 @@
  */
 
 #include <linux/clk.h>
-#include <linux/io.h>
 #include <linux/mfd/syscon.h>
 
 #include <sound/asoundef.h>
diff --git a/sound/soc/sti/uniperif_reader.c b/sound/soc/sti/uniperif_reader.c
index 59043f7..5992c6a 100644
--- a/sound/soc/sti/uniperif_reader.c
+++ b/sound/soc/sti/uniperif_reader.c
@@ -5,9 +5,6 @@
  * License terms:  GNU General Public License (GPL), version 2
  */
 
-#include <linux/clk.h>
-#include <linux/io.h>
-
 #include <sound/soc.h>
 
 #include "uniperif.h"
-- 
1.9.1
