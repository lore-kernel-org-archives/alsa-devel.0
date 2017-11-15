From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 0/3] ALSA: fm801: Fine-tuning for seven
 function implementations
Date: Wed, 15 Nov 2017 13:45:09 +0100
Message-ID: <86b94d9c-77fb-fed5-b55c-a0565f619dc7@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.17.12])
 by alsa0.perex.cz (Postfix) with ESMTP id 1B81A266D11
 for <alsa-devel@alsa-project.org>; Wed, 15 Nov 2017 13:45:50 +0100 (CET)
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
To: alsa-devel@alsa-project.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Bhumika Goyal <bhumirks@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 15 Nov 2017 13:40:43 +0100

A few update suggestions were taken into account
from static source code analysis.

Markus Elfring (3):
  Adjust 17 function calls together with a variable assignment
  Use common error handling code in two functions
  Rename a jump label in snd_card_fm801_probe()

 sound/pci/fm801.c | 140 +++++++++++++++++++++++++++++-------------------------
 1 file changed, 76 insertions(+), 64 deletions(-)

-- 
2.15.0
