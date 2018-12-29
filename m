From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 0/7] Asoc: Various Intel rt5651 patches
Date: Sun, 30 Dec 2018 00:00:18 +0100
Message-ID: <20181229230025.21949-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by alsa0.perex.cz (Postfix) with ESMTP id 3007B267A65
 for <alsa-devel@alsa-project.org>; Sun, 30 Dec 2018 00:00:30 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>, flove@realtek.com, shumingf@realtek.com, Oder Chiou <oder_chiou@realtek.com>
Cc: Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi All,

Here is a v2 of my previous set with various Intel rt5651 patches.

This version contains a small fix to:
[PATCH v2 6/7] ASoC: Intel: bytcr_rt5651: Add support for jack-detect

I forgot to pass the gpio to snd_soc_component_set_jack from the resume
handler too (instead of only from the init function).

Other then that there are no changes, so I've kept Pierre-Louis'
Acked-by for the entire series.

Regards,

Hans
