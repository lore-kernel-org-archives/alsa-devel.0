From: Eckhard Jokisch <e.jokisch@u-code.de>
Subject: Re: sbLive! -Drive digital IOs exchanged?
Date: Tue, 6 Jan 2004 12:22:56 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200401061222.56427.e.jokisch@u-code.de>
References: <200312242220.57516.e.jokisch@u-code.de> <s5h65fq2v0v.wl@alsa2.suse.de>
Reply-To: e.jokisch@u-code.de
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h65fq2v0v.wl@alsa2.suse.de>
Content-Description: clearsigned data
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

=2D----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Takashi Iwai wrote:
> At Wed, 24 Dec 2003 22:20:57 +0100,
>
> Eckhard Jokisch wrote:
> > Hello guys,
> > I just noticed that the controls ( or their names) of the digital inputs
> > of Live!-drive are changed. If I want ot get sound out of the coaxial
> > inputs I have to raise the optocal s "sliders" in alsamixer as well as =
in
> > alsermixergui.
>
> i don't see any changes of codes regarding this...
Hrrgl ... I knew the word "changed" will cause problems ;-)=20
I mean *swapped*.
> is only the capture switch swapped?
No - it's like that:
I connct my TC-electronics"M5000" with acoaxial cable to the front panel's=
=20
"Digital In" (that's S/PDIF right?). To hear something I have to lift up th=
e=20
fader for "IEC958 Optical". I didn't try yet the capture. And I remeber tha=
t=20
I had to lift "IEC958 Coaxial" fader when I once was recording something vi=
a=20
optical interface. If I had to use "IEC958coaxial capture" I don't remeber.=
=20
But as things tend to be easy I think the capture faders are swapped as wel=
l.
Actually I will get back my equipment this afternoon so I can test this aga=
in.=20

As I tok a short look in the code there seems to be an enum responsible for=
=20
the ordering of the names. Surely I could repair this piece of code but wnt=
ed=20
to be sure that's not only me having this problem.

> (to be sure, do you mean "IEC958 Optical Capture" and "IEC958 Coax
> Capture", right?)
=46or completeness: No - not just the captures.
>
>
> Takashi
Eckhard
=2D----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD4DBQE/+pqQiF9FD4kCbGQRAtJSAJ9CWhzTHUGjNXq80m1OgRl3dxZ9pQCXezeZ
/sJ+4PVd6t1o/scexAvJ7A=3D=3D
=3DGLgP
=2D----END PGP SIGNATURE-----



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
