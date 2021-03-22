Return-Path: <SRS0=WNy5=IU=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21DFFC433C1
	for <alsa-devel@archiver.kernel.org>; Mon, 22 Mar 2021 14:17:46 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 318C06196C
	for <alsa-devel@archiver.kernel.org>; Mon, 22 Mar 2021 14:17:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 318C06196C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=perex.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E9DCD10E;
	Mon, 22 Mar 2021 15:16:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E9DCD10E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1616422662;
	bh=x1vSANrkxmeiTzNrdOLzGJ9DkEQCp4Q8bi97FEB4y7Q=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kdeZNPmwhxBoXRtof+YFjEx+32drakKj90mn3sOKhgWZdnzs6OfnYkZiEEL5hHP6u
	 cqwzX7assXa3+KJ2r5IwhBAw6oAvCsAQIznJEvFEPyUnCS22vqQlIcJ/k0cKKLeBgA
	 ZNYrdgAOq6I9HT5D2p9Y7s7ECk63r1a8HUhX3ztU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4AFD1F80156;
	Mon, 22 Mar 2021 15:16:51 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 43478F8016B; Mon, 22 Mar 2021 15:16:49 +0100 (CET)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CAB83F80107
 for <alsa-devel@alsa-project.org>; Mon, 22 Mar 2021 15:16:35 +0100 (CET)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 34B9AA003F;
 Mon, 22 Mar 2021 15:16:35 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 34B9AA003F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1616422595; bh=oFqh6HppdXqLDRTTgLL9AdlUiteGjmDKmvK5hi5prxQ=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=LsViewbGa3JocwWTnqulNydG+YZWBo4OvB0c0/OAc/auACLZ+T8Pg7/YPqsEKjafO
 KHLz0/7Gn+7SA8PL/ExyiNo609bi0EotgSKlaouT1DPO83FtnSuiR8p+y1rMwUXPm+
 jGndrsAF9/WxZ0/JOofiC+bbNwLtzauYE8oAUVsc=
Received: from p1gen2.localdomain (unknown [192.168.100.98])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Mon, 22 Mar 2021 15:16:31 +0100 (CET)
Subject: Re: [PATCH v4 6/6] ALSA: led control - add sysfs kcontrol LED marking
 layer
To: Takashi Iwai <tiwai@suse.de>, Hans de Goede <hdegoede@redhat.com>
References: <20210317172945.842280-1-perex@perex.cz>
 <20210317172945.842280-7-perex@perex.cz>
 <a3ddb881-6580-cd25-ef3c-734e686e6942@redhat.com>
 <s5h5z1nf47r.wl-tiwai@suse.de>
 <3820909c-29ce-9f3f-d1e6-c4611e06abe4@redhat.com>
 <s5h35wqff1m.wl-tiwai@suse.de>
 <a2018c94-8731-de29-e447-92457176a1b4@redhat.com>
 <s5hy2eidul2.wl-tiwai@suse.de>
From: Jaroslav Kysela <perex@perex.cz>
Message-ID: <a9a62884-da5b-ef2a-10ec-e414e6784677@perex.cz>
Date: Mon, 22 Mar 2021 15:16:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <s5hy2eidul2.wl-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: Curtis Malainey <cujomalainey@google.com>,
 ALSA development <alsa-devel@alsa-project.org>
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

Dne 20. 03. 21 v 10:48 Takashi Iwai napsal(a):

>> With other OS you mean e.g. Android?  Android has device-specific
>> init-scripts which can either call alsactl or directly do the
>> echo-s.
> 
> Also ChromeOS.  I'd like to get a general consensus before moving
> forward.

Where are ChromeOS people? They could join to the discussion which is floating
few months now. Perhaps, the gmail's spam filter does not allow them to
communicate with us ;-)

						Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
