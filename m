From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 0/3] ALSA: mpu401: Adjustments for three
 function implementations
Date: Sat, 12 Aug 2017 21:10:12 +0200
Message-ID: <47947226-bd09-5d15-c0d2-a9f4a659e1b4@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [217.72.192.78])
 by alsa0.perex.cz (Postfix) with ESMTP id 3BF4926701A
 for <alsa-devel@alsa-project.org>; Sat, 12 Aug 2017 21:10:55 +0200 (CEST)
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
To: alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 12 Aug 2017 21:05:21 +0200

A few update suggestions were taken into account
from static source code analysis.

Markus Elfring (3):
  Delete an error message for a failed memory allocation in snd_mpu401_uart_new()
  Use common error handling code in snd_mpu401_uart_new()
  Adjust four checks for null pointers

 sound/drivers/mpu401/mpu401_uart.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

-- 
2.14.0
