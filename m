From: Hans de Goede <hdegoede@redhat.com>
Subject: [RFC 0/7] ASoC: rt5651: Drop pdata,
	move over to device-properties
Date: Thu, 22 Feb 2018 18:07:31 +0100
Message-ID: <20180222170738.8508-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 by alsa0.perex.cz (Postfix) with ESMTP id EDDB62677A3
 for <alsa-devel@alsa-project.org>; Thu, 22 Feb 2018 18:07:42 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>
Cc: Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org, Carlo Caione <carlo@endlessm.com>, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

Hi Mark, et al.,

Here is a second attempt to stop having duplicated DMI quirk entries
between the rt5651 codec and machine drivers.

Note this is only compile tested, I'm looking for some quick feedback if
this seems to be going in the right direction, as I'm planning on
rebuilding the rest of my jack-detect cleanup / fix series on top of
this.

The diffstat for this entire set is:

 Documentation/devicetree/bindings/sound/rt5651.txt |    6 
 include/sound/rt5651.h                             |   12 
 sound/soc/codecs/rt5651.c                          |  375 +++++++++------------
 sound/soc/codecs/rt5651.h                          |    7 
 sound/soc/intel/boards/bytcr_rt5651.c              |   46 ++
 5 files changed, 213 insertions(+), 233 deletions(-)

So besides making the code cleaner (IMHO) it also makes it somewhat smaller
and as an added bonus it fixes support the DMIC_EN quirk which was broken.

Regards,

Hans
