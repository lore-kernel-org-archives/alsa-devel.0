From: Tabi Timur-B04825 <B04825@freescale.com>
Subject: Re: [PATCH v3 00/11] ASoC: add imx-sgtl5000 machine
 driver working with fsl_ssi
Date: Fri, 9 Mar 2012 02:11:41 +0000
Message-ID: <4F5966DC.6090201@freescale.com>
References: <1331225990-27308-1-git-send-email-shawn.guo@linaro.org>
	<4F5910EE.8090408@freescale.com>
	<20120309011914.GF2499@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch1outboundpool.messaging.microsoft.com
	(ch1ehsobe004.messaging.microsoft.com [216.32.181.184])
	by alsa0.perex.cz (Postfix) with ESMTP id 920A910BBF7
	for <alsa-devel@alsa-project.org>; Fri,  9 Mar 2012 03:11:50 +0100 (CET)
In-Reply-To: <20120309011914.GF2499@S2101-09.ap.freescale.net>
Content-Language: en-US
Content-ID: <E7E914BED9C2BA4C8D7B61C9ADA7692F@mgd.freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Tabi Timur-B04825 <B04825@freescale.com>, Sascha Hauer <s.hauer@pengutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

Shawn Guo wrote:
> Are you testing the patch set on top of the SHA below, which I
> mentioned in the cover letter?
>
>    3030763 (Merge tag 'asoc-3.4' of git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound into topic/asoc)
>
> I see the similar problem on the following SHA with my testing on
> imx-sgtl5000.
>
>    1a8feca (Merge branch 'for-3.4' into asoc-next)

It appears the problem is with for-3.4 itself.  I'm running git-bisect now 
to narrow it down.

-- 
Timur Tabi
Linux kernel developer at Freescale
