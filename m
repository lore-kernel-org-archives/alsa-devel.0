From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3] ASoC: rt286: fix headphone click/crack
 noise on Dell XPS 9343 I2S mode
Date: Mon, 20 Mar 2017 16:06:22 +0000
Message-ID: <20170320160622.5s2oqdyluvanjp2u@sirena.org.uk>
References: <20170320035831.10762-1-kai.heng.feng@canonical.com>
 <20170320150845.7rltrhycdkk2mza4@sirena.org.uk>
 <CAAd53p53MnZcSEgS47wWcCfm48=J6O3ynjqBdfN6_1nhBMdNwA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3114393364674621048=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 87406266D9D
 for <alsa-devel@alsa-project.org>; Mon, 20 Mar 2017 17:06:33 +0100 (CET)
In-Reply-To: <CAAd53p53MnZcSEgS47wWcCfm48=J6O3ynjqBdfN6_1nhBMdNwA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: oder_chiou@realtek.com, bardliao@realtek.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--===============3114393364674621048==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5hpmpyjvodvhy35f"
Content-Disposition: inline


--5hpmpyjvodvhy35f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 20, 2017 at 03:46:13PM +0000, Kai-Heng Feng wrote:
> On Mon, Mar 20, 2017 at 11:08 PM Mark Brown <broonie@kernel.org> wrote:

> > As covered in SubmittingPatches this should come after the ---, it
> > doesn't need to end up in the changelogs.

> Do you mean
> https://github.com/git/git/blob/master/Documentation/SubmittingPatches#L197
>  ?
> I didn't find any hard rules regarding this, but I'll keep it in mind.

As it says there "...and inserted automatically following the three dash
line".

> > > SND_SOC_DAPM_POST_PMD: +     case SND_SOC_DAPM_POST_PMU: +
> > > snd_soc_write(codec, RT286_SET_AMP_GAIN_HPO, AMP_OUT_MUTE); +
> > > break; +     case SND_SOC_DAPM_PRE_PMU:

Please fix your mail client not to completely mangle quoted patches when
replying.

> > To repeat what I said last time:

> > | After power up we mute the amplifier?  That's worthy of a
> > comment...

> IIUC, HPO Power's  _POST_PMU is triggered right before power down
> (_PRE_PMD), hence it's pretty logical to mute the amplifier at this
> stage.  I can't quite see anything wrong here.

No, that is not the case - I'm not sure what would lead you to believe
that it is.  _POST_PMU is triggered as the last step of powering up the
widget as the name might suggest.  Has this code been tested at all?

> So no I didn't ignore your comment, I simply misinterpreted what you
> meant.  Because of the logical assumption, I thought you were talking
> the unmute part in _PRE_PMU, which I did add in the changelog.

You didn't reply to my review comment and you sent the same code again.
That looks an awful lot like being ignored.

--5hpmpyjvodvhy35f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAljP/f0ACgkQJNaLcl1U
h9CUaQf+Kq10Pg5K+iAUUHpLuOQAw+7JkEOGTCwJv2aOaEYy6yC8t5jT4dViIhdv
1AMDHjKhPfvKA9tpa8DH3RquRIIkT/qQDh1/MaodrM3Q5Pl5dwk5EHJa7HJW2n7M
Um8uJrORrVmcuRV1FPcGltooOMB+CN52UiH2Wrb0TbryvN9f0uTPbbPBgLs4PjNo
w+yl1LlON8+TmxDDfJakl0EEzgCnTjsF1Cp2bh4UTgXSnEmjIj14qHy87XUidDJk
yYj9OCfRDm4RgYoIk/T/Wxk7sosf5Knrn734PH5C/pg9UAxzVuH+3PvBB1pgnd5y
slgxURVRWSYgIq5jkZkWYWseA+02bQ==
=hcTK
-----END PGP SIGNATURE-----

--5hpmpyjvodvhy35f--

--===============3114393364674621048==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3114393364674621048==--
