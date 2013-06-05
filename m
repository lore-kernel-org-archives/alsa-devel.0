From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: [tinycompress][PATCH 0/2] Add support for non-blocking
	I/O
Date: Wed, 5 Jun 2013 13:28:50 +0100
Message-ID: <20130605122850.GD21556@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D2DEF265363
 for <alsa-devel@alsa-project.org>; Wed,  5 Jun 2013 14:28:52 +0200 (CEST)
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

(Applies on top of the two patches I just uploaded to fix the write logic)

Adds support for non-blocking write and read. The API for this is based
on the non-blocking API used in the standard PCM alsalib.
