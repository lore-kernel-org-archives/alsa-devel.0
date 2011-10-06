From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 00/11 v2] Convert wm8xxx codec drivers to use
 snd_soc_write/snd_soc_cache_sync
Date: Fri, 07 Oct 2011 07:43:39 +0800
Message-ID: <1317944619.5579.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f179.google.com (mail-gx0-f179.google.com
	[209.85.161.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 50183103B0D
	for <alsa-devel@alsa-project.org>;
	Fri,  7 Oct 2011 01:43:51 +0200 (CEST)
Received: by ggnf2 with SMTP id f2so2605979ggn.38
	for <alsa-devel@alsa-project.org>; Thu, 06 Oct 2011 16:43:50 -0700 (PDT)
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Jonathan Cameron <jic23@cam.ac.uk>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

This serial converts the wm8xxx codec drivers to use snd_soc_cache_sync.
I don't have these hardware, but I assume Mark has all these hardware.
These patches are UNTESTED. I'd appreciate if someone can test it.
(Current code is broken anyway, thus we need convert to use new API. )

v2: For 7, 9 CODECs that are write only, convert to using cache_bypass + snd_soc_write
    v2 also includes wm8990 that I had sent separately.

*** BLURB HERE ***

Axel Lin (11):
  ASoC: wm8510: Convert to snd_soc_write
  ASoC: wm8711: Convert to snd_soc_write
  ASoC: wm8731: Convert to snd_soc_write
  ASoC: wm8750: Convert to snd_soc_write
  ASoC: wm8776: Convert to snd_soc_write
  ASoC: wm8940: Convert to snd_soc_cache_sync
  ASoC: wm8960: Convert to snd_soc_write
  ASoC: wm8971: Convert to snd_soc_write
  ASoC: wm8974: Convert to snd_soc_write
  ASoC: wm8988: Convert to snd_soc_write
  ASoC: wm8990: Convert to snd_soc_cache_sync

 sound/soc/codecs/wm8510.c |   33 +++++++++++++++++++++----------
 sound/soc/codecs/wm8711.c |   33 +++++++++++++++++++++----------
 sound/soc/codecs/wm8731.c |   35 +++++++++++++++++++++------------
 sound/soc/codecs/wm8750.c |   36 +++++++++++++++++++++-------------
 sound/soc/codecs/wm8776.c |   36 +++++++++++++++++++++-------------
 sound/soc/codecs/wm8940.c |   46 +++++++++++++++++++++-----------------------
 sound/soc/codecs/wm8960.c |   34 +++++++++++++++++++++++---------
 sound/soc/codecs/wm8971.c |   35 ++++++++++++++++++++++-----------
 sound/soc/codecs/wm8974.c |   33 +++++++++++++++++++++----------
 sound/soc/codecs/wm8988.c |   37 +++++++++++++++++++++--------------
 sound/soc/codecs/wm8990.c |   32 ++++++++++++++++++------------
 11 files changed, 242 insertions(+), 148 deletions(-)

-- 
1.7.4.1
