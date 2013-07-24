From: Vinod Koul <vinod.koul@intel.com>
Subject: PCM extra attributes
Date: Wed, 24 Jul 2013 22:39:19 +0530
Message-ID: <20130724170919.GD18642@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
 by alsa0.perex.cz (Postfix) with ESMTP id 1C4B42652E7
 for <alsa-devel@alsa-project.org>; Wed, 24 Jul 2013 19:48:07 +0200 (CEST)
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
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, "Vinnakota,
 Lakshmi N <lakshmi.n.vinnakota@intel.com>"@vkoul-udesk3.iind.intel.com
List-Id: alsa-devel@alsa-project.org

Hey Takashi,

We were looking to find the substream index in the userspace for the device
opened (in case we support multiple substreams and mix them). Since we also
wanted to have some specific alsa controls for each substream the problem of not
knowing substream in usermode make stuff interesting!

I was pointed to an old RFC of yours [1] and it fits my needs. I can get the
substream index using this and program the alsa controls.

Now reading the archive looks like it was note merged. Would be okay to do so
for above case. I can resurrect the patchset if you would like...

Thanks
~Vinod

[1]: http://mailman.alsa-project.org/pipermail/alsa-devel/2009-June/018651.html

-- 
