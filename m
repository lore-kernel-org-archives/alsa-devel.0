Return-Path: <SRS0=OoyA=6A=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DF11C2BA2B
	for <alsa-devel@archiver.kernel.org>; Thu, 16 Apr 2020 21:42:25 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5777221F9
	for <alsa-devel@archiver.kernel.org>; Thu, 16 Apr 2020 21:42:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="WrFvCvA/";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gerhold.net header.i=@gerhold.net header.b="iLqoV286"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5777221F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gerhold.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 42551823;
	Thu, 16 Apr 2020 23:41:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 42551823
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1587073343;
	bh=a92Zj4Dy9s3DO2yYDs5ga85N7Kd13dS6zmHTrt8AlCI=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WrFvCvA/VDlkQlZRF/WQ0B5flZz/8nQ97jfjqZq2eCqH7m6DUari9m78xF7vp0f2S
	 CgD5/Pcvsz9KUj8/DirKO4lBohhicI+wIPosAr248J1f9W40rKBvJ3vIZIxcQ4trOs
	 guuMyiotLhTOlm7SxDeD9amL58L95/eey7TYvD9s=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 66177F8013D;
	Thu, 16 Apr 2020 23:41:32 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2E9C7F8014E; Thu, 16 Apr 2020 23:41:30 +0200 (CEST)
Received: from mo6-p00-ob.smtp.rzone.de (mo6-p00-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5300::8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A7A99F800AB
 for <alsa-devel@alsa-project.org>; Thu, 16 Apr 2020 23:41:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A7A99F800AB
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gerhold.net header.i=@gerhold.net
 header.b="iLqoV286"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1587073282;
 s=strato-dkim-0002; d=gerhold.net;
 h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:
 X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
 bh=Mi2YUfMdJZkOSLL5QkcSs7SfLNPtVRp86fjqTsu2wqY=;
 b=iLqoV286Dt+GrmC6LECeFJUPPpUCjxfsSE4viz6tSTmwjHEnlFQbkZmVDWiIOJNHFh
 TnVZnAts7JMlDOu31X1dpLEaPgBSogY6CZkw4wduCE1H1+LLYu2hDLnlP0ed3nUAi4UO
 mVikQqNQ0IpN2njsbzV8GcNdh//yW9kIOMl6+SAPCLEQ3xHIinG3hBPPtL7CqWFbqHJZ
 UZNpxfYe6CVv4cmh+I5z8+ixfG/+ZkWKQtSaoAz45IN6KffJ+0+atHX5pwZaxwSqbEDb
 /mWLqhKUmtyuN/RG6AKc9Ica7I+oCs8b4JfRq4kOsrz7p0wM4xgcWn9RxxOxQxu1B1ZP
 +VFw==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u26zEodhPgRDZ8j6IczFaoo="
X-RZG-CLASS-ID: mo00
Received: from gerhold.net by smtp.strato.de (RZmta 46.4.1 DYNA|AUTH)
 with ESMTPSA id 2041c9w3GLfG0UG
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
 (Client did not present a certificate);
 Thu, 16 Apr 2020 23:41:16 +0200 (CEST)
Date: Thu, 16 Apr 2020 23:41:11 +0200
From: Stephan Gerhold <stephan@gerhold.net>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH] ASoC: soc-pcm: dpcm: Only allow playback/capture if
 supported
Message-ID: <20200416214111.GA898@gerhold.net>
References: <20200415104928.86091-1-stephan@gerhold.net>
 <61ccf27d-a511-b3a4-2da7-56edb01b24c6@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61ccf27d-a511-b3a4-2da7-56edb01b24c6@linux.intel.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Liam Girdwood <lgirdwood@gmail.com>, ~postmarketos/upstreaming@lists.sr.ht
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

On Thu, Apr 16, 2020 at 03:51:23PM -0500, Pierre-Louis Bossart wrote:
> 
> > diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
> > index 454735f8fa92..77a680da366f 100644
> > --- a/sound/soc/soc-pcm.c
> > +++ b/sound/soc/soc-pcm.c
> > @@ -2911,8 +2911,17 @@ int soc_new_pcm(struct snd_soc_pcm_runtime *rtd, int num)
> >   	int i;
> >   	if (rtd->dai_link->dynamic || rtd->dai_link->no_pcm) {
> > -		playback = rtd->dai_link->dpcm_playback;
> > -		capture = rtd->dai_link->dpcm_capture;
> > +		cpu_dai = asoc_rtd_to_cpu(rtd, 0);
> > +		if (rtd->num_cpus > 1) {
> > +			dev_err(rtd->dev,
> > +				"DPCM doesn't support Multi CPU yet\n");
> > +			return -EINVAL;
> > +		}
> > +
> > +		playback = rtd->dai_link->dpcm_playback &&
> > +			   snd_soc_dai_stream_valid(cpu_dai, SNDRV_PCM_STREAM_PLAYBACK);
> > +		capture = rtd->dai_link->dpcm_capture &&
> > +			  snd_soc_dai_stream_valid(cpu_dai, SNDRV_PCM_STREAM_CAPTURE);
> 
> This commit introduces major regressions with SOF on CherryTrail and
> Broadwell:
> 
>     [   25.705750]  SSP2-Codec: ASoC: no backend playback stream
>     [   27.923378]  SSP2-Codec: ASoC: no users playback at close - state
> 
> it's likely due to the check for min_channels > 0 in
> snd_soc_dai_stream_valid(), which wasn't a requirement before.
> 
> We are testing a fix [1] but other users of DPCM might be impacted.
> 

Indeed, I actually ran into a similar problem myself for q6afe-dai:
https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git/commit/?h=for-5.7&id=0c824ec094b5cda766c80d88c2036e28c24a4cb1

As mentioned in that commit message it was already broken on 5.7-rc1
for me, because of commit 0e9cf4c452ad ("ASoC: pcm: check if cpu-dai
supports a given stream"). [2]

With this commit it's more visible at least, you get a proper error
instead of silently not calling hw_params() for example. :)

[2]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0e9cf4c452ad7e2776441cbac0b9983abaf17ff0

> Mark, this commit is on your for-5.7 branch but not on for-next? Not sure
> which SHA1 to use for the Fixes: tag
> 
> [1] https://github.com/thesofproject/linux/pull/2018/commits/4fa10638dca8aad7a320e85cc3e00b179b8de410
