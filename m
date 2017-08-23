From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 0/6] ALSA: core: Fine-tuning for some function
	implementations
Date: Wed, 23 Aug 2017 10:21:39 +0200
Message-ID: <800d7aa6-d8f2-cbf5-caaa-7e4006976e68@users.sourceforge.net>
References: <b8c9e41b-a47e-1d99-3d1a-5d39772e4b54@users.sourceforge.net>
 <s5h378isw2d.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.15.3])
 by alsa0.perex.cz (Postfix) with ESMTP id E009A2665D5
 for <alsa-devel@alsa-project.org>; Wed, 23 Aug 2017 10:22:02 +0200 (CEST)
In-Reply-To: <s5h378isw2d.wl-tiwai@suse.de>
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
To: alsa-devel@alsa-project.org, Arnd Bergmann <arnd@arndb.de>, Arvind Yadav <arvind.yadav.cs@gmail.com>, Dan Carpenter <dan.carpenter@oracle.com>, Ingo Molnar <mingo@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, Vegard Nossum <vegard.nossum@oracle.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 23 Aug 2017 10:05:43 +0200

Some update suggestions were taken into account
from static source code analysis.

Markus Elfring (6):
  pcm: Use common error handling code in _snd_pcm_new()
  pcm: Adjust nine function calls together with a variable assignment
  pcm: Adjust 11 checks for null pointers
  timer: Use common error handling code in alsa_timer_init()
  timer: Adjust a condition check in snd_timer_resolution()
  timer: Adjust 13 checks for null pointers

 sound/core/pcm.c   | 90 +++++++++++++++++++++++++++++++-----------------------
 sound/core/timer.c | 39 ++++++++++++-----------
 2 files changed, 73 insertions(+), 56 deletions(-)

-- 
2.14.0
