Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42D19C7EE23
	for <alsa-devel@archiver.kernel.org>; Mon, 22 May 2023 06:35:59 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7AFC7822;
	Mon, 22 May 2023 08:35:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7AFC7822
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1684737357;
	bh=V/ai1U8k9AkYcCk8dzKPH/UoP0ew6XE6GigvCFvxMeI=;
	h=Date:To:Cc:References:From:Subject:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=S+8I95hlz7t1/3zxX1lcZbYxLn0dkL7vIV52An+r0EAUn/a0VJmG6RJa6LSSAtJKz
	 BRCLPBhgtTAlBzZ/8nllm3H37LwPiIxDPM7oouxTmkgcmGTRFZF+caCXreCpB0aECf
	 rPpHHcW77ET1hY23Wi0bL2TszK66b0AeCL/I5/ng=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 11389F8024E; Mon, 22 May 2023 08:34:39 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 55319F8024E;
	Mon, 22 May 2023 08:34:38 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2250BF8024E; Mon, 22 May 2023 08:34:33 +0200 (CEST)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 983CAF8016A
	for <alsa-devel@alsa-project.org>; Mon, 22 May 2023 08:34:24 +0200 (CEST)
Received: from mail1.perex.cz (localhost [127.0.0.1])
	by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 64F7E1E2D;
	Mon, 22 May 2023 08:34:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 64F7E1E2D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
	t=1684737263; bh=SSqKCANCkbPDFTma8yaYbczhH18YpkZwEMz5G4zkRMg=;
	h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
	b=p1+04pFNgbC1EyFXTHyxFckyOnzRIzVmfsN1zrpiroWbUle7IPb3GoKIiaKNezZ87
	 cRabZT5HubUJ/HN9hcfwel6PLlpOAiaWV2fYMTRO8zUcgnQglCwbNqT5MQ918IF6pI
	 u5bivEkDZLKZE95LILzX6mv0SANnOPWQzT7oSDl8=
Received: from [192.168.100.98] (unknown [192.168.100.98])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	(Authenticated sender: perex)
	by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
	Mon, 22 May 2023 08:34:21 +0200 (CEST)
Message-ID: <d22c2686-9b36-40b7-f284-17e8b78a04ac@perex.cz>
Date: Mon, 22 May 2023 08:34:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Content-Language: en-US
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
References: <20230519093114.28813-1-tiwai@suse.de>
 <20230519093114.28813-4-tiwai@suse.de>
From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH 03/36] ALSA: rawmidi: UMP support
In-Reply-To: <20230519093114.28813-4-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Message-ID-Hash: TV64MMVNKZKWTIHPMWFIUP55G3MWO6X3
X-Message-ID-Hash: TV64MMVNKZKWTIHPMWFIUP55G3MWO6X3
X-MailFrom: perex@perex.cz
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/TV64MMVNKZKWTIHPMWFIUP55G3MWO6X3/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On 19. 05. 23 11:30, Takashi Iwai wrote:
> This patch adds the support helpers for UMP (Universal MIDI Packet) in
> ALSA core.
> 
> The basic design is that a rawmidi instance is assigned to each UMP
> Endpoint.  A UMP Endpoint provides a UMP stream, typically
> bidirectional (but can be also uni-directional, too), which may hold
> up to 16 UMP Groups, where each UMP (input/output) Group corresponds
> to the traditional MIDI I/O Endpoint.
> 
> Additionally, the ALSA UMP abstraction provides the multiple UMP
> Blocks that can be assigned to each UMP Endpoint.  A UMP Block is a
> metadata to hold the UMP Group clusters, and can represent the
> functions assigned to each UMP Group.  A typical implementation of UMP
> Block is the Group Terminal Blocks of USB MIDI 2.0 specification.
> 
> For distinguishing from the legacy byte-stream MIDI device, a new
> device "umpC*D*" will be created, instead of the standard (MIDI 1.0)
> devices "midiC*D*".  The UMP instance can be identified by the new
> rawmidi info bit SNDRV_RAWMIDI_INFO_UMP, too.
> 
> A UMP rawmidi device reads/writes only in 4-bytes words alignment,
> stored in CPU native endianness.
> 
> The transmit and receive functions take care of the input/out data
> alignment, and may return zero or aligned size, and the params ioctl
> may return -EINVAL when the given input/output buffer size isn't
> aligned.
> 
> A few new UMP-specific ioctls are added for obtaining the new UMP
> endpoint and block information.
> 
> As of this commit, no ALSA sequencer instance is attached to UMP
> devices yet.  They will be supported by later patches.
> 
> Along with those changes, the protocol version for rawmidi is bumped
> to 2.0.3.
> 
> Signed-off-by: Takashi Iwai <tiwai@suse.de>

Reviewed-by: Jaroslav Kysela

except:

> +/* UMP Endpoint information */
> +struct snd_ump_endpoint_info {
> +	int card;			/* card number */
> +	int device;			/* device number */

I suspect that those two fields were added to enumerate devices in the control 
API. But this extension seems to be missing in your patches. There is only 
SNDRV_CTL_IOCTL_UMP_NEXT_DEVICE implemented. Otherwise those two fields are 
not useful.

I also see the reference in the sequencer API 
SNDRV_SEQ_IOCTL_GET_CLIENT_UMP_INFO, but I don't get the use there, too.

> +/* UMP Block information */
> +struct snd_ump_block_info {
> +	int card;			/* card number */
> +	int device;			/* device number */

... dtto ...

					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.

