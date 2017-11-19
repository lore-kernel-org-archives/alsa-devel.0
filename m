From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 0/4] ALSA SoC PCM: Fine-tuning for some
 function implementations
Date: Sun, 19 Nov 2017 21:17:43 +0100
Message-ID: <54203404-1e40-3c97-a6e5-75a41ec3e742@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.15.4])
 by alsa0.perex.cz (Postfix) with ESMTP id 9CC2A266E6B
 for <alsa-devel@alsa-project.org>; Sun, 19 Nov 2017 21:19:06 +0100 (CET)
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
To: alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 19 Nov 2017 21:12:34 +0100

A few update suggestions were taken into account
from static source code analysis.

Markus Elfring (4):
  Improve unlocking of a mutex in soc_dpcm_runtime_update()
  Add some blank lines for better code readability
  Add some spaces for better code readability
  Improve a size determination in dpcm_be_connect()

 sound/soc/soc-pcm.c | 60 ++++++++++++++++++++++++++++++++---------------------
 1 file changed, 36 insertions(+), 24 deletions(-)

-- 
2.15.0
