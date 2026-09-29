Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CEA5CA5FA5
	for <alsa-devel@archiver.kernel.org>; Tue, 29 Sep 2026 19:10:50 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AFA48602F5;
	Tue, 29 Sep 2026 21:10:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AFA48602F5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1790709048;
	bh=wsRKhRIWnMaa7SyxuCyvMLd4mhKnSFaOGLaAP/bMhhE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=YXLtWUcCEeYU4QrjRHluRb81Vzqt/CxzCitn2s1g+Z1wYUWmBpI+aGMxyfDgkolp0
	 3fc7RcibeqFplfjjKT54TFgLlPCu+8D9UtdQq8f32uCFJsoiKTnf7r/f+4Vi3+8CIo
	 zNqO8xJ7d15RUlP0BhufDuhGOPlwNNgYPUaB1iOE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 27CF6F80CB6; Tue, 29 Sep 2026 21:07:26 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 2E0B0F80CC0;
	Tue, 29 Sep 2026 21:07:26 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C136DF8055C; Tue, 29 Sep 2026 08:13:47 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=206.189.79.184
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1790662425;
	b=ThiafFF1FJgK9ts9ihyGAKB3lyjiAEMu6Zb6AEe1xVT3EkjtzC2H3BK+BESH2Scfe1nx
	 df/0r84pPdmqUBfyzw64rMDifyj75ho3PE9ZNna1MEbadl7+lbl50n3H3h8Y11Z1pFn07
	 ujbSe1f0lldnarGjEXeXLFBM4FVACUmR9ZplBoEQnp3T42P10T8FX1CzKwgSknpLwjXBM
	 BR0aIerlAamQbe7zvw6sxvJoba02AveORQOM1zZqPm0iwlzfGf1wv6IXimk3dRy0+C8PA
	 OrLx+k5FfA991IHYNgdRLrfQGT6lXcpPQ/IuXtvUm8uKmFss17HqpZVE+hkpNfpsU7A==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1790662425;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=wsRKhRIWnMaa7SyxuCyvMLd4mhKnSFaOGLaAP/bMhhE=;
	b=Ioyavc/I3D8+nwpic0AInr1zLXbGmPriUhjDIjOyxIHWj7Pi8UUdUfaAgRkjT0cIVqQv
	 vRAxwkLwZv7wRA0Higk/0EnQd8z4ymCriPH4hyIg6qo6hX6Fe2pxtiWwXneuzYpPXPeAV
	 wiNkUj/wSP87kj8jikpBFPB12pxhPh+fVGaTdUQl7gOIJzvGumE9hRq3lePqHPF3EWUEW
	 Brqo+htEn/0Mn1qjTsQi3VMnZQ9Z7xI2ois1whOpWAl7TI+Ak+ACAhWt+9UswEfvYu8H8
	 ygF7nAsBmWZtj7cfXPpjm8G1tu7HPnQVcd0x/RRjqeZASZTXG6kGaxjJnusKL7KqmeQ==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=206.189.79.184
Received: from zg8tmja2lje4os43os4xodqa.icoremail.net
 (zg8tmja2lje4os43os4xodqa.icoremail.net [206.189.79.184])
	by alsa1.perex.cz (Postfix) with ESMTP id E5024F80020
	for <alsa-devel@alsa-project.org>; Tue, 29 Sep 2026 08:13:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E5024F80020
Received: from zju.edu.cn (unknown [10.98.66.117])
	by mtasvr (Coremail) with SMTP id _____wDXdwgQV7tqH3ZFAQ--.2299S3;
	Tue, 29 Sep 2026 14:13:37 +0800 (CST)
Received: from localhost.localdomain (unknown [10.98.66.117])
	by mail-app1 (Coremail) with UTF8SMTPA id yy_KCgBXqokQV7tq0YwWAA--.27363S2;
	Tue, 29 Sep 2026 14:13:36 +0800 (CST)
From: Fan Wu <fanwu01@zju.edu.cn>
To: vijendar.mukunda@amd.com
Cc: lgirdwood@gmail.com,
	broonie@kernel.org,
	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Syed.SabaKareem@amd.com,
	Sunil-kumar.Dommati@amd.com,
	venkataprasad.potturu@amd.com,
	songl@zju.edu.cn,
	Fan Wu <fanwu01@zju.edu.cn>
Subject: Re: [PATCH] ASoC: amd: ps: fix snd_acp63_remove() teardown ordering
Date: Tue, 29 Sep 2026 06:12:32 +0000
Message-Id: <20260929061232.3854-1-fanwu01@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <611b8e7a-b434-40c0-8f0e-4978208bb01f@amd.com>
References: <20260923092640.502145-1-fanwu01@zju.edu.cn>
 <611b8e7a-b434-40c0-8f0e-4978208bb01f@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: yy_KCgBXqokQV7tq0YwWAA--.27363S2
X-CM-SenderInfo: qrstjiaswqq6lmxovvfxof0/
X-CM-DELIVERINFO: 
 =?B?8wpbKAXKKxbFmtjJiESix3B1w3vZ3A9ovKVTomAyoQazvoRs/NHSP8GI2EvgeEEW7R
	sfnRrXgS1QiyEChzQk8Vd3wxVK31z1GTmKcz3pqyIgA5HinhN/ajL70R8jiFGSzNc0dlU0
	9DHEAcvLWH6e8b2tG1LN5RPxYw6l01w8CbPzC/8w
X-Coremail-Antispam: 1Uk129KBj93XoW7KF1kJw4UZw13JFWxZFykCrX_yoW8ZFyxpr
	WkK34jvw4DGFy093W7Za1qkrWDCrs5CryrC3s7K34UXrn09ryFqFWkAFyUZF15Gr95J3W2
	vr4Fgw18ua4qvagCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc804V
	CY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AK
	xVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48Icx
	kI7VAKI48JM4x0Y48IcxkI7VAKI48G6xCjnVAKz4kxMxAIw28IcxkI7VAKI48JMxC20s02
	6xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_Jr
	I_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v2
	6r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj4
	0_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8
	JbIYCTnIWIevJa73UjIFyTuYvjxU7gAwDUUUU
X-MailFrom: fanwu01@zju.edu.cn
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: VUVK7IIUKTD4XQJMNGW3RY65TOUBDGUI
X-Message-ID-Hash: VUVK7IIUKTD4XQJMNGW3RY65TOUBDGUI
X-Mailman-Approved-At: Tue, 29 Sep 2026 19:07:19 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/VUVK7IIUKTD4XQJMNGW3RY65TOUBDGUI/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On 9/25/26 13:35, Mukunda,Vijendar wrote:
> The fix open-codes the register offsets (ACP_EXTERNAL_INTR_STAT,
> ACP_EXTERNAL_INTR_CNTL, ACP_EXTERNAL_INTR_ENB) directly in
> snd_acp63_remove(). Future platforms may have different interrupt
> control register offsets, which would require changes in this remove
> path as well. Consider adding a disable_interrupts callback to struct
> acp_hw_ops and invoking it here instead. This keeps the remove path
> platform-agnostic and the interrupt masking logic co-located with its
> platform-specific counterpart in ps-common.c.

Thank you for the review. Agreed — I have reworked the patch exactly
along these lines for v2:

- struct acp_hw_ops gains a disable_interrupts callback plus an
  acp_hw_disable_interrupts() wrapper, following the interrupt-control
  ops pattern of the acp family in amd.h (en_interrupts member and
  acp_disable_interrupts() helper).
- acp63_hw_init_ops() and acp70_hw_init_ops() wire it to the existing
  static acp63_disable_interrupts()/acp70_disable_interrupts() helpers
  in ps-common.c, so the masking sits next to its platform-specific
  counterparts.
- snd_acp63_remove() now calls acp_hw_disable_interrupts() followed by
  devm_free_irq() before the first child device is unregistered; the
  register writes are gone from the remove path.

The MMIO sequence is unchanged (clear STAT, CNTL = 0, ENB = 0 before
freeing the shared IRQ), and the Fixes tag stays on eaf825037d6d. I
will send v2 as a new thread with a link to this version.

Separately, I noticed your "[PATCH V2 0/9] soundwire: amd: SoundWire
manager driver bug fixes" series: patch 3/9, adding the amd_sdw_irq_thread
drain in amd_sdw_manager_remove(), is exactly the soundwire-side companion
this fix needs. The v2 commit message now notes that the manager-side
drain is handled separately, and with both in place the chain is closed
from the ACP hardirq down to the manager work.

Best regards,
Fan Wu

