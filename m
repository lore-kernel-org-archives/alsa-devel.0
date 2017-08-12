From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 0/3] ALSA: rme9652: Adjustments for six function
 implementations
Date: Sat, 12 Aug 2017 17:32:13 +0200
Message-ID: <a3223028-5b12-0efd-ffe0-aa7300334081@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org, Arnd Bergmann <arnd@arndb.de>, Colin Ian King <colin.king@canonical.com>, Jaroslav Kysela <perex@perex.cz>, Julia Lawall <Julia.Lawall@lip6.fr>, Takashi Iwai <tiwai@suse.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 12 Aug 2017 17:17:23 +0200

A few update suggestions were taken into account
from static source code analysis.

Markus Elfring (3):
  Delete an error message for a failed memory allocation in snd_hdspm_create()
  Improve eight size determinations
  Adjust seven checks for null pointers

 sound/pci/rme9652/hdspm.c | 42 ++++++++++++++++++------------------------
 1 file changed, 18 insertions(+), 24 deletions(-)

-- 
2.14.0
