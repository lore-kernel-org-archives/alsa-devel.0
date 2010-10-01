From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: user space control app driver interface for sound
 soc
Date: Fri, 1 Oct 2010 00:12:34 -0700
Message-ID: <20101001071233.GB20529@opensource.wolfsonmicro.com>
References: <20100930005850.GB4517@opensource.wolfsonmicro.com>
	<B2150E1E4418E1438554A300EA5040E40D46F92916@ITSVLEX06.it.maxim-ic.internal>
	<20100930203118.GA4175@opensource.wolfsonmicro.com>
	<B2150E1E4418E1438554A300EA5040E40D46F92A44@ITSVLEX06.it.maxim-ic.internal>
	<20100930220953.GF4175@opensource.wolfsonmicro.com>
	<B2150E1E4418E1438554A300EA5040E40D46F92A90@ITSVLEX06.it.maxim-ic.internal>
	<20100930233453.GH4175@opensource.wolfsonmicro.com>
	<B2150E1E4418E1438554A300EA5040E40D46F92B44@ITSVLEX06.it.maxim-ic.internal>
	<20101001023728.GK4175@opensource.wolfsonmicro.com>
	<4CA58619.2090408@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 9EE141039DA
	for <alsa-devel@alsa-project.org>;
	Fri,  1 Oct 2010 09:12:18 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4CA58619.2090408@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Peter Hsiang <Peter.Hsiang@maxim-ic.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Fri, Oct 01, 2010 at 08:56:25AM +0200, Clemens Ladisch wrote:

> If the firmware isn't needed when initialzing the device, you can add
> some ioctl that makes the driver call request_firmware() (this basically
> assumes that the data is stored in a file with a known name), or just
> add some device that allows userspace to write data to the device (use
> this for dynamic data).

This does rather depend on what the firmware does and why it needs to be
reloaded - it is very rare that one can just blindly reload the firmware
and frequently changing the firmware will affect the set of user tunable
features that can be offered to the application layer.  Joining
everything up in a way that avoids fragility typically means that the
driver will end up initiating all the requests based on higher level
requests from audio applications.
