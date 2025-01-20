Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84DAAC02181
	for <alsa-devel@archiver.kernel.org>; Mon, 20 Jan 2025 17:56:12 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1808A60284;
	Mon, 20 Jan 2025 18:55:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1808A60284
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1737395769;
	bh=DWug9ITv7rRJWC7yGTnNtYq3b9rfkbk4rc/x/UXVyLI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=lOc5+Z1DBF9wJxDrl5G7Kb/WUwRXYhf257D+NNeuJAIao8z7YsgS0Lbh9Y8KB4kFy
	 HQAuuWeqw0hfs/IqHNSWEagBPrjxY4S8KpNg93hgClNZFcAeh62Eey8e/pv7ys6otM
	 4CMcKZl76dWh4ws9UuISFl/e63JCUNe4t4yBSEww=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E74FDF805C3; Mon, 20 Jan 2025 18:55:35 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 94D50F805C4;
	Mon, 20 Jan 2025 18:55:35 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9944AF80482; Mon, 20 Jan 2025 18:55:20 +0100 (CET)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 25302F800E4
	for <alsa-devel@alsa-project.org>; Mon, 20 Jan 2025 18:55:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 25302F800E4
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=lDdTR7mh
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 8E136A412DF;
	Mon, 20 Jan 2025 17:53:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 988AEC4CEDD;
	Mon, 20 Jan 2025 17:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737395706;
	bh=DWug9ITv7rRJWC7yGTnNtYq3b9rfkbk4rc/x/UXVyLI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lDdTR7mhPr6dTlULbevWycc7Ws3FLiIza2hCqOI0vtILVb6mx5Ay1UVTyXDeXTWGG
	 L3EU1uRiQNkLSUlJDvxnY9xztUYotsrkIWOo7j0IcM5OHGkqeCtt6yWe61Gvno+vVI
	 bIJeQK9KUoCPnzpXMhUAlJPsUNyv3N8RVVl1DBHP6JIGYfDsRjKsIv3EPbDquz1E6f
	 F87tsa7FH03jQ2ZHtpARwtgTYxYsRJDeCflGNJqwFX8dKiN0UHtDnKQ4gXkrE1jRCL
	 eDxpXepMd5b4n9954HDCznmt6SBIiiDRI2RyxCiah6ZSbT4NPMX94X/3UC4KJ1X4A9
	 dNKiPMzpd6KnA==
Date: Mon, 20 Jan 2025 17:55:01 +0000
From: Mark Brown <broonie@kernel.org>
To: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, perex@perex.cz,
	tiwai@suse.com, Basavaraj.Hiregoudar@amd.com,
	Sunil-kumar.Dommati@amd.com, venkataprasad.potturu@amd.com,
	Mario.Limonciello@amd.com, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 12/23] ASoC: amd: acp70: add acp ip interrupt handler
Message-ID: <4d6cf5b7-8f47-4cb8-b302-c02f3b037d6d@sirena.org.uk>
References: <20250120100130.3710412-1-Vijendar.Mukunda@amd.com>
 <20250120100130.3710412-13-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2DACFp3PvTQTLorN"
Content-Disposition: inline
In-Reply-To: <20250120100130.3710412-13-Vijendar.Mukunda@amd.com>
X-Cookie: No lifeguard on duty.
Message-ID-Hash: HP3FG7S4H5AJTBTYRW32EYMAA7KVZB7C
X-Message-ID-Hash: HP3FG7S4H5AJTBTYRW32EYMAA7KVZB7C
X-MailFrom: broonie@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/HP3FG7S4H5AJTBTYRW32EYMAA7KVZB7C/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--2DACFp3PvTQTLorN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 20, 2025 at 03:31:19PM +0530, Vijendar Mukunda wrote:

> +static irqreturn_t acp70_irq_thread(int irq, void *context)
> +{
> +	struct sdw_dma_dev_data *sdw_dma_data;
> +	struct acp70_dev_data *adata = context;
> +	u32 stream_index;
> +
> +	sdw_dma_data = dev_get_drvdata(&adata->sdw_dma_dev->dev);
> +
> +	for (stream_index = 0; stream_index < ACP70_SDW0_DMA_MAX_STREAMS; stream_index++) {
> +		if (adata->sdw0_dma_intr_stat[stream_index]) {
> +			if (sdw_dma_data->sdw0_dma_stream[stream_index])
> +				snd_pcm_period_elapsed(sdw_dma_data->sdw0_dma_stream[stream_index]);
> +			adata->sdw0_dma_intr_stat[stream_index] = 0;
> +		}
> +	}
> +	for (stream_index = 0; stream_index < ACP70_SDW1_DMA_MAX_STREAMS; stream_index++) {
> +		if (adata->sdw1_dma_intr_stat[stream_index]) {
> +			if (sdw_dma_data->sdw1_dma_stream[stream_index])
> +				snd_pcm_period_elapsed(sdw_dma_data->sdw1_dma_stream[stream_index]);
> +			adata->sdw1_dma_intr_stat[stream_index] = 0;
> +		}
> +	}
> +	return IRQ_HANDLED;
> +}

I appreciate that this pattern is already (identically...) in the ps
driver but I'm not seeing anything here that looks like it can't run in
interrupt context - is there a special reason for deferring to thread
context?

> +static irqreturn_t acp70_irq_handler(int irq, void *dev_id)
> +{

This really does seem *very* similar to the acp63 code...

--2DACFp3PvTQTLorN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmeOjfQACgkQJNaLcl1U
h9C8gwf+N+6C3TIdqd2aoAGiIgYKEQPN6HeK6pCEQWOTG2gqxPytqX7AZs6WD+/Y
wWngTrcYBQIu0pBXFZXXAErzSbwkQ/ppzRBOLxlnQEQL4rvt5mlq3o4VMCOVwpz3
EZoZpKT+0JxZmpNtYQxPwxqfk2C0ouQ2eOMi5AMwfru/7U5H81Q4HmI6SXr3+wQO
BM01lmZWw+gBUc0CyWnxjS1fOqIxjabu/C220/rRkj3d5SzoYK56xuToxNxwzu8+
Q2GmIZVoLUE/IVdG3ObFC/Rs+xxkWGgQpx1fQ1WtoApxRBCUwFmoc292/kowBt/A
/xNC4BsPgJnpjsmr9UY1RWZnrW/2oQ==
=QkFS
-----END PGP SIGNATURE-----

--2DACFp3PvTQTLorN--
