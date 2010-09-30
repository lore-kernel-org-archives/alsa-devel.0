From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: user space control app driver interface for sound
	soc
Date: Thu, 30 Sep 2010 15:09:54 -0700
Message-ID: <20100930220953.GF4175@opensource.wolfsonmicro.com>
References: <B2150E1E4418E1438554A300EA5040E40D469C124D@ITSVLEX06.it.maxim-ic.internal>
	<20100929033757.GB29975@opensource.wolfsonmicro.com>
	<B2150E1E4418E1438554A300EA5040E40D46F2D8D8@ITSVLEX06.it.maxim-ic.internal>
	<20100929221826.GC31934@opensource.wolfsonmicro.com>
	<B2150E1E4418E1438554A300EA5040E40D46F2D9E9@ITSVLEX06.it.maxim-ic.internal>
	<20100930005850.GB4517@opensource.wolfsonmicro.com>
	<B2150E1E4418E1438554A300EA5040E40D46F92916@ITSVLEX06.it.maxim-ic.internal>
	<20100930203118.GA4175@opensource.wolfsonmicro.com>
	<B2150E1E4418E1438554A300EA5040E40D46F92A44@ITSVLEX06.it.maxim-ic.internal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E8FC1103991
	for <alsa-devel@alsa-project.org>;
	Fri,  1 Oct 2010 02:37:50 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <B2150E1E4418E1438554A300EA5040E40D46F92A44@ITSVLEX06.it.maxim-ic.internal>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Hsiang <Peter.Hsiang@maxim-ic.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Sep 30, 2010 at 02:55:39PM -0700, Peter Hsiang wrote:
> On Thu, Sep 30, 2010, Mark Brown wrote:

> > This depends on what's idiomatic for the data you need to download -
> > what is the data?

> The data could be filter coefficients, or maybe even proprietary 

For these it depends; frequently these are (like your existing EQ
configuration) included in platform data but it really depends on how
they are generated and if they are custom to a particular system (eg,
dependant on plastics or particular speakers).

> binary code image that goes into the chip's memory.

For this use request_firmware() and associated interfaces.
