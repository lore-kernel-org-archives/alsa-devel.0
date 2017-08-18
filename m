From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH 1/6] ASoC: fsl: make snd_pcm_hardware const
Date: Fri, 18 Aug 2017 01:11:23 -0700
Message-ID: <20170818081122.GA10136@Asurada>
References: <1502964972-22722-1-git-send-email-bhumirks@gmail.com>
 <1502964972-22722-2-git-send-email-bhumirks@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1502964972-22722-2-git-send-email-bhumirks@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bhumika Goyal <bhumirks@gmail.com>
Cc: julia.lawall@lip6.fr, timur@tabi.org, Xiubo.Lee@gmail.com, fabio.estevam@nxp.com, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, plai@codeaurora.org, bgoswami@codeaurora.org, alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, Aug 17, 2017 at 03:46:07PM +0530, Bhumika Goyal wrote:
> Make these const as they are only passed as the 2nd argument to the
> function snd_soc_set_runtime_hwparams, which is const.
> Done using Coccinelle.
> 
> Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
