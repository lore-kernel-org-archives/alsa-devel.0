Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66919C4332F
	for <alsa-devel@archiver.kernel.org>; Tue, 15 Nov 2022 11:49:17 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4B7B01677;
	Tue, 15 Nov 2022 12:48:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4B7B01677
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1668512955;
	bh=1ryAriHbNYrYQ03B8U8b4shYhpJ9k7HBuo/NnMXKthc=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=dQY7IW2ekddlAcuYPpTDG13Oh2wFcV91ocqP+FiH9t/EV+CzWf6wUVsKV3/Ap60vH
	 wXHj1kXsLfSIhdHfG9Yk0X3Hz4IO4tmUYjuwGdD4j978eU0ejl4J8MidHh/TRUTABD
	 AojK99PibAbF+OncFLe+y9qTKV9pEmR6pP0tiwPU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 02124F8016D;
	Tue, 15 Nov 2022 12:48:25 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4F5D5F80171; Tue, 15 Nov 2022 12:48:23 +0100 (CET)
Received: from out28-173.mail.aliyun.com (out28-173.mail.aliyun.com
 [115.124.28.173])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AF517F800B5
 for <alsa-devel@alsa-project.org>; Tue, 15 Nov 2022 12:48:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AF517F800B5
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.09092438|-1; CH=green;
 DM=|CONTINUE|false|; DS=CONTINUE|ham_social|0.00765708-0.000878344-0.991465;
 FP=0|0|0|0|0|-1|-1|-1; HT=ay29a033018047199; MF=wangweidong.a@awinic.com; NM=1;
 PH=DS; RN=17; RT=17; SR=0; TI=SMTPD_---.Q7taEJf_1668512875; 
Received: from AEPW014EEK(mailfrom:wangweidong.a@awinic.com
 fp:SMTPD_---.Q7taEJf_1668512875) by smtp.aliyun-inc.com;
 Tue, 15 Nov 2022 19:48:00 +0800
From: <wangweidong.a@awinic.com>
To: "'Krzysztof Kozlowski'" <krzysztof.kozlowski@linaro.org>,
 <broonie@kernel.org>, <perex@perex.cz>, <alsa-devel@alsa-project.org>,
 <tiwai@suse.com>, <robh+dt@kernel.org>,
 <krzysztof.kozlowski+dt@linaro.org>, <ckeepax@opensource.cirrus.com>,
 <tanureal@opensource.cirrus.com>, <quic_potturu@quicinc.com>,
 <pierre-louis.bossart@linux.intel.com>, <cy_huang@richtek.com>
Subject: Discuss [PATCH V4 6/6] ASoC:codecs:aw883xx corresponds to the
 modified Makefile and Kconfig
Date: Tue, 15 Nov 2022 19:47:55 +0800
Message-ID: <000801d8f8e8$1c8096c0$5581c440$@awinic.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: Adj458AUuahOVz0mSDuxwpTphetfOA==
Content-Language: zh-cn
Cc: duanyibo@awinic.com, yijiangtao@awinic.com, zhangjianming@awinic.com,
 zhaolei@awinic.com, liweilei@awinic.com
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

Hi Krzysztof Kozlowski

Thank you very much for your advice, but there is still a problem I =
would like to discuss with you

> From: Weidong Wang <wangweidong.a@awinic.com>
>=20
> Modified the Makefile and Kconfig to compile aw883xx
>=20
> Signed-off-by: Weidong Wang <wangweidong.a@awinic.com>
> ---
>  sound/soc/codecs/Kconfig  | 10 ++++++++++  sound/soc/codecs/Makefile=20
> |  7 +++++++
>  2 files changed, 17 insertions(+)

> 1. Where is patch 5?

What does this mean? Did you not receive patch V4 5/6?

> 2. Subject: missing spaces.

I would add this space at patch v5

> 3. This should be squashed with previous. There is no point to have =
commits adding dead code, therefore this one as a separate commit does =
not make sense.

I will change this issue on patch v5

Best regards,
Weidong Wang

