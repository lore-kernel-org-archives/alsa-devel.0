From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [RFC PATCH 0/7] Fix Intel audio Kconfig issues
Date: Fri, 17 Nov 2017 18:01:55 -0600
Message-ID: <20171118000202.22302-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id A368A266B67
 for <alsa-devel@alsa-project.org>; Sat, 18 Nov 2017 01:02:23 +0100 (CET)
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
Cc: arnd@arndb.de, tiwai@suse.de, linux-kernel@vger.kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, liam.r.girdwood@linux.intel.com, vinod.koul@intel.com, broonie@kernel.org, andriy.shevchenko@linux.intel.com, torvalds@linux-foundation.org
List-Id: alsa-devel@alsa-project.org

At the risk of being scolded for the third time in two days by
Linux overlords (no hard feelings), here's an attempt to clean
things up.

The first patch *should* implement what Linus, Takashi and Mark
tried to explain by email. There should be no functionality change
and could be merged if deemed ok.

The rest of the patch series does a more in-depth cleanup and should not
be merged without more testing (hence the RFC).

The 4th patch is really the most important one, there were nested
configs which made no sense to me. I don't know the history which led
to such complicated stuff but simpler is better.

The last 3 patches are just clean-ups of the machine driver configs,
for some reason there is no consistency in the settings so I tried to
apply common sense. There might be additional cleanup needed since I
don't really get why we need references to LPSS or DESIGNWARE for things
which are not visible to a machine driver, we should only depend on IC2 or
SPI in my opinion - depending on what the control interface is.

I tried to keep things to a minimum in each patch to make the reviews
easier, if people want them squashed that's fine by me.

I'll do some more testing on my side but I could use feedback. Thanks!

Pierre-Louis Bossart (7):
  ASoC: Intel: Fix Kconfig
  ASoC: Intel: Kconfig: Simplify-clarify ACPI/PCI dependencies
  ASoC: Intel: document what Kconfig options do
  ASoC: Intel: Fix nested/unnecessary Kconfig dependencies
  ASoC: Intel: boards: align Kconfig dependencies for Haswell/Broadwell
  ASoC: Intel: boards: align Kconfig configurations for HiFi2
  ASoC: Intel: boards: align/fix SKL/BXT/KBL Kconfigs

 sound/soc/intel/Kconfig        |  89 ++++++++++++++++++--------
 sound/soc/intel/boards/Kconfig | 140 ++++++++++++++++++++++-------------------
 2 files changed, 137 insertions(+), 92 deletions(-)

-- 
2.14.1
