From: Gregoire Favre <greg@ulima.unil.ch>
Subject: Re: SPDIF and cs46xx ?
Date: Wed, 12 Mar 2003 12:50:24 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030312115024.GC22743@ulima.unil.ch>
References: <20030311233503.GF10785@ulima.unil.ch> <Pine.LNX.4.44.0303121151420.1592-100000@snylter.ii.uib.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0303121151420.1592-100000@snylter.ii.uib.no>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "Ronny V. Vindenes" <s864@lstud.ii.uib.no>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, Mar 12, 2003 at 12:08:45PM +0100, Ronny V. Vindenes wrote:

> The -R option tells ac3dec to decode the stream to a stereo pcm stream,=
=20
> you want to use -C or -P and not include -4/-6

;-)
OK, but I don't hear anything with -C or -P (with and without -4/-6), so
what do you suggest?


> I think you need to pass -ac hwac3 to mplayer to enable ac3 pass-thru

Great, I'll try tonight!!!

> I haven't tested the latest cs46xx driver but in rc7 something was wron=
g=20
> with the way it initalized spdif, that prevented my amplififer (denon=20
> avr1802) from recognising ac3 streams if input was set to spdif before=20
> playing a file. Starting a dvd in xine and after a couple of seconds=20
> turning the amplifier input to spdif would usually work fine.

Thank you very much for the hint, I will try that way!!!

	Gr=E9goire
________________________________________________________________
http://ulima.unil.ch/greg ICQ:16624071 mailto:greg@ulima.unil.ch


-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
