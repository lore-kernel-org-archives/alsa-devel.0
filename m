From: Arve Knudsen <aknuds-1@broadpark.no>
Subject: Re: Query devices in a non-blocking fashion
Date: Sun, 07 Dec 2003 20:51:37 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <oprzttgbyxq1sf88@mail.broadpark.no>
References: <200312071919.hB7JJTNk004757@oud.linuxaudiosystems.com> <oprztsi6z7q1sf88@mail.broadpark.no> <Pine.LNX.4.58.0312072033450.20863@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.58.0312072033450.20863@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: Paul Davis <paul@linuxaudiosystems.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Sun, 7 Dec 2003 20:38:48 +0100 (CET), Jaroslav Kysela <perex@suse.cz>=20
wrote:

> On Sun, 7 Dec 2003, Arve Knudsen wrote:
>
>> On Sun, 07 Dec 2003 14:19:28 -0500, Paul Davis
>> <paul@linuxaudiosystems.com> wrote:
>>
>> >>>> I'd like to be able to query the capabilities (number of=20
>> channels,=3D20
>> >>>> buffer
>> >>>> size etc.) of ALSA devices in the system, even if they should be =
in
>> >>>> us=3D
>> >> e=3D20
>> >>>> by
>> >>>> some other process. The only current way to probe device=20
>> capabilities
>> >>>> =3D
>> >> is
>> >>>> to open a pcm, and use snd_pcm_hw_params, correct? At least this=20
>> is my
>> >>>> current approach, but I'd like to query the devices without first
>> >>>> acquiring exclusive access. If there is currently no way around=3D=
20
>> >>>> acquiring
>> >>>> a device for querying, maybe this requirement could be loosened i=
n=20
>> a
>> >>>> future version of ALSA?
>> >>>
>> >>> Nope. You ask for runtime information. This information can change=
=20
>> due
>> >>> various hardware contraints so we cannot give you an useful=20
>> information
>> >>> without blocking the device.
>> >>>
>> >>> Anyway, auto-probing for devices is a bad idea. Let user to choose=
=20
>> the
>> >>> device (hw:X,Y or plughw:X,Y or some "abstract" name in a dialog=20
>> box)
>> >>> yourself. The hw:X,Y numbers can be determined using the control A=
PI
>> >>> in=3D
>> >> a
>> >>> non-blocking way.
>> >> The user is allowed to choose between devices, but its also good to
>> >> be=3D20
>> >> able to display information about the different units. Like its=20
>> normal
>> >> in=3D
>> >> =3D20
>> >> Windows audio applications to choose between available devices in=20
>> the=3D20
>> >> system and their respective channels. Are you saying this is a bad
>> >> thing?
>> >
>> > its not a *bad* thing, but it is tricky to get it 100% correct. let =
me
>> > explain the kind of thing that is going on *at the moment*. the
>> > drivers i know best are the RME hdsp and digi9652. the number of
>> > channels one of these devices has depends on the sample rate you wan=
t
>> > to use it with. hence, its not possible to say unambigously "RME HDS=
P
>> > (26 channels)" because it might be "RME HDSP (12 channels)". in this
>> > particular case, you could consider this to be a detail: you should
>> > report the number of channels available at the current sample rate.=20
>> ok.
>> >
>> > however, there are other similar aspects of several cards that can't
>> > be finessed as easily as this; sample format, duplex behaviour, samp=
le
>> > rates etc. all end up being dependent on other aspects of the
>> > configuration you are asking about.
>> >
>> > i personally am heading towards believing that we made a design
>> > decision that was wrong here. i now tend to think that the PCM
>> > interface should not be involved with configuring the hardware at al=
l,
>> > and that this should be left to the control API. when you open the P=
CM
>> > device, you get whatever is currently configured. if that's not what
>> > you want, you open the control API first, configure the device, then
>> > open the PCM device. i think this would be much much simpler for
>> > most application programmers (not as simple as JACK, but ...) and it
>> > would also mirror what happens in the windows world to some extent,
>> > where control applets are used to change aspects of the card config.
>> >
>> > still, its pretty much too late for that.
>> Wow, this is somewhat along the lines of what I was thinking myself.
>> Although it didn't manifest itself as clearly. I am aware of the
>> Hammerfall problem, as its also somewhat painful in Windows. Logic
>> Audio never quite coped with it, from what I remember. But there
>> seems to be a separation between obtaining information about a card,
>> and actually acquiring it.
>>
>> Perhaps this could be refined in a future design of ALSA?
>
> We all think in the same way, but there's no simple solution for this
> problem. I prefer to have such configuration information in an user-spa=
ce
> database accessed via an alsa-lib API. It's nothing for the kernel spac=
e.

I dunno, I think Paul's thoughts sound sensible. Its not solved in a simp=
le
manner, but it was obviously solved somehow with other driver=20
architectures.
Will this database cope with runtime variables, such as the number of
channels with RME Hammerfall though (dependent on samplerate)?

Regards

Arve Knudsen


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
