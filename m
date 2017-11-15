From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 0/3] ALSA: es1968: Fine-tuning for seven
 function implementations
Date: Wed, 15 Nov 2017 10:26:28 +0100
Message-ID: <e1e9e0cc-0378-c2fe-015d-15555fd61a23@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [217.72.192.78])
 by alsa0.perex.cz (Postfix) with ESMTP id CD8C7266E67
 for <alsa-devel@alsa-project.org>; Wed, 15 Nov 2017 10:27:13 +0100 (CET)
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
Date: Wed, 15 Nov 2017 10:23:45 +0100

A few update suggestions were taken into account
from static source code analysis.

Markus Elfring (3):
  Adjust 16 function calls together with a variable assignment
  Use common error handling code in two functions
  Use common error handling code in snd_es1968_capture_open()

 sound/pci/es1968.c | 163 ++++++++++++++++++++++++++++++-----------------------
 1 file changed, 92 insertions(+), 71 deletions(-)

-- 
2.15.0
