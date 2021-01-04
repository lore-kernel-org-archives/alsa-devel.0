Return-Path: <SRS0=I7Cd=GH=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C596C433DB
	for <alsa-devel@archiver.kernel.org>; Mon,  4 Jan 2021 14:15:05 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81F7E20770
	for <alsa-devel@archiver.kernel.org>; Mon,  4 Jan 2021 14:15:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81F7E20770
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0F1211681;
	Mon,  4 Jan 2021 15:14:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0F1211681
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1609769703;
	bh=oqztWhFAZMPdxzyKlwb//7PmFe7TTLE83m1Z9TPVaEQ=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GiNhiFyJsK05ZQVWcRlErFBNYg38UMxNthXjujXt1beR/jSCyvKH+CJEaAC6TjpE4
	 2E9X6+lNUeEgq9YC4fs2+nPOOdPcGZOl3vJRJhcGk4FgCTEPnjUmYD7SJV4pLC8eMq
	 KRI/5VEVHh5SCzIYXqBLLIMpC/QyhPjxUAGUKJlI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 910C3F8012B;
	Mon,  4 Jan 2021 15:14:12 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 70161F80166; Mon,  4 Jan 2021 15:14:07 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CCF4DF8012C;
 Mon,  4 Jan 2021 15:13:58 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CCF4DF8012C
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="uKW/2yvA"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 95FB52245C;
 Mon,  4 Jan 2021 14:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1609769636;
 bh=oqztWhFAZMPdxzyKlwb//7PmFe7TTLE83m1Z9TPVaEQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=uKW/2yvAczC2Qcx4GHy0h6O1SUctibjcRTVbNo6njkQqeWBgZiGOx7D1o2b9E9Lrb
 17Io8T0KmdQe7/tHWrbr5QrxAARe8pIrHV8krqfTUwos2pTTTlqbmtmLp5axckNM0C
 G+MQKWwNq8XSLH0qyBJfTZYKL9WmXr91ozuo53y41S/2XFnaNbWUYeo98gLMbN/Bqd
 aoSzUbYZRlUTl+XiWX9OwCqifIfzGjB2uZPTBXiJT5soWNqZblYqryLjwuosbIbUfD
 sIuCQaXVGEx0jA5vwVBA/zJJOpEUwZBAl1pWaV4JYX0unGSkUMIdKf2Myiwg2SfCor
 ZbUPKhIIDY6iw==
Date: Mon, 4 Jan 2021 14:13:29 +0000
From: Mark Brown <broonie@kernel.org>
To: Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH] ALSA: hda: fix SND_INTEL_DSP_CONFIG dependency
Message-ID: <20210104141329.GG5645@sirena.org.uk>
References: <20210103135257.3611821-1-arnd@kernel.org>
 <s5hk0ss94kr.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="4eRLI4hEmsdu6Npr"
Content-Disposition: inline
In-Reply-To: <s5hk0ss94kr.wl-tiwai@suse.de>
X-Cookie: Stupidity is its own reward.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Arnd Bergmann <arnd@kernel.org>, alsa-devel@alsa-project.org,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>,
 Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Daniel Baluta <daniel.baluta@nxp.com>, sound-open-firmware@alsa-project.org
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


--4eRLI4hEmsdu6Npr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 04, 2021 at 03:09:24PM +0100, Takashi Iwai wrote:

> IMO, the problem is rather the unconditional calls of
> snd_intel_dsp_driver_probe() in snd-soc-sof-pci and snd-soc-sof-acpi
> drivers.  Those calls should be done only if Intel drivers are
> involved.  So, wrapping the call with ifdef
> CONFIG_SND_SOC_SOF_INTEL_PCI or CONFIG_SND_SOC_SOF_INTEL_ACPI would
> work better (although those are a bit uglier).

Or stubbing them which might be neater.

--4eRLI4hEmsdu6Npr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/zIogACgkQJNaLcl1U
h9Cs2gf+L8LA4jGPihc58O3+2gVfjpoTLwqR18RhrGsAJrQAhVjPb6+muvVH4rVw
aKm648duaehQ4484pZXS/LUtyEw70+N8RHhchEfyfHu47SVF1Avku3rjsqSIZQF0
qNe8HDF5kJ0npw2mazr/Iv+P1Uv7Yti9GVye63MmAaImJe5HPX9DmfQspj3zeIXu
NMFycv6wLpMoo4L0P5qxFxCkVKVZXSjeJED7/uXQVrtpSJzcWhU+cUn7HI/J48gl
Esu9cmu5UJLHzMbVpzhHxbH/L6GGljPGWxRfWoP9gP/GasEfv5q3gjBHeOLsPEgp
YnyLj/Uegu5vdqyK+bVllUs1klgm3A==
=HwUk
-----END PGP SIGNATURE-----

--4eRLI4hEmsdu6Npr--
