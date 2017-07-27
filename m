From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v3 07/17] regulator: arizona-micsupp: Add
 support for Cirrus Logic Madera codecs
Date: Thu, 27 Jul 2017 12:45:50 +0100
Message-ID: <1501155950.5479.1.camel@rf-debian.wolfsonmicro.main>
References: <1496415790-19164-1-git-send-email-rf@opensource.wolfsonmicro.com>
 <1496415790-19164-8-git-send-email-rf@opensource.wolfsonmicro.com>
 <20170605171006.3ppsjia2xvb22ld2@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 077B8266A8A
 for <alsa-devel@alsa-project.org>; Thu, 27 Jul 2017 13:45:54 +0200 (CEST)
In-Reply-To: <20170605171006.3ppsjia2xvb22ld2@rob-hp-laptop>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Rob Herring <robh@kernel.org>
Cc: gnurou@gmail.com, alsa-devel@alsa-project.org, jason@lakedaemon.net, devicetree@vger.kernel.org, linus.walleij@linaro.org, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, broonie@kernel.org, tglx@linutronix.de, lee.jones@linaro.org
List-Id: alsa-devel@alsa-project.org

On Mon, 2017-06-05 at 12:10 -0500, Rob Herring wrote:
> On Fri, Jun 02, 2017 at 04:03:00PM +0100, Richard Fitzgerald wrote:
> > This adds a new driver identity "madera-micsupp" and probe function
> > so that this driver can be used to control the micsupp regulator on
> > Cirrus Logic Madera codecs.
> > 
> > Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
> > ---
> > No changes since V2
> > 
> >  .../bindings/regulator/arizona-regulator.txt       |  3 +-
> 
> I already acked v2. Please add acks when posting new versions.

Some maintainers have bitten my head off when I've carried forward their
ack so I never know what people want.

> 
> >  drivers/regulator/Kconfig                          |  7 ++-
> >  drivers/regulator/arizona-micsupp.c                | 71 +++++++++++++++++++++-
> >  3 files changed, 76 insertions(+), 5 deletions(-)
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
