From: Cliff Cai <cliffcai.sh@gmail.com>
Subject: Re: [Device-drivers-devel] [PATCH] Add driver for
 Analog Devices ADAU1701 SigmaDSP
Date: Wed, 9 Mar 2011 15:39:03 +0800
Message-ID: <AANLkTikVjp1GJoAKKad7z+M_fyO1VzLTajKJP6ofWvtx@mail.gmail.com>
References: <1299460302-15392-1-git-send-email-cliff.cai@analog.com>
	<20110307114142.GB13471@opensource.wolfsonmicro.com>
	<AANLkTikynw7vCsqqyNZW-LFuGUKKQEtG3s4YCZjpOvko@mail.gmail.com>
	<20110307121502.GG13471@opensource.wolfsonmicro.com>
	<AANLkTinKpvgBokSHpsVf1KVX+m6sD0Xp_dFe8Y+HzY-7@mail.gmail.com>
	<20110307145931.GK13471@opensource.wolfsonmicro.com>
	<AANLkTi=e1xDz6fhBU7NL32DXL1J9Y1CDD2bHQVL6oASw@mail.gmail.com>
	<20110307155508.GM13471@opensource.wolfsonmicro.com>
	<AANLkTim6bQGKCuzAgxNS93LQkq2iqxjcCW49NBArafK1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 4FF5B103935
	for <alsa-devel@alsa-project.org>; Wed,  9 Mar 2011 08:39:04 +0100 (CET)
Received: by fxm11 with SMTP id 11so202382fxm.38
	for <alsa-devel@alsa-project.org>; Tue, 08 Mar 2011 23:39:04 -0800 (PST)
In-Reply-To: <AANLkTim6bQGKCuzAgxNS93LQkq2iqxjcCW49NBArafK1@mail.gmail.com>
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

On Wed, Mar 9, 2011 at 2:08 PM, Mike Frysinger <vapier.adi@gmail.com> wrote:
> On Mon, Mar 7, 2011 at 10:55, Mark Brown wrote:
>> On Mon, Mar 07, 2011 at 10:33:25AM -0500, Mike Frysinger wrote:
>>> On Mon, Mar 7, 2011 at 09:59, Mark Brown wrote:
>>> > I'd expect that the driver would at least error out if the user tried=
 to
>>> > do the wrong thing here, like I say currently the firmware code is ju=
st
>>> > not joined up with anything else at all.
>>
>>> i dont see how the driver can detect a "wrong" thing. =A0the driver has
>>> no idea what arbitrary code the user is going to load and what that
>>> code is going to do, or validate the code in any way. =A0this is why the
>>> firmware has a small crc header on it -- we only make sure that what
>>> the user compiled at build time matches what is loaded into the
>>> hardware.
>>
>> At a bare minimum suddenly stopping and starting the firmware while
>> audio is going through it is unlikely to work well (you'd most likely
>> get a hard stop of the audio followed by a sudden hard start which sound
>> very unpleasant to listeners) and so should be prevented. =A0There's a
>> bunch of options for doing this (including refusing to change, ensuring
>> the DSP output is muted during the change or routing around the DSP
>> while doing the change).
>
> you would probably get the "normal" clicks and pops, but i guess your
> view of "wrong" is much more strict than mine ;). =A0i'm not sure our
> parts allow routing around the DSP (Cliff would have to comment). =A0as
> for the rest, i think it'd be best to let the user space app dictate
> how they want to handle things. =A0perhaps clicks/pops are fine with
> them. =A0or they arent, and so the userspace app would make sure to
> pause/mute/whatever the stream. =A0either way, this sounds like a policy
> that shouldnt be hard coded in the codec driver.

again,this part is a DSP itself not an audio codec like adau1761 whose DSP
core can be bypassed.

>>> > systems) there's no reason they shouldn't be able to rely on standard
>>> > tools for managing their audio configurations.
>>
>>> if the standard tools existed today, i'd of course agree. =A0but as you
>>> indicated there's nothing right now for us to bug off of. =A0so how
>>> userspace "probes" for existing data would be however the end user
>>> chooses to manage things. =A0it's not like the standard tools could
>>> really provide anything other than a simple string that indicates
>>> "some blob exists with name xxx". =A0the meaning/metadata that surrounds
>>> xxx isnt really relevant from the kernel's pov.
>>
>> The standard tools should also be able to manage the mechanics of
>> actually getting the new data into the kernel at appropriate moments.
>> This includes both offering control via UIs such as alsamixer and being
>> able to include configuration of the data in UCM configurations.
>
> exposing this via alsamixer and friends would be a useful debugging
> tool so people can toy around with known working configurations. =A0and
> have code examples to see how to do it.
>
>>> > At present userspace can enumerate and change the runtime configurati=
on
>>> > the system offers via the ALSA APIs (and this will get even better on=
ce
>>> > the media controller API starts being used). =A0This means that you c=
an
>>> > fairly easily write a userspace that'll run on pretty much any Linux
>>> > audio hardware, adapting with pure configuration for which you can
>>> > provide point and click tuning (realistically by allowing the user to
>>> > configure via standard ALSA tools and offering a "save as use case" t=
ype
>>> > interface). =A0If we start adding backdoors to drivers we're taking a=
 step
>>> > back from where we are currently by requiring that the application la=
yer
>>> > know magic stuff about individual systems in order to work with them.
>>
>>> from how we've seen people using these codecs, this scenario doesnt
>>> make much sense. =A0the different algorithms would be loaded on the fly
>>> by the application and its current operating needs, not a single
>>> algorithm selected by the ender user that wouldnt change for the life
>>> of the app. =A0not saying the scenario would never come up, just that it
>>> isnt the one we'd be focused on.
>>
>> I'm not sure you're following what's being said here. =A0The above contr=
ol
>> discussed above full system configuration of all the control offered by
>> the system, not tuning the parameters of an individual algorithm. =A0This
>> includes volume controls, routing controls, algorithms, coefficients and
>> anything else that can be changed. =A0A scenario where you want to change
>> the set of algorithms the hardware can support is certainly included in
>> that.
>
> i just meant that the use cases we've been dealing with involve the
> people developing the application taking care of picking which
> firmwares to load at any particular time. =A0having the end user (the
> guy who buys the actual device) select firmwares doesnt make much
> sense. =A0but this particular qualification probably is irrelevant to
> the framework you're proposing in the end.
> -mike
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
