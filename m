From: Joe Rayhawk <jrayhawk@fairlystable.org>
Subject: Re: BUG: USB audio discontinuities with 'UHCI:
 implement new semantics for URB_ISO_ASAP'
Date: Thu, 18 Apr 2013 14:23:52 -0700
Message-ID: <20130418212352.GA4454__42569.3163801499$1366617473$gmane$org@richardiv.omgwallhack.org>
References: <20130417183436.GA4381@richardiv.omgwallhack.org>
 <Pine.LNX.4.44L0.1304181241010.1525-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2941652082929484623=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <Pine.LNX.4.44L0.1304181241010.1525-100000@iolanthe.rowland.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tova-dev@tovacompany.com, linux-usb@vger.kernel.org, alsa-devel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--===============2941652082929484623==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tKW2IUtsqtDRztdT"
Content-Disposition: inline


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2013 at 12:42:00PM -0400, Alan Stern wrote:
> On Wed, 17 Apr 2013, Joe Rayhawk wrote:
> > Small buffer/period sizes on usb audio playback though UHCI works fine =
on v3.7 but causes audio discontinuities/delays on v3.8 and v3.9-rc7.
>
> Can you provide a usbmon trace showing the problems?  And maybe also a=20
> similar trace made under a 3.7 kernel, where the problem doesn't occur?

root@richardiv:~# uname -a; cat /sys/kernel/debug/usb/usbmon/6u & perl -e '=
print pack "H*", "00FF" x 2048' | aplay --period-size=3D48 -r 44100 -f S16_=
LE -c2 -D hw:1,0; kill %1
Linux richardiv 3.7-trunk-amd64 #1 SMP Debian 3.7.1-1~experimental.1 x86_64=
 GNU/Linux
[1] 4407
Playing raw data 'stdin' : Signed 16 bit Little Endian, Rate 44100 Hz, Ster=
eo
ffff880155fd2780 288949785 S Co:6:007:0 s 01 0b 0001 0001 0000 0
ffff880155fd2780 288951516 C Co:6:007:0 0 0
ffff88015593f3c0 288951743 S Co:6:007:0 s 22 01 0100 0001 0003 3 =3D 44ac00
ffff88015593f3c0 288952512 C Co:6:007:0 0 3 >
ffff88015593f3c0 288952551 S Ci:6:007:0 s a2 81 0100 0001 0003 3 <
ffff88015593f3c0 288953511 C Ci:6:007:0 0 3 =3D 44ac00
ffff8801549cc780 288953559 S Zo:6:007:1 -115:1:0 1 -18:0:176 176 =3D 000000=
00 00000000 00000000 00000000 00000000 00000000 00000000 00000000
ffff8801549cca80 288953569 S Zo:6:007:1 -115:1:0 1 -18:0:176 176 =3D 000000=
00 00000000 00000000 00000000 00000000 00000000 00000000 00000000
ffff8801549cc780 288964489 C Zo:6:007:1 0:1:217621:0 1 0:0:176 176 >
ffff8801549cc780 288964505 S Zo:6:007:1 -115:1:217621 1 -18:0:176 176 =3D 0=
0ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff
ffff8801549cca80 288965508 C Zo:6:007:1 0:1:217622:0 1 0:0:176 176 >
ffff8801549cca80 288965527 S Zo:6:007:1 -115:1:217622 1 -18:0:176 176 =3D 0=
0ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff
ffff8801549cc780 288966486 C Zo:6:007:1 0:1:217623:0 1 0:0:176 176 >
ffff8801549cc780 288966503 S Zo:6:007:1 -115:1:217623 1 -18:0:176 176 =3D 0=
0ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff
ffff8801549cca80 288967488 C Zo:6:007:1 0:1:217624:0 1 0:0:176 176 >
ffff8801549cca80 288967507 S Zo:6:007:1 -115:1:217624 1 -18:0:176 176 =3D 0=
0ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff
ffff8801549cc780 288968508 C Zo:6:007:1 0:1:217625:0 1 0:0:176 176 >
ffff8801549cc780 288968523 S Zo:6:007:1 -115:1:217625 1 -18:0:176 176 =3D 0=
0ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff
ffff8801549cca80 288969485 C Zo:6:007:1 0:1:217626:0 1 0:0:176 176 >
ffff8801549cca80 288969499 S Zo:6:007:1 -115:1:217626 1 -18:0:176 176 =3D 0=
0ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff
ffff8801549cc780 288970507 C Zo:6:007:1 0:1:217627:0 1 0:0:176 176 >
ffff8801549cc780 288970520 S Zo:6:007:1 -115:1:217627 1 -18:0:176 176 =3D 0=
0ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff
ffff8801549cca80 288971487 C Zo:6:007:1 0:1:217628:0 1 0:0:176 176 >
ffff8801549cca80 288971505 S Zo:6:007:1 -115:1:217628 1 -18:0:180 180 =3D 0=
0ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff
ffff8801549cc780 288972491 C Zo:6:007:1 0:1:217629:0 1 0:0:176 176 >
ffff8801549cc780 288972504 S Zo:6:007:1 -115:1:217629 1 -18:0:176 176 =3D 0=
0ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff
ffff8801549cca80 288973485 C Zo:6:007:1 0:1:217630:0 1 0:0:180 180 >
ffff8801549cca80 288973499 S Zo:6:007:1 -115:1:217630 1 -18:0:176 176 =3D 0=
0ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff
ffff8801549cc780 288974490 C Zo:6:007:1 0:1:217631:0 1 0:0:176 176 >
ffff8801549cc780 288974505 S Zo:6:007:1 -115:1:217631 1 -18:0:176 176 =3D 0=
0ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff
ffff8801549cca80 288975485 C Zo:6:007:1 0:1:217632:0 1 0:0:176 176 >
ffff8801549cca80 288975502 S Zo:6:007:1 -115:1:217632 1 -18:0:176 176 =3D 0=
0ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff
ffff8801549cc780 288976491 C Zo:6:007:1 0:1:217633:0 1 0:0:176 176 >
ffff8801549cc780 288976501 S Zo:6:007:1 -115:1:217633 1 -18:0:176 176 =3D 0=
0ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff
ffff8801549cca80 288977485 C Zo:6:007:1 0:1:217634:0 1 0:0:176 176 >
ffff8801549cca80 288977503 S Zo:6:007:1 -115:1:217634 1 -18:0:176 176 =3D 0=
0ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff
ffff8801549cc780 288978491 C Zo:6:007:1 0:1:217635:0 1 0:0:176 176 >
ffff8801549cc780 288978506 S Zo:6:007:1 -115:1:217635 1 -18:0:176 176 =3D 0=
0ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff
ffff8801549cca80 288979481 C Zo:6:007:1 0:1:217636:0 1 0:0:176 176 >
ffff8801549cca80 288979489 S Zo:6:007:1 -115:1:217636 1 -18:0:176 176 =3D 0=
0ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff
ffff8801549cc780 288980484 C Zo:6:007:1 0:1:217637:0 1 0:0:176 176 >
ffff8801549cc780 288980493 S Zo:6:007:1 -115:1:217637 1 -18:0:176 176 =3D 0=
0ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff
ffff8801549cca80 288981481 C Zo:6:007:1 0:1:217638:0 1 0:0:176 176 >
ffff8801549cca80 288981490 S Zo:6:007:1 -115:1:217638 1 -18:0:180 180 =3D 0=
0ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff
ffff8801549cc780 288982483 C Zo:6:007:1 0:1:217639:0 1 0:0:176 176 >
ffff8801549cc780 288982491 S Zo:6:007:1 -115:1:217639 1 -18:0:176 176 =3D 0=
0ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff
ffff8801549cca80 288983484 C Zo:6:007:1 0:1:217640:0 1 0:0:180 180 >
ffff8801549cca80 288983493 S Zo:6:007:1 -115:1:217640 1 -18:0:176 176 =3D 0=
0ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff
ffff8801549cc780 288984481 C Zo:6:007:1 0:1:217641:0 1 0:0:176 176 >
ffff8801549cc780 288984489 S Zo:6:007:1 -115:1:217641 1 -18:0:176 176 =3D 0=
0ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff
ffff8801549cca80 288985488 C Zo:6:007:1 0:1:217642:0 1 0:0:176 176 >
ffff8801549cca80 288985499 S Zo:6:007:1 -115:1:217642 1 -18:0:176 176 =3D 0=
0ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff
ffff8801549cc780 288986489 C Zo:6:007:1 0:1:217643:0 1 0:0:176 176 >
ffff8801549cc780 288986498 S Zo:6:007:1 -115:1:217643 1 -18:0:176 176 =3D 0=
0ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff
ffff8801549cca80 288987499 C Zo:6:007:1 0:1:217644:0 1 0:0:176 176 >
ffff8801549cca80 288987513 S Zo:6:007:1 -115:1:217644 1 -18:0:176 176 =3D 0=
0ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff
ffff8801549cc780 288988485 C Zo:6:007:1 -104:1:217645:0 1 0:0:176 176 >
ffff8801549cca80 288989499 C Zo:6:007:1 0:1:217646:0 1 0:0:176 176 >
ffff880150ffa9c0 288990672 S Co:6:007:0 s 01 0b 0000 0001 0000 0
ffff880150ffa9c0 288992510 C Co:6:007:0 0 0
root@richardiv:~# # Generated only opening and closing clicks

root@richardiv:~# uname -a; cat /sys/kernel/debug/usb/usbmon/4u & perl -e '=
print pack "H*", "00FF" x 2048' | aplay --period-size=3D48 -r 44100 -f S16_=
LE -c2 -D hw:1,0; kill %1
Linux richardiv 3.8-trunk-amd64 #1 SMP Debian 3.8-1~experimental.1 x86_64 G=
NU/Linux
[1] 4702
Playing raw data 'stdin' : Signed 16 bit Little Endian, Rate 44100 Hz, Ster=
eo
ffff880144da0680 3864218837 S Co:4:002:0 s 01 0b 0001 0001 0000 0
ffff880144da0680 3864219942 C Co:4:002:0 0 0
ffff880153b6cd40 3864220177 S Co:4:002:0 s 22 01 0100 0001 0003 3 =3D 44ac00
ffff880153b6cd40 3864220943 C Co:4:002:0 0 3 >
ffff880153b6cd40 3864221002 S Ci:4:002:0 s a2 81 0100 0001 0003 3 <
ffff880153b6cd40 3864221940 C Ci:4:002:0 0 3 =3D 44ac00
ffff880143c80d80 3864222054 S Zo:4:002:1 -115:1:0 1 -18:0:176 176 =3D 00000=
000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
ffff880143c80180 3864222066 S Zo:4:002:1 -115:1:0 1 -18:0:176 176 =3D 00000=
000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
ffff880143c80d80 3864232940 C Zo:4:002:1 0:1:1057125:0 1 0:0:176 176 >
ffff880143c80d80 3864232956 S Zo:4:002:1 -115:1:1057125 1 -18:0:176 176 =3D=
 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff
ffff880143c80180 3864233934 C Zo:4:002:1 0:1:1057126:0 1 0:0:176 176 >
ffff880143c80180 3864233955 S Zo:4:002:1 -115:1:1057126 1 -18:0:176 176 =3D=
 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff
ffff880143c80d80 3864235913 C Zo:4:002:1 0:1:1057128:0 1 0:0:176 176 >
ffff880143c80d80 3864235932 S Zo:4:002:1 -115:1:1057128 1 -18:0:176 176 =3D=
 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff
ffff880143c80180 3864236910 C Zo:4:002:1 0:1:1057129:0 1 0:0:176 176 >
ffff880143c80180 3864236927 S Zo:4:002:1 -115:1:1057129 1 -18:0:176 176 =3D=
 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff
ffff880143c80d80 3864238939 C Zo:4:002:1 0:1:1057131:0 1 0:0:176 176 >
ffff880143c80d80 3864238959 S Zo:4:002:1 -115:1:1057131 1 -18:0:176 176 =3D=
 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff
ffff880143c80180 3864239910 C Zo:4:002:1 0:1:1057132:0 1 0:0:176 176 >
ffff880143c80180 3864239926 S Zo:4:002:1 -115:1:1057132 1 -18:0:176 176 =3D=
 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff
ffff880143c80d80 3864241929 C Zo:4:002:1 0:1:1057134:0 1 0:0:176 176 >
ffff880143c80d80 3864241940 S Zo:4:002:1 -115:1:1057134 1 -18:0:176 176 =3D=
 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff
ffff880143c80180 3864242905 C Zo:4:002:1 0:1:1057135:0 1 0:0:176 176 >
ffff880143c80180 3864242913 S Zo:4:002:1 -115:1:1057135 1 -18:0:180 180 =3D=
 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff
ffff880143c80d80 3864244931 C Zo:4:002:1 0:1:1057137:0 1 0:0:176 176 >
ffff880143c80d80 3864244941 S Zo:4:002:1 -115:1:1057137 1 -18:0:176 176 =3D=
 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff
ffff880143c80180 3864245929 C Zo:4:002:1 0:1:1057138:0 1 0:0:180 180 >
ffff880143c80180 3864245938 S Zo:4:002:1 -115:1:1057138 1 -18:0:176 176 =3D=
 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff
ffff880143c80d80 3864247913 C Zo:4:002:1 0:1:1057140:0 1 0:0:176 176 >
ffff880143c80d80 3864247933 S Zo:4:002:1 -115:1:1057140 1 -18:0:176 176 =3D=
 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff
ffff880143c80180 3864248933 C Zo:4:002:1 0:1:1057141:0 1 0:0:176 176 >
ffff880143c80180 3864248945 S Zo:4:002:1 -115:1:1057141 1 -18:0:176 176 =3D=
 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff
ffff880143c80d80 3864250910 C Zo:4:002:1 0:1:1057143:0 1 0:0:176 176 >
ffff880143c80d80 3864250928 S Zo:4:002:1 -115:1:1057143 1 -18:0:176 176 =3D=
 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff
ffff880143c80180 3864251930 C Zo:4:002:1 0:1:1057144:0 1 0:0:176 176 >
ffff880143c80180 3864251945 S Zo:4:002:1 -115:1:1057144 1 -18:0:176 176 =3D=
 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff
ffff880143c80d80 3864253910 C Zo:4:002:1 0:1:1057146:0 1 0:0:176 176 >
ffff880143c80d80 3864253930 S Zo:4:002:1 -115:1:1057146 1 -18:0:176 176 =3D=
 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff
ffff880143c80180 3864254938 C Zo:4:002:1 0:1:1057147:0 1 0:0:176 176 >
ffff880143c80180 3864254948 S Zo:4:002:1 -115:1:1057147 1 -18:0:176 176 =3D=
 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff
ffff880143c80d80 3864256910 C Zo:4:002:1 0:1:1057149:0 1 0:0:176 176 >
ffff880143c80d80 3864256928 S Zo:4:002:1 -115:1:1057149 1 -18:0:176 176 =3D=
 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff
ffff880143c80180 3864257909 C Zo:4:002:1 0:1:1057150:0 1 0:0:176 176 >
ffff880143c80180 3864257926 S Zo:4:002:1 -115:1:1057150 1 -18:0:180 180 =3D=
 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff
ffff880143c80d80 3864259934 C Zo:4:002:1 0:1:1057152:0 1 0:0:176 176 >
ffff880143c80d80 3864259947 S Zo:4:002:1 -115:1:1057152 1 -18:0:176 176 =3D=
 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff
ffff880143c80180 3864260930 C Zo:4:002:1 0:1:1057153:0 1 0:0:180 180 >
ffff880143c80180 3864260941 S Zo:4:002:1 -115:1:1057153 1 -18:0:176 176 =3D=
 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff
ffff880143c80d80 3864262909 C Zo:4:002:1 0:1:1057155:0 1 0:0:176 176 >
ffff880143c80d80 3864262927 S Zo:4:002:1 -115:1:1057155 1 -18:0:176 176 =3D=
 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff
ffff880143c80180 3864263907 C Zo:4:002:1 0:1:1057156:0 1 0:0:176 176 >
ffff880143c80180 3864263924 S Zo:4:002:1 -115:1:1057156 1 -18:0:176 176 =3D=
 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff
ffff880143c80d80 3864265914 C Zo:4:002:1 0:1:1057158:0 1 0:0:176 176 >
ffff880143c80d80 3864265930 S Zo:4:002:1 -115:1:1057158 1 -18:0:176 176 =3D=
 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff
ffff880143c80180 3864266931 C Zo:4:002:1 0:1:1057159:0 1 0:0:176 176 >
ffff880143c80180 3864266949 S Zo:4:002:1 -115:1:1057159 1 -18:0:176 176 =3D=
 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff 00ff00ff
ffff880143c80d80 3864268912 C Zo:4:002:1 -104:1:1057161:1 1 -18:0:0 176 >
ffff880143c80180 3864269906 C Zo:4:002:1 0:1:1057162:0 1 0:0:176 176 >
ffff880154907ec0 3864273399 S Co:4:002:0 s 01 0b 0000 0001 0000 0
ffff880154907ec0 3864274911 C Co:4:002:0 0 0
root@richardiv:~# # generated tone due to high rate of discontinuities

Should I capture enumeration and setup, too?

--tKW2IUtsqtDRztdT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRcGRoAAoJEN+cO+D+7b7vDEAP/1qU+7herXd60F1+6t0HhaHy
LjJ0QWH35H4T/iDWL5GmS/RKlsMKBbgA7yOFZypwfhMGBlxl5O/xqzQNNFkddt0p
8SPWF/HpqBOLqWWovudjS1UcogWey8Qm1P1rrkBCFubrkPpoHH/WBiovkI/a9z9x
uaiLZ7MO4+XOgkzjbCfXcFo5mWVoyBqwTHDbdJ1ZU386X+1iD9WFLv2+NAM57iMe
vcV3oNMAwg0ziKbWiwzq/xPKLubTOz3dQcJ/tcyrpFlN+tZfj+wlBC7Wsxzn6Udp
T4eNXwhfh8kh95Yhl2wdzqsRZCMKa/iI/vpL5JpWYyvLXKN6aiUEjNoCBUlk/cGD
nLazJMlfrSvIqZ92H2KxmK31qM4XKDgtwC0SaSrJjdMnqBD3zJwckJU6ARYCmw5q
lkuSZsx36S1DsYcscoCIZc2rA132wLytbxyRhY1pXzBtHS8HnN1sGGC2BQ8dwY6H
iAd86lZp5otIcDi3xkJwvuF2RUwAAumF/Fdhtd0yRtKjx/XFlUOY25lJUqlzktOf
qIX50dgIPKmz9nRDIwjQ1B2M40h/QpsiUCmYWTzOn3ZhOw97texv+iiA2NeieEcz
ahoVSZLL43cwubXuAscDnGJr7ezsGzoBngXHNojm1+f+iGokwzYy6wgHow6+ADaQ
hagHQY9rlW4y5hivHYp0
=dBwz
-----END PGP SIGNATURE-----

--tKW2IUtsqtDRztdT--
--
To unsubscribe from this list: send the line "unsubscribe alsa-devel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html


--===============2941652082929484623==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2941652082929484623==--
