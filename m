From: Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: [PATCH 2/3] mfd/ASoC: Convert WM8994 driver to use regmap patches
Date: Mon, 20 Feb 2012 18:02:33 +0100
Message-ID: <20120220170233.GE5387@sortiz-mobl>
References: <1327327172-8411-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <1327327172-8411-2-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1327327172-8411-2-git-send-email-broonie@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Liam Girdwood <lrg@ti.com>, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hi Mark,

On Mon, Jan 23, 2012 at 01:59:31PM +0000, Mark Brown wrote:
> Early revisions of several of the WM8994 variants have register updates
> to improve performance. Move these over to using the regmap patch system
> instead of open coding them in the audio driver. Since the regmap init
> is done by the MFD the code is moved there.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
> 
> If possible I'd like to merge this via regmap as the regmap patch
> support is new and won't be in mainline until 3.4.  Is that OK Samuel?
Sounds good to me.

Acked-by: Samuel Ortiz <sameo@linux.intel.com>

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
