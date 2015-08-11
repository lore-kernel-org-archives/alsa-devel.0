From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: [PATCH v3 0/3] topology: Add external API for building
	topology data
Date: Tue, 11 Aug 2015 18:23:14 +0100
Message-ID: <1439313797-6169-1-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 5EDDE260557
 for <alsa-devel@alsa-project.org>; Tue, 11 Aug 2015 19:27:12 +0200 (CEST)
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

Changes since V2:-

 o Fixed elem memory leaks on error handling paths
 o Fixed indentation.
 o Moved container_of and ARRAY_SIZE to local.h
 o remove use of unlink() and fixed file permissions.

Changes since V1:-

 o Split out refactoring of OBJECT_TYPE to SND_TPLG_TYPE_
 o Removed inclusing of type_compat.h from asoc.h

Liam Girdwood (1):
  core: add convenience macros to local.h

Mengdong Lin (2):
  topology: Add C templates structure for building topology from C
    programs
  topology: A API calls to directly build topology data from templates

 include/local.h           |   7 ++
 include/topology.h        | 202 ++++++++++++++++++++++++++++++++
 src/topology/ctl.c        | 292 ++++++++++++++++++++++++++++++++++++++++++++++
 src/topology/dapm.c       | 183 ++++++++++++++++++++++++++---
 src/topology/elem.c       |  17 +++
 src/topology/parser.c     |  59 +++++++++-
 src/topology/tplg_local.h |  26 ++---
 7 files changed, 749 insertions(+), 37 deletions(-)

-- 
2.1.4
