From: Andreas Hartmann <mail@andreashartmann.eu>
Subject: Re: Bug: LADSPA implementation - no up/downmix handling
Date: Thu, 24 Sep 2015 12:44:53 +0200
Message-ID: <1544609.lNj7aapdUP@deep-thought>
References: <2541800.vBPmoIL6Xo@deep-thought> <s5hpp196wjx.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5101198280636404512=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from stcim.de (stcim.de [78.46.73.102])
 by alsa0.perex.cz (Postfix) with ESMTP id 19F69260505
 for <alsa-devel@alsa-project.org>; Thu, 24 Sep 2015 12:44:57 +0200 (CEST)
Received: from ipbcc2fc9d.dynamic.kabel-deutschland.de ([188.194.252.157]
 helo=deep-thought.localnet)
 by stcim.de with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:256)
 (Exim 4.84) (envelope-from <mail@andreashartmann.eu>)
 id 1Zf41I-0002ki-E8
 for alsa-devel@alsa-project.org; Thu, 24 Sep 2015 12:44:56 +0200
In-Reply-To: <s5hpp196wjx.wl-tiwai@suse.de>
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
List-Id: alsa-devel@alsa-project.org


--===============5101198280636404512==
Content-Type: multipart/signed; boundary="nextPart1622476.1qOaJv33oD"; micalg="pgp-sha1"; protocol="application/pgp-signature"


--nextPart1622476.1qOaJv33oD
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Mittwoch, 23. September 2015, 16:26:58 schrieb Takashi Iwai:
> On Sat, 12 Sep 2015 22:10:40 +0200,
> 
> Andreas Hartmann wrote:
> > Hi,
> > 
> > Using the surround_encoder of the swh-plugins I noticed, that the alsa
> > implementation only assumes an equal number of in- and output channels for
> > ladspa plugins. This occurs from Line 752 onwards in pcm_ladspa.c and
> > leads to a Segfault shortly after.
> > There needs to be a check and correct handling for up/downmix scenarios.
> 
> Could you give the back trace?  Or at best submit a fix patch?
> 
> 
> thanks,
> 
> Takashi
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

Sure here you go

#0  0x00007ffff78623ef in snd_pcm_ladspa_allocate_memory (pcm=0x626fa0, 
pcm=0x626fa0, pcm=0x626fa0, ladspa=0x621ad0) at pcm_ladspa.c:753
#1  snd_pcm_ladspa_init (pcm=0x626fa0) at pcm_ladspa.c:834
#2  0x00007ffff7842946 in snd_pcm_plugin_prepare (pcm=0x626fa0) at 
pcm_plugin.c:171
#3  0x00007ffff784290f in snd_pcm_plugin_prepare (pcm=0x62c760) at 
pcm_plugin.c:162
#4  0x000000000040256a in ?? ()
#5  0x00007ffff7222ec5 in __libc_start_main (main=0x401d80, argc=4, 
argv=0x7fffffffde28, init=<optimized out>, fini=<optimized out>, 
rtld_fini=<optimized out>,
    stack_end=0x7fffffffde18) at libc-start.c:287
#6  0x0000000000402fdd in ?? ()

--nextPart1622476.1qOaJv33oD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAABAgAGBQJWA9QnAAoJEFdgwA+zsF1UwHoP+gM8boPq53kRz/X2j+aHCIxl
VDaxg9sHiy1NmaDKbOUo/qD9SRbSdjL2hWu1wpl1K3Gh5Blhn/WIgVjNF+YdWRh3
Cu8sU6M5ju+NG/GTjxT0UELXk33sry5I6+w4Z8NVWn2IVmYbWrtdDwFlU6CVK3LO
i2iUaszK40AIQvyOvRr6EPtOYTI5LXGtGN0BrekO1/M72jmZW6V9dviGSm/HI6re
CHnlnOHyWN+1s9XJGj47G5ube/ZXdKPD1lty3jr5PIj3FpqkmIuA8JhY2cGxPu4U
rIhVJa5zk5jEklNmMSeH/sDZNLnKbitzOro3RWfai1F40q9/Ri7nH0aBvtQIgfkf
6/1hIpsjT1HAVreCcft/+7voIGTIGOOdRhLGlQBb7Uh+MZo9vV2eVnOrw4O3nS7n
zuI3aHz+xBHexF4ZkGsbkjW6JpoXL1YDeuD/n/KG4v4lDVD9/+Q+DzJM4CAZp7ck
Hh1Mcq9CX/30yM9XRxYwCz+YMaaY+oSZxThq+It2532Zt7gvMaZzm9SnXq9Lj93s
VyCICGLTTizaemQmYsjXqr0E2I2u2FOMZj3H22wektJrcX3sB0Ytbyftm1Jw0zs/
B2RoavKFU40Vj3u397QSfXrRPPmczFMKmLZNsMF3N7mEdcxagK/wWsWx4R3lf/1i
o2/YhqLaeFEYa5Hm1lmd
=8pAR
-----END PGP SIGNATURE-----

--nextPart1622476.1qOaJv33oD--


--===============5101198280636404512==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5101198280636404512==--
