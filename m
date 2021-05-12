Return-Path: <SRS0=rxKz=KH=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F960C433ED
	for <alsa-devel@archiver.kernel.org>; Wed, 12 May 2021 15:55:05 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CE6361E02
	for <alsa-devel@archiver.kernel.org>; Wed, 12 May 2021 15:55:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CE6361E02
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B185A1833;
	Wed, 12 May 2021 17:54:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B185A1833
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1620834901;
	bh=N016NWgkukjszQxuR/Ofv+KdWercgaEVuGtmzHviWyo=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=U6wonkxxDyMVjSAlOHAImqW9vEe9S/gB+57t6XXQ5XJsmIkwscNuS+2IXSI6LvhXS
	 3s6+KgRLjD2FVSl1/k7zR9rAuBqp0m+49G9IHKJ34KRcWQqDc7nGgiz6VW/dHCV7mx
	 qRaYchO/Wr4mVu1V065ZN+HFcVUmuQPjf89jOWyM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 19591F8020C;
	Wed, 12 May 2021 17:54:11 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 04F95F80240; Wed, 12 May 2021 17:54:08 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2F794F800E9
 for <alsa-devel@alsa-project.org>; Wed, 12 May 2021 17:54:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2F794F800E9
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="X5Cdg4r8"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2BF0E61A14;
 Wed, 12 May 2021 15:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1620834838;
 bh=N016NWgkukjszQxuR/Ofv+KdWercgaEVuGtmzHviWyo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=X5Cdg4r8O9CTyFW0SZFaL9lRd52w/VAOm0W3w/7gomx1x4zSjmFLNuzS0E38Jlu3J
 WlfuucToIrQZqnZjO0y19g+ZpkE7oUZd4xpaE1d2RtY/oIzqZ56PFaLhCPPabKlXr/
 JldbdFvCB2K22Ts1uWzkH0uhmY5x9M2nmQQJk46JPa/XHd/nNoyifhVUp/csJEfLo4
 Vo0Xzjyb0CjdiWc9TjxZ8gB0KZXorXV5278qf7x0QnTc15exOoEjFKd61jVLNyx49M
 vKzG0dtFp491CtiKZMq8it5xQaw+9YRc5OQsTB6zmZsFFMEkpQ5q70rdJXkhxbHHC0
 MJJ673GPmnxhg==
Date: Wed, 12 May 2021 16:53:18 +0100
From: Mark Brown <broonie@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH -next] ASoC: intel/boards: add missing MODULE_DEVICE_TABLE
Message-ID: <20210512155318.GA54562@sirena.org.uk>
References: <1620791647-16024-1-git-send-email-zou_wei@huawei.com>
 <50fa973b-aa9f-ccb4-8020-9d38a63e2c30@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="/04w6evG8XlLl3ft"
Content-Disposition: inline
In-Reply-To: <50fa973b-aa9f-ccb4-8020-9d38a63e2c30@linux.intel.com>
X-Cookie: They just buzzed and buzzed...buzzed.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: sathyanarayana.nujella@intel.com, fred.oh@linux.intel.com,
 cezary.rojewski@intel.com, dharageswari.r@intel.com,
 kai.vehmanen@linux.intel.com, kuninori.morimoto.gx@renesas.com,
 linux-kernel@vger.kernel.org, yang.jie@linux.intel.com, tiwai@suse.com,
 liam.r.girdwood@linux.intel.com, tzungbi@google.com,
 ranjani.sridharan@linux.intel.com, Zou Wei <zou_wei@huawei.com>,
 alsa-devel@alsa-project.org, brent.lu@intel.com, yong.zhi@intel.com
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


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 12, 2021 at 08:41:43AM -0500, Pierre-Louis Bossart wrote:

> I wonder if this MODULE_DEVICE_TABLE generates the alias automatically,
> which would make the existing ones added manually at the end of the files
> unnecessary? If that was the case, then we should remove those MODULE_ALIAS
> as well, no?

Yes, you shouldn't need the MODULE_ALIAS stuff there.

--/04w6evG8XlLl3ft
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmCb+e0ACgkQJNaLcl1U
h9C94Qf/R8x4USWufxkjE/vfZi6GbULEc2gbk+fdtzu/4PUfiZ/ZLBWQalz/259s
VFG4tL+IaGU0dgVPODTSMazVCHHXdd3hxXGK5JYtzRv1NGPfi7IHLZmKkzw9yQv+
bAELKl0QB7JXnYXWp8xeKQPZXoUBng5TNESh4qL/vBbEzHNgEA9mvmYP/Uh1cXFc
oosiFoCLmhxxHGFhQwE5mDapqqF4RhRzDaq6paFvGzuGYIrhd6I4YHccJ1cOaRhP
QbikYG9KjKDZUqz8iPfTvVKV+uRuhvXaEfwLPkXPrLs1oQ8syyn/eEAgTw8/kzNL
Izn00HcKd3k0Pdq19CJGrDDzdhIJjg==
=WJu8
-----END PGP SIGNATURE-----

--/04w6evG8XlLl3ft--
