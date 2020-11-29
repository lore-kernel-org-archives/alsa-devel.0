Return-Path: <SRS0=XhTq=FD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EC27C3E8C5
	for <alsa-devel@archiver.kernel.org>; Sun, 29 Nov 2020 09:52:58 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A6DE207BC
	for <alsa-devel@archiver.kernel.org>; Sun, 29 Nov 2020 09:52:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="VaLV4c34"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A6DE207BC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=e-mail.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E3E6017D7;
	Sun, 29 Nov 2020 10:52:03 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E3E6017D7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1606643574;
	bh=yQOendWO06IH4MzKXjG9LuHed6EZE3HBwow5nkFPfKU=;
	h=Subject:From:To:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VaLV4c34SRCRH335xD0RlNd8TSneu2wzv/2FpnQUiW+nnIsF6Sjv9plYYwgze52HW
	 oAUgOXkmTXO+lH0w+CBRec4xx5i/21y23aRZgaUTaWlKBKm8hZqEUXoNs3vIg72iYj
	 cnglm8Hfen0NHKDXM2ia2xtOXcU2FfiEvkHkTmzg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 582AFF80148;
	Sun, 29 Nov 2020 10:52:03 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 39855F80168; Sun, 29 Nov 2020 10:52:02 +0100 (CET)
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CDC5EF8007E
 for <alsa-devel@alsa-project.org>; Sun, 29 Nov 2020 10:51:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CDC5EF8007E
Received: from [192.168.2.105] ([93.225.116.157]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MrxfX-1kOFkh3Elp-00o1Uh; Sun, 29 Nov 2020 10:51:58 +0100
Message-ID: <ff1568a6348d1eece000cced7a28c0b6893508cd.camel@e-mail.de>
Subject: Re: Help me debug snd_emu10k1 - Sound Blaster Audigy Series only
 working in 50% of the boots
From: Micha <debian@e-mail.de>
To: Takashi Iwai <tiwai@suse.de>
Date: Sun, 29 Nov 2020 10:51:58 +0100
In-Reply-To: <s5ha6v3jgdk.wl-tiwai@suse.de>
References: <f7053c2bcfc6698b693102f632daa24795b6fdfa.camel@e-mail.de>
 <s5ha6v3jgdk.wl-tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:GyErNlby+OGJBscR5kL8PKeBM0DAUs8vas3VAfiIMpqSWZjRUu6
 +6BLAh+Qbj1Q+9IVNrLdfDhgMmVj2/lM0lh1YQp8+tFOL+QC/+BulP/jLum141ilhd3bQng
 Mx08ibQZ26oxuTJfcVPRhLe58hwCtbsvDRhF0DdMdgPMFjxuEyp4uE4QjrJffc+KsgrrM/Y
 JASQKmFDFGQG0xZolhPMQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2VEz9CqHwB8=:xgaGXaDVJVi68rqgPRG/hz
 obf3/RwLp9sgRdqW851WsNARU5839yfSlpX48h/YaldliY9K7R0BoXA+msy7jju842v/7T/As
 UuEbuNqbZ8CGx/KbukWCjDLPREklLmVYtRkD5Fhnr06Z7CMuycNvjA0DhZUIz7p6fvRTkvh19
 T0ALCuDPdBoQUnMppfKSGF9ouI/wmmbzOwr4POowlUytARzgWJHgnURWjvMU1iKdFegryfUfq
 1aL1opmubGLiDFnWuUqwRgQZvITqm3yHPn/jEn3L+WqRXh4AW0sqXF4et8lxQgftlCIJwU1wc
 MHO/RJ6ZOBkeph3n4mhvnifaDVc7pfPl+RutBS4GcJkm/cMnq7MRqtBGu1uFSTM5X8W7cCweS
 zlWwDa2Xj00sBG5adYTpqrj6uIIOzcGjaasqCTE2nGRhldQwlUd2Ouo8pKwadyzbIN4gfP71l
 9ruRAlUHM6+HXJGFJvuAtteWWO99FdYXAsLuI+6Pr+fAlIVSMbCX
Cc: alsa-devel@alsa-project.org
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

> IIRC, this is a very long-standing problem, and it depends on the
> motherboard.
> 
> I'd start trying to increase the delay in the probe.  Although I
> thought that this didn't help in the past, maybe still worth to try.

How can I increase the delay for the probe? 


> I suppose this is something to do with emu10k1, but do you know what
> file read triggers this?  If it always happens after the probe
> failure, it should be easy to identify.
> 
> 
> thanks,
> 
> Takashi

To create this error, I only need to:
rmmod -fv snd_emu10k1 
and
insmod snd_emu10k1
insmod: ERROR: could not load module snd_emu10k1: No such file or
directory

But at the moment i can't reproducing the oops. In debian there has
been a kernel update to 5.9.9-1, maybe it was fixed.

regards Micha


