Return-Path: <SRS0=Hwo1=HL=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B4D6C433E0
	for <alsa-devel@archiver.kernel.org>; Tue,  9 Feb 2021 22:25:28 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3EA864E6B
	for <alsa-devel@archiver.kernel.org>; Tue,  9 Feb 2021 22:25:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3EA864E6B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4B19716B5;
	Tue,  9 Feb 2021 23:24:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4B19716B5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1612909524;
	bh=7kfxLK78PvfigA3R4+VMbeoeBXl7l9q8dV+Npd79hmM=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ezxtTInR1F+nMb25rrHchzrn18bBjdkJa3i46C6UhtC7sGdgHgm/o9BvaWF/UHXKZ
	 pgjHrsL8YSM2YlD+6uE84pqbY77Ux6NXlUTbbW7dlz1LkvKyI0ZJkPzmPm9PK4F7G7
	 6Kv2PzT4ZVu/SBWGE6Ccobn6SbQvm804aFUrVaAI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id ABB38F8016B;
	Tue,  9 Feb 2021 23:24:33 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A8DFFF801D5; Tue,  9 Feb 2021 23:24:31 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E4399F80107
 for <alsa-devel@alsa-project.org>; Tue,  9 Feb 2021 23:24:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E4399F80107
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="bytmFa9s"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 64C7764E56;
 Tue,  9 Feb 2021 22:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1612909463;
 bh=7kfxLK78PvfigA3R4+VMbeoeBXl7l9q8dV+Npd79hmM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=bytmFa9s0GNPrj/vhul83Yqfc3J2cbXfknvlwBAwsnb9RN3uOX0U7HT98gqG6CwvO
 v/MzX/xnG504FWaN6fs4kkZPHH7xYxyhfTrwmqsN01qzlR5OiLBihoJXk/cuNL1vl3
 BRqfW8oTcoQHRV7MlKZOETUvNHsRyXEMuR0NXtNj3DbPjXvzGgYGFwPcOEdqC4i3zU
 GyGkZglpS+dtRTRlKy0xv3HpibI0MX10PwNGuX+ThaeG6cIMdO/L1VvhzY30L4sw1n
 8G8oq5BU+KTGQ6wdqAYpcScn+OM4Jq50T0zHrpDpUUJ+ILUc/5DEaTZR+zUjfEvTxa
 W81VBLUwB4T0Q==
Date: Tue, 9 Feb 2021 22:23:31 +0000
From: Mark Brown <broonie@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH] ASoC: soc-pcm: change error message to debug message
Message-ID: <20210209222331.GD4916@sirena.org.uk>
References: <1612771965-5776-1-git-send-email-shengjiu.wang@nxp.com>
 <b7f5442d-ad21-eb8a-7d90-7a8207320541@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="J5MfuwkIyy7RmF4Q"
Content-Disposition: inline
In-Reply-To: <b7f5442d-ad21-eb8a-7d90-7a8207320541@linux.intel.com>
X-Cookie: Put your trust in those who are worthy.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com,
 Shengjiu Wang <shengjiu.wang@nxp.com>, linux-kernel@vger.kernel.org,
 tiwai@suse.com
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


--J5MfuwkIyy7RmF4Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 08, 2021 at 09:06:44AM -0600, Pierre-Louis Bossart wrote:

> If you demote this to dev_dbg, we'll have to ask every single user who
> reports 'sound is broken' to enable dynamic debug traces. I really don't see
> the benefit, this is a clear case of 'fail big and fail early', partly
> concealing the problem doesn't make it go away but harder to diagnose.

Don't you also get the same information out of the DAPM debugfs or did
I misread where the error is generated from?

--J5MfuwkIyy7RmF4Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmAjC2IACgkQJNaLcl1U
h9DwFAf8DLNKdQrHOYHHu+fNRUcqtMVhFvVVF0+cfmG9XU5BbkLm99NYsC1DZXFR
gesRhVjscehAl32rdW26yebEpK25sZ/yivEnPTmgmk/Y+jRzGRHQhAu2wowQtBlO
bJrqcsb72F4oYduMlICmRI9cya3AnWDwlQh5tX6iaYoQT28jM/KqtN0SYWQl9b0Z
ASTnP0KDq9M8nb5PftaVzKa7QGw+owjzxg5aZoEdqs1GuBFJOXJFQKk22b3vUl9S
OUb9tqhjJckUoKWm7mMs5lF3TI6nZHXxRuvBKPxlgLmfyYUkf87ld6oqGzKF7Av5
wLxjnJveFW0YK1Pmj4Es65nSBVdTOg==
=8ykL
-----END PGP SIGNATURE-----

--J5MfuwkIyy7RmF4Q--
