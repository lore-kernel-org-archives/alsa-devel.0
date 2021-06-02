Return-Path: <SRS0=h1r5=K4=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA2B5C47083
	for <alsa-devel@archiver.kernel.org>; Wed,  2 Jun 2021 14:27:11 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DC9A61361
	for <alsa-devel@archiver.kernel.org>; Wed,  2 Jun 2021 14:27:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DC9A61361
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E81DF170C;
	Wed,  2 Jun 2021 16:26:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E81DF170C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1622644030;
	bh=2FzI5ThqOtKWmEgVxwQBluJa6RFUBb0yHZp7JEPIamY=;
	h=To:From:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:From;
	b=WnW2DpkCuWLes+ITHDFaTvxCaRGVLv2BkrzSAupeBsw7COb3/Gnjgb+udg5ympNCS
	 0gFQSgqN9yk25ggSpJViIZo66OLvI43flYfhjrFaBISRsTJNLvMZuM+caIV9r4lTTL
	 IRUL1YRIuE3xOMiKT6wxBsOnicO/lSsSH/wpmsPY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A2A2CF804E6;
	Wed,  2 Jun 2021 16:23:17 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 15181F80424; Wed,  2 Jun 2021 11:10:10 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.15.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AD7CDF80103
 for <alsa-devel@alsa-project.org>; Wed,  2 Jun 2021 11:10:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AD7CDF80103
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="IjzKSA3m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1622625000;
 bh=2FzI5ThqOtKWmEgVxwQBluJa6RFUBb0yHZp7JEPIamY=;
 h=X-UI-Sender-Class:To:From:Subject:Reply-To:Date;
 b=IjzKSA3muPBO9y9Yfp0gprk+vim9WS/AxxaRJtWje7xx37WlOLx9yBg8CMNDyq4OJ
 rqAo9B0DwhURrBYh/Qr+u7KVDmUPHHS7ZTDitsILOaRs4vRpZZaDijYH0J4ySDor7e
 Cam+yozXuh2qCp2Nj941PHoXKeJ0k5S0vUtp28Pk=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.49] ([31.150.84.162]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LvBJK-1lNWIM0ySg-010IoQ for
 <alsa-devel@alsa-project.org>; Wed, 02 Jun 2021 11:10:00 +0200
To: alsa-devel@alsa-project.org
From: "reinerschrutz@web.de" <reinerschrutz@web.de>
Subject: no sound via HDMI
Message-ID: <f6555a72-56db-7a52-4205-9318aef36ed2@web.de>
Date: Wed, 2 Jun 2021 11:09:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: de-DE
X-Provags-ID: V03:K1:zjyghD5poouPQFtZRp+68+23HxDilx5O84NILMB4iCwEVtCQLEa
 88pH4GYRSM699/hH3RrTLrihut2pxGq5a/0kx/54la/NRAWEuSEgskezHlfkpJK4kmxDnl8
 Hh0x1CsRO3KLbelbev+XTywOo4IzqV60oPArQNB8Kl+QAYzLOgablSrswilBIpLPSOh/Sct
 2anQZKaPY+wcwLjn0jCbA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Q0mRhBqOLwk=:7npoWzlpj7L/3yJTJAAybx
 9uqqY+tN0+yixmkpjZM21fzkEMvv1QNXa3dIqyVQgn5kEKX7QKfYADRf2iv+R6YCw7bWVLoki
 9V/0/hxYoNrX7PXeCj7QDlhH4/ur+ej+De/VC9XvfQdulUtUH24XY9DQ5I58mc/cdWbx4QTfe
 eR2sRlfjkywWGMrOGnSNVjmVEde7rjavvuNpVLUz+m7beDJR1TWqPeVdevVa/RQPrjAoisal+
 Q9Nhq6UTe9XkmjDKs7YSTQoHiTPe2ykJehZ3FIkvcM0hOkgRwOe/+0+xvhisnZ51yTim/9hQg
 LbV0HX6RvamIPdyLqlf6ESS+5O8fgCJReS0arnInHNyoAFtdlenX0Wq422NFawuJUPfzACU3t
 esM7Vqdxn5/AyhwfFq6+iHoD80QJLuRHsQ2JzJTYrWTZRSv/qL3p7QxJPocBmxUSQomMttOIA
 7aFuaN1n81VsqUGkLnA/knB4C2ODZpiyy4rDmeITxdDpClDTlD5VvNwQCoFBXe297eLgEYbuS
 GJu0YprXNxi8BMeWhKm9Z8+nKSQx94ETt9KNdohX8E/yYamlOFtPX5Wu+UptdY7M7ZDtoKdrX
 nCZY6yECnseZpGV/rpocYZFrdpVU46FPEqVdBx911gzZhqy0NkHkiapWV4qDkNZxHHg4/BhOb
 uSpiAb+RbxHS6TSQ4hIweO44/TTuHflk5i/NQKLxbDfcSPx4TsxyzPsahY2pDjpBvOw3h+0wJ
 dLnKSaj+YcS71wY5hw7CC1/nlgXDg++u1uRSPNe041edppXva1PGY+lr6XBdD91mTvmLpuGns
 iTCODBQ69aFf/1BI+BoVDDaoWod6/cpYWy+AVhv6su/YS9ZjjhLHPDkruJbOhrOoUknIHJcQd
 MCMuBGCNmDtD7LWVMcSRIhXwpOD5Nrvk+NlYcTVTn41urDOB1idSC3/7e7v3P3X356BrLBmXD
 ZC/0gduMwya/SlWn4xu8+fE4oDtRNZ9qtJjbLbDQNGsDVGzfoZPyXAALQh5Ef3OQCOwAOaCmV
 kCK4Wrr4661wnBiAI24wa/X01v5Tdr+a3oboTZ6p/4KzUNd9FeUpggaYat9Mw9FEHPgXrLG/B
 aJqnOVKsSWClcPc3gaGTvzfrCZUY61D2A3a
X-Mailman-Approved-At: Wed, 02 Jun 2021 16:23:04 +0200
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
Reply-To: reinerschrutz@web.de
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Hi,

missing sound via monitor and HDMI cable

following ubuntuusers "HDA" article I found:

0[generic=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ] - =
HD-Audio Generic=C2=A0 HD-Audio Generic at 0xfcc
88000 irg 62

1[generic_1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ] - HD-Audio Generic=
=C2=A0 HD-Audio Generic at 0xfcc 88000
irq 63

looking for a pci device I found:

05:00.1 Audio device Advanced Micro Devices, Inc. [AMD/ATI] Device 1637

05:00.6 Audio device Advanced Mirco Devices, Inc. [AMD] Family 17h
(Models 10h 1fh) HD Audio Controller


Codec found:=C2=A0 ATI R6xx HDMI


My system: Asus Prime A520M-K, AMD Ryzen 7 Pro 4750G, 8x 3,6 GHz, 16 GD
DDR4 RAM, 500 GB Samsung 870 EVO

Advanced Linux Sound Architecture - Driver Cofiguration Guide said to
give notice.

Thanks.

Stefan Ocken

