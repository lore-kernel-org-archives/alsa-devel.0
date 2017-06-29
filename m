From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v3 01/17] mfd: madera: Add register
 definitions for Cirrus Logic Madera codecs
Date: Thu, 29 Jun 2017 10:11:34 +0100
Message-ID: <1498727494.4826.84.camel@rf-debian.wolfsonmicro.main>
References: <1496415790-19164-1-git-send-email-rf@opensource.wolfsonmicro.com>
 <1496415790-19164-2-git-send-email-rf@opensource.wolfsonmicro.com>
 <20170605100707.zqyfyzhlhrpswa2u@dell>
 <1498466018.4826.81.camel@rf-debian.wolfsonmicro.main>
 <20170628192640.lboeddcabjcrvmtw@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id EFC9D2668BF
 for <alsa-devel@alsa-project.org>; Thu, 29 Jun 2017 11:11:38 +0200 (CEST)
In-Reply-To: <20170628192640.lboeddcabjcrvmtw@sirena.org.uk>
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

On Wed, 2017-06-28 at 20:26 +0100, Mark Brown wrote:
> On Mon, Jun 26, 2017 at 09:33:38AM +0100, Richard Fitzgerald wrote:
> > On Mon, 2017-06-05 at 11:07 +0100, Lee Jones wrote:
> 
> > > For my own reference:
> > >   Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> 
> > Can I suggest that you take this patch into the mfd tree? Other
> > subsystem maintainers will have to base on that but it avoids me keeping
> > emailing out nearly 9000 lines of register definitions each time I do an
> > update to the other patches in the chain.
> 
> Yes, please!  It also helps other maintainers see that the early bits of
> the series we depend on are making progress.

I guess taking all the MFD code when Lee is happy with it would also be
acceptable? There's several multi-thousand-line files in there too.

There are build dependencies between the subsystems but I don't know how
the maintainers prefer to deal with that - keep the patches as a set or
cross-merge branches.
