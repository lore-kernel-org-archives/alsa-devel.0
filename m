Return-Path: <SRS0=OXo6=44=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28D70C10F27
	for <alsa-devel@archiver.kernel.org>; Wed, 11 Mar 2020 08:46:55 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A672F20848
	for <alsa-devel@archiver.kernel.org>; Wed, 11 Mar 2020 08:46:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="TQdW7DMQ";
	dkim=pass (1024-bit key) header.d=perex.cz header.i=@perex.cz header.b="pkge8kUo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A672F20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=perex.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F13C3828;
	Wed, 11 Mar 2020 09:46:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F13C3828
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1583916413;
	bh=UXxuoap7XCsbUVFGwacQFUBfJTOmizXGh8Sehvss0As=;
	h=Subject:To:References:From:Date:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TQdW7DMQ54GwvrYWe4iwLIgg9WoHVEYFDoyir/BhPL9Y5hlHi2EcaSve2tYLJ1dS3
	 qDkFgLmcUH6JFZy5bBrfrVkVYONTu26B2zva1k+gTnq5zesxTygDOiES7mmiqElBwu
	 8QJq44bQPDbwV8MX/mfRAbekpEEDk7BpsZ//2GVg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7792FF801A3;
	Wed, 11 Mar 2020 09:46:02 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8CE9BF801EB; Wed, 11 Mar 2020 09:46:00 +0100 (CET)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9EDDFF800B5
 for <alsa-devel@alsa-project.org>; Wed, 11 Mar 2020 09:45:57 +0100 (CET)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 70EC0A0040;
 Wed, 11 Mar 2020 09:45:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 70EC0A0040
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1583916354; bh=YdDNNrmMnqdOt9QwgG5jXlRhPPsePmWXfgUSmyIathI=;
 h=Subject:To:References:From:Date:In-Reply-To:From;
 b=pkge8kUoAp+y32HzJVx+MV12yPAczUDUe4nxvOdFwgbC+s+6AEjzp6T8H13xBRpis
 UaMjEnuYl13MsxexVN42jV9kuBZojX/J7gEoyZCzrs6ylsI3SgzIvReWy90NxA3KRA
 EYK2lJfc7yygI+fmzQLolaV6iWETa//72JrSezPA=
Received: from p50.perex-int.cz (unknown [192.168.100.94])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Wed, 11 Mar 2020 09:45:52 +0100 (CET)
Subject: Re: [PATCH] alsaloop: reduce cumulative error caused by non-atomic
 samples calculation
To: Ruslan Bilovol <ruslan.bilovol@gmail.com>, alsa-devel@alsa-project.org
References: <1583785794-5173-1-git-send-email-ruslan.bilovol@gmail.com>
From: Jaroslav Kysela <perex@perex.cz>
Message-ID: <2a443d5d-a07a-7193-178f-70cfa5c14642@perex.cz>
Date: Wed, 11 Mar 2020 09:45:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1583785794-5173-1-git-send-email-ruslan.bilovol@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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

Dne 09. 03. 20 v 21:29 Ruslan Bilovol napsal(a):
> When doing loopback between two audio card with
> same sampling frequency, I noticed slow increase
> of pitch_diff.
> 
> When I changed order of get_queued_playback_samples()
> vs get_queued_capture_samples(), I noticed same drift
> of pitch_diff but if was decreasing this time.
> 
> This seems to be caused by non-atomic consecutive
> snd_pcm_delay() invocation for playback then for
> capture. snd_pcm_delay() measures delay between
> read/write call and actual ADC/DAC operation.
> 
> So while we get this value for playback path in
> get_queued_playback_samples(), next call to
> get_queued_capture_samples() will happen a little
> bit later so snd_pcm_delay() may return incorrect
> value.
> 
> Be interleaving get_queued_{playback,capture}_samples()
> order, we divide this small error between playback
> and capture paths. I do not see any issues anymore
> with one-way drift of pitch_diff.
> 
> Signed-off-by: Ruslan Bilovol <ruslan.bilovol@gmail.com>

Nice catch and implementation. Applied.

				Thank you,
					Jaroslav

> ---
>   alsaloop/pcmjob.c | 12 ++++++++++--
>   1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/alsaloop/pcmjob.c b/alsaloop/pcmjob.c
> index b252486..1b7925a 100644
> --- a/alsaloop/pcmjob.c
> +++ b/alsaloop/pcmjob.c
> @@ -1951,8 +1951,16 @@ int pcmjob_pollfds_handle(struct loopback *loop, struct pollfd *fds)
>   	}
>   	if (loop->sync != SYNC_TYPE_NONE) {
>   		snd_pcm_sframes_t pqueued, cqueued;
> -		pqueued = get_queued_playback_samples(loop);
> -		cqueued = get_queued_capture_samples(loop);
> +
> +		/* Reduce cumulative error by interleaving playback vs capture reading order */
> +		if (loop->total_queued_count & 1) {
> +			pqueued = get_queued_playback_samples(loop);
> +			cqueued = get_queued_capture_samples(loop);
> +		} else {
> +			cqueued = get_queued_capture_samples(loop);
> +			pqueued = get_queued_playback_samples(loop);
> +		}
> +
>   		if (verbose > 4)
>   			snd_output_printf(loop->output, "%s: queued %li/%li samples\n", loop->id, pqueued, cqueued);
>   		if (pqueued > 0)
> 


-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
