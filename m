From: Gregoire Favre <greg@ulima.unil.ch>
Subject: Re: SPDIF and cs46xx ?
Date: Sun, 30 Mar 2003 16:46:33 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030330144633.GA9474@ulima.unil.ch>
References: <14a4584ea6cb4a6894e70d84e717abc6.peter599@gotnet.net> <3E75075E.7030401@cucumelo.org> <20030329142035.GA16590@ulima.unil.ch> <3E864424.6060707@cucumelo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <3E864424.6060707@cucumelo.org>
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

On Sun, Mar 30, 2003 at 03:11:00AM +0200, Benny Sjostrand wrote:

> Seems like a user application problem to me.  The cs46xx driver just=20
> support a limited set of period-size configurations, that's a limitatio=
n=20
> in the HW. Then it's up to the application to handle it (I guess)
> I've managed to make AC3 and DTS through SPDIF work witth OGLE and Xine=
,=20
> I dont see any reason why it would'nt work with any other application,=20
> at least you should get further than: "S/P-DIF: Period size not=20
> available: Invalid argument" then when you've managed to open the devic=
e=20
> and write data to it maybe there will apear other unknown problems ...

Well, I think there are two problem, the first one is the limited set of
period-size configurations which the bitstream plugin should take care
of, but the real reason I repost what Dr. Werner Fink wrote in the
vdr@linuxtv.org mailing list was because he spoke exactly about a
problem we are a lots to have with the cs46xx driver :-(
Also found relative to DVB (AC3overDVB from Stefan Huelswitt,
http://www.muempf.de/down/vdr-1.1.26-AC3overDVB-0.1.4.diff.gz ) which
contains in the README.AC3overDVB:

If your receiver doesn't detect the encapsulated stream (at the
beginning of replay in general) you will hear the digital data played as
PCM data. It's a spiky noise. Don't turn up the volume too much, or the
speakers may be damaged. You have been warned!

And afterthat I post the answer from Dr. Werner Fink:

As long as the hardware on the DVB cards are not able to put
the 16bit none audio PCM data stream into a 32bit none audio
S/P-DIF transport stream all receivers which uses the bit flags=20
of the S/P-DIF transport stream for identifying none audio
loose.  All S/P-DIF data get from the DVB card to not have the
none audio bit set.  AFAIK this is a hardware bug (or better
this is the information I've got from TT) ...

And what I think is that we have exactly the same problem with the
cs46xx driver: I couldn't have a real 5.1 with any tools under linux and
cs46xx (ac3dec,ac3play,mplayer,xine), in fact I couldn't alsa hear the
sound from the CD using the SPDIF...

I think we need a fix for some receiver that don't detect the
encapsulated stream...

Thank you very much,

	Gr=E9goire
________________________________________________________________
http://ulima.unil.ch/greg ICQ:16624071 mailto:greg@ulima.unil.ch


-------------------------------------------------------
This SF.net email is sponsored by:
The Definitive IT and Networking Event. Be There!
NetWorld+Interop Las Vegas 2003 -- Register today!
http://ads.sourceforge.net/cgi-bin/redirect.pl?keyn0001en
