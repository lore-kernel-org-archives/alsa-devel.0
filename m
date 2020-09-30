Return-Path: <SRS0=iKRb=DH=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB9D0C2D0A8
	for <alsa-devel@archiver.kernel.org>; Wed, 30 Sep 2020 07:20:54 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E51882075F
	for <alsa-devel@archiver.kernel.org>; Wed, 30 Sep 2020 07:20:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="TwcgfjRm";
	dkim=pass (1024-bit key) header.d=perex.cz header.i=@perex.cz header.b="zxyvqLdK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E51882075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=perex.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2E7DD1807;
	Wed, 30 Sep 2020 09:20:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2E7DD1807
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1601450451;
	bh=4LY3KRbLaFvjihrJNPMlNk9VeBDGzziEf7YC5zvZePU=;
	h=Subject:To:References:From:Date:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TwcgfjRmscnkYDAvflym6TGkaTMDzMvKSTtVelErPFqDZrRvqIrROHr/6HU60+pzW
	 uJpOLWIROnPmCl2vy5kAJ1+ZyQgUcnyMDRNRnngcsOze4zWH/B7XG1v/sfhnVYUKU5
	 8tf6LD4T0kd7u8Iaqt6fyDkXoc3IC2kQua5C8e9s=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AC502F80110;
	Wed, 30 Sep 2020 09:20:00 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C57DFF801ED; Wed, 30 Sep 2020 09:19:58 +0200 (CEST)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5F9C9F80110
 for <alsa-devel@alsa-project.org>; Wed, 30 Sep 2020 09:19:55 +0200 (CEST)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 47334A003F;
 Wed, 30 Sep 2020 09:19:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 47334A003F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1601450393; bh=h9+oBBHP0KTt9VJc/OoNaNah5Dgd/JG9qgS6j/sxev4=;
 h=Subject:To:References:From:Date:In-Reply-To:From;
 b=zxyvqLdKKUwCGd2I9qGtLXBwN2OhhJBHJdTUf5Mbhzm7OWds1vGVFWT4EMusLgoI/
 a5C4EjmVDio+NZVY5R8cUedU+V2dceNQvQQ6nmzOlfW8HnbVuQWWJ21MNV5jQ0ocXa
 Y56VmQS8Fcvz/oY7WwPzHOG1TpMI2UsN0PEJ+TGU=
Received: from p1gen2.perex-int.cz (unknown [192.168.100.98])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Wed, 30 Sep 2020 09:19:50 +0200 (CEST)
Subject: Re: [PATCH] ALSA: hda - Don't register a cb func if it is registered
 already
To: Hui Wang <hui.wang@canonical.com>, alsa-devel@alsa-project.org,
 tiwai@suse.de
References: <20200930055146.5665-1-hui.wang@canonical.com>
From: Jaroslav Kysela <perex@perex.cz>
Message-ID: <bd05e1be-96e8-14bf-011c-b43d165abf17@perex.cz>
Date: Wed, 30 Sep 2020 09:19:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200930055146.5665-1-hui.wang@canonical.com>
Content-Type: text/plain; charset=utf-8
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

Dne 30. 09. 20 v 7:51 Hui Wang napsal(a):
> If the caller of enable_callback_mst() passes a cb func, the callee
> function will malloc memory and link this cb func to the list
> unconditionally. This will introduce problem if caller is in the
> hda_codec_ops.init() since the init() will be repeatedly called in the
> codec rt_resume().
> 
> So far, the patch_hdmi.c and patch_ca0132.c call enable_callback_mst()
> in the hda_codec_ops.init().

Won't be better to handle this double invocation at the callback call time? I
believe that some refcounting and pointing to one allocated callback structure
for all instances is better.

					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
