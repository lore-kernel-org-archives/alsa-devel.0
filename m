Return-Path: <SRS0=lC1U=7X=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9F3AC433DF
	for <alsa-devel@archiver.kernel.org>; Wed, 10 Jun 2020 10:59:29 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36CDC206F7
	for <alsa-devel@archiver.kernel.org>; Wed, 10 Jun 2020 10:59:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="pO440wqy";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="B88mvquo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36CDC206F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CEC781661;
	Wed, 10 Jun 2020 12:58:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CEC781661
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1591786767;
	bh=rSbEJSH5wWHm/u11HYgmNGrwGzUdhPr2VTU9myeit8Y=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pO440wqyIQE9FIz0kxuLspjNl144arKZjERD6OaCbTKqqaJi1a5Mm/ctGLeONJ41M
	 b8L3Bt/sXwv/xLjy2USijQoAC5QE4XMDS6QnayjS3ZYM9EPU4QYauvhG1sAmT2lHXm
	 pIN5XzEN2Qi0BatoIt3XPBVC0kcGCyqcANMjzf4I=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 74242F8021E;
	Wed, 10 Jun 2020 12:58:37 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 075F6F80228; Wed, 10 Jun 2020 12:58:31 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 64341F800E0
 for <alsa-devel@alsa-project.org>; Wed, 10 Jun 2020 12:58:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 64341F800E0
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="B88mvquo"
Received: from localhost (unknown [122.171.156.216])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 64F92206F7;
 Wed, 10 Jun 2020 10:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1591786705;
 bh=rSbEJSH5wWHm/u11HYgmNGrwGzUdhPr2VTU9myeit8Y=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=B88mvquodblHQiVmx/bmvCnLjjKFTzUMx6y9jLgDG+utdI1Sat2H6uJiyvFafdAcW
 EUfQcV3aPa8DikIELFcI2W82W6ZH3AZ9zyu9If+6SgeygqbbhcJUk+d0g8Da8UfxZL
 aq88/Fy/nLQ+DwxJDvl7BRg3I4mJ/g5Q7/iyjX1M=
Date: Wed, 10 Jun 2020 16:28:20 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [RFC PATCH] ALSA: compress: Fix gapless playback state machine
Message-ID: <20200610105820.GA1393454@vkoul-mobl>
References: <20200610100729.362-1-srinivas.kandagatla@linaro.org>
 <817d009e-fa09-e897-cfc3-997bf1dd5e30@perex.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <817d009e-fa09-e897-cfc3-997bf1dd5e30@perex.cz>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, tiwai@suse.com,
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

On 10-06-20, 12:40, Jaroslav Kysela wrote:
> Dne 10. 06. 20 v 12:07 Srinivas Kandagatla napsal(a):
> > For gapless playback call to snd_compr_drain_notify() after
> > partial drain should put the state to SNDRV_PCM_STATE_RUNNING
> > rather than SNDRV_PCM_STATE_SETUP as the driver is ready to
> > process the buffers for new track.
> > 
> > With existing code, if we are playing 3 tracks in gapless, after
> > partial drain finished on previous track 1 the state is set to
> > SNDRV_PCM_STATE_SETUP which is then moved to SNDRV_PCM_STATE_PREPARED
> > after data write. With this state calls to snd_compr_next_track() and
> > few other calls will fail as they expect the state to be in
> > SNDRV_PCM_STATE_RUNNING.
> > 
> > Here is the sequence of events and state transitions:
> > 
> > 1. set_params (Track 1), state =  SNDRV_PCM_STATE_SETUP
> > 2. set_metadata (Track 1), no state change, state = SNDRV_PCM_STATE_SETUP
> > 3. fill and trigger start (Track 1), state = SNDRV_PCM_STATE_RUNNING
> > 4. set_next_track (Track 2), state = SNDRV_PCM_STATE_RUNNING
> > 5. partial_drain (Track 1), state = SNDRV_PCM_STATE_SETUP
> > 6  snd_compr_drain_notify (Track 1), state = SNDRV_PCM_STATE_SETUP
> > 7. fill data (Track 2), state = SNDRV_PCM_STATE_PREPARED
> > 8. set_metadata (Track 3), no state change, state = SNDRV_PCM_STATE_PREPARED
> > 9. set_next_track (Track 3), !! FAILURE as state != SNDRV_PCM_STATE_RUNNING
> 
> 
> The snd_compr_drain_notify() is called only from snd_compr_stop(). Something
> is missing in this sequence?

It is supposed to be invoked by driver when partial drain is complete..
both intel and sprd driver are calling this. snd_compr_stop is stop
while draining case so legit

Somehow not sure how it got missed earlier, but this seem a decent fix
but we still need to check all the states here..

-- 
~Vinod
