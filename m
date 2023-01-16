Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EEDFC54EBE
	for <alsa-devel@archiver.kernel.org>; Mon, 16 Jan 2023 20:46:33 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6682F5B64;
	Mon, 16 Jan 2023 21:45:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6682F5B64
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1673901991;
	bh=gaQum/hpEgSBkVT7pFMgUrrH6bNLpb4/zJIx6k5X3Uk=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tSWY7/dtBOQ1FqnvxtHZXr+S3KR5dCHhlKhILOhR7LwUpFx5A6W+0LJU9O2n9TZf0
	 Na7eL4z4DNZue+mUZwR8L3SBQhBTPu2IjFcVPgQGkURy5b4P5iZxvyJjFeWsSeKFIo
	 3EBUg0adIE1SwA9Nt042ngarweoR0OzyqIM4Rt8I=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 11E7DF8024C;
	Mon, 16 Jan 2023 21:45:41 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1C0C6F80482; Mon, 16 Jan 2023 21:45:40 +0100 (CET)
Received: from 3.mo548.mail-out.ovh.net (3.mo548.mail-out.ovh.net
 [188.165.32.156])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 58CE6F80083
 for <alsa-devel@alsa-project.org>; Mon, 16 Jan 2023 21:45:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 58CE6F80083
Received: from mxplan2.mail.ovh.net (unknown [10.108.16.163])
 by mo548.mail-out.ovh.net (Postfix) with ESMTPS id 96C7421D83
 for <alsa-devel@alsa-project.org>; Mon, 16 Jan 2023 20:45:33 +0000 (UTC)
Received: from gnuinos.org (37.59.142.99) by DAG5EX1.mxp2.local (172.16.2.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16; Mon, 16 Jan
 2023 21:45:33 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-99G0035b72070c-1b07-4496-8dc0-d357c7d292cf,
 E907DC29016DD070D6EDB782DE4A89F4728548EC) smtp.auth=aitor_czr@gnuinos.org
X-OVh-ClientIp: 88.11.110.122
Message-ID: <d8b10881-5fe4-4e62-53d5-072d7d984de1@gnuinos.org>
Date: Mon, 16 Jan 2023 21:45:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: Question about amidi -l output
To: <alsa-devel@alsa-project.org>
References: <01020185bc1fd1bd-853c4526-e5d2-428a-a216-1c38763f0b21-000000@eu-west-1.amazonses.com>
Content-Language: en-US
From: aitor <aitor_czr@gnuinos.org>
In-Reply-To: <01020185bc1fd1bd-853c4526-e5d2-428a-a216-1c38763f0b21-000000@eu-west-1.amazonses.com>
X-Originating-IP: [37.59.142.99]
X-ClientProxiedBy: DAG3EX1.mxp2.local (172.16.2.5) To DAG5EX1.mxp2.local
 (172.16.2.9)
X-Ovh-Tracer-GUID: e03ef893-0d68-4270-bc8b-aabdb4edb32d
X-Ovh-Tracer-Id: 13217220484403750423
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedruddtgedgudegudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurheptgfkffggfgfuvfhfhfgjihesrgdtreertdefjeenucfhrhhomheprghithhorhcuoegrihhtohhrpggtiihrsehgnhhuihhnohhsrdhorhhgqeenucggtffrrghtthgvrhhnpeekueeuvefhjeehlefgffffjedvvddtuedvudejleffuddtieevieelhfefueelveenucffohhmrghinheprghlshgrqdhprhhojhgvtghtrdhorhhgnecukfhppeduvdejrddtrddtrddupdefjedrheelrddugedvrdelleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepoegrihhtohhrpggtiihrsehgnhhuihhnohhsrdhorhhgqedpnhgspghrtghpthhtohepuddprhgtphhtthhopegrlhhsrgdquggvvhgvlhesrghlshgrqdhprhhojhgvtghtrdhorhhgpdfovfetjfhoshhtpehmohehgeekpdhmohguvgepshhmthhpohhuth
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

Hi Jeroen,

On 16/1/23 20:48, Jeroen Baten wrote:

> I hope someone can point me in the right direction.
> So the Ardour application uses the output of amidi -l to name USB
> devices. In my case I now have 3 devices all named "Boutique MIDI 1",
> although they are 3 different types of synth.
> I already added the devices to usb-list and system-hwdb so lsusb shows
> up with correct synth names.
> What can I do to make amidi -l show better device names? Where do these
> names come from? What lib or db should I look at to patch and submit?
> I hope someone can help me.

You can use udev rules for that. The link below might help you:

https://www.alsa-project.org/wiki/Changing_card_IDs_with_udev

Cheers,

Aitor.

