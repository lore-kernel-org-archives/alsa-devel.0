From: Mark Brown <broonie@kernel.org>
Subject: Re: [v3 05/11] ASoC: Intel: sst: add stream operations
Date: Wed, 27 Aug 2014 21:41:47 +0100
Message-ID: <20140827204147.GZ17528@sirena.org.uk>
References: <1408625450-32315-1-git-send-email-subhransu.s.prusty@intel.com>
 <1408625450-32315-6-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0583905228261486234=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D46CE26588F
 for <alsa-devel@alsa-project.org>; Wed, 27 Aug 2014 22:41:52 +0200 (CEST)
In-Reply-To: <1408625450-32315-6-git-send-email-subhransu.s.prusty@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Cc: vinod.koul@intel.com, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============0583905228261486234==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="be8zhcVv+svVvseH"
Content-Disposition: inline


--be8zhcVv+svVvseH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 21, 2014 at 06:20:44PM +0530, Subhransu S. Prusty wrote:

> +	/*allocate device type context*/
> +	sst_init_stream(&sst_drv_ctx->streams[str_id], alloc_param.codec_type,
> +			str_id, alloc_param.operation, 0);
> +	/* send msg to FW to allocate a stream */

/*spaces around the edge of comments like the second not the first*/

This is an issue in quite a lot of places.

> +
> +/**
> +* sst_start_stream - Send msg for a starting stream

/*
 *

> +		sst_fill_header_mrfld(&msg->mrfld_header, IPC_CMD,
> +				str_info->task_id, 1, pvt_id);
> +		msg->mrfld_header.p.header_high.part.res_rqd = 1;
> +		len = sizeof(dsp_hdr);
> +		msg->mrfld_header.p.header_low_payload = len;
> +		sst_fill_header_dsp(&dsp_hdr,
> +					IPC_IA_RESUME_STREAM_MRFLD,
> +					str_info->pipe_id, 0);
> +		memcpy(msg->mailbox_data, &dsp_hdr, sizeof(dsp_hdr));
> +		sst_add_to_dispatch_list_and_post(sst_drv_ctx, msg);
> +		retval = sst_wait_timeout(sst_drv_ctx, block);
> +		sst_free_block(sst_drv_ctx, block);

Can any of this be factored out?  Seems like a lot of duplication in
these operations.

--be8zhcVv+svVvseH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT/kKIAAoJELSic+t+oim9kt8P/j5y+HZwz939opp6Ak4VgQMF
eIIcG4k7XIComJLQ/jE+8/vfHK1AEprZoBvUqV8//ykQl4zVFtUMxhQVy5vgbo0Z
dH0dZEM5uqJbW8EblpjwYpJrlIpExM6Nap9VzehRavL/usjSlImpgH3AYb27Ed8k
fBH221rf5z3U1FLx2bIC+B/0budxgpHa+5U/8IK7CAu8vR3KXyTN8wVvcCfDyRHy
i6qEcB3EJ9UHxVk09q6p022LPYRUEH20IPf1CdA+VmnUez/rT3K3Hzq5cb1XdJ2B
CoMX9O6rORS/qUih2qrpVEBeUFTFJdHmtmJEcTpYhn3Sm0IKKDPoDtzTTM1uveWz
kCOThxCimhn+daICzPjwXKDzjeIF98EEwaRrsvwBHfYaEa9k6BSQZHqg93KX3X4G
hLb49sORdnX6BAynbTyeEykZlI2y5DS9o24VqpOflxw53E1zIClS+nm17HqIml1o
sY3nwCacm3reyELru4Gq59IWiJ0YancRdpD5xcSLbZR8W6Nu8thHhnLqKbaCRGnF
kK9DEJFwKrfDEq775d5XCvEhe8Y9HW5UjZ8IoEs3WPvlNSLIoX5ZSQCv6D4SMF8i
ILzuPS8kN8jCPfJs0psi2QVQk2eGFXR3RMFJsx8YT9Skm57puKNpCi2849mgKM7f
BcvQV7bJFQMSDPPExGNA
=Uv+i
-----END PGP SIGNATURE-----

--be8zhcVv+svVvseH--

--===============0583905228261486234==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0583905228261486234==--
