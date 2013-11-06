From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 0/9] Kill BUG() for ASoC
Date: Wed,  6 Nov 2013 11:07:10 +0100
Message-ID: <1383732439-31441-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 0F59A261664
 for <alsa-devel@alsa-project.org>; Wed,  6 Nov 2013 11:07:23 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hi,

this is the revised patches for replacing BUG() with WARN().
Indeed this gives even better information than a simple BUG(),
so drop the previous patches to replace snd_BUG().

 [PATCH 1/9] ASoC: wm5100: Replace BUG() with WARN()
 [PATCH 2/9] ASoC: wm8350: Replace BUG() with WARN()
 [PATCH 3/9] ASoC: wm8900: Replace BUG() with WARN()
 [PATCH 4/9] ASoC: wm8904: Replace BUG() with WARN()
 [PATCH 5/9] ASoC: wm8958: Replace BUG() with WARN()
 [PATCH 6/9] ASoC: wm8962: Replace BUG() with WARN()
 [PATCH 7/9] ASoC: wm8996: Replace BUG() with WARN()
 [PATCH 8/9] ASoC: wm_hubs: Replace BUG() with WARN()
 [PATCH 9/9] ASoC: Replace BUG() with WARN()


thanks,

Takashi
