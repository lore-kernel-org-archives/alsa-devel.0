From: Gregoire Favre <greg@ulima.unil.ch>
Subject: Re: SPDIF and cs46xx ?
Date: Sat, 29 Mar 2003 15:20:36 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030329142035.GA16590@ulima.unil.ch>
References: <14a4584ea6cb4a6894e70d84e717abc6.peter599@gotnet.net> <3E75075E.7030401@cucumelo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <3E75075E.7030401@cucumelo.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Benny Sjostrand <gorm@cucumelo.org>
Cc: Peter Heatwole <peter599@gotnet.net>, alsa-devel@lists.sourceforge.net, werner@suse.de
List-Id: alsa-devel@alsa-project.org

On Mon, Mar 17, 2003 at 12:23:10AM +0100, Benny Sjostrand wrote:

> Sounds like your receiver don't detect the AC3 stream, and inteprets it
> like PCM instead. There can be many reasons why this hapen, right now I=
=20
> can mention:
> - The AC3 is altered in some how, DSP applies gain's, roundings, while=20
> procesing stream (operation that are audible while playing PCM, and=20
> probably improbes sound),  then when the data reach the receiver it's=20
> not detected as AC3 anymore. In the current cs46xx driver there's a=20
> special treatment for 48khz streams through IEC958, to prevent the DSP=20
> process the stream in any way.
> - The magic status bit's, I'm not sure if the current implementation in=
=20
> the cs46xx that
> set's the IEC958 is correct. I have not found any way to verify ...

And is there any hope of any enhancement?
I "need" the SPDIF of my Digifire 7.1 to be able to use the bitstreamout
plugin of VDR made by Dr. Werner Fink
(https://sourceforge.net/projects/bitstreamout/) because as he wrote the
SPDIF out of my DVB card is not "good":

"As long as the hardware on the DVB cards are not able to put
the 16bit none audio PCM data stream into a 32bit none audio
S/P-DIF transport stream all receivers which uses the bit flags
of the S/P-DIF transport stream for identifying none audio
loose.  All S/P-DIF data get from the DVB card to not have the
none audio bit set.  AFAIK this is a hardware bug (or better
this is the information I've got from TT) ..."

But when I try the plugin I got:

Mar 29 15:15:17 localhost vdr[9090]: S/P-DIF: Period size not available: =
Invalid argument
Mar 29 15:15:17 localhost vdr[9090]: S/P-DIF: unable to establish BitStre=
amOut for none audio PCM=20
Mar 29 15:15:17 localhost vdr[9090]: REPLAY: can't open spdif interface

I am using CVS of driver/lib/utils from yesterday...

Any suggestion?

Thank you very much,

	Gr=E9goire
________________________________________________________________
http://ulima.unil.ch/greg ICQ:16624071 mailto:greg@ulima.unil.ch


-------------------------------------------------------
This SF.net email is sponsored by:
The Definitive IT and Networking Event. Be There!
NetWorld+Interop Las Vegas 2003 -- Register today!
http://ads.sourceforge.net/cgi-bin/redirect.pl?keyn0001en
