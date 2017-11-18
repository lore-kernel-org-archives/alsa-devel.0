From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 0/2] ALSA-Digigram VX222: Fine-tuning for four
 function implementations
Date: Sat, 18 Nov 2017 21:38:52 +0100
Message-ID: <e961ecef-9f03-0c2a-ad64-64102bbc1389@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.17.11])
 by alsa0.perex.cz (Postfix) with ESMTP id 54B99266EFA
 for <alsa-devel@alsa-project.org>; Sat, 18 Nov 2017 21:38:59 +0100 (CET)
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
To: alsa-devel@alsa-project.org, Bhumika Goyal <bhumirks@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 18 Nov 2017 21:27:50 +0100

Two update suggestions were taken into account
from static source code analysis.

Markus Elfring (2):
  Adjust ten function calls together with a variable assignment
  Use common error handling code in two functions

 sound/pci/vx222/vx222.c     | 53 +++++++++++++++++++++++++--------------------
 sound/pci/vx222/vx222_ops.c | 19 +++++++++-------
 2 files changed, 41 insertions(+), 31 deletions(-)

-- 
2.15.0
