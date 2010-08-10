From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: [PATCH 00/17] ASoC: multi-component - CODECs
Date: Wed, 11 Aug 2010 00:02:51 +0100
Message-ID: <1281481388-3000-1-git-send-email-lrg@slimlogic.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 7881224448
	for <alsa-devel@alsa-project.org>;
	Wed, 11 Aug 2010 01:03:24 +0200 (CEST)
Received: by wwa36 with SMTP id 36so2366031wwa.20
	for <alsa-devel@alsa-project.org>; Tue, 10 Aug 2010 16:03:23 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

This is the second part of the multi-component series and focuses on the 
changes required to support ASoC multi-component on CODEC drivers.

I've split the CODEC driver patches into smaller chunks and tried to group
(where possible) similar CODECs together. All the patches will be rebased
together at upstream time so we don't break bisect.

Most CODEC drivers were extremely straight forward with changes limited to 
their probe() and remove() sections. Some CODECs did require a little extra 
work and this is marked in their commit messages.

Again, it's not a one man effort. I've had help from the folks mentioned in
the cover email for the core. 

Liam Girdwood (17):
  ASoC: multi-component - AKM CODECs
  ASoC: multi-component - cs4720, cs42l51 and da7210 CODECs
  ASoC: multi-component - pcm3008, ssm2602, jz4740 and uda1380
  ASoC: multi-component - TI CODECs
  ASoC: multi-component - open firmware
  ASoC: multi-component - Generic AC97 and SPDIF CODECs
  ASoC: multi-component - cq93vc, cx20442, stac9766 and UDA134x CODECs
  ASoC: multi-component - Wolfson WM85xx CODECs
  ASoC: multi-component - Wolfson WM87xx CODECs
  ASoC: multi-component - Wolfson wm8900, 8903, 8904 and 8955 CODECs
  ASoC: multi-component - Wolfson wm8960, 8961, 8940 and 8941 CODECs
  ASoC: multi-component - Wolfson WM8971, 8993, 8990 and 8974 CODECs
  ASoC: multi-component - Wolfson WM8978, 8988 and 8994 CODECs
  ASoC: multi-component - Wolfson WM90xx CODECs
  ASoC: multi-component - Wolfson AudioPlus CODECs
  ASoC: multi-component - Wolfson WM97xx AC97 CODECs
  ASoC: multi-component - remove no longer needed codec headers

 include/sound/soc-of-simple.h        |    4 +-
 include/sound/tlv320aic3x.h          |   43 ++++-
 sound/soc/codecs/ac97.c              |  124 +++++------
 sound/soc/codecs/ac97.h              |   19 --
 sound/soc/codecs/ads117x.h           |   13 -
 sound/soc/codecs/ak4104.c            |  149 +++++--------
 sound/soc/codecs/ak4104.h            |    7 -
 sound/soc/codecs/ak4535.c            |  236 +++++---------------
 sound/soc/codecs/ak4535.h            |    8 -
 sound/soc/codecs/ak4642.c            |  175 +++------------
 sound/soc/codecs/ak4642.h            |   20 --
 sound/soc/codecs/ak4671.c            |  141 +++---------
 sound/soc/codecs/ak4671.h            |    3 -
 sound/soc/codecs/cq93vc.c            |  132 +++---------
 sound/soc/codecs/cq93vc.h            |   29 ---
 sound/soc/codecs/cs4270.c            |  393 ++++++++++++---------------------
 sound/soc/codecs/cs4270.h            |   28 ---
 sound/soc/codecs/cs42l51.c           |  293 ++++++++-----------------
 sound/soc/codecs/cs42l51.h           |    2 -
 sound/soc/codecs/cx20442.c           |  146 +++----------
 sound/soc/codecs/cx20442.h           |    2 -
 sound/soc/codecs/da7210.c            |  157 +++-----------
 sound/soc/codecs/da7210.h            |   24 --
 sound/soc/codecs/jz4740.c            |  116 +++--------
 sound/soc/codecs/jz4740.h            |   20 --
 sound/soc/codecs/pcm3008.c           |   92 ++++-----
 sound/soc/codecs/pcm3008.h           |    3 -
 sound/soc/codecs/spdif_transciever.c |  102 +--------
 sound/soc/codecs/spdif_transciever.h |   18 --
 sound/soc/codecs/ssm2602.c           |  219 +++++-------------
 sound/soc/codecs/ssm2602.h           |    3 -
 sound/soc/codecs/stac9766.c          |  118 ++++------
 sound/soc/codecs/stac9766.h          |    4 -
 sound/soc/codecs/tlv320aic23.c       |  182 +++++----------
 sound/soc/codecs/tlv320aic23.h       |    3 -
 sound/soc/codecs/tlv320aic26.c       |  180 +++++----------
 sound/soc/codecs/tlv320aic26.h       |    3 -
 sound/soc/codecs/tlv320aic3x.c       |  223 ++++++-------------
 sound/soc/codecs/tlv320aic3x.h       |   43 ----
 sound/soc/codecs/tlv320dac33.c       |  249 +++++++--------------
 sound/soc/codecs/tlv320dac33.h       |    3 -
 sound/soc/codecs/twl4030.c           |  231 ++++++-------------
 sound/soc/codecs/twl4030.h           |   55 -----
 sound/soc/codecs/twl6040.c           |  170 ++++-----------
 sound/soc/codecs/twl6040.h           |    3 -
 sound/soc/codecs/uda134x.c           |  154 +++++--------
 sound/soc/codecs/uda134x.h           |    3 -
 sound/soc/codecs/uda1380.c           |  211 +++++-------------
 sound/soc/codecs/uda1380.h           |    3 -
 sound/soc/codecs/wm2000.h            |    3 -
 sound/soc/codecs/wm8350.c            |  231 +++++++------------
 sound/soc/codecs/wm8350.h            |    3 -
 sound/soc/codecs/wm8400.c            |  181 ++++-----------
 sound/soc/codecs/wm8400.h            |    3 -
 sound/soc/codecs/wm8510.c            |  290 ++++++++----------------
 sound/soc/codecs/wm8510.h            |    3 -
 sound/soc/codecs/wm8523.c            |  180 ++++-----------
 sound/soc/codecs/wm8523.h            |    3 -
 sound/soc/codecs/wm8580.c            |  186 +++++-----------
 sound/soc/codecs/wm8580.h            |    3 -
 sound/soc/codecs/wm8711.c            |  206 +++++------------
 sound/soc/codecs/wm8711.h            |    3 -
 sound/soc/codecs/wm8727.c            |  106 +--------
 sound/soc/codecs/wm8727.h            |   21 --
 sound/soc/codecs/wm8728.c            |  294 ++++++++-----------------
 sound/soc/codecs/wm8728.h            |    9 -
 sound/soc/codecs/wm8731.c            |  217 ++++++-------------
 sound/soc/codecs/wm8731.h            |    3 -
 sound/soc/codecs/wm8741.c            |  204 +++++------------
 sound/soc/codecs/wm8741.h            |    3 -
 sound/soc/codecs/wm8750.c            |  269 +++++++---------------
 sound/soc/codecs/wm8750.h            |    9 -
 sound/soc/codecs/wm8753.c            |  407 ++++++++++++----------------------
 sound/soc/codecs/wm8753.h            |    3 -
 sound/soc/codecs/wm8776.c            |  251 ++++++---------------
 sound/soc/codecs/wm8776.h            |    3 -
 sound/soc/codecs/wm8900.c            |  251 ++++++++++-----------
 sound/soc/codecs/wm8900.h            |    3 -
 sound/soc/codecs/wm8903.c            |  268 ++++++++--------------
 sound/soc/codecs/wm8903.h            |    3 -
 sound/soc/codecs/wm8904.c            |  208 +++++------------
 sound/soc/codecs/wm8904.h            |    3 -
 sound/soc/codecs/wm8940.c            |  199 +++++------------
 sound/soc/codecs/wm8940.h            |    2 -
 sound/soc/codecs/wm8955.c            |  184 ++++------------
 sound/soc/codecs/wm8955.h            |    3 -
 sound/soc/codecs/wm8960.c            |  209 ++++++------------
 sound/soc/codecs/wm8960.h            |    3 -
 sound/soc/codecs/wm8961.c            |  241 +++++++--------------
 sound/soc/codecs/wm8961.h            |    3 -
 sound/soc/codecs/wm8971.c            |  250 ++++++---------------
 sound/soc/codecs/wm8971.h            |    8 -
 sound/soc/codecs/wm8974.c            |  171 ++++----------
 sound/soc/codecs/wm8974.h            |    3 -
 sound/soc/codecs/wm8978.c            |  190 +++++-----------
 sound/soc/codecs/wm8978.h            |    3 -
 sound/soc/codecs/wm8988.c            |  266 ++++++++---------------
 sound/soc/codecs/wm8988.h            |    3 -
 sound/soc/codecs/wm8990.c            |  226 +++++--------------
 sound/soc/codecs/wm8990.h            |    8 -
 sound/soc/codecs/wm8993.c            |  307 ++++++++++---------------
 sound/soc/codecs/wm8993.h            |    3 -
 sound/soc/codecs/wm8994.c            |  230 +++++++-------------
 sound/soc/codecs/wm8994.h            |    3 -
 sound/soc/codecs/wm9081.c            |  208 +++++-------------
 sound/soc/codecs/wm9081.h            |    3 -
 sound/soc/codecs/wm9090.c            |  183 +++++----------
 sound/soc/codecs/wm9090.h            |    2 -
 sound/soc/codecs/wm9705.c            |  116 ++++------
 sound/soc/codecs/wm9705.h            |    3 -
 sound/soc/codecs/wm9712.c            |  124 +++++------
 sound/soc/codecs/wm9712.h            |    3 -
 sound/soc/codecs/wm9713.c            |  131 +++++------
 sound/soc/codecs/wm9713.h            |    3 -
 sound/soc/fsl/soc-of-simple.c        |    6 +-
 115 files changed, 3524 insertions(+), 8162 deletions(-)
 delete mode 100644 sound/soc/codecs/ac97.h
 delete mode 100644 sound/soc/codecs/ads117x.h
 delete mode 100644 sound/soc/codecs/ak4104.h
 delete mode 100644 sound/soc/codecs/ak4642.h
 delete mode 100644 sound/soc/codecs/cq93vc.h
 delete mode 100644 sound/soc/codecs/cs4270.h
 delete mode 100644 sound/soc/codecs/da7210.h
 delete mode 100644 sound/soc/codecs/jz4740.h
 delete mode 100644 sound/soc/codecs/spdif_transciever.h
 delete mode 100644 sound/soc/codecs/twl4030.h
 delete mode 100644 sound/soc/codecs/wm8727.h
