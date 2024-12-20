Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F196E77188
	for <alsa-devel@archiver.kernel.org>; Fri, 20 Dec 2024 17:28:25 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 129F96024A;
	Fri, 20 Dec 2024 18:28:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 129F96024A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1734715704;
	bh=ftFlFL8Hf6gjCPdcRFrVx2YclVhyvU0X+h6fy2EfzIQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=rkGPuL7d1ejX2cX2EEQz8Vz2xFczpgAHJtQg5BTl7CsFB34VRAmNWWtmVVE/oR77e
	 KhpyEoo4G7Z45izIgdsUdFyese3k5yBYMO6G4g31PBJTPmoU+2e9W/wtKz7l/+3qIB
	 zpbLd9pDrJl0aWaBGHPlZeTjKBiU1X2yVn4kXBAg=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 81A1CF805C9; Fri, 20 Dec 2024 18:27:49 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 73E50F805BA;
	Fri, 20 Dec 2024 18:27:49 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 25911F80508; Fri, 20 Dec 2024 18:27:42 +0100 (CET)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 0ABB2F8003C
	for <alsa-devel@alsa-project.org>; Fri, 20 Dec 2024 18:27:39 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0ABB2F8003C
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=Q/4mhFqJ
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3863703258fso2074531f8f.1
        for <alsa-devel@alsa-project.org>;
 Fri, 20 Dec 2024 09:27:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734715658; x=1735320458;
 darn=alsa-project.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rl2GUGW1SKIB73yuGvAyVPoBfBy5XbBiVj4hV5yN+VI=;
        b=Q/4mhFqJTeGTuskZUIm7wtIgn2w7OFT3fCCCr9g/m5VS3EquU07UX/LNSWpmW8hn3V
         6oNdW5PO6AlH8dknNQIeaAbam2GBpcKouPT/AHwFT89mKlaSCkjdk20Q0JQuHwiw+Jr+
         8IIMD3d7uVzerQBt+lgNcY+h24oVb+bhMZYcLG6NWswZjF/jQCerGlH9SmQrOAnFllpG
         xx8YGjkP0xvZK7RtR86PKEoWtoZCgcLkyOL0mIs1I1zb6Xwlr8wU2Zn3xpuNWzwXVPM0
         xTpClxlbUTbaeA/3iYmsF8D7bN+2jFuyD/eLI/B6rch1xUyFMDR0yW4xGKFG3RXxH8CG
         MeHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734715658; x=1735320458;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rl2GUGW1SKIB73yuGvAyVPoBfBy5XbBiVj4hV5yN+VI=;
        b=TVi9PQ48Xx0HlxWRoWgF8xPtz/vUJKzULGg+MISW+LlrMlYcImvmMG/efuCXqLNslu
         KTDN1Ebiuc2pDQte/de8/yV1tMa5f47r49J2KK/WcV84+kxnB+PgqSUBlIhblBsCQ97B
         Gfwr5Jll9Zm25G/g+z2+BmMch/H2KfAKNEFqnS1VMPzgmBpdgZicqjfI56EXkDrnOOk6
         gBEis6C4g6gaogsryNTL0fI1BUMqx5kk2c9SYkXuCgpaAmlzrItgAKXNi6cJOUu6K7OX
         XhPuIjc1u68n20+ED8yjWkOxK9+UieDY+jXeo4vWcNdc7MkAMjjAOwt0wuY8xGOEJSbE
         v7og==
X-Forwarded-Encrypted: i=1;
 AJvYcCWNzehBuptqK8dSQGFZX2B5xHqVYtWIVIput3QKtFI+4ctcA6OSZPNrWOadu9xyiLr1iqVBPIipScHw@alsa-project.org
X-Gm-Message-State: AOJu0YxgdHfH6uDsmgvoIuDgoaEtZxkQ0JdX8d6THQ3MvzPhzFCKgTPf
	uhmrK/TZPC3oFcf0WjjZ14B37vaQ5GN+aDHI8sn+HVJMb2NQSxXg8kIggzBSP7E=
X-Gm-Gg: ASbGncuLjkFYDcy0HUqp3MXGlnm+wg4VJmMD3Yp6SCMhXjOToDD2o5IUfazoiZE8hpM
	XdrkmU3r7T2XWHylkL8lR3hN3fcLKtf5aSCviWVjEJM04fULcrhLud+CaF0M7xGea+ZYYTjQz13
	WzVmPEqK3BZ6qaH7GVB6zaLAk0mLhCqZRJ3b0k4AjFJxi+q6gFoli8+OogP4Y/ShcGDwP76xyKf
	/OFWYLfKQUdAnnoFK1K+Po/m3N2TFZC6NDQK0NBFFkNw+xhHT9wbkrwUSBEm4ct5riNxnwUGSI=
X-Google-Smtp-Source: 
 AGHT+IHQofl14bIpVpiQqz6qAEwAjKsEmWVjRCOjis6wH9jKfvKMjWLHCbYlsDgmYPDOjR7ci+Y7xw==
X-Received: by 2002:a5d:47c3:0:b0:388:cacf:24b0 with SMTP id
 ffacd0b85a97d-38a1a1f7253mr6745803f8f.2.1734715658179;
        Fri, 20 Dec 2024 09:27:38 -0800 (PST)
Received: from [192.168.68.114] ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c89e357sm4642915f8f.72.2024.12.20.09.27.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 09:27:37 -0800 (PST)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: linux-gpio@vger.kernel.org, Julia Lawall <Julia.Lawall@inria.fr>
Cc: kernel-janitors@vger.kernel.org, audit@vger.kernel.org,
 linux-mtd@lists.infradead.org, Zhihao Cheng <chengzhihao1@huawei.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, linux-arm-msm@vger.kernel.org,
 linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-usb@vger.kernel.org, linux-mm@kvack.org,
 maple-tree@lists.infradead.org, alsa-devel@alsa-project.org,
 Sanyog Kale <sanyog.r.kale@intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>, dccp@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>,
 drbd-dev@lists.linbit.com, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
 nvdimm@lists.linux.dev, linux-leds@vger.kernel.org,
 Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Naveen N Rao <naveen@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, tipc-discussion@lists.sourceforge.net,
 Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-trace-kernel@vger.kernel.org, Neil Brown <neilb@suse.de>,
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, linux-wireless@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org
In-Reply-To: <20240930112121.95324-1-Julia.Lawall@inria.fr>
References: <20240930112121.95324-1-Julia.Lawall@inria.fr>
Subject: Re: (subset) [PATCH 00/35] Reorganize kerneldoc parameter names
Message-Id: <173471565665.227782.7244101246430956449.b4-ty@linaro.org>
Date: Fri, 20 Dec 2024 17:27:36 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.2
Message-ID-Hash: YEAGWWDWS2KRONPJVTUHEVY3XWW3P3RR
X-Message-ID-Hash: YEAGWWDWS2KRONPJVTUHEVY3XWW3P3RR
X-MailFrom: srinivas.kandagatla@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/YEAGWWDWS2KRONPJVTUHEVY3XWW3P3RR/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


On Mon, 30 Sep 2024 13:20:46 +0200, Julia Lawall wrote:
> Reorganize kerneldoc parameter names to match the parameter
> order in the function header.
> 
> The misordered cases were identified using the following
> Coccinelle semantic patch:
> 
> // <smpl>
> @initialize:ocaml@
> @@
> 
> [...]

Applied, thanks!

[31/35] slimbus: messaging: Reorganize kerneldoc parameter names
        commit: 52d3d7f7a77ee9afc6a846b415790e13e1434847

Best regards,
-- 
Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

