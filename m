From: Mika Westerberg <mika.westerberg@iki.fi>
Subject: [PATCH 3/3] ASoC: ac97: add MODULE_ALIAS for the
	platform driver
Date: Wed, 13 Oct 2010 11:30:33 +0300
Message-ID: <4f03b9b42b8b6adf40568d9e57937201992625d7.1286958072.git.mika.westerberg@iki.fi>
References: <cover.1286958072.git.mika.westerberg@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51])
	by alsa0.perex.cz (Postfix) with ESMTP id DFF401039FE
	for <alsa-devel@alsa-project.org>;
	Wed, 13 Oct 2010 10:30:31 +0200 (CEST)
Received: by mail-bw0-f51.google.com with SMTP id 18so3567297bwz.38
	for <alsa-devel@alsa-project.org>; Wed, 13 Oct 2010 01:30:31 -0700 (PDT)
In-Reply-To: <cover.1286958072.git.mika.westerberg@iki.fi>
In-Reply-To: <cover.1286958072.git.mika.westerberg@iki.fi>
References: <cover.1286958072.git.mika.westerberg@iki.fi>
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
Cc: Mika Westerberg <mika.westerberg@iki.fi>, broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

So that modprobe can load the driver automatically when the platform device
appears.

Signed-off-by: Mika Westerberg <mika.westerberg@iki.fi>
---
 sound/soc/codecs/ac97.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/ac97.c b/sound/soc/codecs/ac97.c
index f5139ae..3c08793 100644
--- a/sound/soc/codecs/ac97.c
+++ b/sound/soc/codecs/ac97.c
@@ -162,3 +162,4 @@ module_exit(ac97_exit);
 MODULE_DESCRIPTION("Soc Generic AC97 driver");
 MODULE_AUTHOR("Liam Girdwood");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:ac97-codec");
-- 
1.5.6.5
