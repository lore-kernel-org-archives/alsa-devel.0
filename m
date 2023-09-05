Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97B29C83F33
	for <alsa-devel@archiver.kernel.org>; Tue,  5 Sep 2023 07:15:50 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DFDE9206;
	Tue,  5 Sep 2023 09:14:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DFDE9206
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1693898147;
	bh=0uc68etqO9EMhuDiGHkwwSq4eZ3TmkFQ/n1cMasyiEk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=kKH3wxCx/4UuFE6ozMq+grZX6OW9RIc+qn61uX4ZvLte+vzGsgtPOOVnM2+g6khva
	 dmxqbzlnA6pypM6XngCnGW1m3uqB48oqnZCwHMbu4wtF6bSBTuR68I2ReQUZ454lOX
	 5FHvHyFz/STOXi3iemLkPawjLpERvO5HEbCnK2iU=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5D53AF80552; Tue,  5 Sep 2023 09:14:30 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id C9706F8047D;
	Tue,  5 Sep 2023 09:14:29 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id CBD73F8047D; Tue,  5 Sep 2023 09:14:25 +0200 (CEST)
Received: from out28-149.mail.aliyun.com (out28-149.mail.aliyun.com
 [115.124.28.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 89306F800F5
	for <alsa-devel@alsa-project.org>; Tue,  5 Sep 2023 09:14:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 89306F800F5
X-Alimail-AntiSpam: 
 AC=CONTINUE;BC=0.1722883|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00741336-0.000123443-0.992463;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047201;MF=wangweidong.a@awinic.com;NM=1;PH=DS;RN=9;RT=9;SR=0;TI=SMTPD_---.UXwp7q2_1693898037;
Received: from ubuntu-VirtualBox..(mailfrom:wangweidong.a@awinic.com
 fp:SMTPD_---.UXwp7q2_1693898037)
          by smtp.aliyun-inc.com;
          Tue, 05 Sep 2023 15:14:00 +0800
From: wangweidong.a@awinic.com
To: krzysztof.kozlowski@linaro.org
Cc: alsa-devel@alsa-project.org,
	broonie@kernel.org,
	lgirdwood@gmail.com,
	linux-kernel@vger.kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	wangweidong.a@awinic.com,
	yijiangtao@awinic.com
Subject: Re: [PATCH 3/3] ASoC: aw88395: drop undocumented and unused
 sound-channel property
Date: Tue,  5 Sep 2023 15:13:56 +0800
Message-ID: <20230905071356.18301-1-wangweidong.a@awinic.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <3ff94d4b-7585-d7ed-9736-ba4c02b3fcff@linaro.org>
References: <3ff94d4b-7585-d7ed-9736-ba4c02b3fcff@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Message-ID-Hash: PIIPMSBJOJW353G4TRCIPHJPDUFF2JZS
X-Message-ID-Hash: PIIPMSBJOJW353G4TRCIPHJPDUFF2JZS
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/PIIPMSBJOJW353G4TRCIPHJPDUFF2JZS/>
List-Archive: <>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Thank you very much for your reply.=0D
=0D
On 05/09/2023 15:05, krzysztof.kozlowski@linaro.org wrote:=0D
> On 05/09/2023 04:46, wangweidong.a@awinic.com wrote:=0D
=0D
>>> Even though it does not look like from the diff, the property is not=0D
>>> actually used by the driver, because once set, it is read only in loops=
=0D
>>> depending on ddt_num (prof_hdr->ddt_num, cfg_hdr->ddt_num).  The=0D
>>> variable ddt_num is never set and is always 0, so the loops do not have=
=0D
>>> any iteration.  Dropping sound-channel and ddt_num-related loops allows=
=0D
>>> to drop empty functions which in turn drop quite a lot of code.  This=0D
>>> entire code was not possible to execute. =0D
>> =0D
>> The ddt_num variable is not always 0, this variable is defined=0D
>> in the configuration file. The "prof_hdr" variable is assigned by =0D
>> the "cfg_hdr" variable. The "cfg_hdr" variable is assigned by "aw_cfg"=0D
>> aw_cfg is the data obtained through request_firmware.The specific =0D
>> process is as follows:=0D
>> =0D
>> request_firmware ---> cont->data ---> aw_cfg->data --> cfg_hdr --> prof_=
hdr=0D
=0D
> Hm. So you load user-space provided file and assign it directly, without=
=0D
> any validation (aw88395_dev_load_acf_check() checks only for magic), to=0D
> a kernel structure. Sounds bullet-proof. Why using known kernel=0D
> interfaces, better to implement some conf-file-parsing.=0D
=0D
Could you please tell me what known kernel interfaces =0D
can be used to parse files? =0D
Thank you very much=0D
=0D
Best regards,=0D
Weidong Wang=
