From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v3 00/22] ASoC: rt5651: jack-detect fixes and
	improvements
Date: Sun,  4 Mar 2018 15:35:48 +0100
Message-ID: <20180304143610.21125-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 by alsa0.perex.cz (Postfix) with ESMTP id 2E90C267016
 for <alsa-devel@alsa-project.org>; Sun,  4 Mar 2018 15:36:14 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org, Carlo Caione <carlo@endlessm.com>, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

Hi All,

Here is v3 of my rt5651 codec and Intel machine-driver series which mainly
consists of various jack-detect related fixes and improvements.

Changes in v3:
-Drop patches of which the v2 version has been merged (Thanks Mark)
-Split out dt-bindings documentation into a separate patch
-Rework how we deal with the machine-driver adding properties, so that
 there no longer is a need for calling the ugly private rt5651_apply_properties
 function from the machine-driver
-Split the patch for moving the configuration of the jack-detect source
 to device-properties into separate codec and machine-driver patches
-Split the patch making the OVCD threshold-current and scale-factor
 configurable into 2 separate patches

Changes in v2;
-Get rid of platform_data and use device-properties instead
-Split up a couple of the micbias / OVCD / jack-detect patches into
 smaller patches, as they were doing too much in a single patch
-Improved commit messages
-Concentrate the knowledge that SSP0 is 16 bits on BYTCR in the fixup
 function and extract the sample-format from the hw_params in other places

Regards,

Hans
