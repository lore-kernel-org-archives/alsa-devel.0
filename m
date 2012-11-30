From: Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: [PATCH 1/4] mfd: arizona: Allow the CODEC DAPM context to be
 accessed elsewhere
Date: Fri, 30 Nov 2012 11:09:39 +0100
Message-ID: <20121130100939.GC3176@sortiz-mobl>
References: <1354020025-23881-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1354020025-23881-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Sender: linux-input-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Liam Girdwood <lrg@ti.com>, alsa-devel@alsa-project.org, linux-input@vger.kernel.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Hi Mark,

On Tue, Nov 27, 2012 at 12:40:22PM +0000, Mark Brown wrote:
> Some other device functions need to integrate with signal sources in the
> audio portion (primarily for haptics) so allow CODEC to export the DAPM
> context by pointing to it from the core driver.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  include/linux/mfd/arizona/core.h |    4 ++++
>  1 file changed, 4 insertions(+)
Probably too late, but I think it would make sense to merge this one through
your asoc tree:

Acked-by: Samuel Ortiz <sameo@linux.intel.com>

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
