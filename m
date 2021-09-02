Return-Path: <SRS0=0EZw=NY=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,CTE_8BIT_MISMATCH,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CBFFC432BE
	for <alsa-devel@archiver.kernel.org>; Thu,  2 Sep 2021 15:23:09 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D273F610A2
	for <alsa-devel@archiver.kernel.org>; Thu,  2 Sep 2021 15:23:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D273F610A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A813917B0;
	Thu,  2 Sep 2021 17:22:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A813917B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1630596185;
	bh=fvNlphRG7GhNUCz5o10bVAzUH84TDwIHR7GCZywVYEk=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=FmeJ/5PfirkXMjeorGIavjR1TkcS8qpXYlCblHVgbH6aVuqAXzlcexIAc46yyn+vp
	 /UNsfF5m4ii21HHfnedqhRdUYy0pvzEnna1krMUHT+br/DdnrRe+KL41Y4lKUImaWI
	 5Vk6orRq6MBijSxXZmI7V0XSX+2fGLVhsrRd8fOs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2ACEDF8025B;
	Thu,  2 Sep 2021 17:22:15 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 61429F80269; Thu,  2 Sep 2021 11:23:41 +0200 (CEST)
Received: from forward107j.mail.yandex.net (forward107j.mail.yandex.net
 [5.45.198.252])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0876FF8020D
 for <alsa-devel@alsa-project.org>; Thu,  2 Sep 2021 11:23:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0876FF8020D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru
 header.b="dQscbRVt"
Received: from sas1-debb23ad927f.qloud-c.yandex.net
 (sas1-debb23ad927f.qloud-c.yandex.net
 [IPv6:2a02:6b8:c14:3914:0:640:debb:23ad])
 by forward107j.mail.yandex.net (Yandex) with ESMTP id C60F688621D
 for <alsa-devel@alsa-project.org>; Thu,  2 Sep 2021 12:23:32 +0300 (MSK)
Received: from mail.yandex.ru (mail.yandex.ru [80.234.78.100])
 by sas1-debb23ad927f.qloud-c.yandex.net (mxback/Yandex) with HTTP id
 VNGJd11Jwa61-NWJ8KGdP; Thu, 02 Sep 2021 12:23:32 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
 t=1630574612; bh=m+w1r3GQvrmGYzRY1Lf3zRqgCa9e9mWiglJits8MuuI=;
 h=Message-Id:Date:Subject:To:From;
 b=dQscbRVtbTQRVO1E/SwenXfdEw0qt3TxYih1rXx3R8yJhOiPVaOGq3lHbnttRqPbk
 Rk62RP4mWoN4gEHpeIDMGchh0KJ7/j/ipulyBzZwzJRYB7x+eOQ+97EqTaqcNI1v0k
 9yN/rdmVJGwi9lm7Q+nAErCp6P6j5abY+rWbk/Qs=
Authentication-Results: sas1-debb23ad927f.qloud-c.yandex.net;
 dkim=pass header.i=@yandex.ru
Received: by sas1-767e5596d8d7.qloud-c.yandex.net with HTTP;
 Thu, 02 Sep 2021 12:23:32 +0300
From: =?utf-8?B?0KHRg9GA0LrQvtCyINCf0LDQstC10Ls=?= <surpaul@yandex.ru>
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Subject: No sound after kernel 5.8.15-301
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date: Thu, 02 Sep 2021 13:23:32 +0400
Message-Id: <333881630574354@mail.yandex.ru>
X-Mailman-Approved-At: Thu, 02 Sep 2021 17:22:13 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.15
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

   Hello!

   Â

   I lost sound from laptop speakers after updating the kernel. Sound via
   HDMI, AUX or Bluetooth works. Details on the links:
   [1]https://bbs.archlinux.org/viewtopic.php?id=269301
   [2]https://ask.fedoraproject.org/t/no-sound-after-kernel-5-8-15-301/164
   41
   Â
   Help me please.

   --Â

   Pavel Surkov

   Â

References

   1. https://bbs.archlinux.org/viewtopic.php?id=269301
   2. https://ask.fedoraproject.org/t/no-sound-after-kernel-5-8-15-301/16441
