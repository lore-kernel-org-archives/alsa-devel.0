From: Jose Alberto Reguero <jareguero@telefonica.net>
Subject: Re: AC3 output problem with via82xx
Date: Fri, 5 Sep 2003 10:29:07 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200309051029.07130.jareguero@telefonica.net>
References: <200309041932.05033.jareguero@telefonica.net> <200309042301.35462.jareguero@telefonica.net> <3F57B36C.60108@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3F57B36C.60108@superbug.demon.co.uk>
Content-Disposition: inline
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

El Jueves, 4 de Septiembre de 2003 23:49, James Courtier-Dutton escribi=F3:
> lists.sourceforge.net
>
>
> Fecha:
> Ayer 23:49:32
>
> Jose Alberto Reguero wrote:
> > El Jueves, 4 de Septiembre de 2003 20:31, Takashi Iwai escribi=F3:
> >>At Thu, 4 Sep 2003 19:32:05 +0200,
> >>
> >>Jose Alberto Reguero wrote:
> >>>I have a problem with ogle 0.9.1 and alsa 0.9.6 with AC3 output.
> >>>My Sound card is VIA 8235 whith AC97 CODEC Realtek ALC650.
> >>>
> >>>ERROR[ogle_audio]: Unable to update the IEC958 control: No such file or
> >>>directory
> >>
> >>try cvs version.
> >>bunch of fixes for ALC650 have been done.
> >
> > With the cvs version don't work.
> >
> > Jose Alberto Reguero
>
> Can you try using xine (xine.sf.net) to play the DVD instead.
> It appears that AC3 passthru only works in native alsa mode, and does
> not work in OSS emulation mode.
> I don't know if ogle uses oss or alsa native mode, but I know that xine
> can do both, so you might have more luck with xine.
>
> Cheers
> James
>
Ogle uses alsa native mode.
I try xine but if i select a52_pass_through in setup audio there is not sou=
nd.

Thanks.

Jose Alberto Reguero



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
