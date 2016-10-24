From: mengdong.lin@linux.intel.com
Subject: [PATCH v3 0/3] topology: Support widgets' stream name
	and file inclusion for text conf file
Date: Mon, 24 Oct 2016 19:37:24 +0800
Message-ID: <cover.1477308877.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 82667266806
 for <alsa-devel@alsa-project.org>; Mon, 24 Oct 2016 13:36:14 +0200 (CEST)
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
Cc: Mengdong Lin <mengdong.lin@linux.intel.com>, tiwai@suse.de, hardik.t.shah@intel.com, guneshwor.o.singh@intel.com, liam.r.girdwood@linux.intel.com, vinod.koul@intel.com, broonie@kernel.org, mengdong.lin@intel.com
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@linux.intel.com>

This series doesn't require or cause any ABI updates. It doesn't need the
kernel patches that trying to udpate ABI from v4 or v5.

Patch 1 fixes a missing topology feature for text conf file to configure
        stream name of a widget.

Patch 2 allows alsaconf to search included files under global
        configuration directories. This will benefit topology and UCM.

Patch 3 adds document about how to include files for topology
        configuration. There is no c code change but actually it depends
        on patch 2.

History:
v2:     No longer use topology-specific code to support searching included
        files, but extend alsaconf to support this and user can just use
        alsaconf syntax <xxx> and <confdir:xxx>.

v3:     Not use <confdir:xxx> but define new syntax <searchdir:xxx> to
        define directories for searching included file.

Mengdong Lin (3):
  topology: Fix missing stream name of widgets in text conf file
  alsaconf: Search included files under user specified configuration
    directories
  topology: Add doc for including other files in the text conf file

 include/topology.h  |  31 ++++++++++
 src/conf.c          | 170 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 src/topology/dapm.c |  10 ++++
 3 files changed, 210 insertions(+), 1 deletion(-)

-- 
2.5.0
