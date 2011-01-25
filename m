From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [QUERY] Download calibration data to co-processor
Date: Tue, 25 Jan 2011 13:36:43 +0000
Message-ID: <20110125133643.GD31453__45753.881315659$1295962619$gmane$org@opensource.wolfsonmicro.com>
References: <4D3E6A0D.40308@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <4D3E6A0D.40308@codeaurora.org>
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

On Mon, Jan 24, 2011 at 10:13:33PM -0800, Patrick Lai wrote:

> co-processor under ALSA framework. I would like to know if there is
> already a precedent which handles this use case. I considered
> request_firmware() approach but there are few drawbacks to this
> approach.  The audio calibration data size can be substantial
> as number of audio use cases grows. It also requires co-processor

What we're doing for this currently is passing the configuration data in
platform data or via request_firmware()  (mostly using the latter for
larger data).  At the minute we're loading everything at startup rather
than on demand, with the drivers presenting an enum with the available
use cases if there's more than one.

> perform extensive parsing of data. Furthermore, host processor and
> co-processor need to establish common use case definitions so
> co-processor know what chunk of calibration data to apply in certain
> scenario such as device switch.

I don't understand the issue with either parsing cost or with listing
use cases - I'd expect that for multiple use cases the host processor
and (if required) the coprocessor would parse the set of use cases out
of the data (for many systems the coprocessor won't know anything about
use cases and they'll be managed by the host reprogramming coefficients
to switch), and I'd expect that either the format will be defined to
something readily usable or the host can do the required processing.
Could you elaborate on the issues here, it's possible I'm missing
something about the sort of data you're looking at?

> If there is no precedent, my idea is to apply calibration data
> through sysfs. After introduction of ASoC multi-component
> architecture, PCM stream created from dailink is registered as
> device. So, there is syfs entry for each dailink. If ALSA ASoC can
> provide API for drivers(platform/CPU) to register additional
> attributes to the PCM device, this approach gives user-space
> application the ability to push down new calibration as audio
> situation changes. I believe it's a viable solution to my problem
> and perhaps can be useful to other systems as well.

I'm not enthused about sysfs for this as it means applications end up
needing custom infrastructure for individual cards, or UCM needs to end
up integrating that anyway, so we'd have some issues at the application
level when writing generic code for multiple systems - we'd need support
for enumerating and understanding the available settings.  In terms of
actually loading the data it doesn't really offer anything that
request_firmware() doesn't except for a push interface and it's not got
the existing userspace infrastructure that request_firmware() does.

Thinking off the top of my head I think we're reasonably covered from
the point of view of actually injecting data already but we currently
don't have a way to add additional data at runtime (eg, when doing a
calibration run).  If we added a way for applications to say "I'd like
to add some new coefficients to this feature" then that would address
that aspect of things, I think?
