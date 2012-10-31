From: Vinod Koul <vinod.koul@linux.intel.com>
Subject: limitations on number of alsa controls for a card
Date: Wed, 31 Oct 2012 19:37:31 +0530
Message-ID: <1351692451.7077.40.camel@vkoul-udesk3>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 63C6226165D
 for <alsa-devel@alsa-project.org>; Wed, 31 Oct 2012 15:21:02 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Hi,

Is there any limitation on maximum number of controls we can have.

I had some platform side controls to represent DSP and adding them made
some of codec controls to vanish. And looks like if I register these
platform controls not all codec controls are visible in userpsace.
Is there nay max limit I am hitting?

-- 
~Vinod
