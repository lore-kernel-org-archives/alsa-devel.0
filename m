From: Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 00/14] soundwire: more code cleanups
Date: Thu,  2 May 2019 16:29:16 +0530
Message-ID: <20190502105930.9889-1-vkoul@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5F8D7F80722
 for <alsa-devel@alsa-project.org>; Thu,  2 May 2019 13:00:13 +0200 (CEST)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
Cc: Greg KH <gregkh@linuxfoundation.org>, Sanyog Kale <sanyog.r.kale@intel.com>, Vinod Koul <vkoul@kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Shreyas NC <shreyas.nc@intel.com>
List-Id: alsa-devel@alsa-project.org

After applying cleanup from Pierre, I realized few more things can be
cleaned up as well, so fixing these instance in the subsystem.

Looks like bool is no longer encouraged, but I have skipped those and few
alignment as they caused code to look worse.

Greg,
if you are okay I would like to add this as well (i know it is late, but
they are cosmetic changes and no logic ones, let me know and I can
send a updated PR)

Vinod Koul (14):
  soundwire: fix kconfig help format
  soundwire: fix SPDX license for header files
  soundwire: intel: fix SPDX license for header file
  soundwire: remove empty line before/after braces
  soundwire: cadence: remove empty line after braces
  soundwire: intel: remove empty line after braces
  soundwire: add argument to function definition
  soundwire: more alignment fixes
  soundwire: intel: more alignment fixes
  soundwire: avoid multiple assignments
  soundwire: fix more typos
  soundwire: wrap macro argument in parenthesis
  soundwire: add a blank line between functions
  soundwire: remove multiple blank lines

 drivers/soundwire/Kconfig               |  2 +-
 drivers/soundwire/bus.c                 | 17 +++++-------
 drivers/soundwire/cadence_master.c      |  1 -
 drivers/soundwire/intel.c               | 36 ++++++++++++-------------
 drivers/soundwire/intel_init.c          |  1 -
 drivers/soundwire/mipi_disco.c          |  6 -----
 drivers/soundwire/stream.c              | 28 +++++++++----------
 include/linux/soundwire/sdw.h           | 16 +++++------
 include/linux/soundwire/sdw_intel.h     |  6 ++---
 include/linux/soundwire/sdw_registers.h |  5 ++--
 include/linux/soundwire/sdw_type.h      |  6 ++---
 11 files changed, 54 insertions(+), 70 deletions(-)

-- 
2.20.1
