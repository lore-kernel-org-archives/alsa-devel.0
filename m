From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 0/3] ALSA: Fix of-node refcount unbalance
Date: Tue, 19 Feb 2019 16:31:21 +0100
Message-ID: <20190219153124.12595-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id E25D2265535
 for <alsa-devel@alsa-project.org>; Tue, 19 Feb 2019 16:31:29 +0100 (CET)
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
Cc: Johannes Berg <johannes@sipsolutions.net>, Robert Jarzmik <robert.jarzmik@free.fr>
List-Id: alsa-devel@alsa-project.org

Hi,

here is a few patches to address the unbalanced OF-node refcount
on powerpc and ac97 driver code.  Another patchset for ASoC will
follow later.


Takashi

===

Takashi Iwai (3):
  ALSA: ac97: Fix of-node refcount unbalance
  ALSA: aoa: Fix of-node refcount unbalance
  ALSA: ppc: Fix of-node refcount unbalance

 sound/ac97/bus.c              | 2 +-
 sound/aoa/core/gpio-feature.c | 1 +
 sound/ppc/tumbler.c           | 1 +
 3 files changed, 3 insertions(+), 1 deletion(-)

-- 
2.16.4
