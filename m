From: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
Subject: RE: CMI8768 patch
Date: Thu, 24 Feb 2005 04:20:22 +0000
Message-ID: <1109218822.1244.35.camel@bastov>
References: <92C0412E07F63549B2A2F2345D3DB515F7D65D@cm-msg-02.cmedia.com.tw>
Reply-To: sergio@sergiomb.no-ip.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <92C0412E07F63549B2A2F2345D3DB515F7D65D@cm-msg-02.cmedia.com.tw>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "\"Tien,  C.L. - =?UTF-8?Q?=E7=94=B0=E6=89=BF=E7=A6=AE=22?=" <cltien@cmedia.com.tw>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel <alsa-devel@lists.sourceforge.net>, t.schorpp@gmx.de
List-Id: alsa-devel@alsa-project.org

On Thu, 2005-02-24 at 06:50 +0800, "Tien, C.L. - =E7=94=B0=E6=89=BF=E7=A6=
=AE" wrote:
> Finally I got a clue.
> The FC3 install the alsa-lib (libasound.so.2.0.0) at /lib, while the al=
sa-cvs and alsa-lib-1.0.8
> install it in /usr/lib, no wonder the softvol cannot run with it! Final=
ly I get PCM volume
> appear. Thanks for your help and sorry that it took me so long to disco=
ver this.

yap very good tip, I link the old one to new one with this command :
ln -s /usr/lib/libasound.so.2.0.0 /lib/libasound.so.2.0.0 -f


The package gettext-devel.i386 is needed for cvscompile alsa-utils.


About my : C-Media CMI9761A

With this change above and compile ALSA from latest CVS, PCM and Master
volume appears !, PCM works great but master doesn't do nothing !=20

thanks,=20


>=20
> Sincerely,
> ChenLi Tien
>=20
> -----Original Message-----
> From:	Takashi Iwai [mailto:tiwai@suse.de]
> Sent:	2005/2/23 [=E6=98=9F=E6=9C=9F=E4=B8=89] =E4=B8=8A=E5=8D=88 05:42
> To:	Tien,  C.L. - =E7=94=B0=E6=89=BF=E7=A6=AE
> Cc:	alsa-devel@lists.sourceforge.net
> Subject:	Re: [Alsa-devel] CMI8768 patch
> At Wed, 23 Feb 2005 11:42:53 +0800,
> Tien, C.L. wrote:
> >=20
> > The message was created with alsa-lib-1.0.8 on RedHat 7.3 (kernel 2.4=
.26)
> > Now I switch to CVS on FC3. I found the result is opposite:
> >=20
> > alsa-lib-1.0.8+RH 7.3, front, rear can be used as -D option, while de=
fault shows the above message.
> >=20
> > alsa-lib CVS+FC3 it is ok to "aplay" directly or "aplay -D default", =
but either front or rear I got
> > ALSA lib pcm.c:1939:(snd_pcm_open_conf) Cannot open shared library /u=
sr/lib/alsa-lib/libasound_module_pcm_softvol.so
> > aplay: main:508: audio open error: No such file or directory
>=20
> It's weird.
> Please make sure that your cvs tree is all updated properly.
>=20
> > The libasound.so.2.0.0 is installed successfully and there is no /usr=
/lib/alsa-lib path
> > in my system (should I create?) Please help!
>=20
> /usr/lib/alsa-lib is the extra path for plugin shared objects.  The
> plugins alsa-plugins repository are installed there.  However, the
> standard plugins are included in libasound.so.  So, you don't need to
> create this directory at all.
>=20
> Just to be sure: your system is i386, not AMD64, right?
>=20
>=20
> Takashi

--=20
S=C3=A9rgio M.B.



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=3D6595&alloc_id=3D14396&op=3Dclick
