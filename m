From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 0/5] ASoC: dapm: Adjustments for some function
	implementations
Date: Thu, 10 Aug 2017 15:00:27 +0200
Message-ID: <e8013ddb-687d-ee56-8153-2791bb9f46fe@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.17.12])
 by alsa0.perex.cz (Postfix) with ESMTP id D35B22665D5
 for <alsa-devel@alsa-project.org>; Thu, 10 Aug 2017 15:01:16 +0200 (CEST)
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
Date: Thu, 10 Aug 2017 14:54:32 +0200

A few update suggestions were taken into account
from static source code analysis.

Markus Elfring (5):
  Delete error messages for a failed memory allocation in snd_soc_dapm_new_pcm()
  Improve a size determination in two functions
  Use kcalloc() in snd_soc_dapm_new_widgets()
  Adjust one function call together with a variable assignment
  Adjust seven checks for null pointers

 sound/soc/soc-dapm.c | 36 ++++++++++++++++--------------------
 1 file changed, 16 insertions(+), 20 deletions(-)

-- 
2.14.0
