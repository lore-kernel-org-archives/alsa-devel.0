From: Tabi Timur-B04825 <B04825@freescale.com>
Subject: Re: [PATCH v3 08/11] ASoC: fsl: make fsl_ssi driver
 compilable on ARM/IMX
Date: Fri, 9 Mar 2012 04:03:19 +0000
Message-ID: <4F598106.30300@freescale.com>
References: <1331225990-27308-1-git-send-email-shawn.guo@linaro.org>
	<1331225990-27308-9-git-send-email-shawn.guo@linaro.org>
	<4F5912D0.2090800@freescale.com>
	<20120309012653.GG2499@S2101-09.ap.freescale.net>
	<4F596674.5030405@freescale.com>
	<20120309032128.GK2499@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from db3outboundpool.messaging.microsoft.com
	(db3ehsobe003.messaging.microsoft.com [213.199.154.141])
	by alsa0.perex.cz (Postfix) with ESMTP id 2A4EA1041BA
	for <alsa-devel@alsa-project.org>; Fri,  9 Mar 2012 05:03:28 +0100 (CET)
In-Reply-To: <20120309032128.GK2499@S2101-09.ap.freescale.net>
Content-Language: en-US
Content-ID: <54E98CD0DF0C0C4A8EB68528E40DC826@mgd.freescale.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Sascha Hauer <s.hauer@pengutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

Shawn Guo wrote:
> On Fri, Mar 09, 2012 at 02:09:57AM +0000, Tabi Timur-B04825 wrote:
>> >  That's the general idea, but I think it needs more study.  I don't
>> >  consider this to be a bug that needs to be fixed ASAP, since it's never
>> >  been an actual problem so far.  For instance, do we need to protect
>> >  between hw_params and _trigger?
>> >
> Ok, I will leave it to you with a big "FIXME" comment then.

Ok.

-- 
Timur Tabi
Linux kernel developer at Freescale
