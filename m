From: Arve Knudsen <aknuds-1@broadpark.no>
Subject: Re: Query devices in a non-blocking fashion
Date: Sun, 07 Dec 2003 21:13:47 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <oprztug9zgq1sf88@mail.broadpark.no>
References: <200312071919.hB7JJTNk004757@oud.linuxaudiosystems.com> <oprztsi6z7q1sf88@mail.broadpark.no> <Pine.LNX.4.58.0312072033450.20863@pnote.perex-int.cz> <oprzttgbyxq1sf88@mail.broadpark.no> <Pine.LNX.4.58.0312072056170.20863@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.58.0312072056170.20863@pnote.perex-int.cz>
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

On Sun, 7 Dec 2003 21:00:13 +0100 (CET), Jaroslav Kysela <perex@suse.cz>=20
wrote:

> On Sun, 7 Dec 2003, Arve Knudsen wrote:
>
>> > We all think in the same way, but there's no simple solution for thi=
s
>> > problem. I prefer to have such configuration information in an=20
>> user-space
>> > database accessed via an alsa-lib API. It's nothing for the kernel=20
>> space.
>>
>> I dunno, I think Paul's thoughts sound sensible. Its not solved in a=20
>> simple
>> manner, but it was obviously solved somehow with other driver
>> architectures.
>
> With very little success when a complicated hardware is in the machine.
I can't remember having any real problems with this on Windows, or hearin=
g
about any such problems from others? There was the problem with Logic Aud=
io
not coping with Hammerfall's variable numberof channels, but I think othe=
r
  applications worked fine.

>> Will this database cope with runtime variables, such as the number of
>> channels with RME Hammerfall though (dependent on samplerate)?
>
> It depends on our goals and what we expect from this information. Can y=
ou
> describe your requirement (for what reason, you need this information?)=
.

I'm one of the developers responsible for the ALSA implementation of a=20
cross
platform audio wrapper called PortAudio (www.portaudio.com), which gather=
s
info about available devices during startup. Also, when using this librar=
y
myself, I would like to be able to display a list of devices/channels to
choose from (I normally use channels 17/18). Anyway, such information is
seemingly easily obtained with other driver architectures, any reason why
this shouldnt be available to Linux users (disregarding the implementatio=
n
issue)? Personally I see no reason to inhibit flexibility beyond what we
see as immediately useful.

Regards

Arve Knudsen




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
