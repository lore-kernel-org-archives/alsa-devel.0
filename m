From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 0/2] ALSA: rme9652: Adjustments for two
 function implementations
Date: Tue, 5 Sep 2017 22:34:46 +0200
Message-ID: <9832906e-3b04-b708-2c26-4755e0beb811@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.17.11])
 by alsa0.perex.cz (Postfix) with ESMTP id 85FED266BCF
 for <alsa-devel@alsa-project.org>; Tue,  5 Sep 2017 22:35:31 +0200 (CEST)
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
To: alsa-devel@alsa-project.org, Arnd Bergmann <arnd@arndb.de>, Bhumika Goyal <bhumirks@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 5 Sep 2017 22:30:22 +0200

Two update suggestions were taken into account
from static source code analysis.

Markus Elfring (2):
  Use common code in hdsp_get_iobox_version()
  Use common error handling code in snd_hdspm_probe()

 sound/pci/rme9652/hdsp.c  | 26 +++++++++++---------------
 sound/pci/rme9652/hdspm.c | 16 ++++++++--------
 2 files changed, 19 insertions(+), 23 deletions(-)

-- 
2.14.1
