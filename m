From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH] ASoC: Intel: Skylake: remove unused 'runtime' variable
Date: Thu, 8 Dec 2016 15:49:25 +0530
Message-ID: <20161208101925.GA6408@localhost>
References: <1481178380-139648-1-git-send-email-kirtika@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1481178380-139648-1-git-send-email-kirtika@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Kirtika Ruchandani <kirtika@chromium.org>
Cc: tiwai@suse.com, arnd@arndb.de, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Jeeja KP <jeeja.kp@intel.com>, "Subhransu S . Prusty" <subhransu.s.prusty@intel.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Dec 07, 2016 at 10:26:20PM -0800, Kirtika Ruchandani wrote:
> skl_platform_open() defines and sets 'struct snd_pcm_runtime* runtime'
> but does not use it. Compiling with W=1 gives the following warning,
> fix it.
> 
> sound/soc/intel/skylake/skl-pcm.c: In function ‘skl_platform_open’:
> sound/soc/intel/skylake/skl-pcm.c:941:26: warning: variable ‘runtime’ set but not used [-Wunused-but-set-variable]
> 
> This was introduced with the initial driver commit a40e693c7f5e
> ("ASoC: Intel: Add Skylake HDA platform driver").
> This is a harmless warning and is only being fixed to reduce the noise
> with W=1 in the kernel.

Acked-by: Vinod Koul <vinod.koul@intel.com>

-- 
~Vinod
