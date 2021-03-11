Return-Path: <SRS0=8+EQ=IJ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 974FEC433DB
	for <alsa-devel@archiver.kernel.org>; Thu, 11 Mar 2021 03:33:14 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D104764FC9
	for <alsa-devel@archiver.kernel.org>; Thu, 11 Mar 2021 03:33:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D104764FC9
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5FF6E16F8;
	Thu, 11 Mar 2021 04:32:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5FF6E16F8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1615433590;
	bh=GU4Du2UQDi57Bnb9nM5Dr3rV0s3tdUekTTfketEvPqQ=;
	h=Date:Subject:From:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=tQRCQzepbQfVeLpFk/lk9OcHAw8Ip02U8ZV8sYN/iKkaeJtvW19MRvzheogljFn+q
	 cL8/MCZ7sAZSj/jlJsHXNm3GFGw/jh8kU0Jgprlc4OvYtK3jGRJ3xe7l78SKi4Iuvs
	 IIU5EfoCYQhK0QQ/3MlZRL8HJBL/Z1lAS/X2ukKY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7B11DF800BF;
	Thu, 11 Mar 2021 04:32:19 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 542E7F80256; Thu, 11 Mar 2021 04:32:17 +0100 (CET)
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com
 [IPv6:2607:f8b0:4864:20::849])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EB744F800BF
 for <alsa-devel@alsa-project.org>; Thu, 11 Mar 2021 04:32:10 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EB744F800BF
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.b="tqoHmWuO"
Received: by mail-qt1-x849.google.com with SMTP id r32so7391404qtd.16
 for <alsa-devel@alsa-project.org>; Wed, 10 Mar 2021 19:32:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:message-id:mime-version:subject:from:to:cc;
 bh=HMm4MRHAOUO6q/qB3ald2mJ4l+Vj1lVMKFNrrOxOXpk=;
 b=tqoHmWuO6wk4I/vjVamFwtXI/50tsZpij77oUpWrxO2bYjYtZ0MdDrJ+HOwhXzlmuZ
 6k+bBE7lFiostWcqX1vV8FEKGi7t1hdaz5Pi9lDdHqk6tJIvpnUlOZvdcQl7n0HZEC8o
 0BpIL2fNQKKZiqklXHEOHOiVGSv5zp91WJN7+qrSo1fNdjm9N0TFBQOfv1Rvg98ip5Oy
 eflxBj8wPh/PfCKT7Dk+0VDZw4qL4UZRBdfT5Uwp+JsICxKGddhHnmj26ajPdSqGgrCi
 4RB6HiHxX8DDVwodIAcctJTELrq3n5r1CcycRZ6B5uAUBdv0uUcg2TyOV4LVxQsbE4Ex
 KGOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
 bh=HMm4MRHAOUO6q/qB3ald2mJ4l+Vj1lVMKFNrrOxOXpk=;
 b=oqgaN8REebibNlhNtI2uJZ5slYb7tcLRmeYDWkdCjkaoBQAlUnMHTAlzEhAfCfpkB6
 Pd+DxiDc6BdtrjHHbA/E2MVeWe8UKn8vT+eTxoDM3DoONrJDEREBrkMP3Gv+cgJEzBpA
 VEsCXsPgUOJ0Yk0eMnziU8Go3Js7Ron6d1MqbOL2az0iCqo1uI0Z8TdhPe5OnHhuMtTe
 O5Q37kbyeDiYxxNvNILJ7r5D9nomWIrLw2vvSdHd26Q4Lx6gH2mGxmjVgyDSnguTJieC
 Z20lsXtG4+rJ21wUsh97WaVDnPooqX6uzjYzntCmPBs0jmolYUJYVOY2wunmyOVN5+mF
 hkCA==
X-Gm-Message-State: AOAM5337c29FlHNJyVFjcI9Ik8ztLA0uZH7NcWjibkZntqtU3vPunr2V
 tvG9Lzm18cH3JFiPqlN0YuiYQWYSExVo
X-Google-Smtp-Source: ABdhPJxUNgUf6oF12k8JFP6QL+1PUgrKdyzn6V5HrQuJsiiJTZ/SLn79hhVb3eLsoEchuS0rhKUYzrxoyAu4
X-Received: from tzungbi-z840.tpe.corp.google.com
 ([2401:fa00:1:b:d958:2f3:afb:68a3])
 (user=tzungbi job=sendgmr) by 2002:a05:6214:1c45:: with SMTP id
 if5mr6125060qvb.9.1615433527865; Wed, 10 Mar 2021 19:32:07 -0800 (PST)
Date: Thu, 11 Mar 2021 11:31:49 +0800
Message-Id: <20210311033151.1818603-1-tzungbi@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH 0/2] ASoC: mediatek: mt8183-mt6358: support machine driver for
 rt1015p
From: Tzung-Bi Shih <tzungbi@google.com>
To: broonie@kernel.org, robh+dt@kernel.org
Content-Type: text/plain; charset="UTF-8"
Cc: tzungbi@google.com, alsa-devel@alsa-project.org, devicetree@vger.kernel.org
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

The series reuses mt8183-mt6358-ts3a227-max98357.c for supporting
machine driver with rt1015p speaker amplifier.

The 1st patch adds document for the new proposed compatible string.

The 2nd patch changes the machine driver to support "RT1015P" codec.

Tzung-Bi Shih (2):
  ASoC: dt-bindings: mt8183: add compatible string for using rt1015p
  ASoC: mediatek: mt8183: support machine driver with rt1015p

 .../sound/mt8183-mt6358-ts3a227-max98357.txt  |  1 +
 sound/soc/mediatek/Kconfig                    |  1 +
 .../mt8183/mt8183-mt6358-ts3a227-max98357.c   | 29 +++++++++++++++++++
 3 files changed, 31 insertions(+)

-- 
2.31.0.rc2.261.g7f71774620-goog

