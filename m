From: Sergey Vlasov <vsu@altlinux.ru>
Subject: Re: ALI M5451 (CMI 9739): PCM always muted?
Date: Wed, 21 Apr 2004 15:28:03 +0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040421112803.GD5966@master.mivlgu.local>
References: <200404171945.35824.bero@arklinux.org> <200404201939.54966.bero@arklinux.org> <20040420183931.GB2166@sirius.home> <200404202125.12660.bero@arklinux.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="veXX9dWIonWZEC6h"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <200404202125.12660.bero@arklinux.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Bernhard Rosenkraenzer <bero@arklinux.org>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--veXX9dWIonWZEC6h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 20, 2004 at 09:25:12PM +0200, Bernhard Rosenkraenzer wrote:
> On Tuesday 20 April 2004 20:39, Sergey Vlasov wrote:
> > > > > On an ALI M5451 (Using a CMI 9739 - PCI ID 10b9:5451 Sub-ID
> > > > > 1019:0f22), snd_ali5451 loads and can adjust mixer settings (except
> > > > > for PCM volume, but I think that's a limitation of the hardware), but
> > > > > doesn't make any noise - apparently PCM is always muted (volume fixed
> > > > > at 0?).
> >
> > And what does "amixer contents" show?
> 
> numid=35,iface=MIXER,name='IEC958 Playback Switch'
>   ; type=BOOLEAN,access=rw---,values=1
>   : values=on
> numid=39,iface=MIXER,name='IEC958 Capture Monitor'
>   ; type=BOOLEAN,access=rw---,values=1
>   : values=on

Did you try to turn these things off?

> numid=42,iface=MIXER,name='External Amplifier'
>   ; type=BOOLEAN,access=rw---,values=1
>   : values=on

Or maybe this (who knows where it is hooked really).

--veXX9dWIonWZEC6h
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD4DBQFAhlrDW82GfkQfsqIRAqGdAJdo+sgAD20POOZ/lTAzIgCU7es4AJ9dTdGW
R981MhIG0UpZgR1SjzAsCQ==
=q8EG
-----END PGP SIGNATURE-----

--veXX9dWIonWZEC6h--


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
