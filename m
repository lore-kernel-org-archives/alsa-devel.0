From: =?ISO-8859-1?Q?Erik_Inge_Bols=F8?= <knan@mo.himolde.no>
Subject: RE: ymfpci : four speakers with OSS-emulation ?
Date: Wed, 13 Mar 2002 15:34:58 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0203131529440.25085-100000@yme.mo.himolde.no>
References: <Pine.LNX.4.10.10203130852530.10486-100000@sorrow.ashke.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Received: from yme.mo.himolde.no (qmailr@[158.38.74.10])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with SMTP id PAA07530
	for <alsa-devel@alsa-project.org>; Wed, 13 Mar 2002 15:30:24 +0100
In-Reply-To: <Pine.LNX.4.10.10203130852530.10486-100000@sorrow.ashke.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Adam K Kirchhoff <adamk@voicenet.com>
Cc: James Courtier-Dutton <James@superbug.demon.co.uk>, Xavier ALLAMIGEON <xavier.allamigeon@libertysurf.fr>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, 13 Mar 2002, Adam K Kirchhoff wrote:
>Well, the ymfpci driver (with native Alsa support) only uses the front
>speakers by default, unless the application (ie. aplay, alsaplayer) is
>told the use the rear speakers. In either case, you can still only get
>output on either the front or the rear :-)  So rewriting the application
>wouldn't necessarily solve the problem.

Having fun with the a type =3D multi pcm on top of hw:0,0 and hw:0,2, the=
n a
type =3D plug pcm with route_policy =3D copy parameter on top of that and=
 the
aoss wrapper on top of that again should also do the trick, I imagine.

--
Erik I. Bols=F8 | email: <knan at mo.himolde.no>
The UNIX philosophy basically involves giving you enough rope to
hang yourself.  And then a couple of feet more, just to be sure.



_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
