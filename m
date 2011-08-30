From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH 1/3] ASoC: Add device tree binding for
	WM8770
Date: Tue, 30 Aug 2011 13:15:07 -0500
Message-ID: <4E5D28AB.7040206@freescale.com>
References: <1314624471-15381-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<CAOZdJXUQpyvxOVgS9mPnMwJM1TNF-X+zOVkOsDqJM_oBNQih0Q@mail.gmail.com>
	<20110830181222.GP2061@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from TX2EHSOBE004.bigfish.com (tx2ehsobe002.messaging.microsoft.com
	[65.55.88.12]) by alsa0.perex.cz (Postfix) with ESMTP id AC50C2475D
	for <alsa-devel@alsa-project.org>;
	Tue, 30 Aug 2011 20:15:15 +0200 (CEST)
In-Reply-To: <20110830181222.GP2061@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "patches@opensource.wolfsonmicro.com" <patches@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:
> I did say this before; personally I find having binding documentation at
> all for the basic I2C/SPI bus binding of a device to be a complete waste
> of time and would rather just not bother unless we have properties.

I'm okay with that, but it's not my decision. :-)

The codec node bindings that my audio driver expects are documented in ssi.txt.
 Note that I require a clock-frequency property to indicate the input clock
frequency on the codec itself.

-- 
Timur Tabi
Linux kernel developer at Freescale
