Return-Path: <SRS0=Xjxi=JJ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3722C433B4
	for <alsa-devel@archiver.kernel.org>; Mon, 12 Apr 2021 11:45:59 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A82A6124C
	for <alsa-devel@archiver.kernel.org>; Mon, 12 Apr 2021 11:45:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A82A6124C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=perex.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 06B43950;
	Mon, 12 Apr 2021 13:45:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 06B43950
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1618227956;
	bh=SRf1e3086vuMyasCB0OG8UCVC2bMFs1e3EjrNjMGc0o=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=b9Ksd3KYtHVROxSlWlLnpTx/ECfaQVIlyTvLd/7JEo5ZvDMRvwxtyyw/SuM407kay
	 Z64Anj43L2ijpdpOhnbNExJ4mBrsjSTT7IR6oYSZJtaUspBAKDTP6VgrYGGoRePwMl
	 s2CtGANcSaHAP3yQqeMzHQ3MI9I+SCuFANzGwoqk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 30C02F8025B;
	Mon, 12 Apr 2021 13:45:05 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D35FBF80269; Mon, 12 Apr 2021 13:45:02 +0200 (CEST)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C9056F800D3
 for <alsa-devel@alsa-project.org>; Mon, 12 Apr 2021 13:44:49 +0200 (CEST)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 50408A003F;
 Mon, 12 Apr 2021 13:44:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 50408A003F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1618227889; bh=DOfq0Wt/duVKTRwX740VO83XuL0sbDm/FYaFdchHlCw=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=jSwvndOdW2wmS0suDYsStY/RiMLk9yWZ9FoejGOsLNstZJsOqR0EToCAxHUJ3xxKX
 l41XiEMcitYADALWh59wiSD/jgCmAjGnbxd8a4/ORP/+2tAH1fDjtXYTXuLoajfQ7/
 BCVPHh071STQf/4cLAHiaqZsX4CSE45jIKAzO9Do=
Received: from p1gen2.localdomain (unknown [192.168.100.98])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Mon, 12 Apr 2021 13:44:45 +0200 (CEST)
Subject: Re: [PATCH v4] sound: rawmidi: Add framing mode
To: Takashi Iwai <tiwai@suse.de>
References: <20210410120229.1172054-1-coding@diwic.se>
 <df8cc177-f91d-28b1-c8df-1162dc136657@perex.cz>
 <bb91fc79-1b61-b051-1543-b5c8b1633fb3@diwic.se>
 <87f906a5-b77f-d3e8-29d7-7ce6e35c452a@perex.cz>
 <s5hk0p73l36.wl-tiwai@suse.de>
 <822b7ebf-71ac-2f84-731d-65e772eea1ff@perex.cz>
 <s5hfszv3jjq.wl-tiwai@suse.de>
 <a2d31a49-ec28-8b54-6632-3d24c96b624a@perex.cz>
 <s5h5z0r3g6k.wl-tiwai@suse.de>
From: Jaroslav Kysela <perex@perex.cz>
Message-ID: <9ed79f34-0c73-35de-81da-06f8423b239c@perex.cz>
Date: Mon, 12 Apr 2021 13:44:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <s5h5z0r3g6k.wl-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org, David Henningsson <coding@diwic.se>
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

Dne 12. 04. 21 v 13:17 Takashi Iwai napsal(a):

>> In this case, we have 31 free bits and this information can be stored there. I
>> would prefer to keep the reserved bytes for some large fields.
> 
> Again, C language doesn't define the position of the bit fields.
> That's the primary problem.

Yes and no. It seems that it's not a big C compiler implementation problem,
because other drivers are using the bitfields in the uapi structures, too.
Yes, it may need some extra care.

> If we really have to save the space, it's a nice workaround.  But for
> other purposes, there is really little merit and more flip side by
> that.

I see your reluctance to talk about extension of the bit field word, but
perhaps, we may be clever and define the flag word for the newly added
parameters now. The space may be used more precisely in the future with this
change.

					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
