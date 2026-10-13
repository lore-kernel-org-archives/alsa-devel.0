Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25190CC6B30
	for <alsa-devel@archiver.kernel.org>; Thu, 15 Oct 2026 10:32:28 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E505360234;
	Thu, 15 Oct 2026 12:32:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E505360234
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1792060347;
	bh=4bF/zFcPZ+rge2e+q78qNspBsBmmrjazXqSGKV4CxYw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=KqRdyOQ8m6rj+NuYzdBLeYOutvKlYwIiDP05RITPrfxsT3pJ7+V9YmoEu+bEij7TU
	 8p+1B0P6CwfFashIqQYogikbyyV+SVfqYQZ+svZsXjiQAvSfj6tjjTDjakDq+ZdrOD
	 tdtOaXxSi9OUkJK3RI2kOTSHvfQ/NFPxgzSZ7SQ0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9AD81F8061F; Thu, 15 Oct 2026 12:31:39 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 158FDF80622;
	Thu, 15 Oct 2026 12:31:39 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 82873F8060D; Thu, 15 Oct 2026 12:31:31 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1792060290;
	b=H7koa5bWBEfHx/5xJPwm3hobNUGhDqFkXhd1SRWAk4RHKHPqmV1W9HT0PaLCroH4ieY+
	 upCZpLk1PfstR6KRydxU/lUV2m0gMjfICCo5gWJ2Bt7Da7t9qADoxJG0ErJgHPmRBfRij
	 NNNd1fp8xb+vl7yqJk4HXeVo2zq/Ujub39Kp+R3n4FIKr+BIiOuNeUsAFd7vvYehxIoGp
	 ER8SaWutrdE/THVGYW4+SD2I79KvNM72dREmFGajvbyuYkE10umQFiUCzYbsXsyBdNNoE
	 CIWce+RgLjpNqK0+WEaplK6Qbx2DI83kgdWE0ZIR2kxkFcowhgOoKgPa9/rpN9pXiSg==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1792060290;
	h=DKIM-Signature:From:To:Subject:Message-Id:Date:MIME-Version;
	bh=4bF/zFcPZ+rge2e+q78qNspBsBmmrjazXqSGKV4CxYw=;
	b=p1SQroDyEELexJbGfu6sM4AjQVpXIV2A7l7y/CiH2JyrYfFEOE+kiamtoWj9THmD7TCF
	 cOh6z1vMbFpXh0g8/xI31RB+DfiMekQU9gVlLLlRoz+wl4h4ObQ4hydt1FZ7Q8+hnuj7C
	 cFFC9nSfAAjFkn7q4O/ukTQnZ1mv0NqrVX/3G3h8mvP/ErU3dSwVwVNcjGelgOQ1kKj90
	 dDpmSLg0qB22q5/AH/9R6H7dWkbLOP4Kc4ZOCQNMImbUyTmb8sH5c9Mqu+s4FRuwVGQ/j
	 4Si9NPmlh+t3LdPLq9j57yHBvvMGEKHgDaeKMKHgURRA5xKwkhji1FhfiAOlwiCxnWA==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=hFh3yJab;
	arc=none smtp.remote-ip=172.234.252.31
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id B6374F80606
	for <alsa-devel@alsa-project.org>; Thu, 15 Oct 2026 12:31:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B6374F80606
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=hFh3yJab
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 7701B400E5;
	Thu, 15 Oct 2026 10:31:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2CD31F000C4;
	Thu, 15 Oct 2026 10:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792060288;
	bh=ZNM/BYGhfHnDKDA67q+sAabYWzpLx4cmmnoJmrbhFeY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=hFh3yJabENhH3Y6vENYG3s9CyB1xltCW3IjjpUktyW6VQdlgvM0eT19ALwrjKL2X5
	 TDkZofaBdIx/THVC77HQQisFyNE3pE0Cz6SU1dPizf45bSkoKLhSCc6a4jftV9D8LQ
	 10efLaHbUqkF+vLqq3+xBc6nDxsvmv1iW64MqX0KwmTHx2eiHw6u1P84mlP1q6MSD3
	 YhBAqEF39IAMNdMmRzO8k8x5EqNGsMBZv+vS1udE16fUIkP1TOiXZaZS0RVO6dTQil
	 hodDpVAQk8mZ4MAWi042/Edr1RMCdigPZepNnYDEaTp7haN8vd7MUx424z4xssiOlK
	 1RsY+m9jirxvQ==
From: Mark Brown <broonie@kernel.org>
To: Simon Trimmer <simont@opensource.cirrus.com>,
 Charles Keepax <ckeepax@opensource.cirrus.com>,
 Richard Fitzgerald <rf@opensource.cirrus.com>, Mingxuan Guo <gmx472@qq.com>
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <tencent_B839C5A92D762B5717B9637A5CFA0841C608@qq.com>
References: <tencent_B839C5A92D762B5717B9637A5CFA0841C608@qq.com>
Subject: Re: [PATCH 1/2] firmware: cs_dsp: clear dsp->running on the
 cs_dsp_run() error path
Message-Id: <179190663311.42298.15437389949849983493.b4-ty@b4>
Date: Tue, 13 Oct 2026 16:50:33 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1283; i=broonie@kernel.org;
 h=from:subject:message-id; bh=4bF/zFcPZ+rge2e+q78qNspBsBmmrjazXqSGKV4CxYw=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLIurK6dsohlZviptYsiUj9uit5Y+8rJOuz4143LtvidV
 WXftdD9akcpC4MYF4OsmCJLXBb3y/qS12v4Di5sg5nDygQyhIGLUwAm0r6CkeFZa+KR5X6TFrT3
 vWl9k2XH28WSsOXUbt7LhmzzvSJP/1vNyLA5/dChHfP3Sh1MVPx+yEbpOZ/+2/KZuu5LVNb8cH4
 /PZUdAA==
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Message-ID-Hash: 3ADTBVGAM754EAOICA3OWICWCMTSOF5D
X-Message-ID-Hash: 3ADTBVGAM754EAOICA3OWICWCMTSOF5D
X-MailFrom: broonie@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/3ADTBVGAM754EAOICA3OWICWCMTSOF5D/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Tue, 13 Oct 2026 18:23:58 +0800, Mingxuan Guo wrote:
> firmware: cs_dsp: clear dsp->running on the cs_dsp_run() error path

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.4

Thanks!

[1/2] firmware: cs_dsp: clear dsp->running on the cs_dsp_run() error path
      https://git.kernel.org/broonie/misc/c/ad6be54d1349
[2/2] firmware: cs_dsp: add a KUnit test for the cs_dsp_run() error path
      https://git.kernel.org/broonie/misc/c/80b3f283e961

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

