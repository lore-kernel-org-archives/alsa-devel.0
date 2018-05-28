From: Daniel Mack <daniel@zonque.org>
Subject: [PATCH 0/3] ASoC: make simple-card a bit more versatile
Date: Mon, 28 May 2018 21:35:00 +0200
Message-ID: <20180528193503.18905-1-daniel@zonque.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.bugwerft.de (mail.bugwerft.de [46.23.86.59])
 by alsa0.perex.cz (Postfix) with ESMTP id C939C267252
 for <alsa-devel@alsa-project.org>; Mon, 28 May 2018 21:35:11 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lgirdwood@gmail.com, broonie@kernel.org, kuninori.morimoto.gx@renesas.com
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Daniel Mack <daniel@zonque.org>
List-Id: alsa-devel@alsa-project.org

In the process of porting some boards to DT, I noticed the simple-card
driver is already capable of handling most cases just fine. The missing
bits I've spotted are:

 * The clock that is passed in is only read, never set, which is not
   sufficient for boards that support several sampling rates with
   different base frequencies

 * The sysclk id that is passed to snd_soc_dai_set_sysclk() is
   hard-coded

 * There's currently no support for calling into snd_soc_dai_set_clkdiv()

The following three patches fix all those and make simple-card a good
match for the board I'm working with.


Thanks,
Daniel

Daniel Mack (3):
  ASoC: simple-card: set cpu dai clk in hw_params
  ASoC: simple-card: make sysclk index configurable
  ASoC: simple-card: add support for clock divider setup

 .../devicetree/bindings/sound/simple-card.txt      | 13 ++++++
 include/sound/simple_card_utils.h                  | 19 ++++++++
 sound/soc/generic/simple-card-utils.c              | 50 ++++++++++++++++++++++
 sound/soc/generic/simple-card.c                    | 49 +++++++++++++++++++--
 4 files changed, 127 insertions(+), 4 deletions(-)

-- 
2.14.3
