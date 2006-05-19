From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: alsa and locking
Date: Fri, 19 May 2006 18:46:03 +0200
Message-ID: <1148057163.6228.26.camel@johannes.berg>
References: <1148055062.6228.19.camel@johannes.berg>
	 <s5hd5eavvcj.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-C+ZU2JwrrmSJ6tkLyyaB"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hd5eavvcj.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
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


--=-C+ZU2JwrrmSJ6tkLyyaB
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2006-05-19 at 18:21 +0200, Takashi Iwai wrote:

> Some descriptions are found in the atomicity section of my tutorial.

Yes, I've seen that. Rather vague though.

> All control callbacks are not protected, except for rwsem against
> addition/removal of elements.

Alright, so it's possible that a user actually changes two controls at
the same time. IOW I have to protect against that.

> The PCM trigger, pointer and ack callbacks shall be atomic, where=20
> protected with spinlock and irq disabled.  Other PCM callbacks are
> not protected but for open mutex.

Right. What about prepare and all the other pcm stuff? Can it race
against the same when two apps open capture/playback etc?

johannes

--=-C+ZU2JwrrmSJ6tkLyyaB
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARG32SKVg1VMiehFYAQLn4Q//Z9n3i79MBr3ixPfkg4Oehp6N8shOcSPl
c3PTjXCHUi1vaqPAVx5hHt0qVNR+WYspcjT/YB5lkzjufc0S2mf0mqXgRPI7EVc7
glyj49zNWGoWxUq7kl4trq8W8mv4ElT+6R+m7X+YKbS26YrO2/TKAAYoVfTngoYp
BtouX7R5MILOtF9XpovicGFqjxWkHhreD8hjKtrC6yGvXEpMSktIPCpNX7XcZEmH
wph8Ls2iITnuGxYzfxe28j3gKDGyg63DOv34N6PHH4sJOKgGxWgIly5uSPnSP+Z3
6jXM6mOdXc5lKNc/5ecaolVnfXpItluw8Nb3J3FcJ01QHHtZlrpzJlHJCSUhv8dq
k5vhpeetKVATdjICgG3XSt7rXDEBX4Um/932jZyTjn8hiM9lcO8G/+1Oz2gnMuwg
p0244t69scas3EXrj9eatJecerXprA1d36jKsu9JFrxFgINezwqpLCw6GVy+7B36
zpF05T4KLEJCYxCwXPRB8uGEa80M/o2xojq/CmY2qphey4Z3fG5nLKGYQkLVi1AB
YgVtyyINKEzeYNwED32D3ct/xsWgbudhL6erl87PsZCV1GAwUdac+97YSxkUb36j
mrBGyRC9gcaihIsKQ52ytq9HWcBe85685fd+Qm1YZGDGjI2yLHRdAMrBu6rynhzv
xV3GsUsSFSU=
=tYUN
-----END PGP SIGNATURE-----

--=-C+ZU2JwrrmSJ6tkLyyaB--



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
