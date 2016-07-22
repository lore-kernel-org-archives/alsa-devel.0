From: mengdong.lin@linux.intel.com
Subject: [PATCH v2 0/2] topology: Fix for handling widgets'
	references
Date: Fri, 22 Jul 2016 09:46:24 +0800
Message-ID: <cover.1469151453.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 740D6265864
 for <alsa-devel@alsa-project.org>; Fri, 22 Jul 2016 03:41:29 +0200 (CEST)
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
Cc: tiwai@suse.de, mengdong.lin@intel.com, Mengdong Lin <mengdong.lin@linux.intel.com>, liam.r.girdwood@intel.com, shreyas.nc@intel.com
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@linux.intel.com>

This series fixes an error when merging a widget's private data and an 
inaccurate output message.

History:
v2: Split v1 into 2 patches. And set the valid reference element value
    only on success.

Mengdong Lin (2):
  topology: Fix inaccurate message on failure to find a widgets's
    reference
  topology: Fix the missing referenced elem ptr when merging private
    data

 src/topology/dapm.c | 2 +-
 src/topology/data.c | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

-- 
2.5.0
