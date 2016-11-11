From: Jyri Sarha <jsarha@ti.com>
Subject: Re: BeagleBone with TLV320AIC3100
Date: Fri, 11 Nov 2016 17:04:20 +0200
Message-ID: <f0ae360f-ce2e-53c4-4cc2-6c177ee0a0f2@ti.com>
References: <235852582.3755112.1478875942989.ref@mail.yahoo.com>
 <235852582.3755112.1478875942989@mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fllnx210.ext.ti.com (fllnx210.ext.ti.com [198.47.19.17])
 by alsa0.perex.cz (Postfix) with ESMTP id 160C9266D07
 for <alsa-devel@alsa-project.org>; Fri, 11 Nov 2016 16:04:24 +0100 (CET)
In-Reply-To: <235852582.3755112.1478875942989@mail.yahoo.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kai Riedel <kairiedel@yahoo.de>, alsa-devel@alsa-project.org
Cc: peter.ujfalusi@ti.com
List-Id: alsa-devel@alsa-project.org

On 11/11/16 16:52, Kai Riedel wrote:
> Hi,
> 
> is there a possibility (parameter in dts file) to get the mclk from the sitara and not from an external oscillator?
> With external clock it works fine now.
> 

In theory all you need is to route some clock from sitara to aic3100's
mclk pin (or so some of the other possible PLL input pins) with suitable
pin-control configuration and refer that clock with phandle in the
simple-card codec node. In practice I have not done it and at the moment
I do not have time to study how it could be done.

Peter, do you know how to do this? Could, for instance, the McASP fclk
be routed to codec mclk for pll input?

Best regards,
Jyri
