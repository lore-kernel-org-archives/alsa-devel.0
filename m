Return-Path: <SRS0=H+KG=D4=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19421C4363A
	for <alsa-devel@archiver.kernel.org>; Wed, 21 Oct 2020 08:24:29 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0352922249
	for <alsa-devel@archiver.kernel.org>; Wed, 21 Oct 2020 08:24:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Lh7pdXZL";
	dkim=pass (1024-bit key) header.d=perex.cz header.i=@perex.cz header.b="eIs8iUYH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0352922249
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=perex.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5D7431723;
	Wed, 21 Oct 2020 10:23:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5D7431723
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1603268662;
	bh=EPP935MPUrpuzprv70hW8ipua1fJwkpsl28fbpIyq+E=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Lh7pdXZLrj6f/g1KEHbvGynHTGk4/f5GZs542j6BThIWhkLAnfIj6DUuufFKwGSPr
	 TjhTdR3SGpPbBf7zlv4D4mrmGFNeSQBgIU8fjT5888UxYc0mg360NGB0y3XhlBQlY6
	 WhtmWJbxr8v7HBbpSEInh2z6Mlm5VGRlL+fjWOlc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BD812F80253;
	Wed, 21 Oct 2020 10:23:31 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9C819F80264; Wed, 21 Oct 2020 10:23:30 +0200 (CEST)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 770EFF80247
 for <alsa-devel@alsa-project.org>; Wed, 21 Oct 2020 10:23:23 +0200 (CEST)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 1D5FFA003F;
 Wed, 21 Oct 2020 10:23:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 1D5FFA003F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1603268603; bh=Y1iJ/N45CN1KRkNT9SnOm7GBc2M+tovomXTMjXL6/+E=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=eIs8iUYHcOiiMRXMp3f24oG5XL9N1xoiXMiALT53zstMrVaCott9kkmZtNGEksy4j
 EEIzhLPyyHR9/dhbpFFUMg7RNK66LAgj4SAva8UlIsum9pQL91UtWHylQWWJYkHF9C
 iQ3lR/P//5YATWkLsRglhrDKe8bmeUMC4rud4fzw=
Received: from p1gen2.perex-int.cz (unknown [192.168.100.98])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Wed, 21 Oct 2020 10:23:18 +0200 (CEST)
Subject: Re: [GIT PULL] ASoC updates for v5.10
To: Mark Brown <broonie@kernel.org>
References: <20201012130845.816462076C@mail.kernel.org>
 <a31e2b24-9ef4-c84f-a663-c2a44b0c8938@perex.cz>
 <20201012132857.GC4332@sirena.org.uk>
From: Jaroslav Kysela <perex@perex.cz>
Message-ID: <0cfec32c-c0b4-ddbc-6a23-f5b898966c48@perex.cz>
Date: Wed, 21 Oct 2020 10:23:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201012132857.GC4332@sirena.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org,
 Liam Girdwood <lgirdwood@gmail.com>
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

Dne 12. 10. 20 v 15:28 Mark Brown napsal(a):
> On Mon, Oct 12, 2020 at 03:16:18PM +0200, Jaroslav Kysela wrote:
>> Dne 12. 10. 20 v 15:08 Mark Brown napsal(a):
> 
>>> ASoC: Updates for v5.10
> 
>> I miss the SOF cleanups here:
> 
>> https://lore.kernel.org/alsa-devel/20200930152026.3902186-1-kai.vehmanen@linux.intel.com/
> 
> Yes, looks like they didn't make it.  Nothing looks particularly urgent
> in there.

Another week and this is ignored. At least, I cannot find this simple patch
set in your for-5.10 tree. I don't care about the cosmetic code fixes, but the
last warning suppression can reduce the maintainer / user confusions ("ASoC:
SOF: loader: handle all SOF_IPC_EXT types").

					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
