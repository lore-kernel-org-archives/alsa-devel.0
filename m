Return-Path: <SRS0=XQZd=IK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFA85C433DB
	for <alsa-devel@archiver.kernel.org>; Fri, 12 Mar 2021 10:46:31 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9821165022
	for <alsa-devel@archiver.kernel.org>; Fri, 12 Mar 2021 10:46:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9821165022
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 337D316E8;
	Fri, 12 Mar 2021 11:45:37 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 337D316E8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1615545987;
	bh=frcCV1k9oG9oKj3dpUqdJg1PxRT2RSN/XKdLCPjaYaY=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=JzELVF/uobuQzi8Mw7FrSW1RmnzFMjl1RCl+dKgC37UIF55J3BVlqLMAFyrny2Noc
	 /k0dQIjo2kgecb/mCm/rgZq98Q1nvPnBibk2HT4thXZDZYI4Hv1KI8MXIThv4hXSOm
	 BKM1dhlHCHiciNhNTQW9EWTloqrGaNtpSolwz2oc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B0A92F8012A;
	Fri, 12 Mar 2021 11:45:36 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0856EF80227; Thu, 11 Mar 2021 14:00:59 +0100 (CET)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1FA5EF800BF
 for <alsa-devel@alsa-project.org>; Thu, 11 Mar 2021 14:00:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1FA5EF800BF
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="Rvvcn0Ii"
Received: by mail-ej1-x636.google.com with SMTP id dx17so46062084ejb.2
 for <alsa-devel@alsa-project.org>; Thu, 11 Mar 2021 05:00:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to:cc;
 bh=AN9nW3Joor3L0und5WjRdNWRPuPbkdauhUlsQA2rUqM=;
 b=Rvvcn0IiO9yA4gqENONos2TtnClDT+5+lUG0tvy+MKTrCiX/E0VmdN89/oiRHQ1WHT
 5CxkdjoyW3KQ1uzeFh4pNIy9sPdQN/3mxKPeVzcZBCgClKRPgUk50afJDFaHgS+Zndgt
 sGCuO50uL/sETb9D5ksZ0J8uVDR402AB/MNSMifzcdha9Am1+z6Uk40KPE+nP23E+Wmw
 g4EP+mB1oWDcvX5NDf5lBc+Y/ji0Bit+U7KReWc2hJsNaBK4UNKarYPIIBPV63jtbxb2
 0tOk9TW/BjOvyCkJ4hbUyJCzQv7LL/zeGDPV4llDt05226fKzC1LX4LtJtFPSY0z5tbN
 h8DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=AN9nW3Joor3L0und5WjRdNWRPuPbkdauhUlsQA2rUqM=;
 b=TaNUH/eHSSWSB0KibxXBg5xsHYxT1GV3eX4VBiOJC0z1B9RMN/1D41klx7UaKg9EfX
 Y1NLy7cUvD/BmsMaF5QHl6Z7CNg6++5cuQKHShRRiVGQspOkQuGZGZx37C4NA4YbCNs3
 YHUo5HH1R0JVdIVaqt8MQlLn2WeoDD8uaKuEta1lQksqofs8kSrDdyZDYAOqmCgCZlYQ
 19lv5isFVmzIxZK6EN82QRh6HX7vRfY6iBtKM8ERqO6KgsGN83GxIwTXZGhi2r8htqZO
 eoRTty7I9e4fK1h7hRwc2bwiqsgwtRGLOkneL7zbNEkSUFir9J4UFV5ZENtQpBwAlJvd
 OqPA==
X-Gm-Message-State: AOAM531MlKaHRdVUVXYu9uxWjhFctoNIuXDpB+K0vCsVbB16V4+lSV6F
 x1UknncQv1w5Npp+BPbEjQqhBjiNyh+oytMEZ0c=
X-Google-Smtp-Source: ABdhPJxS3L0w/iAlL6AJU7hIhfqsNzrCvXNnAvhPM62kvuOO0Y9wDc7g0jH0PWoSx9ZM8ck5JBGWMRdI3UTnmqS4Zx4=
X-Received: by 2002:a17:907:aa2:: with SMTP id
 bz2mr2996933ejc.239.1615467651309; 
 Thu, 11 Mar 2021 05:00:51 -0800 (PST)
MIME-Version: 1.0
From: Sufyan Sheikh <sufyansheikh349@gmail.com>
Date: Thu, 11 Mar 2021 18:30:39 +0530
Message-ID: <CAJ6e=ALLgio8FV+Cif9jby9JnN52DAQ601ywr5XCdKvmtDDhkA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] ASoC: codecs: wcd934x: add a sanity check in set
 channel map
To: srinivas.kandagatla@linaro.org
X-Mailman-Approved-At: Fri, 12 Mar 2021 11:45:35 +0100
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.15
Cc: Amit Pundir <amit.pundir@linaro.org>, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, lgirdwood@gmail.com, bjorn.andersson@linaro.org,
 broonie@kernel.org, john.stultz@linaro.org
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


