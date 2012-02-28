From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 5/6] ASoC: fsl: use platform_device_id
 table to match p1022_ds device
Date: Tue, 28 Feb 2012 09:52:50 +0800
Message-ID: <20120228015248.GB13886@S2101-09.ap.freescale.net>
References: <1329979644-31046-1-git-send-email-shawn.guo@linaro.org>
	<1330092582-21180-1-git-send-email-shawn.guo@linaro.org>
	<1330092582-21180-6-git-send-email-shawn.guo@linaro.org>
	<4F4BF805.60807@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f51.google.com (mail-pz0-f51.google.com
	[209.85.210.51]) by alsa0.perex.cz (Postfix) with ESMTP id 7606224381
	for <alsa-devel@alsa-project.org>; Tue, 28 Feb 2012 02:38:56 +0100 (CET)
Received: by dady9 with SMTP id y9so2617777dad.38
	for <alsa-devel@alsa-project.org>; Mon, 27 Feb 2012 17:38:55 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4F4BF805.60807@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Sascha Hauer <s.hauer@pengutronix.de>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Mon, Feb 27, 2012 at 03:39:17PM -0600, Timur Tabi wrote:
> Shawn Guo wrote:
> 
> > -
> > -	/*
> > -	 * Check if we're actually running on a P1022DS.  Older device trees
> > -	 * have a model of "fsl,P1022" and newer ones use "fsl,P1022DS", so we
> > -	 * need to support both.  The SSI driver uses that property to link to
> > -	 * the machine driver, so have to match it.
> > -	 */
> 
> Please retain this paragraph somewhere.  It's important to explain why
> we're checking for both strings.
> 

Ok, it will be something like the following.

/*
 * Check if we're actually running on a P1022DS.  Older device trees
 * have a model of "fsl,P1022" and newer ones use "fsl,P1022DS", so we
 * need to support both.  The SSI driver uses that property to link to
 * the machine driver, so have to match it.
 */
static struct platform_device_id p1022_ds_ids[] = {
	{ .name = "snd-soc-p1022ds", },
	{ .name = "snd-soc-p1022", },
	{ /* sentinel */ }
};
MODULE_DEVICE_TABLE(platform, p1022_ds_ids);

-- 
Regards,
Shawn
