From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 11/11] ASoC: davinci-sffsdr: Staticize non
	exported struct
Date: Tue, 14 May 2013 22:19:57 +0200
Message-ID: <1368562797-10440-11-git-send-email-lars@metafoo.de>
References: <1368562797-10440-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-208.synserver.de (smtp-out-209.synserver.de
 [212.40.185.209])
 by alsa0.perex.cz (Postfix) with ESMTP id 601BA260865
 for <alsa-devel@alsa-project.org>; Tue, 14 May 2013 22:20:30 +0200 (CEST)
In-Reply-To: <1368562797-10440-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Gururaja Hebbar <gururaja.hebbar@ti.com>
List-Id: alsa-devel@alsa-project.org

The pcm3008_codec struct is not used outside of davinci-sffsdr.c, so make it
static.

Cc: Gururaja Hebbar <gururaja.hebbar@ti.com>
Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/davinci/davinci-sffsdr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/davinci/davinci-sffsdr.c b/sound/soc/davinci/davinci-sffsdr.c
index 5be65aa..24df5bc 100644
--- a/sound/soc/davinci/davinci-sffsdr.c
+++ b/sound/soc/davinci/davinci-sffsdr.c
@@ -106,7 +106,7 @@ static struct pcm3008_setup_data sffsdr_pcm3008_setup = {
 	.pdda_pin = GPIO(38),
 };
 
-struct platform_device pcm3008_codec = {
+static struct platform_device pcm3008_codec = {
 		.name = "pcm3008-codec",
 		.id = 0,
 		.dev = {
-- 
1.8.0
