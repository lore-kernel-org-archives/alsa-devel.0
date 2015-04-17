From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v2 2/7] ALSA: hda - add generic functions
 to set hdac stream params
Date: Fri, 17 Apr 2015 17:03:02 +0530
Message-ID: <20150417113302.GA30624@intel.com>
References: <1429262000-21517-1-git-send-email-vinod.koul@intel.com>
 <1429262000-21517-3-git-send-email-vinod.koul@intel.com>
 <s5hvbgvxfdy.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 6641126053E
 for <alsa-devel@alsa-project.org>; Fri, 17 Apr 2015 13:38:08 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hvbgvxfdy.wl-tiwai@suse.de>
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
Cc: Jeeja KP <jeeja.kp@intel.com>, alsa-devel@alsa-project.org, broonie@kernel.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Fri, Apr 17, 2015 at 11:39:37AM +0200, Takashi Iwai wrote:
> At Fri, 17 Apr 2015 14:43:15 +0530,
> Vinod Koul wrote:
> > 
> > From: Jeeja KP <jeeja.kp@intel.com>
> > 
> > This will be used by hda controller driver to
> > setup stream params in prepare. This function will
> > setup the bdl and periods.
> 
> OK, it's fine to add this function if soc-hda driver needs it too.
> But please put the kerneldoc comment to the function, too.  Then I can
> apply this patch even before other patches.
Okay I will send this as isolated chnage with comments now :)

-- 
~Vinod 
