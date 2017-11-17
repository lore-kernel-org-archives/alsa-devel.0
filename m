From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 0/3] ALSA-RME Digi32: Fine-tuning for seven
 function implementations
Date: Fri, 17 Nov 2017 22:14:41 +0100
Message-ID: <67820e63-aed9-c775-8417-b0f531a9b305@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.15.14])
 by alsa0.perex.cz (Postfix) with ESMTP id 2F399266B67
 for <alsa-devel@alsa-project.org>; Fri, 17 Nov 2017 22:15:01 +0100 (CET)
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
To: alsa-devel@alsa-project.org, Bhumika Goyal <bhumirks@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 17 Nov 2017 22:08:44 +0100

A few update suggestions were taken into account
from static source code analysis.

Markus Elfring (3):
  Adjust 15 function calls together with a variable assignment
  Use common error handling code in snd_rme32_probe()
  Improve unlocking of an IRQ in two functions

 sound/pci/rme32.c | 127 +++++++++++++++++++++++++++++++-----------------------
 1 file changed, 74 insertions(+), 53 deletions(-)

-- 
2.15.0
