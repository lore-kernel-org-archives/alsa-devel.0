From: mengdong.lin@linux.intel.com
Subject: [PATCH 0/2] ASoC: Use DMI name in sound card long name
Date: Wed, 21 Dec 2016 21:02:56 +0800
Message-ID: <cover.1482324245.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 5E3E826058A
 for <alsa-devel@alsa-project.org>; Wed, 21 Dec 2016 14:00:19 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, broonie@kernel.org
Cc: Mengdong Lin <mengdong.lin@linux.intel.com>, tiwai@suse.de, mengdong.lin@intel.com, liam.r.girdwood@linux.intel.com, vinod.koul@intel.com, pierre-louis.bossart@intel.com
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@linux.intel.com>

This series is based on Liam's idea to use DMI name as the sound card
short name in the audio workshop. Now we add DMI info to the card long
name:
- Not change the card name (short name), keep it simple. So the card ID
  won't change as well.
- Use short name and DMI name together to make a readable and unqique
  long name.

Machine drivers can use a new API to get this feature.

In user space, when the sound server ask UCM to open a sound card, UCM
will try to find the best configuration file based on the card long name,
and only if not avaiable, fallback to the default configuration file that
matches the card name (short name). Please see patch:
ucm: Automatically load the best config file based on the card long name

History:
  v1 from RFC: Give up using a table to map DMI info to a simple string,
        since we cannot maintain such a table for each machine. Just do
        verbatim copy of DMI info and let user space decide how to use the
        DMI info in card long name to find the best UCM config file.

        If device driver adds a flavor string, just append it after the
        DMI info fields to the card long name.

Liam Girdwood (1):
  ASoC: core: Add API to use DMI name in sound card long name

Mengdong Lin (1):
  ASoC: Intel: Use DMI name for sound card long name in Broadwell
    machine driver

 include/sound/soc.h                |  4 ++
 sound/soc/intel/boards/broadwell.c |  2 +
 sound/soc/soc-core.c               | 81 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 87 insertions(+)

-- 
2.5.0
