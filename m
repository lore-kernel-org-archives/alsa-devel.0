From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 0/3] ALSA-Trident 4DWave: Fine-tuning for nine
 function implementations
Date: Sat, 18 Nov 2017 20:10:06 +0100
Message-ID: <498d6d73-2c62-178a-3c7a-b0fcb092d81e@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.17.11])
 by alsa0.perex.cz (Postfix) with ESMTP id 95146266EFA
 for <alsa-devel@alsa-project.org>; Sat, 18 Nov 2017 20:10:14 +0100 (CET)
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
To: alsa-devel@alsa-project.org, Arvind Yadav <arvind.yadav.cs@gmail.com>, Bhumika Goyal <bhumirks@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 18 Nov 2017 19:50:12 +0100

A few update suggestions were taken into account
from static source code analysis.

Markus Elfring (3):
  Adjust 34 function calls together with a variable assignment
  Use common error handling code in two functions
  Use common error handling code in snd_trident_mixer()

 sound/pci/trident/trident.c      |  68 ++++++------
 sound/pci/trident/trident_main.c | 221 ++++++++++++++++++++++-----------------
 2 files changed, 163 insertions(+), 126 deletions(-)

-- 
2.15.0
