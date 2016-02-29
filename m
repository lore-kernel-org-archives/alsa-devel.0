From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 0/5] ASoC: pxa: Fix enum ctl accesses
Date: Mon, 29 Feb 2016 17:23:48 +0100
Message-ID: <1456763033-2900-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id C66AD265A01
 for <alsa-devel@alsa-project.org>; Mon, 29 Feb 2016 17:23:57 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@kernel.org>, Robert Jarzmik <robert.jarzmik@free.fr>, Haojian Zhuang <haojian.zhuang@gmail.com>, Daniel Mack <daniel@zonque.org>
List-Id: alsa-devel@alsa-project.org

Hi,

here is a patchset to correct the wrong type accesses in pxa drivers
for enum ctls.  I didn't put Cc to stable for them, supposing these
are only for 32bit systems.  If not, feel free to put Cc to stable. 


thanks,

Takashi

===

Takashi Iwai (5):
  ASoC: pxa: corgi: Fix enum ctl accesses in a wrong type
  ASoC: pxa: magician: Fix enum ctl accesses in a wrong type
  ASoC: pxa: poodle: Fix enum ctl accesses in a wrong type
  ASoC: pxa: spitz: Fix enum ctl accesses in a wrong type
  ASoC: pxa: tosa: Fix enum ctl accesses in a wrong type

 sound/soc/pxa/corgi.c    | 12 ++++++------
 sound/soc/pxa/magician.c |  6 +++---
 sound/soc/pxa/poodle.c   | 12 ++++++------
 sound/soc/pxa/spitz.c    | 12 ++++++------
 sound/soc/pxa/tosa.c     | 12 ++++++------
 5 files changed, 27 insertions(+), 27 deletions(-)

-- 
2.7.2
