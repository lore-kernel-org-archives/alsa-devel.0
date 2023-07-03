Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC7DBC001B0
	for <alsa-devel@archiver.kernel.org>; Mon,  3 Jul 2023 13:14:26 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EB2E11D7;
	Mon,  3 Jul 2023 15:13:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EB2E11D7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1688390064;
	bh=jTsgXs7KbqoUfzENhhrkAAzuUzQYmz/N8W48e7yom8Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=lNsXjtiTuxBQY8e0g2VneeOaAlGH3xMvKNz5INIKd5MIiAK8ymqQEk36lqHQMVzjg
	 sDGSinrhcwWt3k4xpoAzTUVWwcpLivlD5L2oNgaPX+cnXOQCIyDB1EbxvWtP6J6tOJ
	 E8L4u0LjU7rpL1n3A5jfnqd2A+Y3HAhDtdmaaSbU=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A0DF8F80100; Mon,  3 Jul 2023 15:13:09 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 1D464F80125;
	Mon,  3 Jul 2023 15:13:09 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6C5C2F80100; Mon,  3 Jul 2023 15:13:05 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 4E2F1F80100
	for <alsa-devel@alsa-project.org>; Mon,  3 Jul 2023 15:13:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4E2F1F80100
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 0DF8F60F19;
	Mon,  3 Jul 2023 13:13:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC9EAC433C9;
	Mon,  3 Jul 2023 13:12:56 +0000 (UTC)
Message-ID: <d78e6ec3-a531-8fd4-a785-29b6712f83ae@xs4all.nl>
Date: Mon, 3 Jul 2023 15:12:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/6] media: v4l2: Add audio capture and output support
Content-Language: en-US
To: Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.de>
Cc: Shengjiu Wang <shengjiu.wang@gmail.com>,
 Sakari Ailus <sakari.ailus@iki.fi>, Shengjiu Wang <shengjiu.wang@nxp.com>,
 tfiga@chromium.org, m.szyprowski@samsung.com, mchehab@kernel.org,
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 Xiubo.Lee@gmail.com, festevam@gmail.com, nicoleotsuka@gmail.com,
 lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
 alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
 Jacopo Mondi <jacopo@jmondi.org>
References: <1688002673-28493-1-git-send-email-shengjiu.wang@nxp.com>
 <1688002673-28493-2-git-send-email-shengjiu.wang@nxp.com>
 <ZJ6o5fT4V4HXivFa@valkosipuli.retiisi.eu>
 <CAA+D8AND1yZ7eZLjBGxVF=i3hLMecUm-j7AVHN9npJi-4=3VrA@mail.gmail.com>
 <87h6ql5hch.wl-tiwai@suse.de>
 <43f0ecdf-7454-49ae-96b3-2eae5487e9a5@sirena.org.uk>
From: Hans Verkuil <hverkuil@xs4all.nl>
In-Reply-To: <43f0ecdf-7454-49ae-96b3-2eae5487e9a5@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-ID-Hash: DMZ4UIWIDABX7KR2JE3P5BLPSIIWFZCV
X-Message-ID-Hash: DMZ4UIWIDABX7KR2JE3P5BLPSIIWFZCV
X-MailFrom: SRS0=zCDc=CV=xs4all.nl=hverkuil@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/DMZ4UIWIDABX7KR2JE3P5BLPSIIWFZCV/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On 03/07/2023 14:53, Mark Brown wrote:
> On Mon, Jul 03, 2023 at 02:07:10PM +0200, Takashi Iwai wrote:
>> Shengjiu Wang wrote:
> 
>>> There is no such memory to memory interface defined in ALSA.  Seems
>>> ALSA is not designed for M2M cases.
> 
>> There is no restriction to implement memory-to-memory capture in ALSA
>> framework.  It'd be a matter of the setup of PCM capture source, and
>> you can create a corresponding kcontrol element to switch the mode or
>> assign a dedicated PCM substream, for example.  It's just that there
>> was little demand for that.
> 
> Yeah, it's not a terrible idea.  We might use it more if we ever get
> better support for DSP audio, routing between the DSP and external
> devices if driven from the CPU would be a memory to memory thing.
> 
>> I'm not much against adding the audio capture feature to V4L2,
>> though, if it really makes sense.  But creating a crafted /dev/audio*
>> doesn't look like a great idea to me, at least.
> 
> I've still not looked at the code at all.

My main concern is that these cross-subsystem drivers are a pain to
maintain. So there have to be good reasons to do this.

Also it is kind of weird to have to use the V4L2 API in userspace to
deal with a specific audio conversion. Quite unexpected.

But in the end, that's a decision I can't make.

So I wait for that feedback. Note that if the decision is made that this
can use V4L2, then there is quite a lot more that needs to be done:
documentation, new compliance tests, etc. It's adding a new API, and that
comes with additional work...

Regards,

	Hans
