Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E174BC19F2D
	for <alsa-devel@archiver.kernel.org>; Tue, 16 Aug 2022 03:35:48 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5EEC3886;
	Tue, 16 Aug 2022 05:34:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5EEC3886
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1660620946;
	bh=OrhPLo0n4EDyxYz7KCsvj82kV6NSR0qbvoGE6l4vsc8=;
	h=Date:To:From:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=QbgIxEhk+ru6DFyU7gPjxaCLIdu6USVVHsL9T7H5IlAZVaLD2rW3kFlV55l6hS+OP
	 WrGVhCGXm9XSOY/SlwKYiOEnfrKdJRKqoo5vf5Pfsj9yI/5l9/o/11QiQXXnssbjBW
	 /Ewd6g7g/52J/BcLHgIGMN72uLX8UCZXcvb3Fpcw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DCFB1F80238;
	Tue, 16 Aug 2022 05:34:55 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2F3FFF8032D; Tue, 16 Aug 2022 05:34:53 +0200 (CEST)
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com
 [IPv6:2607:f8b0:4864:20::536])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2EF81F80118
 for <alsa-devel@alsa-project.org>; Tue, 16 Aug 2022 05:34:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2EF81F80118
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=flatmax-com.20210112.gappssmtp.com
 header.i=@flatmax-com.20210112.gappssmtp.com header.b="k/0B9+Ce"
Received: by mail-pg1-x536.google.com with SMTP id s206so8193841pgs.3
 for <alsa-devel@alsa-project.org>; Mon, 15 Aug 2022 20:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flatmax-com.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:subject:from:content-language:to
 :user-agent:mime-version:date:message-id:from:to:cc;
 bh=rsMIsTdil7J/nfOTy4q74VYe/P2Pbw3k0vGg0EJiatw=;
 b=k/0B9+CewBP8zh+KfbHVlYoZRwg084SJHjnoVPt6vqAO4YFJRy9weWNthja48tOH/f
 ugT23yI6s3Uz4xivvyOsredBOGEvnN0Dt3MGQzXjFrHpMtxS1XIyiEabsSUN8+oXfEuC
 jMo2zygQxTkxnX2xAlE27CiqrRj5J+VzQdZunWo3qyAbqYUJdFOIupF4e59o9bVXEKSp
 ErlacNGxtCAoC4RXiDVki7CScmjY5QGWRml3ew5rRo8TqwsRgpU1VtT+/OFOotWkP+5q
 DrxDcJ0wdxxabg+0/XladbpRH/ArPD0Jvot0ypQlI7k4zy9ZTimdrx21kDMvirubjgwH
 yVCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:subject:from:content-language:to
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc; bh=rsMIsTdil7J/nfOTy4q74VYe/P2Pbw3k0vGg0EJiatw=;
 b=zSD5ilLjhn9ewrVTKvzKmTJBeo99ZZbYDYaOAXgdR+HC76MKhvLrPD3p+RYcaQfO65
 83M1KkbJxzcUp5PWUR9KjGFZBageNGrhOJPfLEFiK2b531C667QUD3gHCqmpYixwUMmw
 BUM8SAZbwPgJALKBYpSUkUnvChUFUQF8DvuAOHDPsD5/yRVUfuaBkYukUbVJ06FjUaqe
 v2D3v/kOEY6ZdjLvy1fpI1Iz7tFww6MOGKXDGHuJFXdXpP6uSnBjDTdWDbMEMJFwmAuL
 dSj7eDvtEvwIYWZ8sJAnm/+be1Z+6YIJxL11vIizr51hRmiGVSPBB2ZMxyl3d3smffm6
 w+vw==
X-Gm-Message-State: ACgBeo1BcFKDATJFfYOJ0iC7jNctMtFEkh6uxdqewpGZbd5oKG81teBQ
 EhkSiRA/Q5Hur9Hx7J/kL0RG2gcbrxiV2w==
X-Google-Smtp-Source: AA6agR7ajsk58WdSRf5zsgAgSSibUz1EC9FGG1B++/F7r+qjDqhfACWB1N79mM2K4Z+dKnxSE82YqQ==
X-Received: by 2002:a63:1f26:0:b0:429:7f1e:4afc with SMTP id
 f38-20020a631f26000000b004297f1e4afcmr4103793pgf.622.1660620881437; 
 Mon, 15 Aug 2022 20:34:41 -0700 (PDT)
Received: from ?IPV6:2406:3400:213:70c0:9df6:7e57:88ce:1bea?
 ([2406:3400:213:70c0:9df6:7e57:88ce:1bea])
 by smtp.gmail.com with ESMTPSA id
 a12-20020a630b4c000000b004299489dd2bsm915493pgl.8.2022.08.15.20.34.39
 for <alsa-devel@alsa-project.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Aug 2022 20:34:41 -0700 (PDT)
Message-ID: <ee14e446-7db7-aaf8-0208-5e6d9f3f2aa3@flatmax.com>
Date: Tue, 16 Aug 2022 13:34:38 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
To: alsa-devel@alsa-project.org
Content-Language: en-AU
From: Matt Flax <flatmax@flatmax.com>
Subject: UAC gadget audio sample rates
Content-Type: text/plain; charset=UTF-8; format=flowed
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

Hi there,

Is it possible to have a USB audio gadget which supports 
multiple/arbitrary sample rates ?

Matt

