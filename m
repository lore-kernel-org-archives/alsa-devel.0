From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 0/2] ALSA-RME Digi96: Fine-tuning for four
 function implementations
Date: Sat, 18 Nov 2017 13:51:24 +0100
Message-ID: <7b7da9a6-64e1-bde5-99aa-de21f0665323@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.17.12])
 by alsa0.perex.cz (Postfix) with ESMTP id 86B8926698E
 for <alsa-devel@alsa-project.org>; Sat, 18 Nov 2017 13:51:44 +0100 (CET)
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
Date: Sat, 18 Nov 2017 13:45:43 +0100

Two update suggestions were taken into account
from static source code analysis.

Markus Elfring (2):
  Adjust 11 function calls together with a variable assignment
  Improve unlocking of an IRQ in snd_rme96_capture_hw_params()

 sound/pci/rme96.c | 91 +++++++++++++++++++++++++++++++------------------------
 1 file changed, 51 insertions(+), 40 deletions(-)

-- 
2.15.0
