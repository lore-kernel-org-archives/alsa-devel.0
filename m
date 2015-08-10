From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: [PATCH v2 0/3] topology: Add external API for building
	topology data
Date: Mon, 10 Aug 2015 19:13:46 +0100
Message-ID: <1439230429-6173-1-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 693BF26598D
 for <alsa-devel@alsa-project.org>; Mon, 10 Aug 2015 20:13:55 +0200 (CEST)
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
Cc: Takashi Iwai <tiwai@suse.de>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

Currently we can build topology binary data files from topology text files.
However it is sometimes necessary for DSP FW vendors to build topology binary
data within a toolset and create topology binary data directly from within
vendor tools.

This series adds an API to the alsa-lib topology core so that vendor tools
can create topology data directly.

Changes since V1:-

 o Split out refactoring of OBJECT_TYPE to SND_TPLG_TYPE_
 o Removed inclusing of type_compat.h from asoc.h

Liam Girdwood (1):
  topology: rename OBJECT_TYPE_ to SND_TPLG_TYPE_

Mengdong Lin (2):
  topology: Add C templates structure for building topology from C
    programs
  topology: A API calls to directly build topology data from templates

 include/topology.h        | 202 ++++++++++++++++++++++++++++
 src/topology/builder.c    |  38 +++---
 src/topology/ctl.c        | 329 +++++++++++++++++++++++++++++++++++++++++++---
 src/topology/dapm.c       | 223 ++++++++++++++++++++++++++-----
 src/topology/data.c       |  10 +-
 src/topology/elem.c       |  43 ++++--
 src/topology/parser.c     |  63 ++++++++-
 src/topology/pcm.c        |  34 ++---
 src/topology/text.c       |   2 +-
 src/topology/tplg_local.h |  33 ++---
 10 files changed, 847 insertions(+), 130 deletions(-)

-- 
2.1.4
