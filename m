From: Arve Knudsen <aknuds-1@broadpark.no>
Subject: Re: Query devices in a non-blocking fashion
Date: Sun, 07 Dec 2003 19:56:38 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <oprztqwoi4q1sf88@mail.broadpark.no>
References: <oprztlvdeyq1sf88@mail.broadpark.no> <Pine.LNX.4.58.0312071936320.20863@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.58.0312071936320.20863@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Sun, 7 Dec 2003 19:40:23 +0100 (CET), Jaroslav Kysela <perex@suse.cz>=20
wrote:

> On Sun, 7 Dec 2003, Arve Knudsen wrote:
>
>> I'd like to be able to query the capabilities (number of channels,=20
>> buffer
>> size etc.) of ALSA devices in the system, even if they should be in us=
e=20
>> by
>> some other process. The only current way to probe device capabilities =
is
>> to open a pcm, and use snd_pcm_hw_params, correct? At least this is my
>> current approach, but I'd like to query the devices without first
>> acquiring exclusive access. If there is currently no way around=20
>> acquiring
>> a device for querying, maybe this requirement could be loosened in a
>> future version of ALSA?
>
> Nope. You ask for runtime information. This information can change due
> various hardware contraints so we cannot give you an useful information
> without blocking the device.
>
> Anyway, auto-probing for devices is a bad idea. Let user to choose the
> device (hw:X,Y or plughw:X,Y or some "abstract" name in a dialog box)
> yourself. The hw:X,Y numbers can be determined using the control API in=
 a
> non-blocking way.
The user is allowed to choose between devices, but its also good to be=20
able to display information about the different units. Like its normal in=
=20
Windows audio applications to choose between available devices in the=20
system and their respective channels. Are you saying this is a bad thing?

> I think that we should provide the list of devices with a description v=
ia
> some interface in alsa-lib.
Isn't this pretty much what I'm asking for? I don't care how its done, I=20
would just like to obtain available information in some civilized manner=20
(so I can gather info during initialization) :) Speaking of information, =
I=20
wouldn't mind some info from each driver about supported period sizes,=20
like ASIO has a way of obtaining buffer granularity I think. Could be=20
useful for determining a common period size if a full-duplex stream=20
consists of two different devices.

Regards

Arve Knudsen


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
