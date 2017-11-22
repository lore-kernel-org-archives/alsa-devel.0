From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 0/3] ASoC-cs42l73: Adjustments for two function
 implementations
Date: Wed, 22 Nov 2017 16:46:13 +0100
Message-ID: <609e2542-4750-fe60-4f42-08bca79bfb56@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.17.12])
 by alsa0.perex.cz (Postfix) with ESMTP id 8580D266F03
 for <alsa-devel@alsa-project.org>; Wed, 22 Nov 2017 16:47:18 +0100 (CET)
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
To: alsa-devel@alsa-project.org, Brian Austin <brian.austin@cirrus.com>, Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Paul Handrigan <Paul.Handrigan@cirrus.com>, Takashi Iwai <tiwai@suse.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 22 Nov 2017 16:38:32 +0100

Three update suggestions were taken into account
from static source code analysis.

Markus Elfring (3):
  Delete an error message for a failed memory allocation in cs42l73_i2c_probe()
  Improve two size determinations in cs42l73_i2c_probe()
  Fix a typo in two comments

 sound/soc/codecs/cs42l73.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

-- 
2.15.0
