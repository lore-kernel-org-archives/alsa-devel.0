From: Gregoire Favre <greg@magma.unil.ch>
Subject: SPDIF and alsa, does it works for all cards/receivers?
Date: Mon, 28 Jul 2003 13:57:25 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030728115725.GB21471@magma.unil.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello list ;-)

I have a "stupid" 5.1 system from Hercules which don't work perfectly in
the sense, that when I connect it to a SBlive with a coaxial connexion
it works (I can hear lots of noise, but my cable is very bad), my
receiver goes in Dolby Digital mode with Dolby Digital signal and go
back to Stereo mode without Dolby Digital signal: fine with SBlive.

Unfortunately, my motherboard has an integrated intel8x0 with optical
SPDIF, and I can't by any way play any Dolby Digital signal with it, I
can only hardly plays with the http://bitstreamout.sourceforge.net/
which forward the signal from DVB and sent it to the soundcard SPDIF,
then my receiver turns in Dolby Digital on Dolby Digital signal, and
stay in this mode even after the end of the Dolby Digital signal... and
then refuse to play anything at all???

And even worse: I have a Digital 7.1 card, with it I cannot put my
receiver in 5.1 at all???

I just copy an expert, Dr. Werner Fink, as he spoke in the
vdr@linuxtv.org mailing list about a problem with AC3overDVB:

"As long as the hardware on the DVB cards are not able to put
the 16bit none audio PCM data stream into a 32bit none audio
S/P-DIF transport stream all receivers which uses the bit flags
of the S/P-DIF transport stream for identifying none audio
loose.  All S/P-DIF data get from the DVB card to not have the
none audio bit set.  AFAIK this is a hardware bug (or better
this is the information I've got from TT) ..."

Is there such "limitation" with either my integrated intel8x0 or with
the cs46xx card or???

Or is it only ALSA limitation (for example, with the Digifire 7.1 it
works under windows...)?

	Gr=E9goire
__________________________________________________________________
http://www-ima.unil.ch/greg ICQ:16624071 mailto:greg@magma.unil.ch


-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
