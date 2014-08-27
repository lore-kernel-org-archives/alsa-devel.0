From: Mark Brown <broonie@kernel.org>
Subject: Re: [question about DPCM] dpcm_be_disconnect race
	condition
Date: Wed, 27 Aug 2014 19:52:25 +0100
Message-ID: <20140827185225.GQ17528@sirena.org.uk>
References: <53FD9384.3020501@marvell.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5016204995930651277=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 61DE126790C
 for <alsa-devel@alsa-project.org>; Wed, 27 Aug 2014 20:52:35 +0200 (CEST)
In-Reply-To: <53FD9384.3020501@marvell.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Qiao Zhou <zhouqiao@marvell.com>
Cc: "tiwai@suse.de" <tiwai@suse.de>, Xin Qian <xqian@marvell.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============5016204995930651277==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lY/KxbI20NSwRFRe"
Content-Disposition: inline


--lY/KxbI20NSwRFRe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 27, 2014 at 04:15:00PM +0800, Qiao Zhou wrote:
> Hi Liam, Mark
>=20
> I'm developing audio with DPCM on one phone platform, and met one kernel
> panic issue related with dpcm_be_connect. Could you please help to sugges=
t?

Adding Liam.

> Taking audio playback for example:
> 1. User space writes all the data into audio buffer. When the blocking wr=
ite
> returns, it closes audio path(which updates dapm and triggers
> soc_dpcm_runtime_update).
> 2. When user space closes audio path, kernel audio driver(DMA) is still
> transferring data from audio buffer to audio peripheral. So DMA interrupt
> will come, and the interrupt handler runs on different cpu comparing to
> which the task to close audio path runs on.
> 3. Due to system schedule, below case may happen.
>=20
>            cpu0                                      cpu1
>=20
> soc_dapm_mixer_update_power ->        |       DMA interrupt ->
> soc_dpcm_runtime_update ->            |       snd_pcm_period_elapsed ->
> dpcm_be_disconnect(old) ->            |       snd_pcm_update_hw_ptr0 ->
>  __________________________           |       xrun ->
> |                         |           |       snd_pcm_stop ->
> |list_del(&dpcm->list_be) |           |       dpcm_fe_dai_trigger ->
> |list_del(&dpcm->list_fe) |           |       dpcm_be_dai_trigger ->
> |kfree(dpcm);             |           |       list_for_each_entry(dpcm..
> |_________________________|           |
>=20
> On CPU1, list_for_each_entry(dpcm, &fe->dpcm[stream].be_clients, list_be)
> will get dpcm and corresponding be, but there is no protection against the
> dpcm_be_disconnect on cpu0. Related dpcm for the BE may be invalid/freed
> when cpu1 tries to access it.

> Should we require user space to make sure audio transfer ends before clos=
ing
> audio path to avoid such issue? I'm not sure if I missed anything or used=
 it
> wrongly.

Well, it should do that in general if it wants to make sure that the
audio actually gets played but the kernel should protect against this.
We should be holding a lock whenever we update the lists.

> Thanks in advance!
> --=20
>=20
> Best Regards
> Qiao
>=20

--lY/KxbI20NSwRFRe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT/ijmAAoJELSic+t+oim97PgP/RqruzwTe7yiTZEQJtsAFMwx
4iGP85AmIvcaSUHTeXqbWkhCbfOCEpBnZmF/l4mM4N5/duehJi+LHv1mypkQEPOg
TbQCzwfuRt+TKlFcWgfF6Wbm8J4hto1x4UylZpgvtSm6zGicZYtPuiyfRytqN+ZZ
ChdFja6qhPEz9YQWOavif8pl3mtp0LUqrUwHIkM+M5rNZAlb+ZZgXTa6PS7rrJyM
0TWiM3UHagDQ7EFJ+tcFtxGU3fTniZJahzBFRJQVupUvK98exmC/MrCIciNW/3uQ
s+Q4DGdasbfGzPqocN98S2a0mp9UUOl3Shbsw+Eb9d+PyfcxYdhpzkbBC4nPv/rc
RIcI3JWG6BsLoirY/IfgI3BVxHM3YVriVJEq8s2rgv+soxc5/gpRiNxkpB01Gkxa
+ypR+kEyD6vC4akwMgepZ9rVCVz+pcALKzpEPNZinRziLHZM6ypGjcx6eVTz6UKi
g9MTosUaDm8TdknIR1xStcDpBWUFljCcF+EqWS/1bRN7PnFC5uDh+kNMQmUH4len
qRQNYZPAjjuPfpKpSMsb2XLmcqtokK4eXm+uuGoYQJwvLxM8bNMKKWoLjGW+I+Ps
CLeCQHY6sHu+SNxEncTICLN0tTBOexsi+0wIkJg7pIKWcg1hX8HnWiMCcRzq1qhf
m8t24eeJTpO59VwGUdlZ
=C6nQ
-----END PGP SIGNATURE-----

--lY/KxbI20NSwRFRe--

--===============5016204995930651277==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5016204995930651277==--
