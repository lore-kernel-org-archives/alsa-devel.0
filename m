From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 0/3] ALSA - hda: Add support for link audio
	time reporting
Date: Mon, 11 Jul 2016 15:43:26 +0530
Message-ID: <1468232009-14130-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 0E8322654B4
 for <alsa-devel@alsa-project.org>; Mon, 11 Jul 2016 12:06:27 +0200 (CEST)
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
Cc: liam.r.girdwood@linux.intel.com, tiwai@suse.de, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>, patches.audio@intel.com
List-Id: alsa-devel@alsa-project.org

Skylake onwards we support GTS capability and thus can report audio link
time. This series adds support for parsing the capability and then reports
link time.

While at it, fix the timestamping Documentation.

Guneshwor Singh (2):
  ALSA - hda: Add support for GTS capability
  ALSA - hda: Add support for link audio time reporting

Vinod Koul (1):
  ALSA - hda: Fix timestamping documentation

 Documentation/sound/alsa/timestamping.txt |  12 +-
 include/sound/hda_register.h              |  23 ++++
 sound/pci/hda/hda_controller.c            | 192 +++++++++++++++++++++++++++++-
 sound/pci/hda/hda_controller.h            |  27 +++++
 sound/pci/hda/hda_intel.c                 |   1 +
 5 files changed, 248 insertions(+), 7 deletions(-)

-- 
1.9.1
