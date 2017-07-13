From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 01/18] mfd: madera: Add register
 definitions for Cirrus Logic Madera codecs
Date: Thu, 13 Jul 2017 13:44:10 +0100
Message-ID: <1499949850.4826.88.camel@rf-debian.wolfsonmicro.main>
References: <1493050124-5970-1-git-send-email-rf@opensource.wolfsonmicro.com>
 <1493050124-5970-2-git-send-email-rf@opensource.wolfsonmicro.com>
 <20170713080210.lbsjnmlciovoxe4g@dell>
 <20170713100539.mqvyxgvwqowjim6i@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 8101D26648D
 for <alsa-devel@alsa-project.org>; Thu, 13 Jul 2017 14:44:14 +0200 (CEST)
In-Reply-To: <20170713100539.mqvyxgvwqowjim6i@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: gnurou@gmail.com, alsa-devel@alsa-project.org, jason@lakedaemon.net, devicetree@vger.kernel.org, linus.walleij@linaro.org, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, robh+dt@kernel.org, tglx@linutronix.de, Lee Jones <lee.jones@linaro.org>
List-Id: alsa-devel@alsa-project.org


On Thu, 2017-07-13 at 11:05 +0100, Mark Brown wrote:
> On Thu, Jul 13, 2017 at 09:02:10AM +0100, Lee Jones wrote:
> 
> > This patch has been rejected by Linus.
> 
> > https://lkml.org/lkml/2017/7/7/579
> 
> Hrm, when I used to push the register definition patches I did elide all
> the obviously repeated register banks like the write sequencer one that
> Linus is calling out there.  I'm surprised by the "every single line"
> bit though...

Linux doesn't say what he wants us to do about it. I could manually
strip out a few more definitions but seriously, it makes the code a lot
harder to maintain if we can't grep it for use of registers and register
fields. They are big chips, they have a lot of stuff in the registers.
