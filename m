From: mengdong.lin@linux.intel.com
Subject: [PATCH 0/9] topology: Align ABI with kernel to version
	4
Date: Thu,  5 Nov 2015 20:45:20 +0800
Message-ID: <cover.1446726689.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id B2676265B58
 for <alsa-devel@alsa-project.org>; Thu,  5 Nov 2015 13:29:54 +0100 (CET)
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
Cc: Mengdong Lin <mengdong.lin@linux.intel.com>, tiwai@suse.de, mengdong.lin@intel.com, vinod.koul@intel.com, broonie@kernel.org, liam.r.girdwood@intel.com, subhransu.s.prusty@intel.com
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@linux.intel.com>

After this series is applied, the kernel and user space ABIs will be
aligned to version 4.

It also adds C API support for PCM and BE/CC links.

Mengdong Lin (4):
  topology: ABI - Remove tdm_slot & dai_fmt from snd_soc_tplg_stream
  topology: ABI - Change stream formats to a bitwise flag
  topology: ABI - Rename dai_elems to pcm_elems in manifest
  topology: Add C API support for PCM

Vedang Patel (5):
  topology: ABI - Add name element to snd_soc_tplg_stream
  topology: ABI - Separate PCM & BE/CC link support and bump ABI version
    to 4
  topology: ABI - Remove unused struct snd_soc_tplg_stream_config
  topology: ABI - Use __le32 instead of __u32 in
    snd_soc_tplg_dapm_widget
  topology: Add C API support for BE and CC Links.

 include/sound/asoc.h      |  78 +++++----
 include/topology.h        |  59 +++++++
 src/topology/builder.c    |   4 +-
 src/topology/elem.c       |   8 +-
 src/topology/parser.c     |  19 +-
 src/topology/pcm.c        | 429 +++++++++++++++++++++-------------------------
 src/topology/tplg_local.h |  14 +-
 7 files changed, 311 insertions(+), 300 deletions(-)

-- 
1.9.1
