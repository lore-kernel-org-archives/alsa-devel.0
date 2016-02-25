From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch 2/2] ASoC: max9867: silence and array overflow
	warning
Date: Thu, 25 Feb 2016 10:50:38 +0300
Message-ID: <20160225075038.GC7333@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
 by alsa0.perex.cz (Postfix) with ESMTP id 50406261504
 for <alsa-devel@alsa-project.org>; Thu, 25 Feb 2016 08:50:49 +0100 (CET)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Axel Lin <axel.lin@ingics.com>, anish kumar <yesanishhere@gmail.com>, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

Smatch complains that we might reach the end of this loop without
finding what we're looking for leading to a buffer overflow.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/sound/soc/codecs/max9867.c b/sound/soc/codecs/max9867.c
index 4fb6fc7..9fb03c6 100755
--- a/sound/soc/codecs/max9867.c
+++ b/sound/soc/codecs/max9867.c
@@ -156,6 +156,8 @@ static inline int get_ni_value(int mclk, int rate)
 		if (ni_div[i].mclk >= mclk)
 			break;
 	}
+	if (i == ARRAY_SIZE(ni_div))
+		return -EINVAL;
 
 	switch (rate) {
 	case 8000:
