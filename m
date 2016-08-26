From: keqiao.zhang@intel.com
Subject: [PATCH 0/2]  alsabat: add power management S3 test
Date: Fri, 26 Aug 2016 23:37:53 +0800
Message-ID: <1472225875-18081-1-git-send-email-keqiao.zhang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id ABE4326608F
 for <alsa-devel@alsa-project.org>; Fri, 26 Aug 2016 09:59:09 +0200 (CEST)
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
Cc: keqiao.zhang@intel.com
List-Id: alsa-devel@alsa-project.org

From: "Keqiao, Zhang" <keqiao.zhang@intel.com>

The patch set provide a method for QA to quick test audio during system S3

The first patch fix -86 error when system suspend/resume

The second patch provide a test script

Keqiao, Zhang (2):
  alsabat: fix alsabat -86 error
  alsabat: add system power management S3 test

 bat/alsa.c          | 10 ++++++++++
 bat/alsabat-test.sh | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+)

-- 
2.5.0
