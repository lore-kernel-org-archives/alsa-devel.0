From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH v3 00/10] Convert wm8xxx codec drivers to use
 snd_soc_write/snd_soc_cache_sync
Date: Fri, 07 Oct 2011 21:35:08 +0800
Message-ID: <1317994508.9906.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f51.google.com (mail-yw0-f51.google.com
	[209.85.213.51]) by alsa0.perex.cz (Postfix) with ESMTP id 887EE246B5
	for <alsa-devel@alsa-project.org>;
	Fri,  7 Oct 2011 15:35:20 +0200 (CEST)
Received: by ywn1 with SMTP id 1so4224619ywn.38
	for <alsa-devel@alsa-project.org>; Fri, 07 Oct 2011 06:35:19 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: linux-kernel@vger.kernel.org
Cc: Papastamos <dp@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Jonathan Cameron <jic23@cam.ac.uk>, Dimitris@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This serial converts the wm8xxx codec drivers to use snd_soc_cache_sync.
I don't have these hardware, but I assume Mark has all these hardware.
These patches are UNTESTED. I'd appreciate if someone can test it.
(Current code is broken anyway, thus we need convert to use new API. )
  
v3: use snd_soc_cache_sync to replace customized xxxx_sync_cache() calls.
    Drop wm8990 patch in v2, which is already merged.
    I also change the subject line back to be the same as v1.
    ( we are using snd_soc_cache_sync now, not snd_soc_write )

v2: For 7, 9 CODECs that are write only, convert to using cache_bypass + snd_soc_write
    v2 also includes wm8990 that I had sent separately.

Axel Lin (10):
  ASoC: wm8510: Convert to snd_soc_cache_sync
  ASoC: wm8711: Convert to snd_soc_cache_sync
  ASoC: wm8731: Convert to snd_soc_cache_sync
  ASoC: wm8750: Convert to snd_soc_cache_sync
  ASoC: wm8776: Convert to snd_soc_cache_sync
  ASoC: wm8940: Convert to snd_soc_cache_sync
  ASoC: wm8960: Convert to snd_soc_cache_sync
  ASoC: wm8971: Convert to snd_soc_cache_sync
  ASoC: wm8974: Convert to snd_soc_cache_sync
  ASoC: wm8988: Convert to snd_soc_cache_sync

 sound/soc/codecs/wm8510.c |   13 +----------
 sound/soc/codecs/wm8711.c |   15 ++-----------
 sound/soc/codecs/wm8731.c |   15 +------------
 sound/soc/codecs/wm8750.c |   16 +-------------
 sound/soc/codecs/wm8776.c |   16 +-------------
 sound/soc/codecs/wm8940.c |   46 +++++++++++++++++++++-----------------------
 sound/soc/codecs/wm8960.c |   14 +++---------
 sound/soc/codecs/wm8971.c |   15 ++-----------
 sound/soc/codecs/wm8974.c |   13 +----------
 sound/soc/codecs/wm8988.c |   17 +--------------
 10 files changed, 44 insertions(+), 136 deletions(-)

-- 
1.7.4.1
