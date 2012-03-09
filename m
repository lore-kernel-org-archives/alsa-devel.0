From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH v3 08/11] ASoC: fsl: make fsl_ssi driver
 compilable on ARM/IMX
Date: Fri, 9 Mar 2012 11:21:31 +0800
Message-ID: <20120309032128.GK2499@S2101-09.ap.freescale.net>
References: <1331225990-27308-1-git-send-email-shawn.guo@linaro.org>
	<1331225990-27308-9-git-send-email-shawn.guo@linaro.org>
	<4F5912D0.2090800@freescale.com>
	<20120309012653.GG2499@S2101-09.ap.freescale.net>
	<4F596674.5030405@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-tul01m020-f179.google.com (mail-tul01m020-f179.google.com
	[209.85.214.179])
	by alsa0.perex.cz (Postfix) with ESMTP id A9817103A31
	for <alsa-devel@alsa-project.org>; Fri,  9 Mar 2012 04:21:45 +0100 (CET)
Received: by obbup3 with SMTP id up3so1607476obb.38
	for <alsa-devel@alsa-project.org>; Thu, 08 Mar 2012 19:21:44 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4F596674.5030405@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Tabi Timur-B04825 <B04825@freescale.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Sascha Hauer <s.hauer@pengutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

On Fri, Mar 09, 2012 at 02:09:57AM +0000, Tabi Timur-B04825 wrote:
> That's the general idea, but I think it needs more study.  I don't 
> consider this to be a bug that needs to be fixed ASAP, since it's never 
> been an actual problem so far.  For instance, do we need to protect 
> between hw_params and _trigger?
> 
Ok, I will leave it to you with a big "FIXME" comment then.

-- 
Regards,
Shawn
