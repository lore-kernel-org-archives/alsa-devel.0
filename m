From: Mark Brown <broonie@kernel.org>
Subject: Re: configuring machine specific DAPM for codec +
	headset jack detect
Date: Tue, 18 Oct 2016 12:02:36 +0100
Message-ID: <20161018110236.GD10208@sirena.org.uk>
References: <CAJ+vNU2a5G8HxJjZ+0g_NkC1jtMg1jKVq6xOfWqx94tbyA=rLA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5877309752250280800=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 85C4E2614A0
 for <alsa-devel@alsa-project.org>; Tue, 18 Oct 2016 13:02:44 +0200 (CEST)
In-Reply-To: <CAJ+vNU2a5G8HxJjZ+0g_NkC1jtMg1jKVq6xOfWqx94tbyA=rLA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Tim Harvey <tharvey@gateworks.com>
Cc: alsa-devel@alsa-project.org, Dylan Reid <dgreid@chromium.org>
List-Id: alsa-devel@alsa-project.org


--===============5877309752250280800==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2Z2K0IlrPCVsbNpk"
Content-Disposition: inline


--2Z2K0IlrPCVsbNpk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 17, 2016 at 04:33:10PM -0700, Tim Harvey wrote:

> I have a TI TLV320AIC3105 codec on a board connected to a TS3A227E
> headset detect chip (which handles switching pins for OMTP vs std
> jacks as well as jack detect and headset buttons). The AIC3105 doesn't
> use several of the inputs and outputs yet those inputs and outputs
> still have mux widgets volume widgets that are not 'off'.

> Is there a way to easily disable them so they a) are not muxed into
> mixers, b) have their gains set to 0, and c) are pruned from the list
> of widgets so users don't have to muddle through them in mixers?

No, you need to write that code if you want it - we do mark not
connected things with the intention that someone could implement this
but nobody did yet.

> I am also fighting both a pop/click issue and am wondering if there is
> any easy way to disable the DAPM power up/down sequence upon playback
> start/complete (my application is not power sensitive). I'm still
> trying to understand the source of the pop/click.

You can ramp the power down time up but no, there's no way to disable it
completely in the kernel - this is normally done in the sound server and
tends to work better that way as starting and stopping the digital audio
stream tends to be glitchy.

> Additionally the TS3A227E requires MIC bias to be kept enabled in
> order to detect headset button presses. I see that setting
> idle_bias_off to false will keep the MIC bias enabled but I don't see
> a way to specify that via device-tree.

Your machine driver should force enable any widgets it needs.
idle_bias_off should have no effect on microphone biases, if it does
that sounds like a bug.

--2Z2K0IlrPCVsbNpk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJYBgFLAAoJECTWi3JdVIfQrnoH/0fgDA6tglbkaHuLKShhDG7z
AuGG93c97kxN5MZj9UMPai4klq4X8MoroUfzg635kby5Az2gl5A267tp6xeLXV3D
mERIIScUELgaHptZPAv8K5SXxcl2WsD9AGMuW+SPHaoRMVuOD7QrYL6uBeX5ZjdV
HdfAQWOmSBEdKhaaeqslu5xACer4gwgJEjXO309BTSK08PEcZO9yzaLn0pJnsqSj
XTd8aIgKW2AHJU+ezTlPViVazt0BmgEVDUc6RPYOz/vlngUC4tLEuizz72wKsrAk
mWD1HA28w7LZ5U99N7eFZHyxxmuETCXVn6XxPCGQEmgHOvpTp/xU4kvUQVF+PfM=
=FvU7
-----END PGP SIGNATURE-----

--2Z2K0IlrPCVsbNpk--

--===============5877309752250280800==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5877309752250280800==--
