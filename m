From: Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: [PATCH v3 1/5] MFD: twl6040: Use resource to provide irq number
 for slaves
Date: Thu, 7 Jul 2011 11:49:36 +0200
Message-ID: <20110707094936.GR3021@sortiz-mobl>
References: <1309895376-17446-1-git-send-email-peter.ujfalusi@ti.com>
 <1309895376-17446-2-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1309895376-17446-2-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Liam Girdwood <lrg@ti.com>, Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Misael Lopez Cruz <misael.lopez@ti.com>, Felipe Balbi <balbi@ti.com>
List-Id: alsa-devel@alsa-project.org

Hi Peter,

On Tue, Jul 05, 2011 at 10:49:32PM +0300, Peter Ujfalusi wrote:
> Provide the irq number for slaves via resource on the
> platform device.
> The irq number configuration is done in the twl6040-core
> at probe time, so machine drivers do not need to be
> modified.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Acked-by: Samuel Ortiz <sameo@linux.intel.com>

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
