From: "Krzysztof Helt" <krzysztof.h1@wp.pl>
Subject: Re: SB16 ISA max frequency bump to 48kHz
Date: Sat, 11 Nov 2006 15:34:11 +0100
Message-ID: <4555df637b95d@wp.pl>
References: <455420809a154@wp.pl> <s5hirhncyyl.wl%tiwai@suse.de>
	<4554961A.5070509@keyaccess.nl> <4555491E.8060800@keyaccess.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-reply-to: <455420809a154@wp.pl> <s5hirhncyyl.wl%tiwai@suse.de>
	<4554961A.5070509@keyaccess.nl> <4555491E.8060800@keyaccess.nl>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Rene Herman <rene.herman@keyaccess.nl>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Dnia 11-11-2006 o godz. 4:53 Rene Herman napisa=B3(a):
> =

> Confirmed. Although nothing complains with the proposed patch,
audio =

> sampled at 48000 just plays too slow. Not exactly 48000/44100
too slow =

> (a song that lasts 3:21 takes 3:33, which would be 45295) but
too slow.
> =


I must confirm the same. I tested it on CT2260, CT2890 and CT4500
and on all it plays slower that it should (3:55 instead of 3:42
which gives 46.7kHz - exactly the same on all three boards). I
used simple "time play file.wav" to check this.

In my defense, I used this "bump up" for years watching movies
and I never noticed the difference. Your finding my explain why
so many movies seemed slow paced too me ;-)

Please reject the patch.

Regards,
Krzysztof

----------------------------------------------------
Tegoroczne odkrycie TopTrendy - debiutancja p=B3yta Lidii "Intuicja"
http://klik.wp.pl/?adr=3Dhttp%3A%2F%2Fadv.reklama.wp.pl%2Fas%2Fd34.html&sid=
=3D928



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easi=
er
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=3D1=
21642
