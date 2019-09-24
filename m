Return-Path: <SRS0=SJ4a=XT=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 009F2C432C1
	for <alsa-devel@archiver.kernel.org>; Tue, 24 Sep 2019 21:53:23 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AC9F21655
	for <alsa-devel@archiver.kernel.org>; Tue, 24 Sep 2019 21:53:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="spjfWhdG";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d0ptLuEY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AC9F21655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7A98116A0;
	Tue, 24 Sep 2019 23:52:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7A98116A0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1569362000;
	bh=nwmje83Nfmsl7qttSc9qRLfh5TmSctckrB3gevuxX4Y=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=spjfWhdGypCreXlhs2tt8wCxszDl8S/JwJcwqbuUI1e6QDVemVsNLjvLVhLXsozv7
	 GXt57wBlf8Gh2vAWOI9xUP2EEGeXeeB0GMBp3r92g8QbQrhBs3Vi50wywrh/CMzfes
	 l3MnCdHcvEOp6qQiYIrcaRQzTLihDw8r904uDJWs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 116F9F803F4;
	Tue, 24 Sep 2019 23:52:30 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 37CF1F8045F; Tue, 24 Sep 2019 23:52:28 +0200 (CEST)
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20::443])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 624FBF800B4
 for <alsa-devel@alsa-project.org>; Tue, 24 Sep 2019 23:52:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 624FBF800B4
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="d0ptLuEY"
Received: by mail-pf1-x443.google.com with SMTP id q5so2096564pfg.13
 for <alsa-devel@alsa-project.org>; Tue, 24 Sep 2019 14:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=E1xMc24hYDUgJip/G3+nSaUWwisuKmB+ZHuc94zHHzk=;
 b=d0ptLuEYVEam1DP6UXz3ufvlKv0Rh2f7QGWIYd0pimxpen92m1nCjH63Y3oUmfgXdM
 e9vRofKj6tTXOAtvr+g2/9a4OV7tQDiVwVV3Kh3Sve7pqmIzmgRUghHnaZynH67SHnHW
 rIgf7ruRl3rhqnhyBHw02V8XZZKblWPDyB8D3/iet4MIZpE4iw5EZtcTjUztACEmkZLL
 1qjjugP3Ww2u7zIQkdavyfSi2BMnClZMrdlHfrmnhP4EwsJZcIS9b6CNLzqrxxbn7x7b
 fO0hIcWTRFU/XT3rix7PftJL6Pji5+QETeii4ZwTtvNk/+xxeGBV169AGXUu6Hlki8Xd
 onNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=E1xMc24hYDUgJip/G3+nSaUWwisuKmB+ZHuc94zHHzk=;
 b=WHEDzNn0Slw3WjpDk3S4V0ptQPNO1muiS5YZ+ZQ4laiQD7M/TwBWcKFFHbfac0pNOE
 jQ0r1l+qKFnY6sQsRDZ02FfpeFF8YPp5SmooYvPA2fWha22AE2728SOpRcRtMUQxM46O
 gBUBgNJVY6ANTWLo5UZVHqjSQpUdCUAMZytfOFCyD+yLaS+I4cwgZPVhtZacR68cLVTf
 hk7Tr5Jmvp9o7UEgPymbE37iMxnYflBfvzbwfgYMc7fjrL6++6KMKOGwNz/noRpk7HDg
 8/DvBJMHPiBEVLf2DZYSe/SECHMYp0JQbrceF9Oc25Kdl+qR/VEfd47uGqxb9PPGfleK
 b0vA==
X-Gm-Message-State: APjAAAWXsIbOR5Gv8rYgUr8uV46yEO2B6sR0qKv5ig0rd593eu4GbPXx
 hKoM72m+4ElsEYQgdjxSacI=
X-Google-Smtp-Source: APXvYqxe9O60bRaCPe/n2UFtUr8or3Vyc6C0TkkVo5BRee9PILbNcSSLNYNYmW98WrHaMtrjV5ZrRw==
X-Received: by 2002:a63:20d:: with SMTP id 13mr5329837pgc.253.1569361943377;
 Tue, 24 Sep 2019 14:52:23 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com.
 [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id h2sm6197465pfq.108.2019.09.24.14.52.22
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 24 Sep 2019 14:52:23 -0700 (PDT)
Date: Tue, 24 Sep 2019 14:51:35 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Message-ID: <20190924215135.GA2277@Asurada-Nvidia.nvidia.com>
References: <cover.1569296075.git.shengjiu.wang@nxp.com>
 <4d9aab898650c68ea57c10067830dac884eb7439.1569296075.git.shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4d9aab898650c68ea57c10067830dac884eb7439.1569296075.git.shengjiu.wang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, lars@metafoo.de, timur@kernel.org,
 Xiubo.Lee@gmail.com, linuxppc-dev@lists.ozlabs.org, tiwai@suse.com,
 lgirdwood@gmail.com, robh+dt@kernel.org, broonie@kernel.org,
 festevam@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [alsa-devel] [PATCH V4 3/4] ASoC: pcm_dmaengine: Extract
 snd_dmaengine_pcm_refine_runtime_hwparams
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On Tue, Sep 24, 2019 at 06:52:34PM +0800, Shengjiu Wang wrote:
> When set the runtime hardware parameters, we may need to query
> the capability of DMA to complete the parameters.
> 
> This patch is to Extract this operation from
> dmaengine_pcm_set_runtime_hwparams function to a separate function
> snd_dmaengine_pcm_refine_runtime_hwparams, that other components
> which need this feature can call this function.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

Looks good to me.

Reviewed-by: Nicolin Chen <nicoleotsuka@gmail.com>
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
