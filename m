From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH] ASoC: Intel: Skylake: remove unused 'out_fmt' variable
Date: Thu, 8 Dec 2016 15:48:27 +0530
Message-ID: <20161208101826.GZ6408@localhost>
References: <1481176902-131803-1-git-send-email-kirtika@chromium.org>
 <20161208095959.GY6408@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161208095959.GY6408@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: Kirtika Ruchandani <kirtika@chromium.org>
Cc: tiwai@suse.com, arnd@arndb.de, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Hardik T Shah <hardik.t.shah@intel.com>, Omair M Abdullah <omair.m.abdullah@intel.com>, Jeeja KP <jeeja.kp@intel.com>, "Subhransu S . Prusty" <subhransu.s.prusty@intel.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Dec 08, 2016 at 03:30:01PM +0530, Vinod Koul wrote:
> On Wed, Dec 07, 2016 at 10:01:42PM -0800, Kirtika Ruchandani wrote:
> > Commit 4cd9899f0d16 introduced struct skl_module_fmt* out_fmt without
> > using it. Compiling with W=1 gives the below warning, fix it.
> > 
> > sound/soc/intel/skylake/skl-topology.c: In function ‘skl_tplg_update_buffer_size’:
> > sound/soc/intel/skylake/skl-topology.c:301:34: warning: variable ‘out_fmt’ set but not used [-Wunused-but-set-variable]
> > 
> > This is a harmless warning and is only being fixed to reduce the noise
> > with W=1 in the kernel.
> 
> Heya,
> 
> Can you please tell me which tree this warning was found on? At least this
> doesn't exist upstream. The out_fmt is very well used.

Sorry I messed up, got confused mcfg->out_fmt variable :(

This looks fine:

Acked-by: Vinod Koul <vinod.koul@intel.com>

-- 
~Vinod
