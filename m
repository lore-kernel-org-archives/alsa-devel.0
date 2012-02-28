From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 6/6] ASoC: fsl: check property 'compatible'
 for the machine name
Date: Tue, 28 Feb 2012 09:50:15 +0800
Message-ID: <20120228015012.GA13886@S2101-09.ap.freescale.net>
References: <1329979644-31046-1-git-send-email-shawn.guo@linaro.org>
	<1330092582-21180-1-git-send-email-shawn.guo@linaro.org>
	<1330092582-21180-7-git-send-email-shawn.guo@linaro.org>
	<4F4BFB79.30801@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f51.google.com (mail-pz0-f51.google.com
	[209.85.210.51]) by alsa0.perex.cz (Postfix) with ESMTP id 5624724381
	for <alsa-devel@alsa-project.org>; Tue, 28 Feb 2012 02:36:21 +0100 (CET)
Received: by dady9 with SMTP id y9so2615521dad.38
	for <alsa-devel@alsa-project.org>; Mon, 27 Feb 2012 17:36:18 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4F4BFB79.30801@freescale.com>
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

On Mon, Feb 27, 2012 at 03:54:01PM -0600, Timur Tabi wrote:
> Shawn Guo wrote:
> > The fsl_ssi probe function detects the client machine name using model
> > property of the device tree.  But it will not work for the ARM client
> > machines which are to be added.  The model property is given as a
> > descriptive string on all ARM device tree (arch/arm/boot/*.dts).
> > Instead, the compatible property gives the machine name.
> 
> If you apply this change to the P1022DS as well, then you can eliminate
> the need to check for "P1022" and "P1022DS", since the compatible string
> in the P1022DS DTS has always said, "fsl,P1022DS".
> 
Since I was asked by Mark to use new binding for new machine driver,
I would drop this patch and keep PowerPC machine drivers working with
/model property.

-- 
Regards,
Shawn
