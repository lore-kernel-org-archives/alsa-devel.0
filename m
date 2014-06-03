From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 1/2] ASoC: export
	dapm_kcontrol_set/get_value functions
Date: Tue, 3 Jun 2014 11:11:58 +0100
Message-ID: <20140603101158.GU31751@sirena.org.uk>
References: <1401357817-17942-1-git-send-email-vinod.koul@intel.com>
 <20140601192649.GQ5099@sirena.org.uk>
 <20140603054433.GX21128@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4338224213333212614=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A04542610A3
 for <alsa-devel@alsa-project.org>; Tue,  3 Jun 2014 12:12:20 +0200 (CEST)
In-Reply-To: <20140603054433.GX21128@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: Kp Jeeja <jeeja.kp@intel.com>, alsa-devel@alsa-project.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============4338224213333212614==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tn/+KOyBVBGpvvUM"
Content-Disposition: inline


--tn/+KOyBVBGpvvUM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 03, 2014 at 11:14:33AM +0530, Vinod Koul wrote:

> I don't disagree to the concern but as things seem to be today we need these
> handlers. Yes with the componentization work by Lar's this may not be required, so
> I guess we need to get the componentization series done first and then revisit
> this topic.

> In parallel we are trying to test bits to see if we can do away with this
> assumption. Stay tuned...

OK, or at least post the code using them - it's a lot easier to say "we
need this now for this driver" than to say "we need this for this out of
tree driver but we plan to remove the need for it and perhaps that'll
happen before the driver gets upstreamed".

--tn/+KOyBVBGpvvUM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTjZ9rAAoJELSic+t+oim91/4QAIYdB7U2KmfW0Gs3MCY/EalJ
cPTClbedCcdjekH6LQcLN0FdyK+6Qxed3FmkWPfDtt0KQKm3GhJaLWRkUlp+MF3V
qYQNtCWJpVF/9L4HXCFDd9vMAp3ofdyWNiqdtKTqV7opRWkvfi5kTIUk9ZFyd//R
l1CoKR2lZrxSAX00cXmYXkNU3qOBU+o4iKspgzZsHLIcmmiJwqmNsiNOjxtsEDcE
uG8vdBmHRZgAl1hzcxcirkAUVvpzZ0rAGLSUFVxJK6Q0wBA/NSjMcbioRM5nt/Tg
2RboKSmFKp8fMaErErbAAzG3O/56mQZl2DBiZcJURlgvQ1q3u42z3VNCPRVdK86v
iOB75M3emwN4ZDDxXposgVtTU/mIfQCU38QQ/rYFWPqaoiqChPn6yXVU7tK88aUU
9NV/515TWmkNfWh3IruOq9+quu8q5p3fcOF2xTOEYyTG1pjqgc0ejcwMzyOHwVJY
/Na2yQEHlEX9+HqPrjEI/4T/VTCzHxAbAXce/XWIIMC4wiI1Q+t9+/zZwM9CtDjz
Cza/GtKF84T+iFwiO97Q4PC+NjYr9OPQTsiUfpYllacVczhQkNXo47PSwRX79kxN
UEabXtqyiQFetd3WfaqvWxu4LBIegIrIb9Ltl2zYhUfzvLbKbZYj8ufSAkuxtyBl
FsRa1cfnu8xz4JfVgDUE
=ZU2s
-----END PGP SIGNATURE-----

--tn/+KOyBVBGpvvUM--

--===============4338224213333212614==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4338224213333212614==--
