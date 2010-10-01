From: Peter Hsiang <Peter.Hsiang@maxim-ic.com>
Subject: Re: user space control app driver interface for sound
	soc
Date: Thu, 30 Sep 2010 18:56:58 -0700
Message-ID: <B2150E1E4418E1438554A300EA5040E40D46F92B44@ITSVLEX06.it.maxim-ic.internal>
References: <20100929033757.GB29975@opensource.wolfsonmicro.com>
	<B2150E1E4418E1438554A300EA5040E40D46F2D8D8@ITSVLEX06.it.maxim-ic.internal>
	<20100929221826.GC31934@opensource.wolfsonmicro.com>
	<B2150E1E4418E1438554A300EA5040E40D46F2D9E9@ITSVLEX06.it.maxim-ic.internal>
	<20100930005850.GB4517@opensource.wolfsonmicro.com>
	<B2150E1E4418E1438554A300EA5040E40D46F92916@ITSVLEX06.it.maxim-ic.internal>
	<20100930203118.GA4175@opensource.wolfsonmicro.com>
	<B2150E1E4418E1438554A300EA5040E40D46F92A44@ITSVLEX06.it.maxim-ic.internal>
	<20100930220953.GF4175@opensource.wolfsonmicro.com>
	<B2150E1E4418E1438554A300EA5040E40D46F92A90@ITSVLEX06.it.maxim-ic.internal>
	<20100930233453.GH4175@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from antispam01.maxim-ic.com (antispam01.maxim-ic.com
	[205.153.101.182])
	by alsa0.perex.cz (Postfix) with ESMTP id C550310399E
	for <alsa-devel@alsa-project.org>;
	Fri,  1 Oct 2010 03:57:14 +0200 (CEST)
In-Reply-To: <20100930233453.GH4175@opensource.wolfsonmicro.com>
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
> On Thu, Sep 30, 2010 at 04:10:15PM -0700, Peter Hsiang wrote:
> > On Thu, Sep 30, 2010, Mark Brown wrote:
> 
> > > For these it depends; frequently these are (like your existing EQ
> > > configuration) included in platform data but it really depends on how
> > > they are generated and if they are custom to a particular system (eg,
> > > dependant on plastics or particular speakers).
> 
> > In addition to the platform data, I would like in the future be
> > able to load in data values that are stored in or generated from the
> > user space.  Would I use the ALSA interface for this, or would it
> > need to be a separate interface?
> 
> This would not be idiomatic for ALSA.  The particular interface to use
> would depend on the volume of data being configured and the format it is
> provided in.  If this is just for test and development purposes then
> adding something to debugfs would be the normal thing.

This will be intended for normal operation.
The volume of data would be both small amounts (say 20 bytes or so)
for custom parameters, and also larger amounts (order of kilo bytes) 
for firmware image.
Seems like ALSA does not have build-in interfaces that can be 
directly used for these use cases right?
Will it be better to extend on ALSA or setup a separate path?

> > > > binary code image that goes into the chip's memory.
> 
> > > For this use request_firmware() and associated interfaces.
> 
> > Is it more common to load the firmware from the kernel space?
> > Is there an established mechanism for loading from user space?
> 
> Have you looked at request_firmware()?  It is the established mechanism
> for doing this and supports both firmware images built into the kernel
> and firmware loaded from userspace, though firmware in userspace is the
> more common approach.

Thanks, yes I see that it's a kernel space only feature, regardless 
of where the firmware image is located.
Would it be ok for a user space app to handle the image file directly
and send down the file content for the driver to process?
