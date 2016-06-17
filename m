From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH] ASoC: Intel: Add support for PM ops in
 bxt-da7219_max98357a
Date: Fri, 17 Jun 2016 17:45:48 +0530
Message-ID: <20160617121548.GI16910@localhost>
References: <1466138010-27740-1-git-send-email-vinod.koul@intel.com>
 <5763DC72.1060200@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 298AB265A55
 for <alsa-devel@alsa-project.org>; Fri, 17 Jun 2016 14:09:02 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <5763DC72.1060200@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, alsa-devel@alsa-project.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On Fri, Jun 17, 2016 at 01:18:10PM +0200, Lars-Peter Clausen wrote:
> On 06/17/2016 06:33 AM, Vinod Koul wrote:
> > We need card to be early suspended and late resumed, so use
> > prepare and complete for card suspend and resume.
> 
> Why and why is this something that other cards do not need to do?

When card suspends, the DAPM suspend closes the widgets, which translates to
we sending IPC to DSP for tearing down the pipelines.

So we need the platform to be suspended last and resume first. This way the
snd_soc_suspend will tear down pipelines and snd_soc_resume restore those
back.

Thanks
-- 
~Vinod
