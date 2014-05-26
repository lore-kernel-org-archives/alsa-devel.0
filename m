From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 2/2] ASoC: dapm: Add a helper to get the
 platform for DAPM kcontrol
Date: Mon, 26 May 2014 18:21:46 +0530
Message-ID: <20140526125146.GE21128@intel.com>
References: <1401106136-3745-1-git-send-email-vinod.koul@intel.com>
 <1401106136-3745-2-git-send-email-vinod.koul@intel.com>
 <53833726.9050007@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 4A516265158
 for <alsa-devel@alsa-project.org>; Mon, 26 May 2014 15:08:37 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <53833726.9050007@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jarkko.nikula@linux.jf.intel.com>
Cc: Kp Jeeja <jeeja.kp@intel.com>, alsa-devel@alsa-project.org, broonie@kernel.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Mon, May 26, 2014 at 03:44:22PM +0300, Jarkko Nikula wrote:
> On 05/26/2014 03:08 PM, Vinod Koul wrote:
> >From: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
> >
> >commit eee5d7f9 introduced helper for getting codec for DAPM kcontrol, for DSPs
> >we need similar stuff for platforms as well
> >
> Please refer not only the commit id but also commit title ("ASoC:
> dapm: Add a helper to get the CODEC for DAPM kcontrol").
> 
> Makes commit log more clear and helps cases where original commit is
> backported to older tree.
ah yes, my bad :(

Mark, do you want a patch or can edit the commit with title "ASoC: dapm: Add a
helper to get the CODEC for DAPM kcontrol" before applying, if no further
comments

-- 
~Vinod
