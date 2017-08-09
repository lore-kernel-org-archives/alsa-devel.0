From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 0/4] ALSA: emux: Adjustments for four function
	implementations
Date: Wed, 9 Aug 2017 10:00:23 +0200
Message-ID: <412aa3a5-c8b6-c1fe-febb-0d62927dacc2@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.17.12])
 by alsa0.perex.cz (Postfix) with ESMTP id C80C02673DD
 for <alsa-devel@alsa-project.org>; Wed,  9 Aug 2017 10:00:45 +0200 (CEST)
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
To: alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>, Kees Cook <keescook@chromium.org>, Takashi Iwai <tiwai@suse.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 9 Aug 2017 09:50:05 +0200

A few update suggestions were taken into account
from static source code analysis.

Markus Elfring (4):
  Adjust one function call together with a variable assignment
  Improve a size determination in two functions
  Adjust four checks for null pointers
  Delete two error messages for a failed memory allocation in snd_emux_create_port()

 sound/synth/emux/emux_seq.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

-- 
2.13.4
