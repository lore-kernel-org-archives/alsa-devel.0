From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v3 01/17] mfd: madera: Add register
 definitions for Cirrus Logic Madera codecs
Date: Mon, 26 Jun 2017 09:33:38 +0100
Message-ID: <1498466018.4826.81.camel@rf-debian.wolfsonmicro.main>
References: <1496415790-19164-1-git-send-email-rf@opensource.wolfsonmicro.com>
 <1496415790-19164-2-git-send-email-rf@opensource.wolfsonmicro.com>
 <20170605100707.zqyfyzhlhrpswa2u@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id BC7BF266B13
 for <alsa-devel@alsa-project.org>; Mon, 26 Jun 2017 10:33:41 +0200 (CEST)
In-Reply-To: <20170605100707.zqyfyzhlhrpswa2u@dell>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lee Jones <lee.jones@linaro.org>
Cc: gnurou@gmail.com, alsa-devel@alsa-project.org, jason@lakedaemon.net, devicetree@vger.kernel.org, linus.walleij@linaro.org, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, robh+dt@kernel.org, linux-gpio@vger.kernel.org, broonie@kernel.org, tglx@linutronix.de
List-Id: alsa-devel@alsa-project.org

On Mon, 2017-06-05 at 11:07 +0100, Lee Jones wrote:
> On Fri, 02 Jun 2017, Richard Fitzgerald wrote:
> 
> > This patch adds a header file of register definitions for Cirrus
> > Logic "Madera" class codecs. These codecs are all based off a common
> > set of hardware IP so have a common register map (with a few minor
> > device-to-device variations). These are complex devices with a large
> > number of features and so have a correspondingly large register set.
> > The registers.h file has been auto-generated from the hardware register
> > definitions, stripped down to only registers we need to access from
> > the driver
> > 
> > Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
> > ---
> > Changes since V2:
> > - Used new field names for IRQ1_STATUS_33 register
> > 
> >  MAINTAINERS                          |   10 +
> >  include/linux/mfd/madera/registers.h | 8832 ++++++++++++++++++++++++++++++++++
> 
> Crikey!
> 
> For my own reference:
>   Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
>   

Can I suggest that you take this patch into the mfd tree? Other
subsystem maintainers will have to base on that but it avoids me keeping
emailing out nearly 9000 lines of register definitions each time I do an
update to the other patches in the chain.
