From: Cliff Cai <cliffcai.sh@gmail.com>
Subject: Re: [Device-drivers-devel] [PATCH] Add driver for
 Analog Devices ADAU1701 SigmaDSP
Date: Wed, 9 Mar 2011 15:25:05 +0800
Message-ID: <AANLkTik=wEyCEY5xsrdGJw6t_VHH9ByKt4mX348P8uD7@mail.gmail.com>
References: <1299460302-15392-1-git-send-email-cliff.cai@analog.com>
	<20110307114142.GB13471@opensource.wolfsonmicro.com>
	<AANLkTikynw7vCsqqyNZW-LFuGUKKQEtG3s4YCZjpOvko@mail.gmail.com>
	<20110307121502.GG13471@opensource.wolfsonmicro.com>
	<AANLkTinKpvgBokSHpsVf1KVX+m6sD0Xp_dFe8Y+HzY-7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) by alsa0.perex.cz (Postfix) with ESMTP id 2F3982454E
	for <alsa-devel@alsa-project.org>; Wed,  9 Mar 2011 08:25:06 +0100 (CET)
Received: by fxm11 with SMTP id 11so194784fxm.38
	for <alsa-devel@alsa-project.org>; Tue, 08 Mar 2011 23:25:05 -0800 (PST)
In-Reply-To: <AANLkTinKpvgBokSHpsVf1KVX+m6sD0Xp_dFe8Y+HzY-7@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mike Frysinger <vapier.adi@gmail.com>
Cc: cliff.cai@analog.com, Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, device-drivers-devel@blackfin.uclinux.org, akpm@linux-foundation.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Mon, Mar 7, 2011 at 8:29 PM, Mike Frysinger <vapier.adi@gmail.com> wrote:
> On Mon, Mar 7, 2011 at 07:15, Mark Brown wrote:
>> On Mon, Mar 07, 2011 at 06:50:15AM -0500, Mike Frysinger wrote:
>>> On Mon, Mar 7, 2011 at 06:41, Mark Brown wrote:
>>> >=A0I can't apply this driver until it's merged into ASoC via some means
>>>
>>> and andrew has been holding off on merging the firmware driver until
>>> something in mainline needs it. =A0once a driver gets to the point where
>>> you're fine with merging it, we can bug akpm to push the sigma
>>> firmware loader to linus.
>>
>> It'd seem easier to just merge the two patches together rather than
>> trying to deal with cross-tree issues.
>
> that sounds like a terrible idea. =A0they're logically different
> changesets and we shouldnt be squashing them together simply to work
> around problems with process workflows.
>
>>> > More generally this doesn't seem like a great interface - apparently =
the
>>> > device requries that firmware be loaded but the whole firmware load
>>> > process isn't at all joined up with the driver code meaning that the
>>> > application layer has to figure out when firmware needs to be reloade=
d,
>>> > there's no understanding on the part of the driver of what the firmwa=
re
>>> > on the device is doing or how it's glued into the audio subsystem.
>>
>>> the API should allow for userspace to specify the firmware name, but
>>> that's about it. =A0it is up to the userspace application to arbitrarily
>>> load different firmware files on the fly into the codec without the
>>> codec caring what's going into it. =A0often times the firmware is DSP
>>> code to do different post processing on the audio stream (cleanup or
>>> whatever).
>>
>> Right, and this isn't a particularly unusual requirement especially if
>> the driver isn't going to have any ability to interact with the DSP (at
>> which point it's just coefficient data, the fact that it's a DSP program
>> is uninteresting). =A0The problem is that this isn't a great interface f=
or
>> doing that.
>
> i dont see suggestions of a better interface anywhere ...
>
>> At a really basic level the code is not at all integrated with either
>> power management or stream handling in ASoC meaning that the user could
>> try to download firmware in the middle of an active audio stream (which
>> isn't going to be ideal). =A0Obviously the driver doesn't really support
>> any kind of power management at the minute but if it were improved in
>> this area you'd also have issues with trying to download firmware while
>> the device is off which probably isn't going to work either.
>
> wrt pm, that's a trivial programming issue that would be resolved in
> the driver. =A0userspace need not care.
>
> wrt stream flows, all the customers we've talked to are fine with this
> -- having stream control be an application issue. =A0their application
> is driving the codec directly and knows when it needs to change the
> firmware, so it pauses its alsa flow, loads the new firmware, and
> moves on.
>
> that said, i dont see anything in asoc today to address this, so if
> we're simply missing it, please highlight it for us.
>
>> It's also not an interface which offers any kind of discoverability or
>> enumerability, meaning that it's not suitable for integration into
>> application layer code such as the use case manager. =A0Applications need
>> to be hard coded to know that a particular magic sysfs file needs to be
>> poked. =A0This would be a big step backwards in terms of the ability to
>> run off the shelf application software.
>
> i dont see the issue here. =A0the firmware is *optional* and does not
> impair basic audio output. =A0further, the firmware is fully
> written/compiled/maintained by the end customer, just like the
> application. =A0which means there is no "magic" here -- the end customer
> is the wizard.

it's a DSP,so firmware is not optional,actually there is default
internal program can be used
if no external firmware is downloaded,of cause, the internal program
is only used to test analog audio pass-through.

> there is no "stock" firmware that ADI or anyone provides for any of
> these SigmaDSP audio codecs.
> -mike
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
