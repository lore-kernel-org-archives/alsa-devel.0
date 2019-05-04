From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 0/8] soundwire: corrections to ACPI and DisCo properties
Date: Fri,  3 May 2019 19:29:18 -0500
Message-ID: <20190504002926.28815-1-pierre-louis.bossart@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org, gregkh@linuxfoundation.org, liam.r.girdwood@linux.intel.com, jank@cadence.com, joe@perches.com, srinivas.kandagatla@linaro.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Now that we are done with cleanups, we can start fixing the code with
actual semantic or functional changes.

This patchset applies on top of everything Vinod and I contributed
this week.

The fist patch correct a simplifying assumption made earlier. With the
IceLake BIOS the existing code is fooled by the presence of a second
child device and the namespace walk needs to be filtered. This was not
needed on previous generations.

The second patch fixes a long-standing misalignment between code and
DisCo specification, preventing MIPI DisCo properties from being
parsed successfully.

The third and fourth patch remove restrictions preventing codec
drivers from reading DisCo properties.

The fifth patch adds definitions from the SoundWire spec that were
missed somehow, but will be very much needed for dynamic bandwidth
allocation.

The last 3 patches realign the code with the MIPI specification. The
existing code exposes properties that don't exist, or exposes them
with ambiguous wording. Sticking to the specification helps avoid
interpretation issues for integrators, and will make sure the
follow-up sysfs support is self-explanatory.

Parts of this code was initially written by my Intel colleagues Vinod
Koul, Sanyog Kale, Shreyas Nc and Hardik Shah, who are either no
longer with Intel or no longer involved in SoundWire development. When
relevant, I explictly added a note in commit messages to give them
credit for their hard work, but I removed their signed-off-by tags to
avoid email bounces and avoid spamming them forever with SoundWire
patches.

Pierre-Louis Bossart (8):
  soundwire: intel: filter SoundWire controller device search
  soundwire: mipi_disco: fix master/link error
  soundwire: mipi_disco: expose sdw_slave_read_dpn as symbol
  soundwire: mipi_disco: expose sdw_slave_read_dp0 as symbol
  soundwire: add port-related definitions
  soundwire: remove master data port properties
  soundwire: fix master properties
  soundwire: rename/clarify MIPI DisCo properties

 drivers/soundwire/bus.c        |  6 +--
 drivers/soundwire/intel.c      | 11 ++--
 drivers/soundwire/intel_init.c | 19 ++++++-
 drivers/soundwire/mipi_disco.c | 49 +++++++++---------
 drivers/soundwire/stream.c     |  8 +--
 include/linux/soundwire/sdw.h  | 94 +++++++++++++++++++++++++++-------
 6 files changed, 132 insertions(+), 55 deletions(-)

-- 
2.17.1
