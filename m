Return-Path: <SRS0=iQjD=KU=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 178C5C2B9F8
	for <alsa-devel@archiver.kernel.org>; Tue, 25 May 2021 13:27:28 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53A6A60200
	for <alsa-devel@archiver.kernel.org>; Tue, 25 May 2021 13:27:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53A6A60200
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cerno.tech
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D80961739;
	Tue, 25 May 2021 15:26:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D80961739
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1621949243;
	bh=pSD3uCKc8ZbIsUije8W9D3Qtesv3LfVPvAL6Nk/ZW74=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Gv6FRxWwSNldNgHiXUzreo6AhMY/CZrg+DomwacaE0wD16NGUM2X5V8RvYtYEIa7q
	 diWquceWtOfNFnRlhyDPutCKMWm799bJbmbfABDuo3NW5w2uSesh2Yx3FoQfTk1+YX
	 56s3jwmtLH2tx2TRIfpdPz2DYo4S6Phmo9gJi/cs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E7F09F804B0;
	Tue, 25 May 2021 15:24:18 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7F127F8049C; Tue, 25 May 2021 15:24:16 +0200 (CEST)
Received: from new2-smtp.messagingengine.com (new2-smtp.messagingengine.com
 [66.111.4.224])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AF5A1F802CA
 for <alsa-devel@alsa-project.org>; Tue, 25 May 2021 15:24:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AF5A1F802CA
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech
 header.b="fghqbZjj"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="OMSHDlqU"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
 by mailnew.nyi.internal (Postfix) with ESMTP id E7696580712;
 Tue, 25 May 2021 09:24:12 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute6.internal (MEProxy); Tue, 25 May 2021 09:24:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm2; bh=Hm66TN2+4rFj2
 +hvHW2sdkOXUymQe5MbU4IMHCfHuAI=; b=fghqbZjjxyJ77b9oDV6xmd/Cu5Xzx
 zOuj5ZDE7A3L++IKqsBFXrp+RbRagqC5zO3SPA0iwIsy+qAMuFzUhsKCrX5bOw2H
 6B8bV/iV3yq/rc7VxUmarj8CuxCQnQ95wpjVKRFZcAwkavkYhrQCwPnYbAgFnvmg
 MMRqqsP5uXtajgPRcrwnK7UkNdwxtzNg1aZCoQcRUXCX0Al+xAM1a/uqf86WCvW3
 HJuf4bwmR2xkwJrqBxjv7Dy4Z6tRE64PoNT5f98YcVz1eT4HYMEF/8HzCDg/OTzS
 OfeXrg3DdphUqr8ijvDJZuEe8PpAxT4TAUm7OznEWAAF6lWzCTO1kDmng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm2; bh=Hm66TN2+4rFj2+hvHW2sdkOXUymQe5MbU4IMHCfHuAI=; b=OMSHDlqU
 eHcSPgjMwHct8SnnWXxBm8hqPpoFOc01qe9wsU1CLPtn9br8m5h8+d5kQ70TZ8/6
 0Q+Ut4nuCp7Ovt8AQ/ERm/V/Gc+ioD1tsMEyL/WZ/mY4294JusGyYD/34kE5v5Yk
 TGeEB0bpl+CWdNDiy6/8+ZY9qYdrAvatmAyP1LvxoACZynTNaLdjgKZeIhGvAHIF
 Et+CB92zqZUf1V5Ht+We2i5aiJxCJYgfA/iCKVWRWTwaIVPJ54nYo20BcvnAQFW+
 pvmAiWd+RdEoxBMxwsRmpQpX1H9WL1Kv5/c3hJgswvg3nMDTukLfU+NI/2SOYyD1
 wc5Bd8m4eKExgA==
X-ME-Sender: <xms:fPqsYIAIBi1AHfMpeMP_a9lw7hog8Y_d8s5jxHcQopwsU4MqY5jsQA>
 <xme:fPqsYKi6KrWELa47jglk9d6YfoMCMjeWoeq_hYXjn0-RXjb5t6jNH0rzTvuVFu-DQ
 belJs_u42F78LO36lw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdekuddgieehucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhm
 vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
 htvghrnhepvdekleevfeffkeejhfffueelteelfeduieefheduudfggffhhfffheevveeh
 hedvnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
 frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:fPqsYLnBJEGUZccy9pBuTLrE4Dhs6lYaYhIJ2HvQWmNk8tMWYiWObQ>
 <xmx:fPqsYOwdIgywVGf9YNw7d6SMeV2uBgruCRVHj5T9CAPwV62boSkmFQ>
 <xmx:fPqsYNSJPEvcDB7U_Io1pHvuzy1ywPMTMFjfWQh8K0tO_AzqcbdPYw>
 <xmx:fPqsYIln-RYW99UGONrnHxbcERhOWrUJxnBKjyaSXkLQjmxePKoRHQ>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr
 [90.89.68.76]) by mail.messagingengine.com (Postfix) with ESMTPA;
 Tue, 25 May 2021 09:24:12 -0400 (EDT)
From: Maxime Ripard <maxime@cerno.tech>
To: Jaroslav Kysela <perex@perex.cz>, Mark Brown <broonie@kernel.org>,
 dri-devel@lists.freedesktop.org, Daniel Vetter <daniel.vetter@intel.com>,
 David Airlie <airlied@linux.ie>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, Maxime Ripard <maxime@cerno.tech>,
 Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>
Subject: [PATCH v2 06/12] drm/vc4: hdmi: Set HD_CTL_WHOLSMP and
 HD_CTL_CHALIGN_SET
Date: Tue, 25 May 2021 15:23:48 +0200
Message-Id: <20210525132354.297468-7-maxime@cerno.tech>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210525132354.297468-1-maxime@cerno.tech>
References: <20210525132354.297468-1-maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Nicolas Saenz Julienne <nsaenz@kernel.org>, Dom Cobley <dom@raspberrypi.com>,
 Tim Gover <tim.gover@raspberrypi.com>, linux-doc@vger.kernel.org,
 Dave Stevenson <dave.stevenson@raspberrypi.com>, linux-kernel@vger.kernel.org,
 Maxime Ripard <mripard@kernel.org>, Eric Anholt <eric@anholt.net>,
 Rob Herring <robh+dt@kernel.org>, bcm-kernel-feedback-list@broadcom.com,
 linux-arm-kernel@lists.infradead.org, Daniel Vetter <daniel@ffwll.ch>,
 Dom Cobley <popcornmix@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
 Phil Elwell <phil@raspberrypi.com>,
 Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
 linux-rpi-kernel@lists.infradead.org
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

From: Dom Cobley <popcornmix@gmail.com>

Symptom is random switching of speakers when using multichannel.

Repeatedly running speakertest -c8 occasionally starts with
channels jumbled. This is fixed with HD_CTL_WHOLSMP.

The other bit looks beneficial and apears harmless in testing so
I'd suggest adding it too.

Documentation says: HD_CTL_WHILSMP_SET
Wait for whole sample. When this bit is set MAI transmit will start
only when there is at least one whole sample available in the fifo.

Documentation says: HD_CTL_CHALIGN_SET
Channel Align When Overflow. This bit is used to realign the audio
channels in case of an overflow.
If this bit is set, after the detection of an overflow, equal
amount of dummy words to the missing words will be written to fifo,
filling up the broken sample and maintaining alignment.

Signed-off-by: Dom Cobley <popcornmix@gmail.com>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_hdmi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index c27b287d2053..212b5df11d73 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -1267,7 +1267,9 @@ static int vc4_hdmi_audio_trigger(struct snd_pcm_substream *substream, int cmd,
 		HDMI_WRITE(HDMI_MAI_CTL,
 			   VC4_SET_FIELD(vc4_hdmi->audio.channels,
 					 VC4_HD_MAI_CTL_CHNUM) |
-			   VC4_HD_MAI_CTL_ENABLE);
+					 VC4_HD_MAI_CTL_WHOLSMP |
+					 VC4_HD_MAI_CTL_CHALIGN |
+					 VC4_HD_MAI_CTL_ENABLE);
 		break;
 	case SNDRV_PCM_TRIGGER_STOP:
 		HDMI_WRITE(HDMI_MAI_CTL,
-- 
2.31.1

