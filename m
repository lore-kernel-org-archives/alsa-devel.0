Return-Path: <SRS0=BPvr=F4=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39DB2C433E0
	for <alsa-devel@archiver.kernel.org>; Thu, 24 Dec 2020 10:07:17 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35D4D2168B
	for <alsa-devel@archiver.kernel.org>; Thu, 24 Dec 2020 10:07:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35D4D2168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CE0EC17D0;
	Thu, 24 Dec 2020 11:06:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CE0EC17D0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1608804430;
	bh=IWtv7wWTVk0eBKD1X3mXrlnqhKYIqd0DACZFO1L0YQ8=;
	h=Date:Subject:From:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=F6NVNDOTFLsVRmPmEem/L9I3me3uSWUk9SzimOD0j7t+oBRIAUOzD0I/V/+zDuVw5
	 5fLNH67BAer6umdTkEOfzqpoCIEI+vSvtNag+yL7iMVIgInZ9NyOvng31h4ZRG1M1a
	 ZNWbh3XaGfHCSFzCprnNy94FqgsMhP+HxQDuAw/w=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5E343F8021D;
	Thu, 24 Dec 2020 11:06:20 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id AEFF5F800CE; Thu, 24 Dec 2020 11:06:18 +0100 (CET)
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com
 [IPv6:2607:f8b0:4864:20::f4a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5FA6AF800CE
 for <alsa-devel@alsa-project.org>; Thu, 24 Dec 2020 11:06:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5FA6AF800CE
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.b="QCDYDfYC"
Received: by mail-qv1-xf4a.google.com with SMTP id 12so1273461qvk.23
 for <alsa-devel@alsa-project.org>; Thu, 24 Dec 2020 02:06:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=sender:date:message-id:mime-version:subject:from:to:cc;
 bh=ns/6shvdjEx+c826CKe+Bd1+4ZSvL4KMq1hLCqh0QUo=;
 b=QCDYDfYCwNs+ZRgH1C2m8F80uPatznI4quE3WE3J9Vq0iPDZZH59Q6Cg2XJ65QJ5Be
 zGuzQ4P7CDeSUlUNuvPtud0BjwhCvHJQ8ExFH4kQB2c+SbXrMOu3/mm2t+ws2J0TU00l
 Yf1Norw7+pAIpW3x528uiB+mOR4hata6kOs7qKGTUHvV1491T3CP6Vs34dsszToqIjLe
 ylMSgWO4zRGk+Q+/lfQpisNNLEmFo24F3XCA6AkVfiw8i2Roxbu8wU3zwYD8XoVh5n/e
 JZ4BMTxO5dJIsGgZ/ASK+6ZON4+2rO2C/O+73+bOUP0X/8A5iD7YQqCFxXaFnNspaqxg
 pbNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
 :to:cc;
 bh=ns/6shvdjEx+c826CKe+Bd1+4ZSvL4KMq1hLCqh0QUo=;
 b=KT2wdEWxqQAEO1wFNzi/cshdtWpIrN1OmTQySGqEPxKJ/9dWOPov9i+Lh1ezbuJpWx
 zaqYV9tXzQ/iH4NPelgXs22nlTh9fj5O0Yvrp1euO20yetWf9pimhG1hSSC9JuIRFv9V
 Bfsnp01tslYJ+yXVuZPPTehWJsXL3Bpu7LJEDXFdgUpC6taqKK2Nuf3aOsJAFCLXVW9h
 /nTfxoFJjGOqgrXWA0k74hHFSK0PafTIBa6dCwF2JSiuma9OmHR2S0AGpaG+MSjinFme
 qXc5cxKC5i/QQLFO5xTyQoIeQ/MjkmCi/JNLOsfiRTW6xMYLnS3zaW8Y8RmFfCZBG1qL
 KJvg==
X-Gm-Message-State: AOAM531gwANdk7Vrn2eW8lztD0o7UiXCMinKDbgK8OTaZBbmUj7ZwPyf
 H8DEFbMyjysseQgTRRf3F3scupZsRxro
X-Google-Smtp-Source: ABdhPJwkCvJcMGTxK1xY38osc+kT9QYBAwAhJ9NdbQPjuZEjOa79YkPKXYVilmzPWKBp2jyGsJuofayflDn7
X-Received: from tzungbi-z840.tpe.corp.google.com
 ([2401:fa00:1:b:725a:fff:fe41:c6a5])
 (user=tzungbi job=sendgmr) by 2002:a0c:edab:: with SMTP id
 h11mr30989572qvr.23.1608804373089; Thu, 24 Dec 2020 02:06:13 -0800 (PST)
Date: Thu, 24 Dec 2020 18:06:02 +0800
Message-Id: <20201224100607.3006171-1-tzungbi@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.729.g45daf8777d-goog
Subject: [PATCH 0/5] ASoC: rt1015: apply some refactors
From: Tzung-Bi Shih <tzungbi@google.com>
To: broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"
Cc: tzungbi@google.com, alsa-devel@alsa-project.org
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

The series refactors rt1015.c.

The 1st patch sorts header inclusions alphabetically.

The 2nd and 3rd patch improve error handling for kcontrols.

The 4th patch enhances readability.

The 5th patch removes unused variables in rt1015_priv.

Tzung-Bi Shih (5):
  ASoC: rt1015: sort header inclusions
  ASoC: rt1015: save boost_mode only if valid
  ASoC: rt1015: return error if any when setting bypass_boost
  ASoC: rt1015: refactor retry loop and rt1015_priv allocation
  ASoC: rt1015: remove unneeded variables in rt1015_priv

 sound/soc/codecs/rt1015.c | 49 ++++++++++++++++++++-------------------
 sound/soc/codecs/rt1015.h |  4 ----
 2 files changed, 25 insertions(+), 28 deletions(-)

-- 
2.29.2.729.g45daf8777d-goog

