From: Julien Danjou <julien@danjou.info>
Subject: Re: Constant noise on HDA ALC275
Date: Fri, 21 Sep 2012 17:29:09 +0200
Message-ID: <874nmried6.fsf@dex.adm.naquadah.org>
References: <87obl7bg02.fsf@dex.adm.naquadah.org>
 <s5h4nmrbln3.wl%tiwai@suse.de> <87wqznim1k.fsf@dex.adm.naquadah.org>
 <s5hzk4ja5hz.wl%tiwai@suse.de> <87pq5fiklg.fsf@dex.adm.naquadah.org>
 <s5hwqzna4pn.wl%tiwai@suse.de> <87haqrijiz.fsf@dex.adm.naquadah.org>
 <s5htxura31x.wl%tiwai@suse.de> <87d31fii3v.fsf@dex.adm.naquadah.org>
 <s5hmx0ja08z.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7114852018816727550=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.naquadah.org (prometheus.naquadah.org [212.85.154.174])
 by alsa0.perex.cz (Postfix) with ESMTP id 0B73F265D95
 for <alsa-devel@alsa-project.org>; Fri, 21 Sep 2012 17:29:47 +0200 (CEST)
In-Reply-To: <s5hmx0ja08z.wl%tiwai@suse.de> (Takashi Iwai's message of "Fri,
 21 Sep 2012 17:01:16 +0200")
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--===============7114852018816727550==
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 21 2012, Takashi Iwai wrote:

> Thanks.  The DAC paths look good to me.
> What happens if you load snd-hda-intel module with model=3D"nofixup"
> option?

It doesn't change anything.

FWIW, I did the following:

# rmmod snd-hda-intel
(noise still here)
# modprobe snd-hda-intel model=3Dnofixup
(speakers are silent for 1 sec, then modprobe returns and noise is back)
# rmmod snd-hda-intel
(noise still here)
# modprobe snd-hda-intel
(speakers are silent for 1 sec, then modprobe returns and noise is back)


=2D-=20
Julien Danjou
;; Free Software hacker & freelance
;; http://julien.danjou.info

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQXIfFAAoJEGEbqVCLeKXCeDIQAITRfB83NL13u7G+bJ3DDGAI
j6GrEILuG6yitMqP2TgQtnNxmQDcsU3IhSaCLgKwCDVLCdCu7HG2u6v1htr+wBWk
jZUvSD8sS/9pbuxmXB5oNdFsn0iz97dQs33C8pJT496qWiQPK/5z1fUHahx8v+rO
tJinAHDK03xMCrW5v+ORoIoVVnignUpTenyX4zsZ4J1ZpEZQBFejy7QY0Tsevm/Y
UuyHM//2Xv5KrJgfFzfZaFgS2Wq3WC3CvF/Gq/gvDbYGrZW7oidR5hw7blTZEdnF
E3+DyENE1rHbdYPcXlCqpQyL6sqVW2oAcpDQ663CYq3tlqgw1XbtdZBSviEirqu8
/EmHhTxjGiwoSOfCUK8jGt5Wpy7+rSZi7Bd5U5BrdZDKoUmvhD0URL1bsqXuvKzv
grHY3ktgaqJzhg4I8evEcjGXkmamjPKCDNXc5Cl6QdipWIhG6RTGi/sshWCDlhKF
qL1hVq2yQwBLISx/PAXn/PSdzgnUbhr03zJ7zbMZNSeTV+AV7JfSx/rAh3NLJ4Um
qBsAKI+FiuhK6oxk+rrMfr8j3yagfeKR0GkJEDDpqCEv6EqJ4AbmCJF93WUnuReo
LgLR3RHnE5MI+UoShFt0f5p1MV+ziPfoko/ZkQG8wsh1I1wOXKFjlJ5QLVa4rycr
Scr+Swyb/SYfcv/DhJ0E
=09ds
-----END PGP SIGNATURE-----
--=-=-=--

--===============7114852018816727550==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7114852018816727550==--
