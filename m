From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH] ALSA: compress: fix drain calls blocking
 other compress functions
Date: Thu, 24 Oct 2013 16:38:37 +0530
Message-ID: <20131024110837.GY14013@intel.com>
References: <1382545021-26918-1-git-send-email-vinod.koul@intel.com>
 <1382600141-9866-1-git-send-email-vinod.koul@intel.com>
 <s5hli1jnhps.wl%tiwai@suse.de> <20131024092724.GW14013@intel.com>
 <s5hbo2fnddl.wl%tiwai@suse.de> <20131024103505.GX14013@intel.com>
 <s5h61smop3s.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
 by alsa0.perex.cz (Postfix) with ESMTP id 797AC264F2D
 for <alsa-devel@alsa-project.org>; Thu, 24 Oct 2013 14:02:26 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5h61smop3s.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Thu, Oct 24, 2013 at 02:00:39PM +0200, Takashi Iwai wrote:
> > hmmm, yes it needs a better name :)
> > perhaps drain_condition or drain_wake would be apt!
> 
> Yes, drain_wake would be more self-explanatory.
Ok sent v3 with this a few moment ago :)

--
~Vinod
