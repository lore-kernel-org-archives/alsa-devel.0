Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAED2C77B75
	for <alsa-devel@archiver.kernel.org>; Wed,  3 May 2023 20:21:12 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0E8B01458;
	Wed,  3 May 2023 22:20:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0E8B01458
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1683145270;
	bh=Sf8/zqxTJSkidU2WH/RUD8j2zzkozGJLbvu2nsmFIrs=;
	h=Date:From:To:Subject:References:In-Reply-To:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=J3YBGbJyqjsUyHQC7pmIV4fZWAs3hW6HJe49IS1CEEkJW907lKz20TmOGsDHjUJOh
	 Lu4bQRT/LOuacpDKsRi/mu75BY0HbhCR/F6OiYehI0BR0nVDWrRjpYL5da6KKmGxxo
	 04U3OufeTKoufwcI7vpDikHo9YAVAAAvrxQpjtnk=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 5774EF8049E;
	Wed,  3 May 2023 22:19:55 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 21FC7F8049E; Wed,  3 May 2023 22:19:51 +0200 (CEST)
Received: from bluemchen.kde.org (bluemchen.kde.org [209.51.188.41])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 143FBF800EC
	for <alsa-devel@alsa-project.org>; Wed,  3 May 2023 22:19:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 143FBF800EC
Received: from ugly.fritz.box (localhost [127.0.0.1])
	by bluemchen.kde.org (Postfix) with ESMTP id E6A1D23EB7;
	Wed,  3 May 2023 16:19:45 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.4, from userid 1000)
	id 1puIwz-4Ow-00; Wed, 03 May 2023 22:19:45 +0200
Date: Wed, 3 May 2023 22:19:45 +0200
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: Jaroslav Kysela <perex@perex.cz>,
	ALSA development <alsa-devel@alsa-project.org>
Subject: Re: [PATCH alsa-lib 1/4] pcm: hw: setup explicit silencing for
 snd_pcm_drain by default
Message-ID: <ZFLB4agt4SGCuvG0@ugly>
Mail-Followup-To: Jaroslav Kysela <perex@perex.cz>,
	ALSA development <alsa-devel@alsa-project.org>
References: <20230502115010.986325-1-perex@perex.cz>
 <20230502115010.986325-2-perex@perex.cz>
 <ZFJDhQZAiCPBpM0D@ugly>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ZFJDhQZAiCPBpM0D@ugly>
Message-ID-Hash: GKAV4KPJM5MPKPFP3VMSMTZ66FU44HPA
X-Message-ID-Hash: GKAV4KPJM5MPKPFP3VMSMTZ66FU44HPA
X-MailFrom: ossi@kde.org
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/GKAV4KPJM5MPKPFP3VMSMTZ66FU44HPA/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Wed, May 03, 2023 at 01:20:37PM +0200, Oswald Buddenhagen wrote:
>On Tue, May 02, 2023 at 01:50:07PM +0200, Jaroslav Kysela wrote:
>>+		 * or the next period wake up)
>>+		 */
>>+		sw_params.silence_threshold = pcm->buffer_size;
>>+		sw_params.silence_size = silence_size;
>>
>so at this point i got the thought "huh, that can exceed the buffer 
>size. is that ok?" ...
>and yes, it is. but ...
>
>the kernel doesn't check silence_threshold, so user space can trigger 
>the snd_BUG_ON() in snd_pcm_playback_silence(). whoops.
>(yes, this predates my patch.)
>i'm not sure what the best way to deal with this is. anyway, different 
>tree, different patch.

actually, that analysis is garbage, because i didn't look at enough 
context. :}

the kernel _does_ check the values in snd_pcm_sw_params(), which means 
that silence_size exceeding silence_threshold would lead to EINVAL, and 
therefore silencing being broken. this will inevitably happen with small 
buffer sizes, where the 1/10th sec extension dominates.

as snd_pcm_sw_params() checks the parameters (and snd_pcm_hw_params() 
resets the sw params to defaults, so inverse calling order cannot bypass 
it), the concern about the crash is invalid. phew.

regards
