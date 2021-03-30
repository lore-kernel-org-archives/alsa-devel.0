Return-Path: <SRS0=2x8D=I4=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FC74C433C1
	for <alsa-devel@archiver.kernel.org>; Tue, 30 Mar 2021 14:48:32 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03F30619E1
	for <alsa-devel@archiver.kernel.org>; Tue, 30 Mar 2021 14:48:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03F30619E1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AC3001675;
	Tue, 30 Mar 2021 16:47:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AC3001675
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1617115708;
	bh=1W50JCDUOf+7f9pSPPutOpATK4dRlmRXcV3uOmGrI2k=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=vlcjHSSHz/0Bh58W5XKW7COBAyBsWNf919wHTqECPeXsdVGcodaDjiqWp1PIunl6v
	 Azac2VOEDbWh+i1njzxA33jD6YowYL7Bu+h1cgyCZIq3nQH2tBm3iEVx8t4fewQHXC
	 aejbvhxUkGbfcTGGMBRUidYWZ52vN6YexObFqOPA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2BC8DF8026B;
	Tue, 30 Mar 2021 16:47:38 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5DEBCF8026F; Tue, 30 Mar 2021 16:47:35 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AB915F8023E
 for <alsa-devel@alsa-project.org>; Tue, 30 Mar 2021 16:47:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AB915F8023E
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="oFDj0OGc"
Received: by mail-ej1-x629.google.com with SMTP id b7so25256507ejv.1
 for <alsa-devel@alsa-project.org>; Tue, 30 Mar 2021 07:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=DfVVbnMRBjcx8lxNFkrBcP8VRW/be3uoR/xr+g+P8/g=;
 b=oFDj0OGchZRxC1Omw0WtmvRq0/GM+VLpoXoleMFmvHTzAiIr+Rn6H+Rmzxhe88NmNv
 Z1GrbQZycWAC5zdbfHCfKbZBrmtLBnsrQcBAchpIYbQE3dkx2jmwuW3omn1myUsSepmj
 GYO2UTZN8v3HtuY0OeM0cR8TMMSR+Kir2zuoKDWHwV9Ydm6alo1nqH8K7KkpUbhJDJq3
 2XYBtc54JpUNuFFyi+0UHTo1HQgpcg2ajYVGN/y2EjLOJg4f7Uh73WXdpExmgc+Kk5wk
 4PVGwtFtVgaiuxThFgOSjEnh67kI1GHi018M7OBZlikSo/xxk+v578R5MyzI1QtKMoxN
 rbjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=DfVVbnMRBjcx8lxNFkrBcP8VRW/be3uoR/xr+g+P8/g=;
 b=oZVj8mQAPZP/9i+8s+C6wm0vV1vOimoSy5kgxtk/rO1SwuJARrjvBwnRvwAyJkrTSC
 ig0ZhZXUlM65+D2e/ZSKHkCPHDLfaEtaB6Gqqpn4EPrX+wHCRjWYcQZvWaUxw+zzR3Gv
 nsVg6gxCClGaG3NrwkZJRCrzI1uTa+/BDaMNtr+RW8vlVTcswGIr46+97YoQ6XEMFOHu
 e9msf3aOYMBLvw54noAXqzeDItoHKIvPXNOuxJMVAouoeeMzbfbD5B2c5XAh7m9BUvof
 /SsVPnPxSZgkEiKUJ8EEEpAJYEgt6UD5qQMqYE9VTNbXsy+ZwN4ehWxHs7komZ4ZxmqW
 5xbA==
X-Gm-Message-State: AOAM531dZBRRa8b4oGp3Vra0sHT+dUq87pkozIP3ZAQuyMjGSB6XSp17
 AGcZ6O1vSvf56osmfP1d+bqtpw==
X-Google-Smtp-Source: ABdhPJwMYcNcpviBb5ac79qkVKzN8+9vV5ejGiXA/bJ95PIHeV+lX2+wvv6h+0qMbfCyOcGzSZUU1w==
X-Received: by 2002:a17:906:9b2:: with SMTP id
 q18mr6858760eje.147.1617115648503; 
 Tue, 30 Mar 2021 07:47:28 -0700 (PDT)
Received: from srini-hackbox.lan
 (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
 by smtp.gmail.com with ESMTPSA id n16sm11520383edr.42.2021.03.30.07.47.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Mar 2021 07:47:27 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: vkoul@kernel.org
Subject: [PATCH v6 0/9] soundwire: qcom: various improvements
Date: Tue, 30 Mar 2021 15:47:10 +0100
Message-Id: <20210330144719.13284-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: robh@kernel.org, alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
 pierre-louis.bossart@linux.intel.com, linux-kernel@vger.kernel.org,
 sanyog.r.kale@intel.com, yung-chuan.liao@linux.intel.com
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

Thanks for reviewing v5 of this patchset!

During testing SoundWire controller on SM8250 MTP, we found
few issues like all the interrupts are not handled,
all transport parameters are not read from device tree.
Patch to add Auto Enumeration supported by the controller
is also part of this series.

Other major issue was register read/writes which was interrupt based
was an overhead and puts lot of limitation on context it can be used from.

With previous approach number of interrupts generated
after enumeration are around 130:
$ cat /proc/interrupts  | grep soundwire
21: 130 0 0 0 0 0 0 0 GICv3 234 Edge      soundwire
    
after this patch they are just 3 interrupts
$ cat /proc/interrupts  | grep soundwire
21: 3 0 0 0 0 0 0 0 GICv3 234 Edge      soundwire

So this patchset add various improvements to the existing driver
to address above issues.

Tested it on SM8250 MTP with 2x WSA881x speakers, HeadPhones on
WCD938x via lpass-rx-macro and Analog MICs via lpass-tx-macro.
Also tested on DragonBoard DB845c with 2xWSA881x speakers.

Changes since v5:
	- Use BIT macro in interrupt routine
	- add comment for fifo write

Srinivas Kandagatla (9):
  dt-bindings: soundwire: qcom: clarify data port bus parameters
  soundwire: qcom: add support to missing transport params
  soundwire: qcom: set continue execution flag for ignored commands
  soundwire: qcom: start the clock during initialization
  soundwire: qcom: update register read/write routine
  soundwire: qcom: add support to new interrupts
  soundwire: export sdw_compare_devid, sdw_extract_slave_id and
    sdw_slave_add
  soundwire: qcom: add auto enumeration support
  soundwire: qcom: wait for enumeration to be complete in probe

 .../bindings/soundwire/qcom,sdw.txt           |  20 +
 drivers/soundwire/bus.c                       |   4 +-
 drivers/soundwire/qcom.c                      | 529 ++++++++++++++----
 drivers/soundwire/slave.c                     |   1 +
 include/linux/soundwire/sdw.h                 |   2 +
 5 files changed, 443 insertions(+), 113 deletions(-)

-- 
2.21.0

