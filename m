From: Axel Lin <axel.lin@ingics.com>
Subject: ASoC: ssm2518: bug in ssm2518_set_tdm_slot
Date: Mon, 10 Jun 2013 21:39:41 +0800
Message-ID: <1370871581.22493.0.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pb0-f48.google.com (mail-pb0-f48.google.com
 [209.85.160.48])
 by alsa0.perex.cz (Postfix) with ESMTP id 1F7912615EE
 for <alsa-devel@alsa-project.org>; Mon, 10 Jun 2013 15:39:48 +0200 (CEST)
Received: by mail-pb0-f48.google.com with SMTP id ma3so1813733pbc.21
 for <alsa-devel@alsa-project.org>; Mon, 10 Jun 2013 06:39:46 -0700 (PDT)
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

ASoC: ssm2518: bug in ssm2518_set_tdm_slot

The code in ssm2518_set_tdm_slot looks wrong:

        if (tx_mask == 0 || tx_mask != 0)
                return -EINVAL;

So ssm2518_set_tdm_slot() always returns error.
