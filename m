From: Mikael Magnusson <mikaelmagnusson@glocalnet.net>
Subject: Re: Packages to debian
Date: Thu, 22 Sep 2005 11:32:53 +0200
Message-ID: <20050922093253.GA11180@skinner.hem.za.org>
References: <18881116.1127352574262.JavaMail.tomcat@gaza>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <18881116.1127352574262.JavaMail.tomcat@gaza>
Sender: alsa-devel-admin@lists.sourceforge.net
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

On Wed, Sep 21, 2005 at 10:29:34PM -0300, Leomar-Costa@via-rs.net wrote:
> =A0Hi guys, =A0What packages I need install to make ALSA programs in de=
bian ?=A0I was trying to compile this example ( http://equalarea.com/paul=
/alsa-audio.html#playex ), but I give some errors.. I paste in the end of=
 this e-mail.=A0Are there some "apt-get install" that I can use ? Or I ne=
ed download and install from another place ? =A0Thanks a lot, =A0Leomar=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=A0# gcc -o play play.cplay.c: =
In function `main':play.c:44: warning: passing arg 3 of `snd_pcm_hw_param=
s_set_rate_near' makes pointer from integer without a cast/tmp/ccaeBi5f.o=
(.text+0x39): In function `main':: undefined reference to `snd_pcm_open'

You'll need to install the libasound2-dev package and link against the
asound library:

  gcc -o play play.cplay.c -lasound

/Mikael Magnusson



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server.=20
Download it for free - -and be entered to win a 42" plasma tv or your ver=
y
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
