From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 0/9] ALSA: compress offfload fixes
Date: Tue, 27 Aug 2013 18:44:38 +0530
Message-ID: <20130827131438.GA2748@intel.com>
References: <1377585639-29516-1-git-send-email-vinod.koul@intel.com>
 <s5heh9fjtrn.wl%tiwai@suse.de> <20130827100955.GX2748@intel.com>
 <s5h7gf7jov7.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
 by alsa0.perex.cz (Postfix) with ESMTP id 496BC260840
 for <alsa-devel@alsa-project.org>; Tue, 27 Aug 2013 15:59:36 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5h7gf7jov7.wl%tiwai@suse.de>
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

On Tue, Aug 27, 2013 at 02:32:28PM +0200, Takashi Iwai wrote:
> > > >  - As disscused on our sample rate problem, lets move to use rate values and I
> > > >    will fix the lib too. Since the driver are not upstream the impact of this
> > > > change wont be huge.
> > > 
> > > I see no code touching sampling_rate field.
> > Yes its passed directly to the drivers, where tehy use values to program
> > decoders. Only meaning of the field is changing now.
> 
> So you're proposing a patch just changing the comment in the header
> file as a stable fix patch?  Please reread stable_kernel_rules.txt
> once again.
Yes along with header version so that tinycompress can cope with it.

The meaning of the value is changing here... 

~Vinod
-- 
