From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 0/4] ASoC: rt5645: GPD Win jack support
Date: Wed, 28 Jun 2017 14:49:35 +0200
Message-ID: <20170628124939.11696-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 2DA22266BA6
 for <alsa-devel@alsa-project.org>; Wed, 28 Jun 2017 14:49:41 +0200 (CEST)
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
Cc: Oder Chiou <oder_chiou@realtek.com>, Bard Liao <bardliao@realtek.com>, alsa-devel@alsa-project.org, Hans de Goede <hdegoede@redhat.com>
List-Id: alsa-devel@alsa-project.org

Hi,

this is a patchset containing the fixes for the inverted jack
detection on RT5645 codec and a quirk for GPD Win device.
Possibly the newer one, GPD Pocket, would work with the same quirk.
First three are from Bard, and the last one is the suggested by Hans.

You may notice the ugliness there, but unfortunately this is the only
way to identify the machine.  Blame BIOS programmer.


thanks,

Takashi

===

Bard Liao (3):
  ASoC: rt5645: read jd1_1 status for jd detection
  ASoC: rt5645: rename jd_invert flag in platform data
  ASoC: rt5645: add inv_jd1_1 flag

Takashi Iwai (1):
  ASoC: rt5645: Add jack detection workaround for GPD Win

 include/sound/rt5645.h    |  6 ++--
 sound/soc/codecs/rt5645.c | 72 +++++++++++++++++++++++++++++------------------
 2 files changed, 49 insertions(+), 29 deletions(-)

-- 
2.13.2
