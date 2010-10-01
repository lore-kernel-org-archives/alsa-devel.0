From: Peter Hsiang <Peter.Hsiang@maxim-ic.com>
Subject: Re: user space control app driver interface for sound
 soc
Date: Fri, 1 Oct 2010 14:57:28 -0700
Message-ID: <B2150E1E4418E1438554A300EA5040E40D46F92E39@ITSVLEX06.it.maxim-ic.internal>
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
	<20101001071233.GB20529@opensource.wolfsonmicro.com>
	<s5hr5gaqba8.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from antispam01.maxim-ic.com (antispam01.maxim-ic.com
	[205.153.101.182])
	by alsa0.perex.cz (Postfix) with ESMTP id 1160F103A35
	for <alsa-devel@alsa-project.org>;
	Fri,  1 Oct 2010 23:57:01 +0200 (CEST)
In-Reply-To: <s5hr5gaqba8.wl%tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

On Fri, Oct 01, 2010, Takashi Iwai wrote:
> At Fri, 1 Oct 2010 00:12:34 -0700, Mark Brown wrote:
> >
> > On Fri, Oct 01, 2010 at 08:56:25AM +0200, Clemens Ladisch wrote:
> >
> > > If the firmware isn't needed when initialzing the device, you can add
> > > some ioctl that makes the driver call request_firmware() (this basically
> > > assumes that the data is stored in a file with a known name), or just
> > > add some device that allows userspace to write data to the device (use
> > > this for dynamic data).

Thanks Clemens, Takashi and Mark for the good comments.
Does ALSA use ioctl to implement its ALSA control elements?
To add an ioctl entry, would one expand on an existing list of ioctls
in ALSA, or would it be a fresh set of open/read/write/ioctl 
implemented in the codec driver?

> >
> > This does rather depend on what the firmware does and why it needs to be
> > reloaded - it is very rare that one can just blindly reload the firmware
> > and frequently changing the firmware will affect the set of user tunable
> > features that can be offered to the application layer.  Joining
> > everything up in a way that avoids fragility typically means that the
> > driver will end up initiating all the requests based on higher level
> > requests from audio applications.
> 
> Such a thing wasn't so uncommon in the past, even ISA days; they
> weren't called as "firmware" at that time, though.
> The implementation really depends on the driver, i.e. how complex and
> how influential to the whole operation, as Mark repeatedly wrote :)

I agree too that it depends on a number of factors.
If it's dynamic, can't be computed ahead of time, and the combination 
is too large to be stored statically in a limited amount of RAM, 
then there is a valid need.
A build-in mechanism in the driver to handle dynamic info will also
enable the driver itself to function as part of the runtime solution
that produces the dynamic data, and also saves them to disk file, 
for example.

> 
> FWIW, if it's an EQ band coef data or such small and more-or-less safe
> data, you can create even a dedicated ALSA control element to
> read/write the byte array.  For example, SPDIF status bits are
> transferred in that way between the driver and the user-space.

Thanks this is good to know.
> 
> 
> Takashi
