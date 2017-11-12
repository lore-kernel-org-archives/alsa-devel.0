From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 0/2] ALSA: au88x0: Fine-tuning for some
 function implementations
Date: Sun, 12 Nov 2017 22:36:39 +0100
Message-ID: <e42f1434-f1d7-a43b-d887-a82b50158280@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.15.14])
 by alsa0.perex.cz (Postfix) with ESMTP id 4D4CF266A73
 for <alsa-devel@alsa-project.org>; Sun, 12 Nov 2017 22:36:45 +0100 (CET)
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
To: alsa-devel@alsa-project.org, Arnd Bergmann <arnd@arndb.de>, Arvind Yadav <arvind.yadav.cs@gmail.com>, Bhumika Goyal <bhumirks@gmail.com>, Colin Ian King <colin.king@canonical.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 12 Nov 2017 22:30:44 +0100

A few update suggestions were taken into account
from static source code analysis.

Markus Elfring (2):
  Adjust 40 function calls together with a variable assignment
  Use common error handling code in two functions

 sound/pci/au88x0/au88x0.c        | 112 +++++++++++++++++++--------------------
 sound/pci/au88x0/au88x0_a3d.c    |  28 +++++-----
 sound/pci/au88x0/au88x0_core.c   |  78 +++++++++++++--------------
 sound/pci/au88x0/au88x0_eq.c     |  21 +++++---
 sound/pci/au88x0/au88x0_mixer.c  |   3 +-
 sound/pci/au88x0/au88x0_mpu401.c |  14 ++---
 sound/pci/au88x0/au88x0_pcm.c    |  16 +++---
 7 files changed, 140 insertions(+), 132 deletions(-)

-- 
2.15.0
