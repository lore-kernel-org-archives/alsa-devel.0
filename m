Return-Path: <SRS0=9b6r=YW=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 552AACA9EAE
	for <alsa-devel@archiver.kernel.org>; Tue, 29 Oct 2019 17:53:08 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2D2E2087E
	for <alsa-devel@archiver.kernel.org>; Tue, 29 Oct 2019 17:53:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="B6jiCZT5";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eMG+GuYW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2D2E2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A59052287;
	Tue, 29 Oct 2019 18:52:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A59052287
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1572371585;
	bh=L0we4wCqjNVHYsWts23HdaM3uGsMJgRrSbCT4IWDitg=;
	h=Date:From:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=B6jiCZT5mLFv7ImjCDPOya9GSimiQn6MxrGWFLH+5R3gVUQUcXOxx9nfU6c0XleY6
	 JjlbUpRa4EqZS3eaBwkcfXoigIrMsL2EJcMcWjncyJ01F/vhCOsaxyajdQwgH5XB32
	 ESUGLDR9ITGZVfoggyPC8DGAS+NfGbDibHPV3lDo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 28D58F8036C;
	Tue, 29 Oct 2019 18:52:15 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1E7AEF80392; Tue, 29 Oct 2019 18:52:14 +0100 (CET)
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com
 [IPv6:2607:f8b0:4864:20::544])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 583CAF8015A
 for <alsa-devel@alsa-project.org>; Tue, 29 Oct 2019 18:52:10 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 583CAF8015A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="eMG+GuYW"
Received: by mail-pg1-x544.google.com with SMTP id 15so10084240pgt.7
 for <alsa-devel@alsa-project.org>; Tue, 29 Oct 2019 10:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:mime-version:content-disposition
 :user-agent; bh=WQuaGhw+j/L1GECLdxkL+IQAboSwYNwdTLYnLHvyPs8=;
 b=eMG+GuYW0OmhY6ro8Yeeu1abzM+LR/mzcdQEofubIIHWWpsksdJybinfj19OxIPIfV
 2F/h4pVMuFWoK3OZR3aNK1N4LvBM7hwCpwHrGOrnTBTeA2l5MGwLpBXNxolXYTiNdsZi
 +r4xnfjZcf1F1AD7+FotPnmSKvKT7FJ9ke0Cx0M1wpcO019m9SRWj5DrvPDBk80byObM
 V8J6Fdc6HN4gB319c6v7TulUONDQuiWf8aCtAgkNddCyesnMvBkfqPdePR7LguFh3xTW
 Vr+atD2bGf7HMjywS1koa0GnrKT58QtG6hLSFE5+uuT4djFo80FRXdp2bYwLJ61Wuars
 jJ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition:user-agent;
 bh=WQuaGhw+j/L1GECLdxkL+IQAboSwYNwdTLYnLHvyPs8=;
 b=VzxQwMS0eYawVxr46TrLoTYsmQkwy5CvJ77B+wmdiLzNF5QbSZJWYnlQVz7T8pTiP9
 HF2hldJfKPJv0/OPiNkhTSIr4fjctLAgfVbsCPDyLdaJ8ayzfWSx+7tvUgjB+xW1/NgA
 SP6IYqxEdinEMnETpdzLdGEAhU+feuQav0ZOGL+Z+Jpar1tMOYnmn9BJMFQto5Eem76J
 VAt3gxa1aOUQ0E9rTjtN2HKwBfS1FjDUm48g6fUnManlSASCL+6+oWsbqlIwMWqmtBFd
 zV+epbThRcRKX9BLuS6z48BDN3soS4Ma81+PqH5sGhbkPalSNsEG3EiHVIU8yZXknU0j
 VJBg==
X-Gm-Message-State: APjAAAUN1hCO4filKQMJZdp1RX6OBHp8cskLJtTVsxFO2Bp77KZmnBCq
 xr5GepRrEN1TuNim39GG5W8=
X-Google-Smtp-Source: APXvYqzrSQsPEEJLMY2h97BAVghXEBeEsEuCaCOuF7o17Uq27bil0is02/pulRLMZFnxkezDHUGo2Q==
X-Received: by 2002:a17:90a:1424:: with SMTP id
 j33mr8490846pja.2.1572371528296; 
 Tue, 29 Oct 2019 10:52:08 -0700 (PDT)
Received: from saurav ([117.232.226.35])
 by smtp.gmail.com with ESMTPSA id m17sm8901042pfh.79.2019.10.29.10.52.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Oct 2019 10:52:07 -0700 (PDT)
Date: Tue, 29 Oct 2019 23:22:00 +0530
From: Saurav Girepunje <saurav.girepunje@gmail.com>
To: perex@perex.cz, tiwai@suse.com, allison@lohutok.net,
 rfontana@redhat.com, saurav.girepunje@gmail.com, tglx@linutronix.de,
 gregkh@linuxfoundation.org, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org
Message-ID: <20191029175200.GA7320@saurav>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: saurav.girepunje@hotmail.com
Subject: [alsa-devel] [PATCH v1] ALSA: usb-audio: sound: usb: usb true/false
 for bool return type
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Use true/false for bool type return in uac_clock_source_is_valid().

Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
---

Changes in v1:

	- Update the patch subject suggested by Takashi Iwai <tiwai@suse.de>

        - Drop "!!" but keep the ternary operator in last return
          statement so that function will return always true/false.
 
 sound/usb/clock.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/usb/clock.c b/sound/usb/clock.c
index 72e9bdf76115..8d5538063598 100644
--- a/sound/usb/clock.c
+++ b/sound/usb/clock.c
@@ -167,21 +167,21 @@ static bool uac_clock_source_is_valid(struct snd_usb_audio *chip,
 			snd_usb_find_clock_source_v3(chip->ctrl_intf, source_id);
 
 		if (!cs_desc)
-			return 0;
+			return false;
 		bmControls = le32_to_cpu(cs_desc->bmControls);
 	} else { /* UAC_VERSION_1/2 */
 		struct uac_clock_source_descriptor *cs_desc =
 			snd_usb_find_clock_source(chip->ctrl_intf, source_id);
 
 		if (!cs_desc)
-			return 0;
+			return false;
 		bmControls = cs_desc->bmControls;
 	}
 
 	/* If a clock source can't tell us whether it's valid, we assume it is */
 	if (!uac_v2v3_control_is_readable(bmControls,
 				      UAC2_CS_CONTROL_CLOCK_VALID))
-		return 1;
+		return true;
 
 	err = snd_usb_ctl_msg(dev, usb_rcvctrlpipe(dev, 0), UAC2_CS_CUR,
 			      USB_TYPE_CLASS | USB_RECIP_INTERFACE | USB_DIR_IN,
@@ -193,10 +193,10 @@ static bool uac_clock_source_is_valid(struct snd_usb_audio *chip,
 		dev_warn(&dev->dev,
 			 "%s(): cannot get clock validity for id %d\n",
 			   __func__, source_id);
-		return 0;
+		return false;
 	}
 
-	return !!data;
+	return data ? true :  false;
 }
 
 static int __uac_clock_find_source(struct snd_usb_audio *chip, int entity_id,
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
