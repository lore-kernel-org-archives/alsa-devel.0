From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 0/2] ALSA: pcxhr: Fine-tuning for three
 function implementations
Date: Thu, 16 Nov 2017 22:24:46 +0100
Message-ID: <c110ba76-d99d-9f80-d927-14d437115004@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.17.11])
 by alsa0.perex.cz (Postfix) with ESMTP id 70FC1266EE4
 for <alsa-devel@alsa-project.org>; Thu, 16 Nov 2017 22:24:56 +0100 (CET)
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
To: alsa-devel@alsa-project.org, Arnd Bergmann <arnd@arndb.de>, Bhumika Goyal <bhumirks@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 16 Nov 2017 22:20:02 +0100

Two update suggestions were taken into account
from static source code analysis.

Markus Elfring (2):
  Adjust six function calls together with a variable assignment
  Use common error handling code in pcxhr_probe()

 sound/pci/pcxhr/pcxhr.c | 82 ++++++++++++++++++++++++++-----------------------
 1 file changed, 44 insertions(+), 38 deletions(-)

-- 
2.15.0
