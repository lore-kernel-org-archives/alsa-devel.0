From: Nitin PAI <nitinmpai@gmail.com>
Subject: Re: ASOC - Codecs : Renaming of spdif_tranceiver.c
Date: Wed, 7 Mar 2012 19:45:24 +0530
Message-ID: <CAJDSjBhYdsxh+=LEfatCLrydSDm_KLCVqfptBkOBStNpZJgS4A@mail.gmail.com>
References: <CAJDSjBikNPj_EExz_XojUOT0c4ip8MG3kEf+dzbcW1s_73SbeA@mail.gmail.com>
	<20120307134310.GK3107@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
	[209.85.210.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 6DC4B24409
	for <alsa-devel@alsa-project.org>; Wed,  7 Mar 2012 15:15:25 +0100 (CET)
Received: by iakh37 with SMTP id h37so9252143iak.38
	for <alsa-devel@alsa-project.org>; Wed, 07 Mar 2012 06:15:24 -0800 (PST)
In-Reply-To: <20120307134310.GK3107@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, lrg@ti.comm, swarren@nvidia.com
List-Id: alsa-devel@alsa-project.org

Hi Mark,

The usecase for the DSP was specifically for automotive where there is no
power requirements and the audio functionality is always on.
The programming of the codecs usually from the userspace.  However ALSA is
used  for ease of using the alsalib for its various functions (applications
standpoint).

>>The CPU side drivers have no dependency on the CODEC drivers, these are
>>integrated by the machine.  The SoC vendor can easily ship drivers which
>>will work with any CODEC which works well on Linux.
The problem with just writing the machine driver and shipping it is,
without any codec driver the cards wont be enumerated.
Having a thin codec driver to enumerate the cards and ship it will help.
(from debug and development standpoint).

 >>Another option is to just embed all the data
>>structures in a single driver which binds to them all and selects the
>>right data structure based on the probe information, that might be
>>useful.
Are you suggesting to have this in the machine driver?  I didnt understand
this, please clarify.

Thanks,
Nitin

On Wed, Mar 7, 2012 at 7:13 PM, Mark Brown <
broonie@opensource.wolfsonmicro.com> wrote:

> On Wed, Mar 07, 2012 at 12:15:07PM +0530, Nitin PAI wrote:
>
> Adding a CC to Liam.  *ALWAYS* CC the maintainers on mails, I know you
> followed up adding Liam but you still missed me off.
>
> > In my project I am feeling of need to have generic_codec.  This will
> > provide the required codec_dais for the usecases like
>
> > -HDMI/SPDIF where there is no codec involved.
> > -For audio over MOST, where CPLD/glue logic is used
>
> These still need something to say what the capabilities of the device
> are - ideally users could just specify the part name and not worry about
> that stuff.  If you look at how thin the drivers are it's really not
> clear to me what we'd save here, though if someone did the work and it
> looked useful...  Another option is to just embed all the data
> structures in a single driver which binds to them all and selects the
> right data structure based on the probe information, that might be
> useful.
>
> > -For complex audio DSPs connected which will be mostly programmed in the
> > user-space.
>
> These will need in kernel drivers, if only to export the interfaces
> required by the application layer to userspace.  They'll also have
> difficulty integrating well with the power management without an in
> kernel representation of the device, especially for bypass cases like in
> call audio.
>
> > -SOC manufactures who would like to ship their drivers without having to
> > know what will be the final codec that will be present in the system.
>
> The CPU side drivers have no dependency on the CODEC drivers, these are
> integrated by the machine.  The SoC vendor can easily ship drivers which
> will work with any CODEC which works well on Linux.
>
> If you actually mean machine drivers it's not really possible to write a
> generic machine driver which will actually work for modern CODECs,
> especially those used in smartphones and tablets, the clocking
> architectures are far too varied and flexible for this to work usefully.
> This is before you get into things that are genuine hardware choices and
> need to be enumerated at runtime, and of course most modern devices will
> require software to power them on so you need to match them up with the
> relevant driver to do that.
>
> In general pluggable reference boards really need to have some means of
> identifying the connected boards if they want to support running with
> different setups without recompilation.  For example, the Wolfson
> reference systems have ID chips on each board which are queried during
> boot to allow us to instantiate things based on what's physically
> connected.  We can swap boards over and have a single system image boot
> successfully without software changes.
>
> > 4) Any other ideas ?
>
> I don't think you've fully thought through what you're suggesting, it
> doesn't seem practical for most things.
>



-- =

=93Karmanya vadhikaraste ma phaleshu kadachana Ma karma-phala-hetur bhu ma =
te
sango stav karmani=94           -  Krishna
