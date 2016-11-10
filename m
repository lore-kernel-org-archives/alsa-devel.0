From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 00/10] ASoC: Modernize documents
Date: Thu, 10 Nov 2016 22:47:12 +0100
Message-ID: <20161110214722.14698-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 13BFC2673D6
 for <alsa-devel@alsa-project.org>; Thu, 10 Nov 2016 22:47:28 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi,

this patchset converts the ASoC text documents to ReST format, which
has been recently introduced to the kernel tree.  The conversions are
really simple since the original texts were already well formatted.

The files are moved to Documentation/sound/soc, and TOC is to the
index page.

All the patches are found in topic/rest-docs branch of sound git
tree.

The new file after 4.9 isn't covered yet, as the branch is based on
4.9-rc4.  I found only soc/codec_to_codec.txt in linux-next, and it
seems easy to convert.  Mark, let me know how you'd like to organize.
I can pull your branch and convert in my side, or you pull mine and do
it on yours.


thanks,

Takashi

===

Takashi Iwai (10):
  ASoC: doc: ReSTize overview.txt
  ASoC: doc: ReSTize codec.txt
  ASoC: doc: ReSTize DAI.txt
  ASoC: doc: ReSTize dapm.txt
  ASoC: doc: ReSTize platform.txt
  ASoC: doc: ReSTize machine.txt
  ASoC: doc: ReSTize pops_clicks.txt
  ASoC: doc: ReSTize clocking.txt
  ASoC: doc: ReSTize jack.txt
  ASoC: doc: ReSTize DPCM.txt

 Documentation/sound/index.rst                      |   1 +
 .../{alsa/soc/clocking.txt => soc/clocking.rst}    |  13 +-
 .../sound/{alsa/soc/codec.txt => soc/codec.rst}    |  75 +++---
 .../sound/{alsa/soc/DAI.txt => soc/dai.rst}        |  28 ++-
 .../sound/{alsa/soc/dapm.txt => soc/dapm.rst}      | 249 ++++++++++--------
 .../sound/{alsa/soc/DPCM.txt => soc/dpcm.rst}      | 280 +++++++++++----------
 Documentation/sound/soc/index.rst                  |  19 ++
 .../sound/{alsa/soc/jack.txt => soc/jack.rst}      |   1 +
 .../{alsa/soc/machine.txt => soc/machine.rst}      |  22 +-
 .../{alsa/soc/overview.txt => soc/overview.rst}    |  32 +--
 .../{alsa/soc/platform.txt => soc/platform.rst}    |  31 +--
 .../soc/pops_clicks.txt => soc/pops-clicks.rst}    |  15 +-
 12 files changed, 417 insertions(+), 349 deletions(-)
 rename Documentation/sound/{alsa/soc/clocking.txt => soc/clocking.rst} (94%)
 rename Documentation/sound/{alsa/soc/codec.txt => soc/codec.rst} (84%)
 rename Documentation/sound/{alsa/soc/DAI.txt => soc/dai.rst} (71%)
 rename Documentation/sound/{alsa/soc/dapm.txt => soc/dapm.rst} (62%)
 rename Documentation/sound/{alsa/soc/DPCM.txt => soc/dpcm.rst} (57%)
 create mode 100644 Documentation/sound/soc/index.rst
 rename Documentation/sound/{alsa/soc/jack.txt => soc/jack.rst} (99%)
 rename Documentation/sound/{alsa/soc/machine.txt => soc/machine.rst} (90%)
 rename Documentation/sound/{alsa/soc/overview.txt => soc/overview.rst} (83%)
 rename Documentation/sound/{alsa/soc/platform.txt => soc/platform.rst} (81%)
 rename Documentation/sound/{alsa/soc/pops_clicks.txt => soc/pops-clicks.rst} (87%)

-- 
2.10.2
