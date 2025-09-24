Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91B4CCAC5A5
	for <alsa-devel@archiver.kernel.org>; Wed, 24 Sep 2025 15:17:20 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 74B81601E8;
	Wed, 24 Sep 2025 17:17:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 74B81601E8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1758727038;
	bh=2VbBzvLvFZoo4XGwnxkRJZBI+Gx42jrX0GoxKkjapX0=;
	h=Subject:From:To:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=HcH6P/iPPrlCtrBH1ZKkLJnIs0enMbKJ1jU84KbCsICY683qSjbZkW9/Qp6xUDzz3
	 /oAbuj2Z+sDLfxRU4Lg9hoUDIiyRiaKPE7jWmGDVzLOwv9igGFyQj80hmTPTzjM+0f
	 38ZUPHVH69qhS0L51raYobxRj15sNGIAldGAYiVE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9B071F800E3; Wed, 24 Sep 2025 17:16:45 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 0EB15F805D2;
	Wed, 24 Sep 2025 17:16:45 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9CB7CF80301; Wed, 24 Sep 2025 17:16:18 +0200 (CEST)
Received: from mailman-web.alsa-project.org (mailman-web.alsa-project.org
 [10.254.200.11])
	by alsa1.perex.cz (Postfix) with ESMTP id 88529F800E3
	for <alsa-devel@alsa-project.org>; Wed, 24 Sep 2025 17:16:18 +0200 (CEST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: ASOC - Manage sound card with multiple optional codecs
From: claudio.mocci@abinsula.com
To: alsa-devel@alsa-project.org
Date: Wed, 24 Sep 2025 15:16:18 -0000
Message-ID: 
 <175872697852.20.16571469264981576402@mailman-web.alsa-project.org>
User-Agent: HyperKitty on https://mailman.alsa-project.org/
Message-ID-Hash: 4I6A3KYNZZWHGIN4JOWZMK7ATVTCFQSJ
X-Message-ID-Hash: 4I6A3KYNZZWHGIN4JOWZMK7ATVTCFQSJ
X-MailFrom: claudio.mocci@abinsula.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/JJBKEUO2TEJP3K4RACGEDBX2RJ5E55U2/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

I'm working on a custom driver for an embedded device that should manage an audio card with multiple codecs. Each codec  can be hotplugged or removed because is placed on an external display that extends an i2cbus.

I used the orginal fsl/imx-card.c driver as a starting point and my device tree looks like this:

sound_card: sound {
        compatible = "display-audio-card";
        model = "disp-audio";
        pri-dai-link {            
            link-name = "disp-codec-1";
            format = "dsp_b";
            dai-tdm-slot-num = <4>;
            dai-tdm-slot-width = <32>;
            dai-tdm-slot-tx-mask = <1 1 1 1 0 0 0 0>;
            fsl,mclk-equal-bclk;
            cpu {
                 sound-dai = <&esai0>;
            };
            codec {
                 sound-dai = <&speaker_dac_1>, <&speaker_dac_2>;
            };
        };
	};

The first issue I encountered was that if both of the codecs were not present at the system start the snd_soc_of_get_dai_link_codecs was returning probe_defer, so I made an internal customization to set one of the two codecs to dummy and continuing registering the card that works as required.
Now the problem I am facing is when I have both displays connected and when I unplug one of them all the card gets unregistered instead of the single codec. I tried implementing the codec_i2c_remove where I removed the component from the component list

        snd_soc_component_remove(component);
        list_del(&component->list);        
        devm_kfree(dev, component->name);

and this did not unregistered the card, but something is odd. So I tried to replace the component with a dummy codec to be transparent but without success

There is some other architecture instead of imx-card that I can use to implement the feature? I remember firsly I tried with audio-graph-card but without success.
