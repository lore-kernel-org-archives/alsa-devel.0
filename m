From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 0/4] ALSA-Riptide: Fine-tuning for seven
 function implementations
Date: Fri, 17 Nov 2017 10:46:10 +0100
Message-ID: <0eef2699-f28a-c1e0-9351-268b5eb7e0c1@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.15.3])
 by alsa0.perex.cz (Postfix) with ESMTP id D6982266B67
 for <alsa-devel@alsa-project.org>; Fri, 17 Nov 2017 10:47:00 +0100 (CET)
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
To: alsa-devel@alsa-project.org, Bhumika Goyal <bhumirks@gmail.com>, David Howells <dhowells@redhat.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 17 Nov 2017 10:32:23 +0100

A few update suggestions were taken into account
from static source code analysis.

Markus Elfring (4):
  Adjust 13 function calls together with a variable assignment
  Delete an unnecessary variable initialisation in snd_riptide_proc_read()
  Reduce the scope for two variables in snd_riptide_proc_read()
  Use common error handling code in snd_riptide_create()

 sound/pci/riptide/riptide.c | 78 ++++++++++++++++++++++++++-------------------
 1 file changed, 46 insertions(+), 32 deletions(-)

-- 
2.15.0
