From: Nicolin Chen <b42378@freescale.com>
Subject: [PATCH v2 0/2] Only do snd_soc_dai_digital_mute() in
	hw_free()
Date: Wed, 4 Dec 2013 11:18:35 +0800
Message-ID: <cover.1386126119.git.b42378@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0186.outbound.messaging.microsoft.com [213.199.154.186])
 by alsa0.perex.cz (Postfix) with ESMTP id A39F7265307
 for <alsa-devel@alsa-project.org>; Wed,  4 Dec 2013 04:18:16 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: tiwai@suse.de, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This series of patches mainly fixes an issue of snd_soc_dai_digital_mute()
operation after playback/capture is done. The current system has two of
them in a normal PCM instance while one of them has an invalid condition.
Thus we first fix the condition and then drop the redundant one.

Changelog:
v2:
 * Bisected into two patches.
 * Fixed indentation in PATCH-1.

Nicolin Chen (2):
  ASoC: soc-pcm: Use valid condition for snd_soc_dai_digital_mute() in
    hw_free()
  ASoC: soc-pcm: Drop the redundant snd_soc_dai_digital_mute() in
    soc_pcm_close()

 sound/soc/soc-pcm.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

-- 
1.8.4
