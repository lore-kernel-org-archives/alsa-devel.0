From: Tim Blechmann <tim@klingt.org>
Subject: Re: hdspmixer broken for 96khz
Date: Mon, 4 Apr 2011 10:05:58 +0200
Message-ID: <201104041005.58890.tim@klingt.org>
References: <in74oi$qce$1@dough.gmane.org> <201104031139.41395.tim@klingt.org>
	<s5hr59imoqt.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2334705482625889972=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from klingt.org (mail.klingt.org [86.59.21.178])
	by alsa0.perex.cz (Postfix) with ESMTP id E36311038F7
	for <alsa-devel@alsa-project.org>;
	Mon,  4 Apr 2011 10:06:10 +0200 (CEST)
In-Reply-To: <s5hr59imoqt.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Adrian Knoth <adi@drcomp.erfurt.thur.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--===============2334705482625889972==
Content-Type: multipart/signed;
  boundary="nextPart1993367.fbr5P7kPoi";
  protocol="application/pgp-signature";
  micalg=pgp-sha256
Content-Transfer-Encoding: 7bit

--nextPart1993367.fbr5P7kPoi
Content-Type: multipart/mixed;
  boundary="Boundary-01=_mvXmNMeyOwKGWIy"
Content-Transfer-Encoding: 7bit


--Boundary-01=_mvXmNMeyOwKGWIy
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

> > > > the updated hdspmixer doesn't work for 96khz any more. the 44.1/48
> > > > khz versions are drawn correctly, the 88.2/96 khz version hides all
> > > > controls, so just the menu is visible.
> > >=20
> > > I've seen "both", a *working* hdspmixer at 96k and all hidden control=
s.
> > > The latter could be caused by wrongly initialized or restored presets.
> > >=20
> > > Can you try to activate the controls in the View menu again? Maybe ev=
en
> > > the shortcuts work: I for Input section, P for Playback and O for
> >=20
> > ok, after removing my old hdspmixer configuration file, it seems to wor=
k.
> > would be good to have a more robust behavior, since the current behavior
> > is quite confusing and people may have rather complex mixer setups,
> > which they would need to regenerate.
>=20
> Any chance to recover the old broken configuration?
> Then we can track down the bug.

attached

tim

=2D-=20
tim@klingt.org
http://tim.klingt.org

I don't write music for sissy ears.
  Charles Ives

--Boundary-01=_mvXmNMeyOwKGWIy
Content-Type: application/zip;
  name="hhdsp.mix.zip"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="hhdsp.mix.zip"

UEsDBBQAAAAIAIc7R/wH2OBmgQ4AAO3IEQAJAAAAaGhkc3AubWl47d0/juTGFQfgHo1kbagjOHTq
zAdwsIkBA04UKFDiwKkDw8dx6GP1MRzaBYEQXWiy+aeqWI/1fQCxxMxsP76pxU53/eY1v/7xL3/+
09/++de///Yfv39E8vXz8fj5f8ePn68//9PCx3Ppy75++3g8H9uOUs7UK917JO96W/v8R3b+n0es
dS/dezRr/a197pvs/MtHrHVPSvYe0VKPa71/Zuc/fBNv3ZNSvUf1qs+13r/NzqP9fJ8r0Xtkea9r
vX+XnUde9+Rs79HN+13r/TfZefR1T870fgdTz2u9f5+d32Hdk6O930Xqe633L9n5XdY9OdL7qLbu
c9zRyL0DjOZjdrRU+mfNUm6xt176PtR+7vfqWs7UK917TTWeY/x8cB97/m8+bWX+q/Jebul1T0r2
XlONdS+VX/w74LqX7L2mWq8pSuQX0f6fX3vctY8nr3qvqeZryd6zm1rrvvTYPWU3tfcQes5uaq77
q8fvKbtpsXfUa3ZTe93zGj1lN632DHvMblqs+7xOT9lNy73i3rKbVus+1ZLdbDNyfjFy7wCjqZHd
bPk5UvJnTel6Z577Hb2W1vWWnH3ud2YWpHW9fPbk7HP+I9fSut7kVe9nHc0TWtfL84sSr/X2Xkvr
epNXvZdwJE9oXa9WdrPnWlrXm9TMbvbmCa3r1cxutl5L63qT2tnNnjyhdb3a2c2Wayldb/5cPa83
ffzzsfycvkWmszVnaF2vRabz7lpa15u0ynS25Ayt632fndfa21+7ltb1Jq96r+VdztC6XstMZ+la
WtebyHR+NXKuMXLvAKMZOdNZ6nmETGet9zMiZDof2Z/T+QiZzlrvZ/We6Uw9j5jprPVeQs+Zznyv
8zE7HyHTWeu9lF4znan3ETOdtd5L6jHTmXq/Y6bzrt5a76X1lt1MvY+Y3az1XkNP2c3U+/ezj6Xz
EbKbtd5r6SW7mXofMbtZ631UI+cXI/cOMJql7CbS7RFqZEXPjUcpR+u1zsl6cyYryvOL5LnxKOVM
vdK9R3M0K8rzi+S58SjlbL2SvUd0JCvK84vkufEopUS9Ur1HdXYmJXluPEopVa9E75GdmcdJnhuP
UkrWO9t7dEdnT5LnxqOU0vXO9H4HR2ZPkufGo5Qa9Y72fhd7Z0+S58ajlFr1jvQOQP+m/9qj7sHR
n6vuj1PSlr3tPblGpHsj1ug9knd723tyjUjrnpTuPZq1ve09uUa0dU9K9h7R0t72nlwj4ronpXqP
6tXe9p5cI+q6JyV6jyzf296Ta0Re9+Rs79HN97b35BrR1z050/sdTH3vyTXusO7J0d7vYm+ukb72
+Yi/7smR3keldwBG8JEdLX6no/TPmUjZzdJ1HK0XKbup8fwiSnZTet3XHnP6XC/ZTa3nlRGymxrr
vva4PWU3NV9P9J7d1Fr3pcfuKbup/Tqy5+ym5rq/evyespsW+we9Zje11z2v0VN202rfqMfspsW6
z+v0lN203C/sLbtpte5TrZ6ym9b7xHvzi7us+1Rvb++jGjm/GLl3gNFckd0kJX/WbHmsV1+z9H5S
tX9f69W1HK1Xo/earsjtcvN7wczPI6370uO9+/xa7zVdkdvl5veCmZ9HW/elx1z73FrvNV2R2+Xy
e35P5xHXfelxlz6+1ntNV+R2ufm9YObnV6z7ZPpU6ffuLPE9qemKPC83v0fM/Dzq/wNLj7+395qu
yPNy83vEzM+jr3teY2/vNV2R5+Xm94iZn99h3ed19vZe0xV5Xm5+j5j5+V3Wfaq1t/dRjZxrjNw7
wGjucH8cAAAAAACAu8jncQAAAAAARpDPzgP0TqYDAAAAAADQD9kNAAAAAABAP2Q3AIzO7DwAAAAA
Ech0AAAAAAAA+iG7AQAAAKBHZucB4P/JdAAAAAAAAPohuwEAAAAAAOiH7Abondl5AAAAAACZDgAA
AAAAQE9kNwAAAMARZucBANqS6QAAAAAAAPRDdgMAAAAAANAP2Q1nmZ0HAAAAAID6ZDoAAAAAAAD9
uEt28/Xz8fj585c/5376fP31S9KXf/328Xg+1o/SztQr3XskSz1u6f0jO//dR6x1L917NK/63NL7
N9n5H4Kte1Ky94jyXrf0/pmd//xNvHVPSvUe1bzfLb1/m51H+/k+V6L3yKaet/T+XXYeed2Ts71H
l/re0vtvsvPo656c6X3O7Pz+10V3MnLvAAB31TrPqfWc8scT+9tz6ftQ6zXg2rWcqVe69xpqvpZ4
1f/eXCNtcX6ptMdba92Tkr3XUPs1ZN7/3lwjffkPAdc9KdV7DbXXvUSu8eUz5rqX6r2GFntGvWY6
tdc9r9FTptNqr7DHTKfFus/r9JTptNwj7i3TabXuU60Smc5IRs4vRu4dAOCuamQ3a88bazynLF3v
zGu9o9fSut6Ss6/1zsyItK6Xz6ScfY1/5Fpa15u86v2sozMirevlMykl9nb2XkvrepNXvZdwJE9o
XS/PL0rt6e25ltb1Jq96L2VvntC6Xs3sZuu1tK43qZ3d7MkTWternd1suZbW9SYtsputeULrei2y
m3fX0rreRHbzq5Hzi5F7BwCI6ujs/MiZzlLPI2Q6a72fESHT+cj+nM5HyHTWej+r90xn6nnETGet
9xJ6znSm3kfMdNZ6L6XXTGfqfcRMZ633knrMdKbeR8x01novrbdMZ+p9xExnrfdRjZxrjNw7AMBd
LWU3kd4/uUZW9HxzlHa0XuucrDclZ1KS55ujtDP1SvceTamZlOT55ijtbL2SvUdUYiYleb45SitR
r1TvUZ2dSUmeb47SStUr0XtkZ2ZSkuebo7SS9c72Ht3RmZTk+eYorXS9M70DAADxtb4PTg1re9hH
8otI90Kt0XskS3vYR/KLSOuelO49mld72Efyi2jrnpTsPaJ8D/tIfhFx3ZNSvUc138M+kl9EXfek
RO+RTX0fyS96X/eppb3Pxc9+T6I7mmukv/N89PvvYYszvY9K7wAA3MlHdtT8Ha4r3k+rl0zn3XUc
rRch07ni/bR6yXRqrfvSY/eU6Vzxflq9ZDo11/3V4/eU6Vzxflq9ZDq11z2v0VOmc8X7afWS6bRY
93mdnjKdK95Pq5dMp9W6T7V6ym5a7w8fzS+ir/tU72jvoxo5vxi5dwCAu2qZ3SQ1nlMefT+xpfeT
qvV7m2vXcrRejd5ruCK3WzK/F8z8PNK6rz3u0d5ruCK3WzK/F8z8PNq6Lz320d5ruCK3WzK/F8z8
POK6v3r8o73XcEVut2R+L5j5edR1z2sc7b2GK3K7JfN7wczPI6/7vM7R3mu4IrdbMr8XzPw8+rpP
tY72PqqR84uReweAWo7OzkNtd7g/DgAAAAAAwF3k8zgAAAAAAABcR3YDAPCa2XkAAACgJzIdAAAA
AACAfshuAAAAAIBIzM4Do5LpAAAAAAAA9EN2AwAAAAAA0A/ZDQBRmZ0HAAAAYCQyHQAAAAAAgH7I
bgAAAAAoyew8ANQh0wEAAAAAAOiH7AYAAAAAAKAfshugFrPzAAAAAADlyHQAAAAAAAD6IbsBAACA
sZidBwCISaYDAAAAAADQD9kNAAAAAABAP2Q34zI7DwAAAAAAcch0AAAAAAAA+iG7AQAA6IvZeQAA
4BWZDgAAAAAAQD9kNwAAAAAAAO9dPTsv0wEAAAAAAOiH7AYAAAAAAKAfshsAANjn6tl5AAAAxiTT
AQAAAAAA6IfsBgAAAACAOzA7z93JdAAAAAAAAPohuwEAAAAAAOiH7AYAuBuz8wAAAMAdyXQAAAAA
AAD6IbsBAAAAAFowOw9wjkwHAAAAAACgH7IbAAAAAACAfshuAGjN7DwAAAAA7CfTAQAAAAAA6Ifs
BgAAAIDE7DwA9E2mAwAAAAAA0A/ZDQAAAAAAQD9kN0DO7DwAAAAAQH9kOgAAAAAAAAAAAAC/2Pp7
lWbnAQAAAAAAAAAAAAAAAAAA6JXZeQAAAAAAAAAAAAAAAAAAAKIzOw8AAAAAAAAAAAAAAAAAAEB0
ZucBAAAAAAAAAAAAAAAAAACIzuw8AAAAAAAAAAAAAAAAAAAA0ZmdBwAAAAAAAAAAAAAAAAAAIDqz
8wAAAAAAAAAAAAAAAAAAAERndh4AAAAAAAAAAAAAAAAAAIDozM4DAAAAAAAAAAAAAAAAAAAQndl5
AAAAAAAAAAAAAAAAAAAAojM7DwAAAAAAAAAAAAAAAAAAQHRm5wEAAAAAAAAAAAAAAAAAAIjO7DwA
AAAAAAAAAAAAAAAAAADRmZ0HAAAAAAAAAAAAAAAAAAAgOrPzAAAAAAAAAAAAAAAAAAAARGd2HgAA
AAAAAAAAAAAAAAAAgOjMzgMAAAAAAAAAAAAAAAAAABCd2XkAAAAAAAAAAAAAAAAAAACiMzsPAAAA
AAAAAAAAAAAAAABAdGbnAQAAAAAAAAAAAAAAAAAAiM7sPAAAAAAAAAAAAAAAAAAAANGZnQcAAAAA
AAAAAAAAAAAAACA6s/MAAAAAAAAAAAAAAAAAAABEZ3YeAAAAAAAAAAAAAAAAAACA6MzOAwAAAAAA
AAAAAAAAAAAAEJ3ZeQAAAAAAAAAAAAAAAAAAAKIzOw8AAAAAAAAAAAAAAAAAAEB0ZucBAAAAAAAA
AAAAAAAAAACIzuw8AAAAAAAAAAAAAAAAAAAA0ZmdBwAAAAAAAAAAAAAAAAAAIDqz8wAAAAAAAAAA
AAAAAAAAAERndh4AAAAAAAAAAAAAAAAAAIDozM4DAAAAAAAAAAAAAAAAAAAQndl5AAAAAAAAAAAA
AAAAAAAAojM7DwAAAAAAAAAAAAAAAAAAQHRm5wEAAAAAAAAAAAAAAAAAAIjO7DwAAAAAAAAAAAAA
AAAAAADRmZ0HAAAAAAAAAAAAAAAAAAAgOrPzAAAAAAAAAAAAAAAAAAAARGd2HgAAAAAAAAAAAAAA
AAAAgOjMzgMAAAAAAAAAAAAAAAAAABCd2XkAAAAAAAAAAAAAAAAAAACiOzI7/19QSwECFAMUAAAA
CACHO0f8B9jgZoEOAADtyBEACQAJAAAAAAAAAAAApIEAAAAAaGhkc3AubWl4VVQFAAf/////UEsF
BgAAAAABAAEAQAAAAKgOAAAAAA==

--Boundary-01=_mvXmNMeyOwKGWIy--

--nextPart1993367.fbr5P7kPoi
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iF4EABEIAAYFAk2Ze+YACgkQMLNj2qIwZ4UwGwEArHuuwfWwnxguMQ+yH5UqQncW
887MbR4zqsgEtaFKvUgBANED+E77KjkV4mESxU7oMQ1txQrhJMSTSQzSl47YPitx
=EL3e
-----END PGP SIGNATURE-----

--nextPart1993367.fbr5P7kPoi--

--===============2334705482625889972==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============2334705482625889972==--
