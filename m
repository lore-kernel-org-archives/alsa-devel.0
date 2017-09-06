From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 0/3] ALSA: ymfpci: Fine-tuning for some
 function implementations
Date: Wed, 6 Sep 2017 21:45:29 +0200
Message-ID: <dafe6d86-1bfd-41a8-e189-bde7ae30dea9@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.15.14])
 by alsa0.perex.cz (Postfix) with ESMTP id A71EF266A8A
 for <alsa-devel@alsa-project.org>; Wed,  6 Sep 2017 21:45:44 +0200 (CEST)
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
To: alsa-devel@alsa-project.org, Bhumika Goyal <bhumirks@gmail.com>, David Howells <dhowells@redhat.com>, Ingo Molnar <mingo@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 6 Sep 2017 21:37:32 +0200

Three update suggestions were taken into account
from static source code analysis.

Markus Elfring (3):
  Use common error handling code in snd_card_ymfpci_probe()
  Use common error handling code in snd_ymfpci_create()
  Adjust 17 checks for null pointers

 sound/pci/ymfpci/ymfpci.c      | 62 ++++++++++++++++++------------------
 sound/pci/ymfpci/ymfpci_main.c | 72 ++++++++++++++++++++++--------------------
 2 files changed, 67 insertions(+), 67 deletions(-)

-- 
2.14.1
