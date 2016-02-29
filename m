From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 0/2] ASoC: omap: Fix enum ctl accesses
Date: Mon, 29 Feb 2016 17:26:20 +0100
Message-ID: <1456763182-2986-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 41840265D3D
 for <alsa-devel@alsa-project.org>; Mon, 29 Feb 2016 17:26:27 +0100 (CET)
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
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

Hi,

here is a patchset to correct the wrong type accesses in omap drivers
for enum ctls.  I didn't put Cc to stable for them, supposing these
are only for 32bit systems.  If not, feel free to put Cc to stable. 


thanks,

Takashi

===

Takashi Iwai (2):
  ASoC: omap: n810: Fix enum ctl accesses in a wrong type
  ASoC: omap: rx51: Fix enum ctl accesses in a wrong type

 sound/soc/omap/n810.c | 18 +++++++++---------
 sound/soc/omap/rx51.c | 18 +++++++++---------
 2 files changed, 18 insertions(+), 18 deletions(-)

-- 
2.7.2
