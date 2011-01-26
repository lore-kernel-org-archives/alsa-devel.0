From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [QUERY] Download calibration data to co-processor
Date: Wed, 26 Jan 2011 13:10:30 +0000
Message-ID: <20110126131022.GB5476__6489.2710805454$1296047428$gmane$org@opensource.wolfsonmicro.com>
References: <4D3E6A0D.40308@codeaurora.org>
	<20110125133643.GD31453@opensource.wolfsonmicro.com>
	<4D3FD43E.9090001@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <4D3FD43E.9090001@codeaurora.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: linux-arm-msm@vger.kernel.org, alsa-devel@vger.kernel.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Tue, Jan 25, 2011 at 11:58:54PM -0800, Patrick Lai wrote:
> On 1/25/2011 5:36 AM, Mark Brown wrote:

> >What we're doing for this currently is passing the configuration data in
> >platform data or via request_firmware()  (mostly using the latter for
> >larger data).  At the minute we're loading everything at startup rather
> >than on demand, with the drivers presenting an enum with the available
> >use cases if there's more than one.

> Can you point me to an example driver which does exactly what you

For the enum there's stuff like wm8904 for example.

> describe? Loading at startup is what I would like to avoid. That
> means
> calibration data for all use cases would be packed into single binary file.

You can load as many firmware files as you wish - there's no limits
there.  Note also that there's no requirement that the firmware be
dumped into the device directly.

> Parsing is not a big concern as the co-processor in question does
> parsing to some extend. The calibration binary contains coefficients
> for different features on the co-processor for a given playback or
> capture path. I would like to keep parsing based on features(i.e
> type of filter) supported on the co-processor but stay use case
> agnostic. A more concrete example would be reapplying calibration
> data for different device mode(speaker, headphone). In this case, if
> calibrations data for all devices is packed into single binary,
> host-processor and co-processor would need to maintain common device
> ID. When there is device switch, host-processor passes new device ID
> so co-processor know the right set of calibration to apply. As a
> device mode is constructed by connecting components in the CODEC
> through mixer commands, co-processor should also stay device-mode
> agnostic. That's why I believe push down model would work better
> based what I have stated above.

This sounds exactly like the sort of stuff we're already handling - the
device has no idea what the use cases are, it just gets its configuration
changed by the AP.  The device only ever sees a single use case setup at
once and has no idea what they mean, and it's up to the system integrator
to define the set that's available on any given device.

> >I'm not enthused about sysfs for this as it means applications end up
> >needing custom infrastructure for individual cards, or UCM needs to end
> >up integrating that anyway, so we'd have some issues at the application
> >level when writing generic code for multiple systems

> That's exactly why we need UCM, right? Though application request
> for headphone device, different system would have different set of
> mixer controls to construct headphone device. That's why I do not
> see why each DAI link cannot have its own unique attributes.

Having a way to inject the data is only a part of what's needed.  The
issue is that it's an API that applications including UCM don't know
about and won't be able to enumerate or otherwise work with unless we
teach them about it.  Applications here includes tools used to generate
use cases, the goal is that we'll have applications which understand
both the raw ALSA API and the UCM file format and can provide users with
tools for tuning use cases.

> we'd need support
> >for enumerating and understanding the available settings.  In terms of
> >actually loading the data it doesn't really offer anything that
> >request_firmware() doesn't except for a push interface and it's not got
> >the existing userspace infrastructure that request_firmware() does.

> Request_frmware() can accomplish my request but requires common
> device ID to be defined. If there is new use case with new device

I don't understand what you mean by a "common device ID"?

> defined, co-processor would have to be updated with new ID and it's
> not a scalable solution.

Could you explain this in more detail?  I don't understand why the
coprocessor needs to know about this and why anything it does need to
know can't come down via the same path as the coefficients themselves.
I think you've got an idea of the implementation of this that you're
thinking of here :)

>                          Another approach is to devise mixer command
> which passes name of calibration file. This command triggers
> request_firmware() being called with file name passed as parameter
> of the command. The caveat is, unless user-space application wants
> to extract calibration data for a device mode and save into file
> system at run-time, we would end up having numerous calibration
> files in the file system.

This sounds pretty much exactly what I suggest in the text you've quoted
below:

> >Thinking off the top of my head I think we're reasonably covered from
> >the point of view of actually injecting data already but we currently
> >don't have a way to add additional data at runtime (eg, when doing a
> >calibration run).  If we added a way for applications to say "I'd like
> >to add some new coefficients to this feature" then that would address
> >that aspect of things, I think?

As far as having many files in the filesystem goes that sounds like an
implementation issue which we should be able to address - off the top of
my head we could do something like having the driver load a file which
combines multiple use cases requested at system startup to seed things
and a tool that combines individual use case files into a pack but using
the unpacked format for on-demand addition of use cases.

Or it may just be that nobody has an issue with creating lots of files
so we don't need to worry; I'd be tempted to try that as a first pass.
