From: Gregoire Favre <greg@magma.unil.ch>
Subject: Re: SPDIF and alsa, does it works for all cards/receivers?
Date: Mon, 28 Jul 2003 15:03:11 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030728130311.GB26829@magma.unil.ch>
References: <20030728115725.GB21471@magma.unil.ch> <3F251827.2030604@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <3F251827.2030604@superbug.demon.co.uk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: James Courtier-Dutton <James@superbug.demon.co.uk>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, Jul 28, 2003 at 01:33:43PM +0100, James Courtier-Dutton wrote:

> You are correct, SPDIF and alsa does NOT work with all cards and all=20
> receivers.
> Points to note: -
> 1) Does the receiver require "non-audio" bit to be set? Some do, some=20
> don't. My receiver does need it.

Yes, unfortunately it does!!!

> 2) Does the sound card set the "non-audio" bit correctly when outputtin=
g=20
> AC3 data. The SB Live does this correctly.

I think the cs46xx and the intel-8x0 don't (like my DVB card).

> 3) Does the sound card output data un-modified from the PC to the SPDIF=
=20
> socket. The SB Live does interpolation on the PCM samples from the PC,=20
> so that the samples comming out of the SPDIF are different from the PCM=
=20
> samples from the PC. This therefore corrupts the AC3 frame (crc checks=20
> are done on it by the receiver) and no sound is output. (Normal stereo=20
> sound works because the ear cannot tell the difference between=20
> interpolated samples and the original samples). The alsa programmers=20
> have done a special work around for the SB Live problem, using somethin=
g=20
> called the TRAM, in order to bypass the interpolators and get perfect=20
> AC3 output.

So, maybe I should consider using a SBlive (and buy a "good" cable for
it)!!!

> 4) Sample rates. Some audio cards can only work at 48Khz, or only at=20
> 44.1Khz, so outputting an AC3 signal from a DVD requires 48Khz, but=20
> outputting a AC3 signal from a CD requires 44.1khz. So, depending on=20
> where the media file with AC3 in it came from, it may or may not play.

I am not sure of the sample rate that come from the DVB source?

> It seems that SPDIF AC3 output is about the last feature that the alsa=20
> developers add when a new card is supported with alsa.
> As intel8x0 is used on so many different motherboards, alsa cannot hope=
=20
> to support them all. The important issue with intel8x0 is the type of=20
> ac97 chip used. If you run alsamixer, in the top left corner, it will=20
> have "Chip: ....". Which chip does you motherboard have.

I am not at home now, but according to
http://www.msi.com.tw/program/products/mainboard/mbd/pro_mbd_detail.php?U=
ID=3D311&MODEL=3DMS-6398E
I have a Realtek ALC650 6-channel audio

> All motherboards use different chips, and it is the programming of that=
=20
> chip that is required in order to set the "non-audio" bits.
> Summary: -
> Your problems are most likely to be (2) and (4).

I think (2) is the real one, because, a friend with the same Digifire
7.1 card and another receiver have perfekt 5.1 sound with his receiver.
Is there any hope for it to be solved?

It's not a real problem for me to use the SBlive or the Digifire 7.1 as
I don't really need the Firewire of the Digifire 7.1 ;-)

Thank you very much,

	Gr=E9goire
__________________________________________________________________
http://www-ima.unil.ch/greg ICQ:16624071 mailto:greg@magma.unil.ch


-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
