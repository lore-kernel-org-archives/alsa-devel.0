From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v2 0/2] ALSA - hda: Add support for link audio
	time reporting
Date: Tue, 19 Jul 2016 16:16:40 +0530
Message-ID: <1468925202-29445-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 53EDF265FE4
 for <alsa-devel@alsa-project.org>; Tue, 19 Jul 2016 12:39:36 +0200 (CEST)
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

Guneshwor Singh (2):
  ALSA - hda: Add support for parsing new HDA capabilities
  ALSA - hda: Add support for link audio time reporting

 include/sound/hda_register.h   |  23 ++++
 sound/pci/hda/hda_controller.c | 244 ++++++++++++++++++++++++++++++++++++++++-
 sound/pci/hda/hda_controller.h |  27 +++++
 sound/pci/hda/hda_intel.c      |  12 ++
 4 files changed, 305 insertions(+), 1 deletion(-)

-- 
1.9.1
