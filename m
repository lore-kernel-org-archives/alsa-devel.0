Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71873C4332F
	for <alsa-devel@archiver.kernel.org>; Mon, 30 Oct 2023 02:30:49 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D6CC9886;
	Mon, 30 Oct 2023 03:29:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D6CC9886
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1698633046;
	bh=6q5r1uPTv4El3dJVWoOmR7zuz63DMvcsvOFCfaWSBzE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=pQCiDdxuzrtRlHxF6dORJIr2xooVOc+wYc3MTdPBf0U0p49MuNs826Hz06G1aBb6y
	 4xaZqmpHUbLLhf3Yh3DtIhUrxkbEjN3HTAeiAf+otK12hiTd6b7T0i0jgYoWdvSmvL
	 fj4NNX7iwEmMuLcW3JRaJkv+se+38irHSdQkbXA8=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B7BA3F800FA; Mon, 30 Oct 2023 03:29:27 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 59F5EF800FA;
	Mon, 30 Oct 2023 03:29:27 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id BF9AFF8016D; Mon, 30 Oct 2023 03:29:22 +0100 (CET)
Received: from out28-97.mail.aliyun.com (out28-97.mail.aliyun.com
 [115.124.28.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id C614FF8014B
	for <alsa-devel@alsa-project.org>; Mon, 30 Oct 2023 03:29:10 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C614FF8014B
X-Alimail-AntiSpam: 
 AC=CONTINUE;BC=0.123296|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_social|0.0512103-0.000464542-0.948325;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047201;MF=wangweidong.a@awinic.com;NM=1;PH=DS;RN=11;RT=11;SR=0;TI=SMTPD_---.VAhPcwq_1698632937;
Received: from ubuntu-VirtualBox..(mailfrom:wangweidong.a@awinic.com
 fp:SMTPD_---.VAhPcwq_1698632937)
          by smtp.aliyun-inc.com;
          Mon, 30 Oct 2023 10:29:02 +0800
From: wangweidong.a@awinic.com
To: nathan@kernel.org
Cc: alsa-devel@alsa-project.org,
	broonie@kernel.org,
	lgirdwood@gmail.com,
	llvm@lists.linux.dev,
	ndesaulniers@google.com,
	patches@lists.linux.dev,
	trix@redhat.com,
	wangweidong.a@awinic.com,
	liweilei@awinic.com,
	yijiangtao@awinic.com
Subject: Re: [PATCH] ASoC: codecs: aw88399: Fix -Wuninitialized in
 aw_dev_set_vcalb()
Date: Mon, 30 Oct 2023 10:28:56 +0800
Message-ID: <20231030022856.12355-1-wangweidong.a@awinic.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: 
 <20231027-asoc-aw88399-fix-wuninitialized-v1-1-b1044493e4cd@kernel.org>
References: 
 <20231027-asoc-aw88399-fix-wuninitialized-v1-1-b1044493e4cd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: 5DPJ6VGGZF5SYC5RI7X3NM4OHSWTOI4G
X-Message-ID-Hash: 5DPJ6VGGZF5SYC5RI7X3NM4OHSWTOI4G
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/5DPJ6VGGZF5SYC5RI7X3NM4OHSWTOI4G/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Hi, Nathan

On Fri, 27 Oct 2023 09:54:25 -0700 nathan@kernel.org wrote:

> Clang warns (or errors with CONFIG_WERROR=y):

>  sound/soc/codecs/aw88399.c:441:18: error: variable 'vsense_select' is uninitialized when used here [-Werror,-Wuninitialized]
>    441 |         vsense_select = vsense_select & (~AW88399_VDSEL_MASK);
>        |                         ^~~~~~~~~~~~~
>  sound/soc/codecs/aw88399.c:431:28: note: initialize the variable 'vsense_select' to silence this warning
>    431 |         unsigned int vsense_select, vsense_value;
>        |                                   ^
>        |                                    = 0
>  1 error generated.

> This clearly should have been using the value received from
> regmap_read(). Use the correct variable to resolve the warning.

> Closes: https://github.com/ClangBuiltLinux/linux/issues/1952
> Fixes: 8ade6cc7e261 ("ASoC: codecs: Add aw88399 amplifier driver")
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
> sound/soc/codecs/aw88399.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

Thank you very much for your patch.

Reviewed-by: Weidong Wang <wangweidong.a@awinic.com>

Best regards,
Weidong Wang
