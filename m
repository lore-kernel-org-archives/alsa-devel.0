From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 00/19] ASoC: rt5640: Add jack-detect and
	button-press support
Date: Tue,  8 May 2018 17:35:45 +0200
Message-ID: <20180508153604.23711-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 by alsa0.perex.cz (Postfix) with ESMTP id 0EAFE2676A9
 for <alsa-devel@alsa-project.org>; Tue,  8 May 2018 17:36:08 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

Hi All,

This series has been long in the making, but it is finally ready now.
This series adds jack-detect support for rt5640 using devices.

This is modelled after the recent rt5651 codec- and bytcr-rt5651 machine-
driver jack-detect changes (which were actually based on a WIP version of
this series).

As discussed on the list already unfortunately there are no really good
defaults which work everywhere, so patch 18 adds quirks for 10 devices,
I've decided to do this in one go rather then split this into 10 patches.

Patch 19 makes the bytcr-rt5640 set a longname based on the speaker and
input-map quirks, so that userspace can pick a correct UCM profile based
on the longname with working jack-detect based input / output switching.
I've matching patches adding UCM profiles for this to alsa-lib here:
https://github.com/jwrdegoede/alsa-lib/commits/master
I'm waiting with submitting those upstream until patch 19 is accepted
for merging.

Regards,

Hans
