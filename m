From: Yu Zhao <yuzhao@google.com>
Subject: Re: [PATCH 1/3] Revert "ASoC: Intel: Skylake: Acquire irq after RIRB
 allocation"
Date: Tue, 11 Sep 2018 14:44:56 -0600
Message-ID: <20180911204456.GA18086@google.com>
References: <20180910211718.200802-1-yuzhao@google.com>
 <s5hd0tk3712.wl-tiwai@suse.de>
 <20180911163636.GC10123@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180911163636.GC10123@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Guneshwor Singh <guneshwor.o.singh@intel.com>, Naveen Manohar <naveen.m@intel.com>, Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>, Rakesh Ughreja <rakesh.a.ughreja@intel.com>, Sanyog Kale <sanyog.r.kale@intel.com>, Sriram Periyasamy <sriramx.periyasamy@intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Jie Yang <yang.jie@linux.intel.com>, Jaroslav Kysela <perex@perex.cz>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, Sep 11, 2018 at 05:36:36PM +0100, Mark Brown wrote:
> On Tue, Sep 11, 2018 at 08:03:21AM +0200, Takashi Iwai wrote:
> > Yu Zhao wrote:
> 
> > > Will fix the problems in the following patches. Also attaching the
> > > crash for future reference.
> 
> > > [   16.950887] RIP: 0010:snd_hdac_bus_update_rirb+0x19b/0x4cf [snd_hda_core]
> > > [   16.950889] RSP: 0000:ffff88015c807c08 EFLAGS: 00010003
> > > [   16.950891] RAX: 0000000000000101 RBX: 000000000000080c RCX: 1ffff10026822185
> 
> > Please try to rip off uninteresting hex values and other stuff there.
> 
> Right:
> 
> Please think hard before including complete backtraces in upstream
> reports, they are very large and contain almost no useful information
> relative to their size so often obscure the relevant content in your
> message. If part of the backtrace is usefully illustrative then it's
> usually better to pull out the relevant sections.

Thanks, will do in v2.
