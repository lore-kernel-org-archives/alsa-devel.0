From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: Re: [PATCH] ASoC: rt5645: fix build warning
Date: Thu, 8 Oct 2015 14:25:50 +0530
Message-ID: <20151008085550.GA3806@sudip-pc>
References: <1444220532-14199-1-git-send-email-sudipm.mukherjee@gmail.com>
 <20151007140527.GK12635@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20151007140527.GK12635@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Oct 07, 2015 at 03:05:27PM +0100, Mark Brown wrote:
> On Wed, Oct 07, 2015 at 05:52:12PM +0530, Sudip Mukherjee wrote:
> > We were getting build warning about "Section mismatch".
> > dmi_platform_intel_broadwell is being referenced from the probe function
> > rt5645_i2c_probe(), but dmi_platform_intel_broadwell was marked with
> > __initdata.
> > 
> > Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
> 
> > -static struct dmi_system_id dmi_platform_intel_broadwell[] __initdata = {
> > +static struct dmi_system_id dmi_platform_intel_broadwell[] = {
> 
> This doesn't seem like the obvious fix - why are we not annotating the
> probe function suitably (or alternatively if we can't why does
> __initdata still exist)?

probe function should not be __init. probe can be called anytime after
the module has been loaded.
__initdata still exists as that part of the code was added by
e9159e7577cf ("ASoC: rt5645: Add dmi for Broadwell") which is a very
recent modification and I think that has been added by mistake.
One more argument in my favor:
The use in probe function is 
if (dmi_check_system(dmi_platform_intel_braswell) || 
		dmi_check_system(dmi_platform_intel_broadwell))

dmi_platform_intel_braswell is not marked as __initdata but
dmi_platform_intel_broadwell is marked but they both have same use at
the same place.

regards
sudip
