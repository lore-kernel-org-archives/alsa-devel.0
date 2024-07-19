Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA5F5C3DA59
	for <alsa-devel@archiver.kernel.org>; Fri, 19 Jul 2024 07:26:55 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A1DCCE66;
	Fri, 19 Jul 2024 09:26:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A1DCCE66
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1721374012;
	bh=fsR4r83D0Rjp4EESb5D65/o3F2/faYX5vjAt5wxp8lk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=N8drS8d6kMzHhEg9TMiJmgcCRFh882jk+4pQqf3jVV6mGGFNEOfkvtA2CeSSqyF3y
	 I1g3fJEbnP7xoqWM7HjrOJM3R+UhVEoiedT4wUiUP8rO+XIzDThfnEX77bzq9rcKXz
	 Atn1xdguwJH16XOwgjpbC3QZPIQpFkqYyDFmVNLw=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7FE6BF805AD; Fri, 19 Jul 2024 09:26:31 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 95BA4F805B4;
	Fri, 19 Jul 2024 09:26:30 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2071BF8007E; Fri, 19 Jul 2024 09:21:38 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 8DF61F8007E
	for <alsa-devel@alsa-project.org>; Fri, 19 Jul 2024 09:17:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8DF61F8007E
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=QBQuWicn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721373441; x=1752909441;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=fsR4r83D0Rjp4EESb5D65/o3F2/faYX5vjAt5wxp8lk=;
  b=QBQuWicnigNwPU3Ti4jYsm0THL3sKegYgxbuJrOIdGp+EmLwmkXuoJHT
   FdvFB49bE7zkPP9sB9OeiI1cMq1Q0ofvqFKESU0fsnA1gGDLGYJXtRtq6
   LjWBsv+0Vi4Mow/y4P3Pe2EDmx/EQyYplpRdc9yjKmfszdScEmVXYZBjF
   6XMob7nx1azr4AwRuTf9FeG2Pxlcx1CzxEWL1L1nQuqNED1BoErOOKcZF
   mT9k0nXunbDlfSEWVb8APXGFIzTBrSoDJw/fcZJW3wehIZGLa/VsRNAHo
   yCq+H/wA8vidmVxOAtf64PZFvrzhyIcVERF9Tq73JWsf3b28V548mlYo0
   Q==;
X-CSE-ConnectionGUID: UREFyMAeTOadZwgYDerYRA==
X-CSE-MsgGUID: uWemaNr0TRG6Ur9aU8zbjA==
X-IronPort-AV: E=McAfee;i="6700,10204,11137"; a="19117518"
X-IronPort-AV: E=Sophos;i="6.09,220,1716274800";
   d="scan'208";a="19117518"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jul 2024 00:17:15 -0700
X-CSE-ConnectionGUID: socrVyXSQtK9N/tMVPTH4g==
X-CSE-MsgGUID: viO/oCXASOuiaCxybtxS5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,220,1716274800";
   d="scan'208";a="51300060"
Received: from aslawinx-mobl.ger.corp.intel.com (HELO [10.94.0.53])
 ([10.94.0.53])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jul 2024 00:17:13 -0700
Message-ID: <9d0a16c8-5539-4977-9ac0-9bbf3df56676@linux.intel.com>
Date: Fri, 19 Jul 2024 09:17:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 01/xx] ALSA: add snd_stream_is_playback/capture() macro
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>
References: <87zfqel1g7.wl-kuninori.morimoto.gx@renesas.com>
 <87y15yl1fa.wl-kuninori.morimoto.gx@renesas.com>
Content-Language: en-US
From: =?UTF-8?Q?Amadeusz_S=C5=82awi=C5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>
In-Reply-To: <87y15yl1fa.wl-kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Message-ID-Hash: JFZXW3TBTI7EDFRBQXXADDWHFZV7CYFH
X-Message-ID-Hash: JFZXW3TBTI7EDFRBQXXADDWHFZV7CYFH
X-MailFrom: amadeuszx.slawinski@linux.intel.com
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/JFZXW3TBTI7EDFRBQXXADDWHFZV7CYFH/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On 7/19/2024 1:34 AM, Kuninori Morimoto wrote:
> Many drivers are using below code to know the direction.
> 
> 	if (direction == SNDRV_PCM_STREAM_PLAYBACK)
> 
> Add snd_stream_is_playback/capture() macro to handle it.
> It also adds snd_substream_is_playback/capture() to handle
> snd_pcm_substream.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>   include/sound/pcm.h | 19 +++++++++++++++++++
>   1 file changed, 19 insertions(+)
> 
> diff --git a/include/sound/pcm.h b/include/sound/pcm.h
> index 3edd7a7346daa..024dc2b337154 100644
> --- a/include/sound/pcm.h
> +++ b/include/sound/pcm.h
> @@ -501,6 +501,25 @@ struct snd_pcm_substream {
>   
>   #define SUBSTREAM_BUSY(substream) ((substream)->ref_count > 0)
>   
> +static inline int snd_stream_is_playback(int stream)
> +{
> +	return stream == SNDRV_PCM_STREAM_PLAYBACK;
> +}
> +
> +static inline int snd_stream_is_capture(int stream)
> +{
> +	return stream == SNDRV_PCM_STREAM_CAPTURE;
> +}
> +
> +static inline int snd_substream_is_playback(const struct snd_pcm_substream *substream)
> +{
> +	return snd_stream_is_playback(substream->stream);
> +}
> +
> +static inline int snd_substream_is_capture(const struct snd_pcm_substream *substream)
> +{
> +	return snd_stream_is_capture(substream->stream);
> +}
>   
>   struct snd_pcm_str {
>   	int stream;				/* stream (direction) */

Perhaps you could use generics here, so you could have one caller for 
both cases?

Something like:
#define snd_pcm_is_playback(x) _Generic((x),                   \
         int :         (x == SNDRV_PCM_STREAM_PLAYBACK), \
         struct snd_pcm_substream *substream * : (x->stream == 
SNDRV_PCM_STREAM_PLAYBACK))(x)
or just call the above functions in it?
