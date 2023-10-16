Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4524CDB465
	for <alsa-devel@archiver.kernel.org>; Mon, 16 Oct 2023 09:09:55 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 984C882A;
	Mon, 16 Oct 2023 11:09:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 984C882A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1697447392;
	bh=iJBHxcmpwEQetn/iFVefybJ9XusBjNDcJA/8mBj1/0w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=mucXSruj516CIqc7TEC+goAD2XkrMim9uxbMancvEbDrfJpxkN7m4oj8lETkfbVym
	 HgFYlIS1YedFI+t3ozEu4fcE0x3VxnFrXtwXyzjWC3BasgcggTGC5hXJ9S9ZbVjXmR
	 5uRUGmmW5ruqwV8DgCUJJlIPaB+qmxi0jUTtDRgU=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8CF18F80557; Mon, 16 Oct 2023 11:08:25 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 18B20F8019B;
	Mon, 16 Oct 2023 11:08:25 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B61AEF8025F; Mon, 16 Oct 2023 11:08:21 +0200 (CEST)
Received: from out28-49.mail.aliyun.com (out28-49.mail.aliyun.com
 [115.124.28.49])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 43DF4F8019B
	for <alsa-devel@alsa-project.org>; Mon, 16 Oct 2023 11:08:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 43DF4F8019B
X-Alimail-AntiSpam: 
 AC=CONTINUE;BC=0.06892163|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.023128-0.00177961-0.975092;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047193;MF=wangweidong.a@awinic.com;NM=1;PH=DS;RN=26;RT=26;SR=0;TI=SMTPD_---.V08HDja_1697447275;
Received: from ubuntu-VirtualBox..(mailfrom:wangweidong.a@awinic.com
 fp:SMTPD_---.V08HDja_1697447275)
          by smtp.aliyun-inc.com;
          Mon, 16 Oct 2023 17:08:03 +0800
From: wangweidong.a@awinic.com
To: wangweidong.a@awinic.com
Cc: 13916275206@139.com,
	alsa-devel@alsa-project.org,
	arnd@arndb.de,
	broonie@kernel.org,
	ckeepax@opensource.cirrus.com,
	colin.i.king@gmail.com,
	conor+dt@kernel.org,
	dan.carpenter@linaro.org,
	devicetree@vger.kernel.org,
	fido_max@inbox.ru,
	herve.codina@bootlin.com,
	krzysztof.kozlowski+dt@linaro.org,
	lgirdwood@gmail.com,
	linus.walleij@linaro.org,
	linux-kernel@vger.kernel.org,
	liweilei@awinic.com,
	perex@perex.cz,
	rf@opensource.cirrus.com,
	robh+dt@kernel.org,
	ryans.lee@analog.com,
	sebastian.reichel@collabora.com,
	shumingf@realtek.com,
	tiwai@suse.com,
	trix@redhat.com,
	yijiangtao@awinic.com
Subject: Re: [PATCH V1 3/3] ASoC: codecs: Add aw88399 amplifier driver
Date: Mon, 16 Oct 2023 17:07:54 +0800
Message-ID: <20231016090754.64363-1-wangweidong.a@awinic.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231016081017.46963-1-wangweidong.a@awinic.com>
References: <20231016081017.46963-1-wangweidong.a@awinic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Message-ID-Hash: 3XSKYQNACML6D2I2H6RIPLPIJ5EAZXPP
X-Message-ID-Hash: 3XSKYQNACML6D2I2H6RIPLPIJ5EAZXPP
X-MailFrom: wangweidong.a@awinic.com
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/3XSKYQNACML6D2I2H6RIPLPIJ5EAZXPP/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

I'm very sorry that I misunderstood my last comment, correct it here.=0D
Thank you again for you hard review.=0D
=0D
On Mon, Oct 16, 2023 at 16:10:17 +0800, wangweidong.a@awinic.com wrote=0D
> On Fri, Oct 13, 2023 at 03:10:56 PM +0100, broonie@kernel.org wrote:=0D
>> On Fri, Oct 13, 2023 at 06:42:20PM +0800, wangweidong.a@awinic.com wrote=
:=0D
=0D
>> This looks good - some *very* minor comments below.=0D
=0D
=0D
>>> +static int aw_dev_dsp_update_container(struct aw_device *aw_dev,=0D
>>> +			unsigned char *data, unsigned int len, unsigned short base)=0D
>>> +{=0D
>>> +	int i, ret;=0D
>>> +=0D
>>> +#ifdef AW88399_DSP_I2C_WRITES=0D
>>> +	u32 tmp_len;=0D
=0D
>> This looks like debug code which can hopefully be removed in favour of=0D
>> the regmap implementation?=0D
=0D
> Thank you very much, but this is not a debugging statement, This is desig=
ned=0D
> to be compatible with different platforms that may not support continuous=
=0D
> writing.=0D
=0D
I found "use_single_write" in regmap, I will remove "AW88399_DSP_I2C_WRITES=
".=0D
=0D
Best regards,=0D
Weidong Wang=0D
