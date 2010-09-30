From: Peter Hsiang <Peter.Hsiang@maxim-ic.com>
Subject: Re: user space control app driver interface for sound
	soc
Date: Thu, 30 Sep 2010 14:55:39 -0700
Message-ID: <B2150E1E4418E1438554A300EA5040E40D46F92A44@ITSVLEX06.it.maxim-ic.internal>
References: <B2150E1E4418E1438554A300EA5040E40D469C124D@ITSVLEX06.it.maxim-ic.internal>
	<20100929033757.GB29975@opensource.wolfsonmicro.com>
	<B2150E1E4418E1438554A300EA5040E40D46F2D8D8@ITSVLEX06.it.maxim-ic.internal>
	<20100929221826.GC31934@opensource.wolfsonmicro.com>
	<B2150E1E4418E1438554A300EA5040E40D46F2D9E9@ITSVLEX06.it.maxim-ic.internal>
	<20100930005850.GB4517@opensource.wolfsonmicro.com>
	<B2150E1E4418E1438554A300EA5040E40D46F92916@ITSVLEX06.it.maxim-ic.internal>
	<20100930203118.GA4175@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from antispam01.maxim-ic.com (antispam01.maxim-ic.com
	[205.153.101.182])
	by alsa0.perex.cz (Postfix) with ESMTP id 94E2210398D
	for <alsa-devel@alsa-project.org>;
	Thu, 30 Sep 2010 23:55:30 +0200 (CEST)
In-Reply-To: <20100930203118.GA4175@opensource.wolfsonmicro.com>
Content-Language: en-US
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Sep 30, 2010, Mark Brown wrote:
> On Thu, Sep 30, 2010 at 10:23:54AM -0700, Peter Hsiang wrote:
> 
> > If I want to build an audio user space app to perform things like
> > transferring large blocks of data to the sound soc codec
> > using I2C, what is the best kernel driver interface to use
> > for this purpose?  Add file interface (read/write/ioctl) in the
> > sound soc codec driver, or does ALSA already have this?
> > The soc codec driver needs to co-exist with this mechanism.
> 
> This depends on what's idiomatic for the data you need to download -
> what is the data?

The data could be filter coefficients, or maybe even proprietary 
binary code image that goes into the chip's memory.
