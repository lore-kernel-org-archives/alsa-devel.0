Return-Path: <SRS0=zQEr=Y6=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C3DBC5DF62
	for <alsa-devel@archiver.kernel.org>; Wed,  6 Nov 2019 13:11:56 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CA3A217F4
	for <alsa-devel@archiver.kernel.org>; Wed,  6 Nov 2019 13:11:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="jGEH3dQq";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=perex.cz header.i=@perex.cz header.b="A0G0lwPl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CA3A217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=perex.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 29F891692;
	Wed,  6 Nov 2019 14:11:03 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 29F891692
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1573045913;
	bh=xEaQzC0K5v9J8IxdgaKMAuqQfpZFm7ipPYoSuGi3ZDg=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jGEH3dQq4euHduwiHdSRz8QXXFB8pS8v80sa7jLCpq2P4VEvRFEBtfoZ0bwdjx3uX
	 iJKBehfVOIqnmmDp7EQTnD75JOV8Kd3yhZl87Fm8oDyrRhm/z6ZUSF0qCDMFxYEsG/
	 zmLQZSW0PJTS4EPi5gwEOkeWGEGqW52tSoRunJhs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A65EFF80321;
	Wed,  6 Nov 2019 14:11:02 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4DF68F803D0; Wed,  6 Nov 2019 14:11:01 +0100 (CET)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7AD8CF800F3
 for <alsa-devel@alsa-project.org>; Wed,  6 Nov 2019 14:10:57 +0100 (CET)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 7E449A003F;
 Wed,  6 Nov 2019 14:10:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 7E449A003F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1573045857; bh=QXup/9cVIyiRJGPEjVI8jDnUCx9j7MaJvCPpCk+Gpow=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=A0G0lwPlZxBf9LtFlkI5FZ4n0C5JyZ1Q2A5JUZPiHh9bKKqGcqcsn1yJ2VXcQXNHL
 wMtWBjkaqM4saHOURVGGUKNHuJVKDc9xV9XbvTnM30FTXnhgW42OU/jcolhOyadEkF
 1IeT9qie6CmZ74MoW2jFxmUZQoJeNrcE0ypp0jl0=
Received: from p50.perex-int.cz (unknown [192.168.100.94])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Wed,  6 Nov 2019 14:10:53 +0100 (CET)
To: Kai Vehmanen <kai.vehmanen@linux.intel.com>
References: <6dcc3e0d-0df5-90cf-220f-59253d3b5c7c@perex.cz>
 <alpine.DEB.2.21.1911061327470.16459@zeliteleevi>
From: Jaroslav Kysela <perex@perex.cz>
Message-ID: <140d987f-280a-309a-d09c-fa4b210563db@perex.cz>
Date: Wed, 6 Nov 2019 14:10:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1911061327470.16459@zeliteleevi>
Content-Language: en-US
Cc: Takashi Iwai <tiwai@suse.de>,
 ALSA development <alsa-devel@alsa-project.org>,
 Mark Brown <broonie@kernel.org>
Subject: Re: [alsa-devel] UCM extensions
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Dne 06. 11. 19 v 12:50 Kai Vehmanen napsal(a):
> Hi Jaroslav,
> 
> On Tue, 5 Nov 2019, Jaroslav Kysela wrote:
> 
>> 	I make some internal ucm code cleanups in alsa-lib and added three
>> major extensions to allow more complex configurations which we require for the
>> SOF kernel driver.
> 
> looks very good and pragmatic way to tackle some of the issues you hit
> with current UCM.
> 
> E.g. the If block would be also sufficient to tackle the recent HDMI codec
> driver change (with a single UCM file) -- i.e. use existence of the
> hdac-hdmi driver controls to select which enable-sequences to run. Hmm, I
> like this better than trying to select a whole different UCM file based on
> which drivers are used.
> 
> And same usage pattern can be applied to other mixer control name changes
> (like you already did for the HDA mic control).
> 
> That of course leads to the question do we soon need mechanisms to
> choose between more than two conditions (e.g. if mixer controls have
> changed multiple times in recent kernels, so covering for this
> in UCM would need a Switch, If-Else, or similar). But yeah, one can
> always define another UCM, so keeping-it-simple might be the right
> choice here.

I already implemented the nested If (so you may use another If in the 
True/False blocks).

Also 'String' (equal, substring) and 'RegexMatch' conditions were added.

For the substitution, I added ${CardComponents}, too. The driver might pass 
another component description strings to the user space for a better 
identification - there is snd_component_add() kernel function for this.

>> 	I added everything to keep the interface backward compatible, so the
>> current applications should not observe any different behavior. The
>> applications like pulseaudio should use the 'hw:CARD_INDEX' specifier for the
>> open call in the future and snd_use_case_parse_ctl_elem_id() helper for the
>> element control names.
> 
> This sounds good as well. Some testing with common versions of
> e.g. Pulseaudio is probably in order to sanity check how this
> works.

Yep, I will do more testing.

Do you have any progress with the pulseaudio volume UCM extension? Could you 
send me a link to the repository again? Thank you.

					Jaroslav

> 
> Br, Kai
> 


-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
