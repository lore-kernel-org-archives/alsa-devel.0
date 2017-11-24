From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 0/4] ASoC: wm2000: Adjustments for
	wm2000_i2c_probe()
Date: Fri, 24 Nov 2017 08:34:26 +0100
Message-ID: <cd76c876-81a5-3cf6-e7d9-52037729fb98@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.15.4])
 by alsa0.perex.cz (Postfix) with ESMTP id 15520266A74
 for <alsa-devel@alsa-project.org>; Fri, 24 Nov 2017 08:34:50 +0100 (CET)
Content-Language: en-GB
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, patches@opensource.cirrus.com, Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 24 Nov 2017 08:26:56 +0100

A few update suggestions were taken into account
from static source code analysis.

Markus Elfring (4):
  Delete an error message for a failed memory allocation
  One function call less in wm2000_i2c_probe() after error detection
  Fix a typo in a comment line
  Improve a size determination

 sound/soc/codecs/wm2000.c | 28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)

-- 
2.15.0
