From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 07/16] regulator: madera-micsupp: Mic
 supply for Cirrus Logic Madera codecs
Date: Wed, 5 Apr 2017 14:53:57 +0100
Message-ID: <1491400437.4096.5.camel@rf-debian.wolfsonmicro.main>
References: <1491386884-30689-1-git-send-email-rf@opensource.wolfsonmicro.com>
 <1491386884-30689-8-git-send-email-rf@opensource.wolfsonmicro.com>
 <20170405134054.kz3j56vza4pqki75@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 74128267094
 for <alsa-devel@alsa-project.org>; Wed,  5 Apr 2017 15:53:59 +0200 (CEST)
In-Reply-To: <20170405134054.kz3j56vza4pqki75@sirena.org.uk>
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
Cc: gnurou@gmail.com, alsa-devel@alsa-project.org, jason@lakedaemon.net, devicetree@vger.kernel.org, linus.walleij@linaro.org, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, robh+dt@kernel.org, tglx@linutronix.de, lee.jones@linaro.org
List-Id: alsa-devel@alsa-project.org

On Wed, 2017-04-05 at 14:40 +0100, Mark Brown wrote:
> On Wed, Apr 05, 2017 at 11:07:55AM +0100, Richard Fitzgerald wrote:
> > The adds a driver for the microphone supply regulator on Cirrus Logic
> > Madera class codecs.
> 
> Again, this appears to have only data and minor code style changes
> relative to the existing arizona driver - is there no opportunity for
> code sharing here?

I'll have a look at how it would work out.
My thought was that these two regulator drivers are so small it wasn't
worth creating an entanglement between arizona and madera for so little
code.
