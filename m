From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 00/31] Kill BUG*() volume 2: ASoC
Date: Tue,  5 Nov 2013 18:39:47 +0100
Message-ID: <1383673218-18405-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id BD6B12619F9
 for <alsa-devel@alsa-project.org>; Tue,  5 Nov 2013 18:40:41 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hi,

this is a second series of small patches to replace the usages of
BUG*() macros, at this time, in ASoC.  And the last patch is a
revival of the previous coverity fix.

The patches have been split to small pieces, but feel free to
combine them appropriately.

 [PATCH 01/31] ASoC: blackfin: Use WARN_ON() instead of BUG_ON()
 [PATCH 02/31] ASoC: max98088: Use WARN_ON() instead of BUG_ON()
 [PATCH 03/31] ASoC: max98095: Use WARN_ON() instead of BUG_ON()
 [PATCH 04/31] ASoC: tpa6130a2: Use WARN_ON() instead of BUG_ON()
 [PATCH 05/31] ASoC: wm0010: Use WARN_ON() instead of BUG_ON()
 [PATCH 06/31] ASoC: wm2000: Use WARN_ON() instead of BUG_ON()
 [PATCH 07/31] ASoC: wm8580: Use WARN() instead of BUG_ON()
 [PATCH 08/31] ASoC: wm5100: Use WARN_ON() instead of BUG_ON()
 [PATCH 09/31] ASoC: wm8776: Use WARN_ON() instead of BUG_ON()
 [PATCH 10/31] ASoC: wm8900: Use WARN_ON() instead of BUG_ON()
 [PATCH 11/31] ASoC: wm8904: Use WARN_ON() instead of BUG_ON()
 [PATCH 12/31] ASoC: wm9713: Use WARN_ON() instead of BUG_ON()
 [PATCH 13/31] ASoC: wm_adsp: Fix BUG_ON() and WARN_ON() usages
 [PATCH 14/31] ASoC: mid-x86: Use WARN_ON() instead of BUG_ON()
 [PATCH 15/31] ASoC: omap: Use WARN_ON() instead of BUG_ON()
 [PATCH 16/31] ASoC: pxa: Use WARN_ON() instead of BUG_ON()
 [PATCH 17/31] ASoC: s6000: Use WARN_ON() instead of BUG_ON()
 [PATCH 18/31] ASoC: rcar: Use WARN_ON() instead of BUG_ON()
 [PATCH 19/31] ASoC: sh: Use WARN_ON() instead of BUG_ON()
 [PATCH 20/31] ASoC: txx9: Use WARN_ON() instead of BUG_ON()
 [PATCH 21/31] ASoC: dapm: Use WARN_ON() instead of BUG_ON()
 [PATCH 22/31] ASoC: wm5100: Replace BUG() with snd_BUG()
 [PATCH 23/31] ASoC: wm8350: Replace BUG() with snd_BUG()
 [PATCH 24/31] ASoC: wm8900: Replace BUG() with snd_BUG()
 [PATCH 25/31] ASoC: wm8904: Replace BUG() with snd_BUG()
 [PATCH 26/31] ASoC: wm8958: Replace BUG() with snd_BUG()
 [PATCH 27/31] ASoC: wm8962: Replace BUG() with snd_BUG()
 [PATCH 28/31] ASoC: wm8996: Replace BUG() with snd_BUG()
 [PATCH 29/31] ASoC: wm_hubs: Replace BUG() with snd_BUG()
 [PATCH 30/31] ASoC: Replace BUG() with snd_BUG()
 [PATCH 31/31] ASoC: max98095: Add missing negative channel checks


thanks,

Takashi
