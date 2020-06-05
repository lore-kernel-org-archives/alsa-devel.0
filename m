Return-Path: <SRS0=S+eB=7S=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DBADC433E0
	for <alsa-devel@archiver.kernel.org>; Fri,  5 Jun 2020 09:45:56 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FE01206A2
	for <alsa-devel@archiver.kernel.org>; Fri,  5 Jun 2020 09:45:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="T67Nsa5i";
	dkim=pass (1024-bit key) header.d=perex.cz header.i=@perex.cz header.b="AA4ZIykn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FE01206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=perex.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 72BE61658;
	Fri,  5 Jun 2020 11:45:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 72BE61658
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1591350352;
	bh=gtRe2Ye7hNVfhkKI1mBoCwBjU3iPMV5I7UVuL96md8E=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=T67Nsa5iZtSWeUph/sEPaResqT7w3uvMTWtxkF9QvaK2iDQayap+3fZ/ZR2hK7ADJ
	 pXJ4wpLawiKhxlO2xdX/BIiE9uwH78Wurev51/rIKWUS0KpMxKCyJ7Alx2QIohysZb
	 tUTv9N5fB+zSUt9RjjINcZ8FJ5f3c/1coTEByERQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 56895F80108;
	Fri,  5 Jun 2020 11:45:01 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 34BC2F801ED; Fri,  5 Jun 2020 11:44:50 +0200 (CEST)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 33086F80132
 for <alsa-devel@alsa-project.org>; Fri,  5 Jun 2020 11:44:42 +0200 (CEST)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id A951BA003F;
 Fri,  5 Jun 2020 11:44:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz A951BA003F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1591350277; bh=qaRaf4lc7OYaACugjgMu9JQlvwdZGPLJjpDZ3T6fdYk=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=AA4ZIyknzr/ZFXKpOOZV3Q9JgkQ/fd34qoqkM5Ogxqzgfo+fpsRkdMH0BeIXJixvT
 dDuuUCjjuAo1X7zxgsD0QwOD8PoOtGRQtKpMtoino2ehu27pvtVs6+CUs1NcwEsGA8
 3kw0i9B6uNZ6bBgeuRCnf9psUAIsU7BaATtPgfLQ=
Received: from p50.perex-int.cz (unknown [192.168.100.94])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Fri,  5 Jun 2020 11:44:34 +0200 (CEST)
Subject: Re: Lenovo P520/Realtek ALC662 - front jack & mic in [FIXED]
To: Jan Pokorny <lists@t.poki.me>, alsa-devel@alsa-project.org
References: <ebbabedc-195b-afb7-d1e6-ce5523f92530@poki.me>
 <e523ea58-892d-4ab7-58aa-beb3c94a10a3@poki.me>
 <b25fc548-981e-5ae6-2895-ef9eb85912e1@poki.me>
 <f9cdb458-9e2e-c23b-675b-8b3ea55a8b51@poki.me>
From: Jaroslav Kysela <perex@perex.cz>
Message-ID: <70ccd2ef-8d72-221d-defe-6eb498e9f21e@perex.cz>
Date: Fri, 5 Jun 2020 11:44:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <f9cdb458-9e2e-c23b-675b-8b3ea55a8b51@poki.me>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: Mark Pearson <mpearson@lenovo.com>
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

Dne 02. 06. 20 v 13:59 Jan Pokorny napsal(a):
> Problem solved!
> 
> The solution was as simple as installing alsa-ucm package.
> (Extra credit to Mark Pearson for pointing some recent changes
> in that project out to me.)
> 
> Color me very embarrassed.
> 
> Perhaps the intention of keeping the package set minimal backfired
> (EDIT: nope, nothing seems to be actively associated with that
> package incl. opt-in ones), but frankly, have never needed this package,
> not even heard about it before.
> 
> I wonder why there are no pointers anywhere, at least in alsa-info.sh
> output that would perhaps make the case clear for the experts amongst
> you.  Or somewhere else, where it could be raised as a suggestion:
> 
>     It appears as if you have a card/coded that relies on UCM for it
>     to be used to the full extent, and UCM does not appear to be
>     installed.  Try installing that software, commonly packaged as
>     alsa-ucm.  Having it up-to-date may also help.
> 
> [if not anything else, perhaps at least this makes it on-topic for
> the list]
> 
> Perhaps even close relationship between alsa-utils and alsa-ucm,
> on the suggests/recommends level or something like that?
> 
> On the whole it seems more enlightenment towards users is advisable,
> on more than one front, mainly for the ignorants like me :-)

Thanks for this analysis. Please, create a Fedora bug for this for the further 
analysis / fixes. The alsa-ucm is installed for the workstation GUIs:

https://pagure.io/fedora-comps/blob/master/f/comps-f33.xml.in

See "Fedora Workstation", "LXDE Desktop", "LXQt Desktop" etc. All depends on 
the "multimedia" package group which contains alsa-ucm.

Anyway, it's a distro problem, so move the discussion to the right place.

					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
