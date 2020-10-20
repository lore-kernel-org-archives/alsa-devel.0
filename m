Return-Path: <SRS0=iKR9=D3=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 291F2C4363A
	for <alsa-devel@archiver.kernel.org>; Tue, 20 Oct 2020 18:12:23 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A9EC20770
	for <alsa-devel@archiver.kernel.org>; Tue, 20 Oct 2020 18:12:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="QSNytaB5";
	dkim=pass (1024-bit key) header.d=perex.cz header.i=@perex.cz header.b="hB/mnvu2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A9EC20770
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=perex.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B0D3116DD;
	Tue, 20 Oct 2020 20:11:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B0D3116DD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1603217536;
	bh=oYBd2BZdfJcsNwqjdHiEcNu1xeNHYVS8PVLKxcBamA0=;
	h=To:From:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=QSNytaB5jhjuRIlTYaxWM+RQiy2koZc8jkLDTfskNDG3uYMCQjhzaeKQ9Bv64kaso
	 euKb9ES4FJDdwbh6AIquaoK/brD80lt6oS99Hu1CjS6AIDdqNjo06W7GOP+J0Yqr/L
	 aVtiegMrrnymG/Wcp0iQlgp0hog65n3S7M8QmbPk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2D531F804AA;
	Tue, 20 Oct 2020 20:11:26 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 59CFBF804AB; Tue, 20 Oct 2020 20:11:24 +0200 (CEST)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8C8EAF80475
 for <alsa-devel@alsa-project.org>; Tue, 20 Oct 2020 20:11:19 +0200 (CEST)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 999EFA0040
 for <alsa-devel@alsa-project.org>; Tue, 20 Oct 2020 20:11:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 999EFA0040
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1603217478; bh=EPRowl5n0efdRUC7fmC7rEBRwd/30GvPr+ES8PkP3hc=;
 h=To:From:Subject:Date:From;
 b=hB/mnvu20uxVPFQnIBYAbC5pXMfoyVjuemG6ZJFyOo3IFpFj3fVMeo44cD0oe5Pik
 1eNdEQZ3qQW6fgPZaQoCGEQ7jPAAThGDd3/EWH+Kypg+XXMag8pHDie9niyDrF9sVl
 TFa/hKeGCSeP/L+xxvqaQ8GC2pPdO8gEHvRm4Qtc=
Received: from p1gen2.perex-int.cz (unknown [192.168.100.98])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA
 for <alsa-devel@alsa-project.org>; Tue, 20 Oct 2020 20:11:17 +0200 (CEST)
To: ALSA development <alsa-devel@alsa-project.org>
From: Jaroslav Kysela <perex@perex.cz>
Subject: ALSA 1.2.4 release
Message-ID: <c2860da9-d21f-52bb-e15e-fda214e6890a@perex.cz>
Date: Tue, 20 Oct 2020 20:11:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
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

Hello all,

     new ALSA userspace packages were released. You may download them from
the ALSA website http://www.alsa-project.org or directly:

     FTP:  ftp://ftp.alsa-project.org/pub
     HTTP: https://www.alsa-project.org/files/pub

Full list of changes:

     https://www.alsa-project.org/wiki/Changes_v1.2.3.2_v1.2.4

All files on the primary ALSA site have also GPG signature now.
The fingerprint of the public signing key is:

     F04D F507 37AC 1A88 4C4B 3D71 8380 596D A6E5 9C91

				Have fun,
					Jaroslav



-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
