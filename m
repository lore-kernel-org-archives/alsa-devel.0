From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: [PATCH 0/3] ASoC: da7219: Add ACPI initialisation
	support to driver
Date: Thu, 5 May 2016 11:53:03 +0100
Message-ID: <cover.1462285398.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.bemta14.messagelabs.com (mail1.bemta14.messagelabs.com
 [193.109.254.117])
 by alsa0.perex.cz (Postfix) with ESMTP id 8C88E265DC4
 for <alsa-devel@alsa-project.org>; Thu,  5 May 2016 12:53:05 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Support Opensource <support.opensource@diasemi.com>
List-Id: alsa-devel@alsa-project.org

This patch set updates the driver to use generic device property & fwnode
related functions to read in either DT and ACPI data for driver initialisation.

Changes are based on v4.6-rc6 Linux Kernel.

Adam Thomson (3):
  ASoC: da7219: Convert driver to use generic device/fwnode functions
  ASoC: da7219: Add ACPI parsing support
  ASoC: da7219: Add initial ACPI id for device

 sound/soc/codecs/da7219-aad.c | 96 +++++++++++++++++++++++++++++++------------
 sound/soc/codecs/da7219.c     | 35 ++++++++++------
 2 files changed, 91 insertions(+), 40 deletions(-)

--
1.9.3
