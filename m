From: Arve Knudsen <aknuds-1@broadpark.no>
Subject: Re: [Alsa-devel][OT]Was: Query devices in a non-blocking fashion
Date: Mon, 08 Dec 2003 12:52:59 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <oprzu1ylxcq1sf88@mail.broadpark.no>
References: <200312071919.hB7JJTNk004757@oud.linuxaudiosystems.com> <oprztsi6z7q1sf88@mail.broadpark.no> <Pine.LNX.4.58.0312072033450.20863@pnote.perex-int.cz> <oprzttgbyxq1sf88@mail.broadpark.no> <Pine.LNX.4.58.0312072056170.20863@pnote.perex-int.cz> <oprztug9zgq1sf88@mail.broadpark.no> <20031208104945.GA22502@fliwatut.scifi> <oprzuzv9syq1sf88@mail.broadpark.no> <20031208113924.GB23208@fliwatut.scifi>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20031208113924.GB23208@fliwatut.scifi>
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

On Mon, 8 Dec 2003 12:39:25 +0100, Frank Barknecht <fbar@footils.org>=20
wrote:

> Hallo,
> Arve Knudsen hat gesagt: // Arve Knudsen wrote:
>
>> On Mon, 8 Dec 2003 11:49:45 +0100, Frank Barknecht <fbar@footils.org>
>> wrote:
>> >Which reminds me to ask: how does Portaudio currently cope with
>> >user-defined, not enumerable interfaces in ALSA?
>> Only concrete hardware devices are considered at the moment as far as =
I
>> can tell, that is, we enumerate based on snd_card_next. I'll have to
>> admit I never really got into the ALSA configuration system. I might
>> look into it later, once I'm happy with the basic functionality of the
>> implementation (getting there).
>
> Ah, that would be cool. I'm not really intimate with PortAudio, but my
> main application, Pure Data (not written by me ;), is using it in
> parallel to direct ALSA/JACK/OSS backends. The goal is, to switch to
> PA fully, but it would very annoying not to be able to select ALSA
> devices by name.
>
> Actually from a developer's perspective, ALSA's PCM configuration
> system is rather simple: Just use the name (char*) the user provides
> where you'd otherwise use something like "hw:0" or "default". The only
> problem is, that this is not enumarable. But not providing the
> possibility for a user, to specify a PCM name, is like trying to
> outsmart the user.
There is infrastructure support for custom stream info when opening a
stream, so it would be possible to pass a device string through this,
but it is unimplemented as of yet.

Regards

Arve Knudsen


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
