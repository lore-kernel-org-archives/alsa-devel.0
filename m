Return-Path: <SRS0=kTGd=ZB=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE05BC43331
	for <alsa-devel@archiver.kernel.org>; Sat,  9 Nov 2019 09:48:04 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34CA021848
	for <alsa-devel@archiver.kernel.org>; Sat,  9 Nov 2019 09:48:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="rINZv9Q6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34CA021848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 530181686;
	Sat,  9 Nov 2019 10:47:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 530181686
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1573292882;
	bh=zvOfDPZX+psJYHC/I8OHNvYvXKPTMiLbKMu6jpHYH48=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=rINZv9Q6JJkviUsKzZDybsIRx5ROz7mOja1Oxuo5e7qAprgulXN5UcFP21FP3QR35
	 cZbFDb3beiEEKK4P2aQ5p9kfxExjYvcwJBQLUOF2OH0fZHo/n9ySo33uBM5iFNCmd/
	 h7zGG+KLB2aCsiuSQYfU/3+P03ax1/QWT5RTg/iU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D661AF80639;
	Sat,  9 Nov 2019 10:44:17 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E8787F8045F; Fri,  8 Nov 2019 18:48:59 +0100 (CET)
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8301CF800F3
 for <alsa-devel@alsa-project.org>; Fri,  8 Nov 2019 18:48:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8301CF800F3
Received: from [127.0.0.1] (localhost [127.0.0.1]) (Authenticated sender: sre)
 with ESMTPSA id 78DD929128D
Received: by jupiter.universe (Postfix, from userid 1000)
 id EA32148009C; Fri,  8 Nov 2019 18:48:53 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Support Opensource <support.opensource@diasemi.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Date: Fri,  8 Nov 2019 18:48:38 +0100
Message-Id: <20191108174843.11227-1-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.24.0.rc1
MIME-Version: 1.0
X-Mailman-Approved-At: Sat, 09 Nov 2019 10:43:39 +0100
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>,
 linux-kernel@vger.kernel.org,
 Sebastian Reichel <sebastian.reichel@collabora.com>, kernel@collabora.com
Subject: [alsa-devel] [PATCHv1 0/5] ASoC: da7213: support for usage with
	simple-card
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

Hi,

This extends the da7213 driver to be used with simple-audio-card in
combination with a fixed clock. Here is a snippet of the downstream
board's DT, that is supposed to be supported by this patchset.

---------------------------------------------------------------------
/ {
        sound {
                compatible = "simple-audio-card";
                simple-audio-card,name = "audio-card";
                simple-audio-card,format = "i2s";
                simple-audio-card,bitclock-master = <&dailink_master>;
                simple-audio-card,frame-master = <&dailink_master>;
                
                simple-audio-card,widgets = "Speaker", "Ext Spk";   
                simple-audio-card,audio-routing = "Ext Spk", "LINE";
                
                simple-audio-card,cpu {
                        sound-dai = <&ssi1>;
                };

                dailink_master: simple-audio-card,codec {
                        sound-dai = <&codec>;
                };
        };

        clk_ext_audio_codec: clock-codec {
                compatible = "fixed-clock";
                #clock-cells = <0>;
                clock-frequency = <12288000>;
        };
};

&i2c1 {
        codec: audio-codec@1a {
                compatible = "dlg,da7212";
                reg = <0x1a>;
                #sound-dai-cells = <0>;
                VDDA-supply = <&reg_2v5_audio>;
                VDDSP-supply = <&reg_5v0_audio>;
                VDDMIC-supply = <&reg_3v3_audio>;
                VDDIO-supply = <&reg_3v3_audio>;
                clocks = <&clk_ext_audio_codec>;
                clock-names = "mclk";
        };
};
---------------------------------------------------------------------

-- Sebastian

Sebastian Reichel (5):
  ASoC: da7213: Add regulator support
  ASoC: Add DA7213 audio codec as selectable option
  ASoC: da7213: move set_sysclk to codec level
  ASoC: da7213: move set_pll to codec level
  ASoC: da7213: add default clock handling

 .../devicetree/bindings/sound/da7213.txt      |   4 +
 sound/soc/codecs/Kconfig                      |   3 +-
 sound/soc/codecs/da7213.c                     | 128 ++++++++++++++++--
 sound/soc/codecs/da7213.h                     |   3 +
 4 files changed, 125 insertions(+), 13 deletions(-)

-- 
2.24.0.rc1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
