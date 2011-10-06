From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 00/10] Convert wm8xxx codec drivers to use
 snd_soc_cache_sync
Date: Thu, 06 Oct 2011 14:10:17 +0800
Message-ID: <1317881417.13399.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
	[209.85.213.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 0E063103823
	for <alsa-devel@alsa-project.org>;
	Thu,  6 Oct 2011 08:10:30 +0200 (CEST)
Received: by yxk8 with SMTP id 8so2670168yxk.38
	for <alsa-devel@alsa-project.org>; Wed, 05 Oct 2011 23:10:30 -0700 (PDT)
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
Cc: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, Ian@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Lartey <ian@opensource.wolfsonmicro.com>, Kenneth Kiraly <kiraly@lab126.com>, Richard Purdie <rpurdie@rpsys.net>, Jonathan Cameron <jic23@cam.ac.uk>, Mike Arthur <linux@wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

This serial converts the wm8xxx codec drivers to use snd_soc_cache_sync.
I don't have these hardware, but I assume Mark has all these hardware.
These patches are UNTESTED. I'd appreciate if someone can test them.
(Current code is broken anyway, thus we need convert to use new API. )

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

 sound/soc/codecs/wm8510.c |   30 ++++++++++++++++++----------
 sound/soc/codecs/wm8711.c |   19 +++++++----------
 sound/soc/codecs/wm8731.c |   29 ++++++++++++++++-----------
 sound/soc/codecs/wm8750.c |   32 +++++++++++++++++-------------
 sound/soc/codecs/wm8776.c |   33 ++++++++++++++++++-------------
 sound/soc/codecs/wm8940.c |   46 +++++++++++++++++++++-----------------------
 sound/soc/codecs/wm8960.c |   37 +++++++++++++++++++++++++----------
 sound/soc/codecs/wm8971.c |   32 +++++++++++++++++++-----------
 sound/soc/codecs/wm8974.c |   29 +++++++++++++++++----------
 sound/soc/codecs/wm8988.c |   32 +++++++++++++++++-------------
 10 files changed, 185 insertions(+), 134 deletions(-)

-- 
1.7.4.1
