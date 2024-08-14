Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7692C3DA7F
	for <alsa-devel@archiver.kernel.org>; Thu, 15 Aug 2024 08:29:39 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 24FF62BFA;
	Thu, 15 Aug 2024 10:29:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 24FF62BFA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1723710578;
	bh=jP1PlyVQSYX+9EOblft8Z9RVmgYuBR/GJLEYElQscbg=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=Wwi+mKy6YUsoulTKS5O59Tej4sbEgplbFa/46vgNGFrw17XyhS3iggbFYrdvytpHz
	 qe4XOk1VRQIw+8BySEY2Rz1Bn/YfCEeMbMObMIGxKo6k0Zcy3j90dlvNcrLRXUfE0f
	 Ym1kc4USVSbjFZp3oMwgZjdReORe0YGHgEwVQbCA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6FA04F89684; Thu, 15 Aug 2024 10:24:43 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 19B7EF896F2;
	Thu, 15 Aug 2024 10:24:43 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 79046F80423; Wed, 14 Aug 2024 04:43:19 +0200 (CEST)
Received: from mail78-63.sinamail.sina.com.cn (mail78-63.sinamail.sina.com.cn
 [219.142.78.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 2C8F0F800B0
	for <alsa-devel@alsa-project.org>; Wed, 14 Aug 2024 04:43:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2C8F0F800B0
Received: from unknown (HELO zy-virtual-machine.localdomain)([180.172.39.131])
	by sina.net (10.185.250.32) with ESMTP
	id 66BC19B50000609D; Wed, 14 Aug 2024 10:43:02 +0800 (CST)
X-Sender: zhangyi@everest-semi.com
X-Auth-ID: zhangyi@everest-semi.com
Authentication-Results: sina.net;
	 spf=none smtp.mailfrom=zhangyi@everest-semi.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=zhangyi@everest-semi.com
X-SMAIL-MID: 62B93378C3E645008C7814FCAE2EA2EC
X-SMAIL-UIID: 62B93378C3E645008C7814FCAE2EA2EC-20240814-104302
From: Zhang Yi <zhangyi@everest-semi.com>
To: alsa-devel@alsa-project.org,
	broonie@kernel.org
Cc: tiwai@suse.com,
	amadeuszx.slawinski@linux.intel.com,
	yangxiaohua@everest-semi.com,
	zhuning@everest-semi.com,
	zhangyi@everest-semi.com
Subject: [PATCH] ASoC: codecs: ES8326: Adjust buttons
Date: Wed, 14 Aug 2024 10:43:01 +0800
Message-Id: <20240814024301.5820-1-zhangyi@everest-semi.com>
X-Mailer: git-send-email 2.17.1
X-MailFrom: zhangyi@everest-semi.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: O5K2EMQHWYOPJ5KTCSJYTEG3N7AELZP2
X-Message-ID-Hash: O5K2EMQHWYOPJ5KTCSJYTEG3N7AELZP2
X-Mailman-Approved-At: Thu, 15 Aug 2024 08:24:37 +0000
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/O5K2EMQHWYOPJ5KTCSJYTEG3N7AELZP2/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

> > To adapt to chrome, we have adjusted the buttons to match the system.
> 
> >  	case 0x4b:
> >  		/* button volume up */
> > -		cur_button = SND_JACK_BTN_1;
> > +		cur_button = SND_JACK_BTN_2;
> >  		break;
> >  	case 0x27:
> >  		/* button volume down */
> > -		cur_button = SND_JACK_BTN_2;
> > +		cur_button = SND_JACK_BTN_3;
> >  		break;
> 
> This is really problematic, we're changing the keys reported here in a
> way that's not ABI compatible.  If this was a new driver then fine but
> this is quite old, it's in LTS releases, so we might be disrupting
> people's existing systems.  I'm not sure we have a good solution for
> this at this point, we're not even swapping the buttons here but rather
> using a different set of buttons.  Probably ChromeOS needs to work
> around this somehow, or we need to add some mechanism which allows
> userspace to configure the driver mapping at runtime.


We'll use a different method to solve this issue.thank you 
