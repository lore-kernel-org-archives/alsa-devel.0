From: Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: [PATCH 1/3] mfd: Add __devinit and __devexit annotations in
 wm8994
Date: Mon, 20 Feb 2012 18:03:06 +0100
Message-ID: <20120220170306.GF5387@sortiz-mobl>
References: <1327327172-8411-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1327327172-8411-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Liam Girdwood <lrg@ti.com>, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hi Mark,

On Mon, Jan 23, 2012 at 01:59:30PM +0000, Mark Brown wrote:
> The wm8994_device_init() and wm8994_device_exit() functions were not
> annotated as device init and exit functions, meaning they shouldn't
> reference __devinitdata.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
> 
> This is mostly just a warning fix for the second patch and doesn't seem
> terribly critical otherwise so it should probably get merged along with
> it.
Fine with me as well.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
