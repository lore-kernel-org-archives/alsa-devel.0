Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E962DC636D3
	for <alsa-devel@archiver.kernel.org>; Fri,  3 Feb 2023 00:13:07 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0CAC51DB;
	Fri,  3 Feb 2023 01:12:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0CAC51DB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1675383185;
	bh=gqxwPeNlRx+kG+3R5N+r3/ZF+0RUbb6MkLeIP15eV5Q=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oJS23pE5JU2kr2nbBj86BFG901MC4gw/IIO6te+1hjPJxMb3YO3fezW6URDZ8jh9U
	 1uTkeJ2T7hBNv8dN6NRU+TrW8wlwgq3o6lbxgJ+4MmnrEBBrKc8CUGNaWk5xrgq7jk
	 pAmG5XdJP5CtVmGtfGUfPPOGJ1eSuJoMJAHP0CRE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9316BF80271;
	Fri,  3 Feb 2023 01:12:14 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3134EF804C2; Fri,  3 Feb 2023 01:12:13 +0100 (CET)
Received: from 5.mo552.mail-out.ovh.net (5.mo552.mail-out.ovh.net
 [188.165.45.220])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 937ECF800ED
 for <alsa-devel@alsa-project.org>; Fri,  3 Feb 2023 01:12:08 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 937ECF800ED
Received: from mxplan2.mail.ovh.net (unknown [10.108.1.237])
 by mo552.mail-out.ovh.net (Postfix) with ESMTPS id 974DD2B8AB
 for <alsa-devel@alsa-project.org>; Fri,  3 Feb 2023 00:12:07 +0000 (UTC)
Received: from gnuinos.org (37.59.142.97) by DAG5EX1.mxp2.local (172.16.2.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.17; Fri, 3 Feb
 2023 01:12:07 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-97G002421b4ed4-7ef3-40b7-8000-3b5690505430,
 AF3C1994F3CAB3BA2770C3D535EE4C8A39E6775B) smtp.auth=aitor_czr@gnuinos.org
X-OVh-ClientIp: 88.11.110.122
Message-ID: <61f8c285-9be5-4842-81c5-ac319e3f0485@gnuinos.org>
Date: Fri, 3 Feb 2023 01:12:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: Is there any way to install alsa-lib with the suid bit set?
To: <alsa-devel@alsa-project.org>
References: <CAFBfLLcrTQ6_X85XWDdkcQgYUYFfRmJr1eYW29TP0=PFAVsmgg@mail.gmail.com>
Content-Language: en-US
From: aitor <aitor_czr@gnuinos.org>
In-Reply-To: <CAFBfLLcrTQ6_X85XWDdkcQgYUYFfRmJr1eYW29TP0=PFAVsmgg@mail.gmail.com>
X-Originating-IP: [37.59.142.97]
X-ClientProxiedBy: DAG2EX2.mxp2.local (172.16.2.4) To DAG5EX1.mxp2.local
 (172.16.2.9)
X-Ovh-Tracer-GUID: 2a102a6f-6827-4ce1-8e8c-e08c2c6c4667
X-Ovh-Tracer-Id: 5861153441797105175
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedrudefledgudekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucenucfjughrpegtkfffgggfuffvfhfhjghisegrtderredtfeejnecuhfhrohhmpegrihhtohhruceorghithhorhgptgiirhesghhnuhhinhhoshdrohhrgheqnecuggftrfgrthhtvghrnhepkeefgfejffduteejledtjeejuddvheeikeekkedvfffggeehveevvedvvdffledunecuffhomhgrihhnpehmrghnjedrohhrghenucfkphepuddvjedrtddrtddruddpfeejrdehledrudegvddrleejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpeeorghithhorhgptgiirhesghhnuhhinhhoshdrohhrgheqpdhnsggprhgtphhtthhopedupdhrtghpthhtoheprghlshgrqdguvghvvghlsegrlhhsrgdqphhrohhjvggtthdrohhrghdpoffvtefjohhsthepmhhoheehvddpmhhouggvpehsmhhtphhouhht
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.29
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

Hi Stefan,

On 29/1/23 22:52, Stefan Alexe wrote:
> I am trying to only use a static /dev. I have opened an issue about this on
> GitHub and got it to work only as the root user. This resembles my
> experience with xorg. In that case I had to use the suid use flag. Is there
> an equivalent in this situation?

The suid flag can be applied only to executables. Whereas there are examples
of libraries marked executable that can be run as standalone applications [*],
the point of setting this executable bit is to show some info about the library,
like the version number and so on. Nothing to do with the routines it provides
to every program linked against the library then. So, the answer is no. On the
other hand, the same goes for linux capabilities:

https://man7.org/linux/man-pages/man7/capabilities.7.html

Hope this helps,

Aitor.

[*] For the sake of example, try running *|libc.so.6*|

   

  
