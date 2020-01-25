Return-Path: <SRS0=22TH=3O=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FA92C2D0DB
	for <alsa-devel@archiver.kernel.org>; Sat, 25 Jan 2020 14:47:54 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 953ED2071A
	for <alsa-devel@archiver.kernel.org>; Sat, 25 Jan 2020 14:47:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ttF29NNO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 953ED2071A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jensverwiebe.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DE4321667;
	Sat, 25 Jan 2020 15:47:01 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DE4321667
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1579963672;
	bh=paXjJOAQuIVxToJxgP53BazCJwUl14vEVV6U5p8VlRc=;
	h=To:References:From:Date:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ttF29NNOO6BNq99q+/wWPeaUVxS8SRwPjqtdCA9pxiemNE27A0KeAM8Ze3SKyE0od
	 oi7NVfgLHVrH+YRCB4QUs4woxKOPcF8FQ+f+vIZhmCFYVqP+Uk3i+IxLl2VuhMLOfl
	 PxAIVj4JVaxCg6VQwqr9MV+vz/fELPiar3bLFWhE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 56129F801D9;
	Sat, 25 Jan 2020 15:47:01 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id AC920F800F5; Sat, 25 Jan 2020 15:46:59 +0100 (CET)
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 250BCF800F5
 for <alsa-devel@alsa-project.org>; Sat, 25 Jan 2020 15:46:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 250BCF800F5
Received: from [192.168.178.21] ([77.10.30.73]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MQMmF-1jHYOC0ayv-00MHlB for <alsa-devel@alsa-project.org>; Sat, 25 Jan 2020
 15:46:53 +0100
To: alsa-devel@alsa-project.org
References: <CABPh3UM=R0UwbRGDPWn3_14abVm7sE7dFYxVZMqxV0Pfg9=MaQ@mail.gmail.com>
From: Jens Verwiebe <info@jensverwiebe.de>
Message-ID: <49a2c15f-655e-ebdb-8913-a0728b9c3f03@jensverwiebe.de>
Date: Sat, 25 Jan 2020 15:46:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CABPh3UM=R0UwbRGDPWn3_14abVm7sE7dFYxVZMqxV0Pfg9=MaQ@mail.gmail.com>
Content-Language: de-DE
X-Provags-ID: V03:K1:abl4//U0lRONGZtLk6p/PTEWN9s/2juXBU+bHJGMFSkT+QZeFrd
 BFpaq/bjCxcW+7NMN63HzPEsWIahDjUVMLC+jq3sWj4Q7SeZnXoRa0j9mfqWT7SyAclordj
 6rWO994dMWn3/H75cbszCqJGPXa+F1VlI3OGWm8MAnvYN95wZbv1mkIbvkP7SxtQqrYeOZj
 EUJTuwmQyEozb4i2C5TJQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:iHqN/g3uKb4=:yZ2UbX/upnqSnEtWqOCCk6
 N/ds/LhyBS1kXSFAlUtaRnjNiUSO/VTI+Wwe89QsUxA4VB5zRp8Q1LhRsorZCd0X2YoZdgR5G
 KuPoQCyt5P78mtKK2cBtFIKhta4pUQkg3+bxbSGoI5V3hTzyi/0IWU5XivDGtoPxt8gaVfLpJ
 3FI6I88aYgshib/twqcieA1O0xxYoDfmkEKilJpa4clXqKkKjq5sS7lPLSyWHAzy4uC7LEJZ3
 tp0SsmZ8i5NCbxBBpso93X+Cwv9K/0vvEnzZoFyPp3ECT3qPjPLTwbRPdGHIzkHsLJUEEdBIY
 kQfw6yoYWSRjUOrkVrx4qEgbd4L8lH4TMw6EGCxJAPaQ7hl5/3F313up1pqq+SqD6l/qxsdnz
 /iYSO1t3w1g7Ivm/jdv8Cm0BM0iOa8xXh/YP4pbpajRvZn7duEmpk/4OgLSUI0Aenvzu7HaW9
 Y7B8KQSxJYUFJBJkwdNvwBpUqlpKi2RqRPn59SBQiWKYfB6q1hCpRKGqNzhL9wZUXfjKUfNMT
 cpqkKLaFSzZ8zsg2SPX9/XqNmP+UafVgJFznpEgJ1Fl4xSFFcmWfkT70evOl1aXQhXVqUhAsh
 0/o+bwua5PAdA3H1zvT6+VZE3ZXDcg3OwcDbsJMjDKsQXBdJLtHGKj76/ow/TEz80f+rHf3XR
 wLIE+qJp+kQz0xDw9yJ5jcYjyjFs/nI6ssDENc8MQcTsQDraRgvqJRGt3BOr8YLil1VeU5VbY
 398+dMvSIdKVCnaiXS7u6lUruO5+gAzH3wjxiYsqf+27pFueK2z3b5FVP+1MXKKugZhchv9za
 zyxsuHESVOr0JWAAUUuSqVukHvFWoiyp/RRTid/BtAUOFwHb6H8ZbkvG/ZgYq3yUg7tCVTm
Subject: Re: [alsa-devel] [PATCH] ALSA: usb-audio: add quirks for Line6
 Helix fw 2.82
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

Shall i show you the line6 forum entry where ppl confirmed ?

https://line6.com/support/topic/52539-need-linux-users-with-helix-helix-lt-helix-rack-helix-something/

Also my much older thread has info i gave you before:

https://line6.com/support/topic/4426-line-6-with-linux/#comments

So please don't miss that. The response from users is poor enough.


Jens

-- 

Jens Verwiebe
Allerskehre 44 - 22309 Hamburg

Tel.: +49 40 68 78 50
mailto: info@jensverwiebe.de
web: https://www.jensverwiebe.de

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
