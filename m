From: Johannes Geiss <johannes.geiss@online.de>
Subject: Re: Linux-Kernel: System freezes after hibernate or
 suspend on a Mac mini 6, 2
Date: Mon, 23 Apr 2018 20:40:37 +0200
Message-ID: <20180423204037.7a57bdb5@mizar>
References: <20180423085341.6c72de13@web.de>
	<s5hefj6rqd2.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3446433019817988250=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
 by alsa0.perex.cz (Postfix) with ESMTP id CAB82266CA1
 for <alsa-devel@alsa-project.org>; Mon, 23 Apr 2018 20:40:52 +0200 (CEST)
In-Reply-To: <s5hefj6rqd2.wl-tiwai@suse.de>
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

--===============3446433019817988250==
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/sjI7pl1uDv16X.2oXOMJdUu"; protocol="application/pgp-signature"

--Sig_/sjI7pl1uDv16X.2oXOMJdUu
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 23 Apr 2018 15:42:33 +0200
Takashi Iwai <tiwai@suse.de> wrote:

> Did you get the error message "Too many HDMI devices" as mentioned in
> the changelog?

Yes:

Mar 14 11:29:48 mizar kernel: snd_hda_intel 0000:00:1b.0: Too many HDMI
devices Mar 14 11:29:48 mizar kernel: snd_hda_intel 0000:00:1b.0:
Consider building the kernel with CONFIG_SND_DYNAMIC_MINORS=3Dy Mar 14
11:29:48 mizar kernel: input: HDA Intel PCH Line
as /devices/pci0000:00/0000:00:1b.0/sound/card0/input3 Mar 14 11:29:48
mizar kernel: input: HDA Intel PCH Headphone
as /devices/pci0000:00/0000:00:1b.0/sound/card0/input4 Mar 14 11:29:48
mizar kernel: input: HDA Intel PCH SPDIF In
as /devices/pci0000:00/0000:00:1b.0/sound/card0/input5 Mar 14 11:29:48
mizar kernel: input: HDA Intel PCH HDMI/DP,pcm=3D3
as /devices/pci0000:00/0000:00:1b.0/sound/card0/input7 Mar 14 11:29:48
mizar kernel: input: HDA Intel PCH HDMI/DP,pcm=3D7
as /devices/pci0000:00/0000:00:1b.0/sound/card0/input8 Mar 14 11:29:48
mizar kernel: input: HDA Intel PCH HDMI/DP
as /devices/pci0000:00/0000:00:1b.0/sound/card0/input9 Mar 14 11:29:48
mizar systemd[1]: Reached target Sound Card.

Does this mean I should try to use CONFIG_SND_DYNAMIC_MINORS=3Dy to solve
the hibernate/suspend problem?

Bye
Johannes
--=20

 ------//--------------------------------------------------------------
      //    Johannes R. Geiss                       Mac mini server and
  \\ //                                                OpenPandora user
 --\X/-----------------------------------------------------------------

--Sig_/sjI7pl1uDv16X.2oXOMJdUu
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQShVKB6tDq/F13WLuRZBXiGs2qKFQUCWt4opgAKCRBZBXiGs2qK
FavdAJoCNZbs/D/Ljhoe0PDflDcHcAxU9wCdFccb64sl/nlbTVJrYC+mHVq9llk=
=JJZX
-----END PGP SIGNATURE-----

--Sig_/sjI7pl1uDv16X.2oXOMJdUu--

--===============3446433019817988250==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3446433019817988250==--
