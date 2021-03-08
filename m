Return-Path: <SRS0=LCrH=IG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB61CC433E0
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Mar 2021 17:26:22 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68A496528B
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Mar 2021 17:26:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68A496528B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0348718E5;
	Mon,  8 Mar 2021 18:25:29 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0348718E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1615224379;
	bh=b6BRR50HzmVWmrotn7iSHieZh+VlfjdpIW3Os6BAFLU=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lMJbO2kI1mB0buNPShDgVcnAdX7+TK5z1tFKHzPsi++o338IU4mk9kmCZkbdyKVUp
	 7OjejipT1kiN5PA8ARPdT4v7b36BGQpwFPa6Y8W4nmiujsquQcxyfczRJb1urPmHq9
	 9BbztEbx2mPKrNsAtXmswbdANXiwddQmSOWYBpP0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7378DF800ED;
	Mon,  8 Mar 2021 18:25:28 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0A7D8F801D8; Mon,  8 Mar 2021 18:25:27 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 28557F800ED
 for <alsa-devel@alsa-project.org>; Mon,  8 Mar 2021 18:25:22 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 28557F800ED
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="q05+R6Qv"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 705F5652A8;
 Mon,  8 Mar 2021 17:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1615224320;
 bh=b6BRR50HzmVWmrotn7iSHieZh+VlfjdpIW3Os6BAFLU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=q05+R6QvIbOWHvQnLt40wPncFyjcTkw1RsV89WPmkcT+m7Kz8NSFneI0M3KzgGXBM
 TM6lXkvvvyWn8d9Oy+yGow9kvhLaSuCKraoZLV+BDk0swrxlSjM7ZpI4w6U7w/KZHe
 DMad0seUgaPb70hP9nd0ENcVas5MwnP04IkzTI734mwQMgVxMZmZeQe50c4w2iw90Y
 L56gml9uTuEPmW1CEy3FkpzqBQmFnNRqP6kEJTWrKkrDPT6E7Xs9pFfakyPUr6/9zp
 WMVlo6GzihqDePkx1SY+28OcS0bFMzwJLVlUYLl2hlfV8nMMYt4ktBm5xSJzq6BYb+
 kFgrfHGLje64w==
Date: Mon, 8 Mar 2021 17:24:09 +0000
From: Mark Brown <broonie@kernel.org>
To: Perry Yuan <Perry.Yuan@dell.com>
Subject: Re: [PATCH v4 2/2] ASoC: rt715:add micmute led state control supports
Message-ID: <20210308172409.GF4656@sirena.org.uk>
References: <20210301093834.19524-1-Perry_Yuan@Dell.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="QXO0/MSS4VvK6f+D"
Content-Disposition: inline
In-Reply-To: <20210301093834.19524-1-Perry_Yuan@Dell.com>
X-Cookie: Am I SHOPLIFTING?
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, mgross@linux.intel.com,
 hdegoede@redhat.com, lgirdwood@gmail.com, Mario.Limonciello@dell.com,
 tiwai@suse.com, pierre-louis.bossart@linux.intel.com,
 platform-driver-x86@vger.kernel.org, pobrn@protonmail.com,
 linux-kernel@vger.kernel.org
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


--QXO0/MSS4VvK6f+D
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 01, 2021 at 05:38:34PM +0800, Perry Yuan wrote:

> +	/* Micmute LED state changed by muted/unmute switch */
> +	if (mc->invert) {
> +		if (ucontrol->value.integer.value[0] || ucontrol->value.integer.value[1]) {
> +			micmute_led = LED_OFF;
> +		} else {
> +			micmute_led = LED_ON;
> +		}
> +		ledtrig_audio_set(LED_AUDIO_MICMUTE, micmute_led);
> +	}

These conditionals on inversion seem weird and counterintuitive.  If
we're going with this approach it would probably be clearer to define a
custom operation for the affected controls that wraps the standard one
and adds the LED setting rather than keying off invert like this.

--QXO0/MSS4VvK6f+D
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmBGXbgACgkQJNaLcl1U
h9AXRgf/e2ciVQlrAlmLa8m9QF1UsyV9296wawACwZFQLD7Wt16EsjqSW/c0tHDT
U3IeVN5wCG+DIO5MpG+BefiEH/tfqZXeokAwcK4kVm1WsNgDRK9yF1qJNmGdhEvg
iCTKDjBru0W/Xy06ETNZkDhnOm/YwTaZ/K8qn6XmVJaNaPioK9eWT+H09K4bnjdb
Kns45ThVDbzr2pBbO7LbMcE07oIGlZwbnoy4E0LTKYkZeVeM8RGAYCoYj17Npekc
Oe1SyE/KtHeZOeUMTEzxmj5NVBcvfsA/L0dD+OwlBrrsxZuxCe+t2qOV+WX2GmyV
FvF4wwH5rWLCAiJU6as/F2FLQBhnAA==
=JdN1
-----END PGP SIGNATURE-----

--QXO0/MSS4VvK6f+D--
