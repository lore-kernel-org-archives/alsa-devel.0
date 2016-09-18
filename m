From: Randy Li <ayaka@soulik.info>
Subject: [PATCH] make samsung interface entries explicitly
Date: Sun, 18 Sep 2016 22:09:10 +0800
Message-ID: <1474207751-9804-1-git-send-email-ayaka@soulik.info>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: sbkim73@samsung.com, s.nawrocki@samsung.com, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, krzk@kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, Randy Li <ayaka@soulik.info>
List-Id: alsa-devel@alsa-project.org

I found those modules should be selected directly, as I
only use the simple sound card.

Randy Li (1):
  ASoC: samsung: make audio interface/controller explicitly

 sound/soc/samsung/Kconfig | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

-- 
2.7.4
