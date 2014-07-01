From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 0/4] ASoC: Aux dev initialization cleanup
Date: Tue,  1 Jul 2014 22:13:44 +0200
Message-ID: <1404245628-30877-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-155.synserver.de (smtp-out-155.synserver.de
 [212.40.185.155])
 by alsa0.perex.cz (Postfix) with ESMTP id ADDDE265099
 for <alsa-devel@alsa-project.org>; Tue,  1 Jul 2014 22:13:54 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Sebastian Reichel <sre@kernel.org>, Benoit Cousson <bcousson@baylibre.com>
List-Id: alsa-devel@alsa-project.org

This patch cleans up the way a aux dev is initialized and bound to the rtd. This
is useful for both componentization (moving aux devs to the component level) as
well as for the multi-CODEC support patches.

The series depends on topic/component.

- Lars

Lars-Peter Clausen (4):
  ASoC: Remove duplicated rtd->codec initialization
  ASoC: Replace soc_find_matching_codec() with soc_find_codec()
  ASoC: Bind aux devs early
  ASoC: Move non-shared code paths out of snd_soc_post_component_init()

 sound/soc/soc-core.c | 192 +++++++++++++++++----------------------------------
 1 file changed, 62 insertions(+), 130 deletions(-)

-- 
1.8.0
