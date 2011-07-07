From: Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: [PATCH v3 5/5] MFD: twl6040: Remove wrapper for threaded irq
 request
Date: Thu, 7 Jul 2011 11:51:20 +0200
Message-ID: <20110707095120.GT3021@sortiz-mobl>
References: <1309895376-17446-1-git-send-email-peter.ujfalusi@ti.com>
 <1309895376-17446-6-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1309895376-17446-6-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Liam Girdwood <lrg@ti.com>, Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Misael Lopez Cruz <misael.lopez@ti.com>, Felipe Balbi <balbi@ti.com>
List-Id: alsa-devel@alsa-project.org

Hi Peter,

On Tue, Jul 05, 2011 at 10:49:36PM +0300, Peter Ujfalusi wrote:
> Remove the twl6040_request_irq/free_irq inline functions,
> and use direct calls instead in the core driver to
> register the threaded irq.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Acked-by: Samuel Ortiz <sameo@linux.intel.com>

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
