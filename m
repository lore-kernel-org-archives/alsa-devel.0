From: Julien Danjou <julien@danjou.info>
Subject: Re: Constant noise on HDA ALC275
Date: Thu, 01 Nov 2012 23:39:52 +0100
Message-ID: <87fw4t9ccn.fsf@dex.adm.naquadah.org>
References: <87obl7bg02.fsf@dex.adm.naquadah.org>
 <s5htxura31x.wl%tiwai@suse.de> <87d31fii3v.fsf@dex.adm.naquadah.org>
 <s5hmx0ja08z.wl%tiwai@suse.de> <874nmried6.fsf@dex.adm.naquadah.org>
 <s5hfw6bpen9.wl%tiwai@suse.de> <87vcf7gyl5.fsf@dex.adm.naquadah.org>
 <s5h6277pdfi.wl%tiwai@suse.de> <87r4pvgxvx.fsf@dex.adm.naquadah.org>
 <87r4pepcgo.fsf@dex.adm.naquadah.org> <s5h1uh9jfxq.wl%tiwai@suse.de>
 <87zk3xku73.fsf@dex.adm.naquadah.org> <s5hwqz1i0y0.wl%tiwai@suse.de>
 <87fw5pktos.fsf@dex.adm.naquadah.org> <s5hr4p9hzw0.wl%tiwai@suse.de>
 <87ehl96ifc.fsf@dex.adm.naquadah.org> <s5h7gr1gc7o.wl%tiwai@suse.de>
 <87ehl86h4l.fsf@dex.adm.naquadah.org> <s5hvcek7oh7.wl%tiwai@suse.de>
 <87zk3wity4.fsf@dex.adm.naquadah.org> <5073C20C.2080603@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3833064245757892795=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.naquadah.org (prometheus.naquadah.org [212.85.154.174])
 by alsa0.perex.cz (Postfix) with ESMTP id 22FFF264F02
 for <alsa-devel@alsa-project.org>; Thu,  1 Nov 2012 23:39:54 +0100 (CET)
In-Reply-To: <5073C20C.2080603@canonical.com> (David Henningsson's message of
 "Tue, 09 Oct 2012 08:19:56 +0200")
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--===============3833064245757892795==
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 09 2012, David Henningsson wrote:

Hi David, Takashi,

I'm still trying to advance on this! :)

> So; if everything is muted, it causes some codec bug to appear. If this o=
nly
> happens in the speaker, maybe we should try to reroute the speaker to go
> 0x02 -> 0x0c -> 0x14 instead of 0x03 -> 0x0d -> 0x14? What will happen if
> you change 0x14 to take its input from 0x0c instead?

I just did that using the hda-analyzer tool. I changed 0x14 to uses 0x0c
as a source, and it's indeed much better. The noise disappear when
neither master or speaker is muted, and actually the music playback
sounds better and without the little background noise I still hear on
low volume level.

Actually, I'm sure it'd be easy to come with a patch, so my question
would rather be: what's this routing about, and why is 0x0d set up
instead of 0x0c?

I'm still trying to find a way to fix the noise when speaker or master
are muted. No chance so far. :(

=2D-=20
Julien Danjou
# Free Software hacker & freelance
# http://julien.danjou.info

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQkvo4AAoJEGEbqVCLeKXCWOgP/j8lXoj4Vyoisq5yJMQMt6o9
5i5SzVwMH36YQnAlY7Y+3gbkyA7nnKpSJBAnFYyZpX2KuE9DMNOLxRQiyehM+sk1
uazmSXWtq1ae3XDS+4vMmvkk5zt4dCmYvgHTGQLKN48QW+3XsVhAJ9uppmNTALJ5
HKbIyabCzyNZi+0kJXpZYMMUB6aWbZkXoc9ksR/yLG3K+IzgtORJ6vLClS82/huG
Y8KAXDtuhh04QRBVHM85AnOJiBt7ALqo84CQia0RTr3unB02o+GwGyLydDZYStc7
U1WgHMa4oZlEsCxdK78TlkWQh+dXDfDn1x86F0nBj8xt++BTYwiVfkpJPLzw+9Pf
0WQtI7jnpVY2j9UVIu/WV2o2YwMm6Hi6J7N0zGwR6eVmfOq/BWTxCVcVKQ4s7Anq
S/ZrAPefYCpy6T1TZby2JHSL9w/BdK34ZtaQ+TcaiQNryQeNDUI6/3rIU8GHhmmm
JBrtMs4zvg1G5z1fJK2qZnXv/ELnFw+migbYygmM76Y+O8RG6Qe63tqtVn5N1uhp
WmbSGgRfVdneli5iP8Optu7R4vrPnYZI/EmCyv2i+P54vJnUUOhiu1OCRgQOWH+r
srNZ/B3B49BEHQuTTQ0WxB2ugNhTc7uoHra/VLI0IcOPuANMhhXVETlBdscHwAjm
XlfUo3PfWgNeKA2IKgX6
=Ypsy
-----END PGP SIGNATURE-----
--=-=-=--

--===============3833064245757892795==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3833064245757892795==--
