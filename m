From: Nicolas Boichat <drinkcat@chromium.org>
Subject: [PATCH v2 0/3] ASoC: rt5645: Remove codec dependency
	in workqueue handler
Date: Tue, 14 Jul 2015 14:51:24 +0800
Message-ID: <1436856687-31550-1-git-send-email-drinkcat@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f182.google.com (mail-pd0-f182.google.com
 [209.85.192.182])
 by alsa0.perex.cz (Postfix) with ESMTP id 149052606DD
 for <alsa-devel@alsa-project.org>; Tue, 14 Jul 2015 08:51:57 +0200 (CEST)
Received: by pdrg1 with SMTP id g1so643271pdr.2
 for <alsa-devel@alsa-project.org>; Mon, 13 Jul 2015 23:51:55 -0700 (PDT)
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
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, koro.chen@mediatek.com, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org

Same issue as https://patchwork.kernel.org/patch/6694351/, but reworked fix.

The first 2 patches are preparatory work for the 3rd one, which fixes occasional
kernel panics on boot.

Nicolas Boichat (3):
  ASoC: rt5645: Simplify rt5645_enable_push_button_irq
  ASoC: rt5645: Remove irq_jack_detection function
  ASoC: rt5645: Remove codec dependency in workqueue handler

 sound/soc/codecs/rt5645.c | 185 +++++++++++++++++++++++-----------------------
 sound/soc/codecs/rt5645.h |   1 +
 2 files changed, 95 insertions(+), 91 deletions(-)

-- 
2.4.3.573.g4eafbef
