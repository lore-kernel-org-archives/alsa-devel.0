From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 00/32] ASoC: rt5651: jack-detect fixes and
	improvements
Date: Sun, 25 Feb 2018 11:46:41 +0100
Message-ID: <20180225104713.4745-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 by alsa0.perex.cz (Postfix) with ESMTP id 612EB267253
 for <alsa-devel@alsa-project.org>; Sun, 25 Feb 2018 11:47:18 +0100 (CET)
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

Here is v2 of my rt5651 codec and Intel machine-driver series which mainly
consists of various jack-detect related fixes and improvements.

As discussed in the review of v1 I've made the following changes:

1) Get rid of platform_data and use device-properties instead

2) Split up a couple of the micbias / OVCD / jack-detect patches into
smaller patches, as they were doing too much in a single patch

3) Improved commit messages

4) Concentrate the knowledge that SSP0 is 16 bits on BYTCR in the fixup
function and extract the sample-format from the hw_params in other places

Regards,

Hans
