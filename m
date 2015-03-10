From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 00/14] Fix wrong ctl value references in ASoC
	codecs
Date: Tue, 10 Mar 2015 12:39:02 +0100
Message-ID: <1425987556-569-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id C4B542604CA
 for <alsa-devel@alsa-project.org>; Tue, 10 Mar 2015 12:39:23 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Brian Austin <brian.austin@cirrus.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>, Liam Girdwood <lgirdwood@gmail.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Hi,

while looking through the ASoC codec codes, I noticed that lots of
drivers refer to the wrong union value type for boolean controls.
They should be value.integer.value[], but the code accesses to
value.enumerated.item[].  They haven't been noticed so far maybe just
because both are same on 32bit architectures.  But they are
incompatible on 64bit architectures, thus must be fixed.


Takashi

===

Takashi Iwai (14):
  ASoC: adav80x: Fix wrong value references for boolean kctl
  ASoC: ak4641: Fix wrong value references for boolean kctl
  ASoC: cs4271: Fix wrong value references for boolean kctl
  ASoC: es8238: Fix wrong value references for boolean kctl
  ASoC: pcm1681: Fix wrong value references for boolean kctl
  ASoC: tas5086: Fix wrong value references for boolean kctl
  ASoC: wm2000: Fix wrong value references for boolean kctl
  ASoC: wm8731: Fix wrong value references for boolean kctl
  ASoC: wm8903: Fix wrong value references for boolean kctl
  ASoC: wm8904: Fix wrong value references for boolean kctl
  ASoC: wm8955: Fix wrong value references for boolean kctl
  ASoC: wm8960: Fix wrong value references for boolean kctl
  ASoC: wm9712: Fix wrong value references for boolean kctl
  ASoC: wm9713: Fix wrong value references for boolean kctl

 sound/soc/codecs/adav80x.c | 4 ++--
 sound/soc/codecs/ak4641.c  | 4 ++--
 sound/soc/codecs/cs4271.c  | 4 ++--
 sound/soc/codecs/es8328.c  | 4 ++--
 sound/soc/codecs/pcm1681.c | 4 ++--
 sound/soc/codecs/tas5086.c | 4 ++--
 sound/soc/codecs/wm2000.c  | 8 ++++----
 sound/soc/codecs/wm8731.c  | 4 ++--
 sound/soc/codecs/wm8903.c  | 4 ++--
 sound/soc/codecs/wm8904.c  | 4 ++--
 sound/soc/codecs/wm8955.c  | 4 ++--
 sound/soc/codecs/wm8960.c  | 4 ++--
 sound/soc/codecs/wm9712.c  | 6 +++---
 sound/soc/codecs/wm9713.c  | 6 +++---
 14 files changed, 32 insertions(+), 32 deletions(-)

-- 
2.3.2
