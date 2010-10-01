From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: user space control app driver interface for sound
 soc
Date: Fri, 01 Oct 2010 08:56:25 +0200
Message-ID: <4CA58619.2090408@ladisch.de>
References: <20100929221826.GC31934@opensource.wolfsonmicro.com>	<B2150E1E4418E1438554A300EA5040E40D46F2D9E9@ITSVLEX06.it.maxim-ic.internal>	<20100930005850.GB4517@opensource.wolfsonmicro.com>	<B2150E1E4418E1438554A300EA5040E40D46F92916@ITSVLEX06.it.maxim-ic.internal>	<20100930203118.GA4175@opensource.wolfsonmicro.com>	<B2150E1E4418E1438554A300EA5040E40D46F92A44@ITSVLEX06.it.maxim-ic.internal>	<20100930220953.GF4175@opensource.wolfsonmicro.com>	<B2150E1E4418E1438554A300EA5040E40D46F92A90@ITSVLEX06.it.maxim-ic.internal>	<20100930233453.GH4175@opensource.wolfsonmicro.com>	<B2150E1E4418E1438554A300EA5040E40D46F92B44@ITSVLEX06.it.maxim-ic.internal>
	<20101001023728.GK4175@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5.smtp.messagingengine.com (out5.smtp.messagingengine.com
	[66.111.4.29]) by alsa0.perex.cz (Postfix) with ESMTP id A28A01039D3
	for <alsa-devel@alsa-project.org>;
	Fri,  1 Oct 2010 08:55:34 +0200 (CEST)
In-Reply-To: <20101001023728.GK4175@opensource.wolfsonmicro.com>
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
Cc: Peter Hsiang <Peter.Hsiang@maxim-ic.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:
> On Thu, Sep 30, 2010 at 06:56:58PM -0700, Peter Hsiang wrote:
> > On Thu, Sep 30, 2010, Mark Brown wrote:
> > > Have you looked at request_firmware()?  It is the established mechanism
> > > for doing this and supports both firmware images built into the kernel
> > > and firmware loaded from userspace, though firmware in userspace is the
> > > more common approach.
> > 
> > Thanks, yes I see that it's a kernel space only feature, regardless
> > of where the firmware image is located.
> > Would it be ok for a user space app to handle the image file directly
> > and send down the file content for the driver to process?
> 
> With request_firmware() to userspace the firmware is loaded into the
> kernel by a userspace application.

request_firmware() is used to get the firmware data into the driver, but
it assumes that the driver decides when to ask for it.

If the firmware isn't needed when initialzing the device, you can add
some ioctl that makes the driver call request_firmware() (this basically
assumes that the data is stored in a file with a known name), or just
add some device that allows userspace to write data to the device (use
this for dynamic data).


Regards,
Clemens
