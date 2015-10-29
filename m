From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 00/17] ASoC: Intel: Skylake: More fixes and
	updates
Date: Thu, 29 Oct 2015 12:34:37 +0900
Message-ID: <20151029033434.GA31066@vkoul-mobl.iind.intel.com>
References: <1445905380-18167-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id A5D9026531F
 for <alsa-devel@alsa-project.org>; Thu, 29 Oct 2015 04:34:43 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1445905380-18167-1-git-send-email-vinod.koul@intel.com>
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
Cc: liam.r.girdwood@linux.intel.com, tiwai@suse.de, broonie@kernel.org, patches.audio@intel.com
List-Id: alsa-devel@alsa-project.org

On Tue, Oct 27, 2015 at 09:22:43AM +0900, Vinod Koul wrote:
> Hi all,
> 
> This series adds more minor fixes and some enhancements to the driver.
> Most of the fixes patches are single line count changes
> 
> The enhancements are:
> - optimizing code and using module pin info for unbinding
> - supporting virtual dsp widgets like switches in topology
> - add pin formats and supports multiple heterogeneous pins

Hi Mark,

Jeeja found two more fixes for this so I have appended these to the last
patch. First fixes bit format on SSP port and second fixes the missing
machine entry required as BIOS doesn't have that

They seem to appear in this thread so easy to find :)

-- 
~Vinod
