Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF5ECC3065A
	for <alsa-devel@archiver.kernel.org>; Mon,  1 Jul 2024 07:48:08 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2E813233D;
	Mon,  1 Jul 2024 09:47:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2E813233D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1719820087;
	bh=62EtLx2rOQcXg46lhp8cb5zB/P0swEUokGwSyGI8wpE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=nL2zLFD5nJooKW+GfsGuuyKoXXNuTj2BtBQpNZk679jWbn9Ffryw2QZ2CbIwUz0zy
	 1LJhOXGJfbF56unGyaunXfExfTLLPqa/3aY/JXezT+NEvVJ+gxqwT6x4KZiSqugnb3
	 lSJg6hLEUAwyLQaaI/QDUxeq6ZBmqxYKVjDvTiQc=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3EFD3F805BB; Mon,  1 Jul 2024 09:47:33 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id AC7E5F805B2;
	Mon,  1 Jul 2024 09:47:33 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C8EB5F8028B; Mon,  1 Jul 2024 09:47:27 +0200 (CEST)
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net
 [217.70.183.198])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 739F3F8003A
	for <alsa-devel@alsa-project.org>; Mon,  1 Jul 2024 09:47:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 739F3F8003A
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=gm1 header.b=nOwrn1G/
Received: by mail.gandi.net (Postfix) with ESMTPSA id BDF99C0009;
	Mon,  1 Jul 2024 07:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1719820043;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xSzCTTdVM/tcdktgKnj2I7uwAMajiojP6tk7tkVB+GU=;
	b=nOwrn1G/VVmjuD7GQhpAhtIOYD4Tk851VLzUI1ZTims5TqG4tZlpA7uSctgxtqbkI2K0Xj
	Nt7nlclZz9+hXabDud4SgSZrf1t0kwzdWf+0Of1xY8LXrf7cx4G4A3+uzneL3wK2ZwZS/z
	G6fOkCA5hspB4XuvatPoJSSf6RUlWv7PbcrhNxpDANZ2+l4lbXcGIPOkOiBOypxLqIANp+
	cR4r9RisDQab29H9k/zdkGFuwjlX9I6h4JU2gyDKM4IEyogbotiWf9VaNa0YGXMfuxBkSa
	zlt0sXdai9zB1+kvOGYnBomUFCe57yzDpOCXQ2X0hYLWj6dslwC+Nj9kHyH5pg==
Date: Mon, 1 Jul 2024 09:47:19 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: Herve Codina <herve.codina@bootlin.com>, Liam Girdwood
 <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Qiang Zhao <qiang.zhao@nxp.com>, Shengjiu Wang
 <shengjiu.wang@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam
 <festevam@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>, Jaroslav
 Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Christophe Leroy
 <christophe.leroy@csgroup.eu>
Cc: alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
 linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Thomas
 Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 10/10] ASoC: fsl: fsl_qmc_audio: Add support for
 non-interleaved mode.
Message-ID: <20240701094719.14f2eda3@bootlin.com>
In-Reply-To: <20240620084300.397853-11-herve.codina@bootlin.com>
References: <20240620084300.397853-1-herve.codina@bootlin.com>
	<20240620084300.397853-11-herve.codina@bootlin.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com
Message-ID-Hash: ID5IIS32D7U2PTEDIKCZCMCAL6QELQAA
X-Message-ID-Hash: ID5IIS32D7U2PTEDIKCZCMCAL6QELQAA
X-MailFrom: herve.codina@bootlin.com
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/ID5IIS32D7U2PTEDIKCZCMCAL6QELQAA/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Hi,

On Thu, 20 Jun 2024 10:42:57 +0200
Herve Codina <herve.codina@bootlin.com> wrote:

...
> +static bool qmc_audio_access_is_interleaved(snd_pcm_access_t access)
> +{
> +	switch (access) {
> +	case SNDRV_PCM_ACCESS_MMAP_INTERLEAVED:
> +	case SNDRV_PCM_ACCESS_RW_INTERLEAVED:
> +		return true;
> +	default:
> +		return false;
> +	}
> +};
> +

The ';' at the end of the function should not be here and will be removed
in the next iteration.
Also, this function will be changed to
--- 8< ---
static bool qmc_audio_access_is_interleaved(snd_pcm_access_t access)
{
	switch (access) {
	case SNDRV_PCM_ACCESS_MMAP_INTERLEAVED:
	case SNDRV_PCM_ACCESS_RW_INTERLEAVED:
		return true;
	default:
		break;
	}
	return false;
}
--- 8< ---

Hervé
