From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 0/3] ALSA: ens1370: Fine-tuning for six
 function implementations
Date: Tue, 14 Nov 2017 18:43:07 +0100
Message-ID: <8bcf1ada-f44c-cb83-0890-adc8ae8edda0@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.15.3])
 by alsa0.perex.cz (Postfix) with ESMTP id 882DD266F61
 for <alsa-devel@alsa-project.org>; Tue, 14 Nov 2017 18:43:52 +0100 (CET)
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
To: alsa-devel@alsa-project.org, Bhumika Goyal <bhumirks@gmail.com>, Colin Ian King <colin.king@canonical.com>, David Howells <dhowells@redhat.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 14 Nov 2017 18:38:28 +0100

A few update suggestions were taken into account
from static source code analysis.

Markus Elfring (3):
  Adjust 15 function calls together with a variable assignment
  Use common error handling code in snd_audiopci_probe()
  Use common error handling code in snd_ensoniq_create()

 sound/pci/ens1370.c | 110 +++++++++++++++++++++++++++++-----------------------
 1 file changed, 61 insertions(+), 49 deletions(-)

-- 
2.15.0
