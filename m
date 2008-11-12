From: Wu Fengguang <wfg@linux.intel.com>
Subject: Re: [PATCH 1/3] introduce i830_hdmi_priv.has_hdmi_sink
Date: Wed, 12 Nov 2008 16:16:03 +0800
Message-ID: <1226477768.297868.8785@de>
References: <20081107062338.158523355@linux.intel.com>
	<20081107062410.013520150@linux.intel.com>
	<20081112072747.GD14627@zhen-devel.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from azsmga101.ch.intel.com (mga07.intel.com [143.182.124.22])
	by alsa0.perex.cz (Postfix) with ESMTP id 5350624179
	for <alsa-devel@alsa-project.org>; Wed, 12 Nov 2008 09:16:12 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20081112072747.GD14627@zhen-devel.sh.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Wang, Zhenyu Z" <zhenyu.z.wang@intel.com>, "linux-gfx@linux.intel.com" <linux-gfx@linux.intel.com>, "xorg@lists.freedesktop.org" <xorg@lists.freedesktop.org>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 12, 2008 at 03:27:47PM +0800, Wang, Zhenyu Z wrote:
> On 2008.11.07 14:23:39 +0800, Wu Fengguang wrote:
> > HDMI is compatible with DVI, and we've seen many boards that
> > use HDMI port for DVI output.
> > 
> > So Zhenyu proposed this flag: i830_hdmi_priv.has_hdmi_sink
> > to indicate the presence of HDMI capable monitors.
> > 
> > Signed-off-by: Wu Fengguang <wfg@linux.intel.com>

> We should check if the symbol is available for xserver compatiblity.
> So below is updated patch for check this. 

> +
> +    if (xf86LoaderCheckSymbol("xf86MonitorIsHDMI") &&
> +	    xf86MonitorIsHDMI(edid_mon))
> +	dev_priv->has_hdmi_sink = TRUE;

I'm OK with the backward compatibility check.
The side effect is that audio output won't be enabled for old xservers.

Thanks,
Fengguang
