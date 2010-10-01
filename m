From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: user space control app driver interface for sound
	soc
Date: Thu, 30 Sep 2010 19:37:29 -0700
Message-ID: <20101001023728.GK4175@opensource.wolfsonmicro.com>
References: <20100929221826.GC31934@opensource.wolfsonmicro.com>
	<B2150E1E4418E1438554A300EA5040E40D46F2D9E9@ITSVLEX06.it.maxim-ic.internal>
	<20100930005850.GB4517@opensource.wolfsonmicro.com>
	<B2150E1E4418E1438554A300EA5040E40D46F92916@ITSVLEX06.it.maxim-ic.internal>
	<20100930203118.GA4175@opensource.wolfsonmicro.com>
	<B2150E1E4418E1438554A300EA5040E40D46F92A44@ITSVLEX06.it.maxim-ic.internal>
	<20100930220953.GF4175@opensource.wolfsonmicro.com>
	<B2150E1E4418E1438554A300EA5040E40D46F92A90@ITSVLEX06.it.maxim-ic.internal>
	<20100930233453.GH4175@opensource.wolfsonmicro.com>
	<B2150E1E4418E1438554A300EA5040E40D46F92B44@ITSVLEX06.it.maxim-ic.internal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 415791039AD
	for <alsa-devel@alsa-project.org>;
	Fri,  1 Oct 2010 04:37:14 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <B2150E1E4418E1438554A300EA5040E40D46F92B44@ITSVLEX06.it.maxim-ic.internal>
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

On Thu, Sep 30, 2010 at 06:56:58PM -0700, Peter Hsiang wrote:
> On Thu, Sep 30, 2010, Mark Brown wrote:

> > This would not be idiomatic for ALSA.  The particular interface to use
> > would depend on the volume of data being configured and the format it is
> > provided in.  If this is just for test and development purposes then
> > adding something to debugfs would be the normal thing.

> This will be intended for normal operation.
> The volume of data would be both small amounts (say 20 bytes or so)

That's still not really answering the questions about how and when the
values will be generated which are important here.

> for custom parameters, and also larger amounts (order of kilo bytes) 
> for firmware image.

For firmware there's request_firmware().

> Seems like ALSA does not have build-in interfaces that can be 
> directly used for these use cases right?
> Will it be better to extend on ALSA or setup a separate path?

It seems likely that the behaviour should have some sort of higher level
interface wrapped around it - for example, firmwares will add certain
features to the chip, coefficients will set the chip into a given mode.
Presenting these things uninterpreted to userspace would be really bad
for usability since they're not likely to be things that make sense to
users directly.

If the values are calculated ahead of time specifically for a given
system then platform data is probably the most appropriate way to get
the data into the driver.  If the values are very large then treating
them as a firmware image may be the best approach.  It really does
depend on what the things that need to be set do and where they come
from how they should be set.

> > Have you looked at request_firmware()?  It is the established mechanism
> > for doing this and supports both firmware images built into the kernel
> > and firmware loaded from userspace, though firmware in userspace is the
> > more common approach.

> Thanks, yes I see that it's a kernel space only feature, regardless 
> of where the firmware image is located.
> Would it be ok for a user space app to handle the image file directly
> and send down the file content for the driver to process?

With request_firmware() to userspace the firmware is loaded into the
kernel by a userspace application.
