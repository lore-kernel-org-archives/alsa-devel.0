From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v3 00/10] ASoC: rt5640: Add jack-detect and
	button-press support
Date: Sun, 13 May 2018 09:24:25 +0200
Message-ID: <20180513072435.3358-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 by alsa0.perex.cz (Postfix) with ESMTP id 1409C26765C
 for <alsa-devel@alsa-project.org>; Sun, 13 May 2018 09:24:43 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>
Cc: Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

Hi Mark, et. al.,

Here is v3 of the remaining patches from my rt5640 jack-detect series.

This time this is really based on your sound/for-next branch, so this should
apply cleanly now.

As mentioned with v2 I've also added a quirk for one more device to the:
"ASoC: Intel: bytcr_rt5640: Add quirks for various devices" patch.

Other then that there are no changes.

Regards,

Hans
