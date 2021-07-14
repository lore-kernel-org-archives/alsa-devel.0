Return-Path: <SRS0=PPjj=MG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81AB6C12002
	for <alsa-devel@archiver.kernel.org>; Wed, 14 Jul 2021 19:35:02 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8828C613BA
	for <alsa-devel@archiver.kernel.org>; Wed, 14 Jul 2021 19:35:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8828C613BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2EBBA167F;
	Wed, 14 Jul 2021 21:34:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2EBBA167F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1626291299;
	bh=6t8P63gUUVmHpSDAy+xkJ87md14MyIPty+YX4jWejW4=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UMDOlVROCcT9WblvHLeoZ9lqN+7Ix/BYiipihoUxgt+3BkyJ6roaHD0zOn+z52dM2
	 E8KNZvsSnG059wSRwg7UwKUINbTZUnKp9UUNYbVbha6lM4tlno5bTdX8L/eCEkinJn
	 11VGjjeV/pVnBxZvFY5FAFuZZwefJuz8p0nmwZkw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8C7E1F80253;
	Wed, 14 Jul 2021 21:34:08 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7B2D1F80254; Wed, 14 Jul 2021 21:34:06 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 54440F8011C
 for <alsa-devel@alsa-project.org>; Wed, 14 Jul 2021 21:34:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 54440F8011C
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="TH7S5C/G"
Received: by mail.kernel.org (Postfix) with ESMTPSA id E8E9760698;
 Wed, 14 Jul 2021 19:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1626291234;
 bh=6t8P63gUUVmHpSDAy+xkJ87md14MyIPty+YX4jWejW4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=TH7S5C/G90qfYco8QyzfxkfNyp4Z1j8TOKuOVi3B7wpT42765dmXT5aTkV9Jbb97B
 NPp+ozMz5/8yvmFCquH7/myfT2P9BfhTNqQu3cTikZDlq3JI9wPHtX9MeeA2xUpfe7
 LJGUMI+px+WkF0fqBi/YZAyjhmnjbnrSjc69kEYpSU85/aBjzLtFaYSIuHQset9958
 tCAxKTRwMQ/pWfXTzoeU4Rb071hv7KHRR/gaAEDg9E1XhXo9pqa5gLLF7iuRlJZrVf
 WMCJfPEsZl8n2t49BwALHqsDIEftANv2Ru/NsDLluPb8upWhO2f0vPvXUCkCbHZrad
 c9m3kfM/SBgUA==
Date: Wed, 14 Jul 2021 20:33:15 +0100
From: Mark Brown <broonie@kernel.org>
To: Bard Liao <yung-chuan.liao@linux.intel.com>
Subject: Re: [PATCH 00/10] soundwire/ASoC: add mockup codec support
Message-ID: <20210714193315.GK4719@sirena.org.uk>
References: <20210714032209.11284-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="g4MvFqI7wmANiPDo"
Content-Disposition: inline
In-Reply-To: <20210714032209.11284-1-yung-chuan.liao@linux.intel.com>
X-Cookie: C for yourself.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: alsa-devel@alsa-project.org, vinod.koul@linaro.org, tiwai@suse.de,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 pierre-louis.bossart@linux.intel.com, vkoul@kernel.org,
 sanyog.r.kale@intel.com, bard.liao@intel.com
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


--g4MvFqI7wmANiPDo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 14, 2021 at 11:21:59AM +0800, Bard Liao wrote:
> Adding mockup SoundWire codec is useful to debug driver/topology changes
> without having any actual device connected.

The following changes since commit e73f0f0ee7541171d89f2e2491130c7771ba58d3:

  Linux 5.14-rc1 (2021-07-11 15:07:40 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-sdw-mockup-codec

for you to fetch changes up to 0ccac3bcf3564cbcba483dec20c7550939873f59:

  ASoC: Intel: boards: sof_sdw: add SoundWire mockup codecs for tests (2021-07-14 18:02:07 +0100)

----------------------------------------------------------------
ASoC: Add mockup SoundWire CODEC

Useful for bringup testing, not for production usage.

----------------------------------------------------------------
Pierre-Louis Bossart (4):
      ASoC: codecs: add SoundWire mockup device support
      ASoC: soc-acpi: cnl: add table for SoundWire mockup devices
      ASoC: soc-acpi: tgl: add table for SoundWire mockup devices
      ASoC: Intel: boards: sof_sdw: add SoundWire mockup codecs for tests

 sound/soc/codecs/Kconfig                           |  18 ++
 sound/soc/codecs/Makefile                          |   2 +
 sound/soc/codecs/sdw-mockup.c                      | 310 +++++++++++++++++++++
 sound/soc/intel/boards/Kconfig                     |   1 +
 sound/soc/intel/boards/sof_sdw.c                   |  41 +++
 sound/soc/intel/common/Makefile                    |   3 +-
 sound/soc/intel/common/soc-acpi-intel-cnl-match.c  |  15 +
 .../intel/common/soc-acpi-intel-sdw-mockup-match.c | 166 +++++++++++
 .../intel/common/soc-acpi-intel-sdw-mockup-match.h |  17 ++
 sound/soc/intel/common/soc-acpi-intel-tgl-match.c  |  23 ++
 10 files changed, 595 insertions(+), 1 deletion(-)
 create mode 100644 sound/soc/codecs/sdw-mockup.c
 create mode 100644 sound/soc/intel/common/soc-acpi-intel-sdw-mockup-match.c
 create mode 100644 sound/soc/intel/common/soc-acpi-intel-sdw-mockup-match.h

--g4MvFqI7wmANiPDo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmDvO/oACgkQJNaLcl1U
h9D7HQf9H4qYjHhqgj4kDvFhdKdFwRRYYaRQcB0IT7zKt4T2NHRl4YX3D2sLOoZz
/tC4hdM9nwW8BWOsamCScZyKHjtQoE7PjKQwyWMD8JTG8HBKr5NqDiGzdiKUvp0C
6S+q9Ft3n9zI+G5pGfhTJeIPEtItdvly4xWkbGzuD4ovGbxEte6KM5GBekekmCss
uEx88ujhNReKj50Q2EHmd+DxblESue3Zm9Xx6JI7tpP83aTM8qv5LZ31F8uYXuRZ
K0rx0qXqRV47jWGBsQxftShM797m9zowC8Rl9/gTLs1R3g4PVPye40G5kIhnmEpc
gT3Xq/2+v6991DJh6++wN46L0E26OA==
=f5bU
-----END PGP SIGNATURE-----

--g4MvFqI7wmANiPDo--
