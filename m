From: mengdong.lin@linux.intel.com
Subject: [RFC PATCH 0/3] Add support for component devices
Date: Tue, 15 Nov 2016 15:57:43 +0800
Message-ID: <cover.1479195801.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id CF4DB266FF1
 for <alsa-devel@alsa-project.org>; Tue, 15 Nov 2016 08:55:58 +0100 (CET)
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
Cc: Mengdong Lin <mengdong.lin@linux.intel.com>, tiwai@suse.de, mengdong.lin@intel.com, liam.r.girdwood@linux.intel.com, vinod.koul@intel.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@linux.intel.com>

Sound cards are defined by machines. And off-soc codecs and DSPs embedded
in DSP can be taken as the components and resued by different machines/
sound cards. This series allows codec and SOC vendors to install UCM
configuration files for a specific codec or DSP, and sound card verb
files can just include these conf files of components, and trigger enable/
disable sequence defined by the component devices.

Component devices will not be exposed to applications for backward
compatibility. So audio servers like PulseAudio and CRAS still only see
the machine devices.

Mengdong Lin (3):
  ucm: Skip component directories when scanning sound card configuration
    files
  ucm: Parse sequence of component devices
  ucm: Execute sequence of component devices

 src/ucm/main.c      |  98 ++++++++++++++++++++++++++++++++++++-----
 src/ucm/parser.c    | 122 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 src/ucm/ucm_local.h |  11 +++++
 src/ucm/utils.c     |   1 +
 4 files changed, 220 insertions(+), 12 deletions(-)

-- 
2.7.4
