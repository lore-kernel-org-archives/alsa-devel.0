Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6DDDCD8C9D
	for <alsa-devel@archiver.kernel.org>; Sun,  7 Jun 2026 23:58:51 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 59B6F601C4;
	Mon,  8 Jun 2026 01:58:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 59B6F601C4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1780876729;
	bh=j3/tU3QfwWByPUrJCBOhRpyTu7phGSmI9ChKkTDu+4Y=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=ji/OPazg2skHJXZkKqjNXrWYuhSZ3a56Fj2V8HSB8+QEeUB/99Z3EQBGrRZU02ye7
	 39fSWUMsDNCgjBiPQovwE/V+5QkiNpAzeeqvPETamhrpjV9qrtZk1lQMqLEZgIuQyv
	 e18nAqYCUBxwTna2yNFNOwMrg6wGQp/OOT7jGBPE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 09759F805FC; Mon,  8 Jun 2026 01:58:15 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id A764DF805FE;
	Mon,  8 Jun 2026 01:58:15 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id DC6AFF80423; Mon,  8 Jun 2026 01:58:09 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1780876689;
	b=UBGdpW1XA4x2CUq5lO3Q2D8pBHaOXcZ0row/NstsmByWhj5BU5WOaRLWq07UoJKvZBbN
	 lpVv+lRs8sl7kw09Y6qFRrZlJQgBRaiyE+G5QSwfnjWHch2dTnowvrbqHKnJY7HPYli+X
	 fvUGvzvJMS6bChTHJskcnr5RpNlOBNnjePw90+nD++Ke6kMDkUTqsp194rTfh/+EBcPGQ
	 KeQdSjrhAJHIyRXbGw1ru2JKOTQ7V3883IrQQBOgpC5Ss64ascdZJM+5N4BSD/JVG3v0/
	 pWtPd2PH19HZoi1L3aGzB7Dakehw/Atza9WqVfGUnD2HZgjouElAXYT+xB/3wsMFKAQ==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1780876689;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=j3/tU3QfwWByPUrJCBOhRpyTu7phGSmI9ChKkTDu+4Y=;
	b=XeAOm+0VvsbcQZQgYR/7tOL2ir4lK03AQzC1/PbaBlmbl5qGilgWHgFdTsRwVrpwJD4x
	 chuzVEUlYt429KnsCMAgoJs+1I3RsgP+2kSJyV9G1XB3WPbt5Jesq/xAQetUzODKzs3Cr
	 2WkjeUz76CZTfN0vNW79JddCqLcL3OKuHOuVVs5GXLXu9db1CmeuxKMiIrs5OTvl+k0wB
	 zg/lGHU8GiTqyB18IZTyZgWjD1k5+/jYG2Gat/0gs+D9BPMZIiJZaggPSfcnza1dRhnYy
	 gnf/pnaNJ7RuDGpgRase9GpMRzinP/o5RaLWhZ33jyZD8zmWM3YEdP9PC3uxoOFareQ==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id EB2C3F8001F
	for <alsa-devel@alsa-project.org>; Mon,  8 Jun 2026 01:58:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EB2C3F8001F
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18b6f1e948cf6800-webhooks-bot@alsa-project.org>
In-Reply-To: <18b6f1e948aab700-webhooks-bot@alsa-project.org>
References: <18b6f1e948aab700-webhooks-bot@alsa-project.org>
Subject: M-Audio Fast Track Ultra USB sound card is unavailable in JUCE simce
 1.2.16
Date: Mon,  8 Jun 2026 01:58:09 +0200 (CEST)
Message-ID-Hash: U6ME3TMYTBR3CGTIAV5C4QXBXV44WU4G
X-Message-ID-Hash: U6ME3TMYTBR3CGTIAV5C4QXBXV44WU4G
X-MailFrom: github@alsa-project.org
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/U6ME3TMYTBR3CGTIAV5C4QXBXV44WU4G/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf issue #781 was opened from KottV:

Hello.

M-Audio FastTrack Ultra USB sound card not detected by any JUCE application anymore after update to 1.2.16. Looks like this commit is a culprit: https://github.com/jglathe/alsa-ucm-conf/commit/9feb12d68699b25c5be86c629b013d2ebbe77841

without alsa-ucm-conf:
```JUCE v8.0.10
--------------------------------
Type: ALSA
Inputs:
  Default ALSA Output (currently PulseAudio Sound Server)
  PulseAudio Sound Server
  Default Audio Device
  Rate Converter Plugin Using Speex Resampler
  Plugin for channel upmix (4,6,8)
  Fast Track Ultra, USB Audio; Front output / input
  HDA Intel PCH, ALC892 Analog; Front output / input
Outputs:
  Default ALSA Output (currently PulseAudio Sound Server)
  PulseAudio Sound Server
  Default Audio Device
  Rate Converter Plugin Using Speex Resampler
  Plugin for channel upmix (4,6,8)
  Fast Track Ultra, USB Audio; Front output / input
  Fast Track Ultra, USB Audio; 2.1 Surround output to Front and Subwoofer speakers
  Fast Track Ultra, USB Audio; 4.0 Surround output to Front and Rear speakers
  Fast Track Ultra, USB Audio; 4.1 Surround output to Front, Rear and Subwoofer speakers
  Fast Track Ultra, USB Audio; 5.0 Surround output to Front, Center and Rear speakers
  Fast Track Ultra, USB Audio; 5.1 Surround output to Front, Center, Rear and Subwoofer speakers
  Fast Track Ultra, USB Audio; 7.1 Surround output to Front, Center, Side, Rear and Woofer speakers
  Fast Track Ultra, USB Audio; IEC958 (S/PDIF) Digital Audio Output
  HDA Intel PCH, ALC892 Analog; Front output / input
  HDA Intel PCH, ALC892 Analog; 2.1 Surround output to Front and Subwoofer speakers
  HDA Intel PCH, ALC892 Analog; 4.0 Surround output to Front and Rear speakers
  HDA Intel PCH, ALC892 Analog; 4.1 Surround output to Front, Rear and Subwoofer speakers
  HDA Intel PCH, ALC892 Analog; 5.0 Surround output to Front, Center and Rear speakers
  HDA Intel PCH, ALC892 Analog; 5.1 Surround output to Front, Center, Rear and Subwoofer speakers
  HDA Intel PCH, ALC892 Analog; 7.1 Surround output to Front, Center, Side, Rear and Woofer speakers
  HDA Intel PCH, ALC892 Digital; IEC958 (S/PDIF) Digital Audio Output
  HDA NVidia, HSG1075; HDMI Audio Output
  HDA NVidia, HDMI 1; HDMI Audio Output
  HDA NVidia, HDMI 2; HDMI Audio Output
  HDA NVidia, HDMI 3; HDMI Audio Output
```

with alsa-ucm-conf:
```JUCE v8.0.10
--------------------------------
Type: ALSA
Inputs:
  Default ALSA Output (currently PulseAudio Sound Server)
  PulseAudio Sound Server
  Rate Converter Plugin Using Speex Resampler
  Plugin for channel upmix (4,6,8)
  HDA Intel PCH, ALC892 Analog; Front output / input
Outputs:
  Default ALSA Output (currently PulseAudio Sound Server)
  PulseAudio Sound Server
  Rate Converter Plugin Using Speex Resampler
  Plugin for channel upmix (4,6,8)
  HDA Intel PCH, ALC892 Analog; Front output / input
  HDA Intel PCH, ALC892 Analog; 2.1 Surround output to Front and Subwoofer speakers
  HDA Intel PCH, ALC892 Analog; 4.0 Surround output to Front and Rear speakers
  HDA Intel PCH, ALC892 Analog; 4.1 Surround output to Front, Rear and Subwoofer speakers
  HDA Intel PCH, ALC892 Analog; 5.0 Surround output to Front, Center and Rear speakers
  HDA Intel PCH, ALC892 Analog; 5.1 Surround output to Front, Center, Rear and Subwoofer speakers
  HDA Intel PCH, ALC892 Analog; 7.1 Surround output to Front, Center, Side, Rear and Woofer speakers
  HDA Intel PCH, ALC892 Digital; IEC958 (S/PDIF) Digital Audio Output
  HDA NVidia, HSG1075; HDMI Audio Output
  HDA NVidia, HDMI 1; HDMI Audio Output
  HDA NVidia, HDMI 2; HDMI Audio Output
  HDA NVidia, HDMI 3; HDMI Audio Output

```

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/781
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
