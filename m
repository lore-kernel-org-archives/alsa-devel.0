From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: [tinycompress][PATCH 0/2] Fixes for write loop logic
Date: Wed, 5 Jun 2013 13:08:27 +0100
Message-ID: <20130605120827.GA21556@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 66FBA26546C
 for <alsa-devel@alsa-project.org>; Wed,  5 Jun 2013 14:08:30 +0200 (CEST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: vinod.koul@intel.com
Cc: alsa-devel@alsa-project.org, ckeepax@opensource.wolfsonmicro.com, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org

Two small patches which correct the logic of compress_write()
so that it will work correctly if asked to write a buffer
shorter than the fragment length. The first patch is needed
to ensure that if the client requests auto-configuration
of fragment size the internal copy of the config contains the
configured fragment size. The second patch contains the actual
fix to the write loop logic.

Richard Fitzgerald (2):
  compress: copy final version of config struct
  compress: do not poll if enough space to write remaining data

 compress.c |   13 ++++++-------
 1 files changed, 6 insertions(+), 7 deletions(-)

-- 
1.7.2.5
