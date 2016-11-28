From: mengdong.lin@linux.intel.com
Subject: [PATCH v3 0/3] ucm: Add support for component devices
Date: Mon, 28 Nov 2016 13:33:27 +0800
Message-ID: <cover.1480309753.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id E7D682669E3
 for <alsa-devel@alsa-project.org>; Mon, 28 Nov 2016 06:31:30 +0100 (CET)
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
files can include these conf files of components.

Component devices will not be exposed to applications for backward
compatibility. So audio servers like PulseAudio and CRAS still only see
the machine devices.

History:
v2: Use an array to define component directories. Document syntax to
    enable/disable a component device. Hide cdev defined by the parent
    device in ucm manager for executing a component sequence.

v3: No longer use macros for UCM manager to enter/exit component domain,
    to make code simpler.

Mengdong Lin (3):
  ucm: Skip component directories when scanning sound card configuration
    files
  ucm: Parse sequence of component devices
  ucm: Execute sequence of component devices

 src/ucm/main.c      |  78 +++++++++++++++++++++++++-
 src/ucm/parser.c    | 154 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 src/ucm/ucm_local.h |  19 +++++++
 src/ucm/utils.c     |   1 +
 4 files changed, 249 insertions(+), 3 deletions(-)

-- 
2.7.4
