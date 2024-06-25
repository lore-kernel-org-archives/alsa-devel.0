Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8D2DC2BBCA
	for <alsa-devel@archiver.kernel.org>; Tue, 25 Jun 2024 13:50:56 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8D1A883E;
	Tue, 25 Jun 2024 15:50:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8D1A883E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1719323453;
	bh=7cRZ7RSanbNqP4/UsuFatp5+Yyy3gQFuJtGygSMSx4Q=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=kAOO+TEuIzAF51q2XhidnyzwUv/Ubqmvq9TQvx+bc827+wL4LH2CMf3yEA9WHyAQB
	 GbwESYHyi67ozUssPAYDucCB2MpD95eSD3C92/aeATrFTjqn3ztvrRt0erUkOHfueE
	 wf3vxf2C9PZfcgAqDBdVItBhO+Lda5po33x+QXaI=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 63BD2F805BD; Tue, 25 Jun 2024 15:50:21 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 2E248F805B5;
	Tue, 25 Jun 2024 15:50:19 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 141D8F80154; Tue, 25 Jun 2024 15:38:48 +0200 (CEST)
Received: from irl.hu (irl.hu [95.85.9.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with UTF8SMTPS id 2BC7DF80154
	for <alsa-devel@alsa-project.org>; Tue, 25 Jun 2024 15:32:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2BC7DF80154
Received: from fedori.lan (91ec5716.dsl.pool.telekom.hu
 [::ffff:145.236.87.22])
  (AUTH: CRAM-MD5 soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 00000000000720C2.00000000667AC6E1.00006109;
 Tue, 25 Jun 2024 15:32:16 +0200
Message-ID: <c0a9e15e7926e098bdea97a7d31c32427e0910c9.camel@irl.hu>
Subject: Re: [PATCH v2] ALSA: hda/realtek: Enable headset mic on IdeaPad
 330-17IKB 81DM
From: Gergo Koteles <soyer@irl.hu>
To: Rauty <rautyrauty@gmail.com>, alsa-devel@alsa-project.org,
  tiwai@suse.com
Cc: perex@perex.cz, kailang@realtek.com,
  sbinding@opensource.cirrus.com, luke@ljones.dev,
  shenghao-ding@ti.com, simont@opensource.cirrus.com,
  foss@athaariq.my.id, rf@opensource.cirrus.com, wzhd@ustc.edu,
  linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 25 Jun 2024 15:32:16 +0200
In-Reply-To: 
 <CAGpJQTGqxEkfp003QLsp-syUgzDFCmHSmNaoOaem0ZMVf7_=bg@mail.gmail.com>
References: <20240615125457.167844-1-rauty@altlinux.org>
	 <2c9ba341bc95d4b9010bf5f8794c0d14b1c57dc9.camel@irl.hu>
	 <CAGpJQTHoBAixmxta2WuZfjHjiK9GXF=hkfPyV7PBD5rt9Z_0WA@mail.gmail.com>
	 <CAGpJQTGqxEkfp003QLsp-syUgzDFCmHSmNaoOaem0ZMVf7_=bg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 (3.52.2-1.fc40) 
MIME-Version: 1.0
Message-ID-Hash: K6V4S3TINMXFH4W4AYHIDLTSAOVFEG4F
X-Message-ID-Hash: K6V4S3TINMXFH4W4AYHIDLTSAOVFEG4F
X-MailFrom: soyer@irl.hu
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/K6V4S3TINMXFH4W4AYHIDLTSAOVFEG4F/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Hey Rauty,

On Mon, 2024-06-24 at 11:25 +0300, Rauty wrote:
> I haven't changed the patch yet, but it's already in the stable-queue:
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/t=
ree/queue-5.10/alsa-hda-realtek-enable-headset-mic-on-ideapad-330-1.patch
> Do you still need changes from me?

I still think this breaks Duet 7 sound, because snd_hda_pick_fixup
function picks the PCI SSIDs before Codec SSIDs.
But maybe I missed something.

Takashi, what do you think?

Best regards,
Gergo Koteles

