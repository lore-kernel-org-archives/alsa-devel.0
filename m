Return-Path: <SRS0=dMuI=H3=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AE6CC433DB
	for <alsa-devel@archiver.kernel.org>; Thu, 25 Feb 2021 11:31:33 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43ADD64ECF
	for <alsa-devel@archiver.kernel.org>; Thu, 25 Feb 2021 11:31:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43ADD64ECF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A44C616B1;
	Thu, 25 Feb 2021 12:30:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A44C616B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1614252690;
	bh=JBUYayNy3evHFwEU8b+lYJeGEoEUDi/DNq0J8g+SPTM=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=f4cujU0plbNa++a9Jld29Wowar9zHH75iltWcDI8oHYGGkMhHyEEpHHB5RqLDBEvR
	 ljjZZuERi1sJMNyajLyu0SHfOhp7mH+WKx/CaUus+qCiEoFIynvcME9OPzB1phumMP
	 D6xuQ4QHGvIyT915q9ONU604Af5ed4KFl5HfoHtE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 914BEF804EB;
	Thu, 25 Feb 2021 12:25:59 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4D997F8016C; Wed, 24 Feb 2021 08:09:02 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 77642F80159
 for <alsa-devel@alsa-project.org>; Wed, 24 Feb 2021 08:08:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 77642F80159
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net
 header.b="QZzTW3UN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1614150524;
 bh=JBUYayNy3evHFwEU8b+lYJeGEoEUDi/DNq0J8g+SPTM=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=QZzTW3UNngrZnLn4yZutnsVTjjnrvfS8H/Lzl8DsGC3af1Y12hCQASjhsNzyk7xgS
 Anwy3KisJuAbTkjyv28cvjBoAd+VU5L3eaoaMq5IsuP/9ZLRJA+KdFqhNZjfAR6abM
 hnGZw3RmFeG4UcNCmeBqYJ4Z53IbSoIaxbkd/tOE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from Valinor ([213.216.209.188]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MOzSu-1lT1DL3Vvg-00PPyQ; Wed, 24
 Feb 2021 08:08:44 +0100
Date: Wed, 24 Feb 2021 09:10:27 +0200
From: Lauri Kasanen <cand@gmx.com>
To: Wei Yongjun <weiyongjun1@huawei.com>
Subject: Re: [PATCH -next] sound: n64: Fix return value check in
 n64audio_probe()
Message-Id: <20210224091027.8d172c0b7aa4d6d651a3d34e@gmx.com>
In-Reply-To: <20210224013803.2146953-1-weiyongjun1@huawei.com>
References: <20210224013803.2146953-1-weiyongjun1@huawei.com>
X-Mailer: Sylpheed 3.5.0 (GTK+ 2.18.6; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:w274xjZp7tauHIHUJ0KH48Knh/UIezK9ZJRHbL1UhsWlkDbMYnc
 m5LxWvYoIQVxD7tt/hQG1T2RMSUiltGCcDsgWmSJBhOCd0LlMFWbwMh4KTxlD9YzpLRdcsw
 63UJYw14WM9jrH1v2N7paD644KZ9jfmRnPHOAlmnZM9oWth2wlellsd5Yum6LKW9No3I7t3
 PmciFgLpu8J0yMHmm0zMg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Q/4/yVZPhN8=:Zifqb/WYYtNIwpWcDiD4vz
 ovz3Q+qneELNLKYHgnkcIJzlnspUZuN/iIQn3OYtD2OSoymtw0v9RQvUgi0a+3ntweQAC/x8F
 pzjQ65Pz0eEkCgSj72TtvF/plWVgdO+q0/jqkogChVKlTawPOXepVqJsLGZgUZsW7e5JoymXg
 e9cyq6iKsyd9iN6LD6KvSxhiblv4HWmChz7SyfT3rIZgRV8RrZTsRawWNrUUP1x8NDA3WXoSK
 99pNA1q9qIzM2poNj3snXa1XV6Y+c0G7sJp2UYZ5z/Y/RaytjhaBepdW99CNymVl66q5tiW4N
 gbcrTB7MloJrXhmH688atMbyvb1P4h1KlbYlr6f2bkMTcDMJ9MaVZ4snFd/dasdEWC/hpFR89
 PJj271hPyyfq35GZOrNlyVodU2OERlA/gHYqRPahqnAlCc6T5TzTqx/WnHuXomYU1ZSoxECOB
 0uCK7t9Gc30mxoY+fliY9CCjIJqkVwldAD6cX0iCQTQB4BxcACcRpHMPdcyjU9pXegvKdKekp
 iJIbddMkTVHokHNCxuT8YV6b2HecfCL63BJE3s1HGqo2MMHE6YhZW+Qx1MzdC5rw1S1a1kIk8
 +dC9GlOFeUy5rTz0hwu3q7V+mr8kaNlnobNtMLTr6cOMrOaV+h7Ov9taDMs+m59v8KBtY9V4s
 lpkgcirPNNllzF6NQLxxjnZPEjsfdPPzHoLn1mBjZfCj8dHfVObwZWpsZvQ9QtbuHlSjNBJbu
 pTxrmTGL3s5I6FYL2OfvEANL6Mqyq9AsVkQBIWvaLpLkUbk3ZEF+AOHUn99GENYOfq3JG3Kao
 ccPIYDCxxECYyVOJKrqI7dymWxvW4zAJVQ024d2G1qhS+NWWM2ng5cmeWnafV2IMs/BX53tFk
 bxQg3OJy3lZK112kPkcQ==
X-Mailman-Approved-At: Thu, 25 Feb 2021 12:25:30 +0100
Cc: alsa-devel@alsa-project.org,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Takashi Iwai <tiwai@suse.com>,
 linux-kernel@vger.kernel.org, Hulk Robot <hulkci@huawei.com>
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

On Wed, 24 Feb 2021 01:38:03 +0000
Wei Yongjun <weiyongjun1@huawei.com> wrote:

> In case of error, the function devm_platform_ioremap_resource()
> returns ERR_PTR() and never returns NULL. The NULL test in the
> return value check should be replaced with IS_ERR().
>
> Fixes: 1448f8acf4cc ("sound: Add n64 driver")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  sound/mips/snd-n64.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Lauri Kasanen <cand@gmx.com>

- Lauri
