From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: Re: DT soundcard driver with special clock routing
Date: Mon, 14 Dec 2015 13:28:45 +0100
Message-ID: <566EB5FD.2000803@samsung.com>
References: <5669A8DE.7060702@barix.com> <5669B2BD.6010100@samsung.com>
 <566EA8B1.2020908@barix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com
 [210.118.77.11])
 by alsa0.perex.cz (Postfix) with ESMTP id F3BB5260453
 for <alsa-devel@alsa-project.org>; Mon, 14 Dec 2015 13:30:47 +0100 (CET)
Received: from eucpsbgm1.samsung.com (unknown [203.254.199.244])
 by mailout1.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5 2014))
 with ESMTP id <0NZC005LQLF7B9B0@mailout1.w1.samsung.com> for
 alsa-devel@alsa-project.org; Mon, 14 Dec 2015 12:30:43 +0000 (GMT)
In-reply-to: <566EA8B1.2020908@barix.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Petr Kulhavy <petr@barix.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello Petr,

On 14/12/15 12:32, Petr Kulhavy wrote:
> 
> thank you for the explanation. I can follow the clock description in the 
> DT and it looks like a reasonable approach.
> However neither the codec or I2S seem to implement any clock provider.
> How is the implementation side done? I mean someone needs to set the 
> PLLs, etc.

Yes, you need the clock provider somewhere. In my case it was the I2S
driver that registered a clock provider. Probably you can add your 
output clock provider to your SoC's main clock controller driver,
and perhaps use pinctrl API for the pin function mux setup.

You can place assigned-clock* DT properties in the clock provider
node and the PLL's will be configured by the kernel's clk subsystem.
Grep for of_clk_set_defaults or see last chapter of
Documentation/devicetree/bindings/clock/clock-bindings.txt.

-- 
Regards,
Sylwester
