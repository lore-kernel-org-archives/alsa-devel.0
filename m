From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 0/3] ALSA: ml403-ac97cr: Fine-tuning for five
 function implementations
Date: Sat, 11 Nov 2017 14:16:02 +0100
Message-ID: <4c38a970-2407-3559-060d-501b8259b3fc@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.15.14])
 by alsa0.perex.cz (Postfix) with ESMTP id 642DB266A73
 for <alsa-devel@alsa-project.org>; Sat, 11 Nov 2017 14:16:11 +0100 (CET)
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
To: alsa-devel@alsa-project.org, Arvind Yadav <arvind.yadav.cs@gmail.com>, Bhumika Goyal <bhumirks@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 11 Nov 2017 14:13:12 +0100

Three update suggestions were taken into account
from static source code analysis.

Markus Elfring (3):
  Use common error handling code in two functions
  Delete an unnecessary return statement in snd_ml403_ac97cr_codec_write()
  Adjust four checks for null pointers

 sound/drivers/ml403-ac97cr.c | 61 ++++++++++++++++++++++----------------------
 1 file changed, 30 insertions(+), 31 deletions(-)

-- 
2.15.0
