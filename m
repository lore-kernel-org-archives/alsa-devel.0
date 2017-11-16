From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 0/2] ALSA: nm256: Fine-tuning for three
 function implementations
Date: Thu, 16 Nov 2017 18:05:27 +0100
Message-ID: <d98a2685-ddf9-1cba-839a-d12c5ff8d3ba@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.17.12])
 by alsa0.perex.cz (Postfix) with ESMTP id 2C78D26774A
 for <alsa-devel@alsa-project.org>; Thu, 16 Nov 2017 18:06:18 +0100 (CET)
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
To: alsa-devel@alsa-project.org, Arvind Yadav <arvind.yadav.cs@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 16 Nov 2017 18:00:18 +0100

Two update suggestions were taken into account
from static source code analysis.

Markus Elfring (2):
  Adjust five function calls together with a variable assignment
  Use common error handling code in snd_nm256_probe()

 sound/pci/nm256/nm256.c | 48 +++++++++++++++++++++++++++++-------------------
 1 file changed, 29 insertions(+), 19 deletions(-)

-- 
2.15.0
