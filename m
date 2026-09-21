Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 941B1C982DA
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Sep 2026 03:50:30 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 296A36021E;
	Mon, 21 Sep 2026 05:50:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 296A36021E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1789962628;
	bh=JgaUwQOJIMLdyI1osNTK3/BaFpO2Xck+IK6bDChsqVE=;
	h=Date:From:To:Subject:In-Reply-To:References:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=I/iO6l/kenF0HcBPbKrMF8HSEp5zuIB0iQGyDJvgcX4LRxNwUr+4NjfGxYBLwFFyT
	 0HVLzeDw35oFLOSje7VvmcqY6aYQlazzPmaQ/pcbf0tHPaoeODtci1B4zJX0wZ0HmF
	 mxd1Q182wVRHOuQ7z9voGPIJQRApsIGMsiE34SAc=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id F06DEF8058C; Mon, 21 Sep 2026 05:49:53 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 28978F805ED;
	Mon, 21 Sep 2026 05:49:53 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7578AF804F3; Mon, 21 Sep 2026 05:49:47 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=95.217.178.61
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1789962586;
	b=bEzS3GWLNrfqoHCO73Xi5+85Rsjqi8AFttU2F3tl+0hN8hKa6vWOFwHD+1txnu3oCzyf
	 6etTqaJcxPjnqZwOWhOutvTZ5vuLv4qJKJJgUDoTagAQ9P/yL87QMYVUKthUcxKqabAp4
	 kTFycd1+r1qC7KqNqyIVdIzOKtEZGTB7NJErTjuLjnmYSXO79Prfn1ZfrAibD4Y66wG7+
	 4qvC+Kbir7hhgAqyfaO4pe5ee59dMTtdDQPULUjJS+HQNj4ph2Hp6zRjHDN1W9Q6qboht
	 w6+ShRdNi6h9imH3poNARSQsuFDWz1rWiX5yCnzoLj+XlCe3cO76WPF9ZDsSPQC83WQ==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1789962586;
	h=DKIM-Signature:DKIM-Signature:Date:From:To:Subject:Message-Id:
	 Mime-Version;
	bh=JgaUwQOJIMLdyI1osNTK3/BaFpO2Xck+IK6bDChsqVE=;
	b=RFqu8jeDsLfO2i2yHjFBwRpYZfXjcSRAc2IMqt1tYiTJQbb9ZTm8DR/xi+65YO8AP+2+
	 nHoY/6Lsk0xZZ3xTftk3oBkrCzq+SsqFKA9EJx0c/MSVghLTtIopxKIM+uECxbJ1D+j88
	 JCJk7T+aqJmRCY7Vobs5P94L76kMbjcCstlKre+SHx/MXDxl/xwquzfYD/Q7qt2QfwGLt
	 zhNow/imlsGgB0HsOpsZSKWMQa/+9YOTd7ECFcQATlvfVSXfXE1J1oQIvOcK3vhk9fI9a
	 rqwc3eyoisLOhOudbBsmDZqmpHDj90ProkFqwoCCD/nYD/7myV+vRLm48xJv8gmnX1g==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=fail reason="signature verification failed" header.d=gorgnet.net
 header.i=@gorgnet.net header.a=ed25519-sha256 header.s=b1 header.b=uQiOIqai;
	dkim=pass header.d=gorgnet.net header.i=@gorgnet.net header.a=rsa-sha256
 header.s=a1 header.b=a4FpCOFr;
	arc=none smtp.remote-ip=95.217.178.61
Received: from gorgnet.net (gorgnet.net [95.217.178.61])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 0B060F800B0
	for <alsa-devel@alsa-project.org>; Mon, 21 Sep 2026 05:49:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0B060F800B0
Authentication-Results: alsa1.perex.cz;
	dkim=fail reason="signature verification failed" header.d=gorgnet.net
 header.i=@gorgnet.net header.a=ed25519-sha256 header.s=b1 header.b=uQiOIqai;
	dkim=pass (2048-bit key,
 unprotected) header.d=gorgnet.net header.i=@gorgnet.net header.a=rsa-sha256
 header.s=a1 header.b=a4FpCOFr
DKIM-Signature: v=1; a=ed25519-sha256; c=simple/simple;
  d=gorgnet.net; s=b1; x=1790567163; q=dns/txt; h=Received:
  Received:Date:From:To:Subject:Message-Id:In-Reply-To:References:
  Mime-Version:Content-Type:Content-Transfer-Encoding; bh=JgaUwQO
  JIMLdyI1osNTK3/BaFpO2Xck+IK6bDChsqVE=; b=uQiOIqaiu+PHIl9RwAPrSpS
  2GJGWwR/AnR6WyWS7LW8L1LZFtUpwUI5f1i0ChiCMFm6Ckb/qhEAD16g3z78vAA=
  =
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=gorgnet.net; s=a1; x=1790567163; q=dns/txt; h=Received:
  Received:Date:From:To:Subject:Message-Id:In-Reply-To:References:
  Mime-Version:Content-Type:Content-Transfer-Encoding; bh=JgaUwQO
  JIMLdyI1osNTK3/BaFpO2Xck+IK6bDChsqVE=; b=a4FpCOFrAUdmB/NfocSPRh/
  CbN6nVoAPGPItPeUv28dSDuYbkoM0qcNIRCR55MAcqSqGWKS5hU2Jg3kV6Eg1Cie
  yF8stxdP8enc/dzMTBYAdMbBHRTCVYZcWJbnwOs/n3d+drdk8CxkAMtjzXL6CkEY
  tT1ZtoLfUgKp/JvV8TCXlqTTQA9q2yazcnANulUKMxRNqLttzOitl2F3l6AYAFzA
  TUlsE6J3J39BXkvGfI3feNbv03wqpNCJ1H7pguZZpwIxccZ81aMLDdrBcaw0tHlG
  fbeA+VvE2IEjzKlLKaz+K6LFdAUXRBiqxAy1iOHzbJzAdyVI0jjK9nIho7UM2Jw=
  =
Received: (qmail 22669 invoked from network); 21 Sep 2026 03:46:02 -0000
Received: from unknown (HELO void1)
 (gorg@gorgnet.net@2600:1003:b005:6485:afa8:5b4d:a716:19f5)
  for <alsa-devel@alsa-project.org>
  de/crypted with TLSv1.2: ECDHE-ECDSA-CHACHA20-POLY1305 [unknown/unknown]
  by 0 with ESMTPSA; 21 Sep 2026 03:46:02 -0000
Date: Sun, 20 Sep 2026 20:49:39 -0700
From: George Matsumura <gorg@gorgnet.net>
To: alsa-devel@alsa-project.org
Subject: Re: [PATCH] alsa-lib: Revert
 "A try to fix one rouding problem in refine"
Message-Id: <20260920204939.62536218e5f1804d2b6f819f@gorgnet.net>
In-Reply-To: <fe1c4c8d-1a2f-4d4b-a3e3-654b0a011f0a@perex.cz>
References: <20260919072437.ecc0cf4d5c702127dc77ac0e@gorgnet.net>
	<f3961c4b-3aba-46b3-844b-0fcd3ad9ce73@perex.cz>
	<20260920062458.bef6ad9e4972c868216aad0f@gorgnet.net>
	<fe1c4c8d-1a2f-4d4b-a3e3-654b0a011f0a@perex.cz>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-unknown-linux-musl)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-ID-Hash: AWSO7XHFNKEXEBB4ODNTZBIFX7JLRRVT
X-Message-ID-Hash: AWSO7XHFNKEXEBB4ODNTZBIFX7JLRRVT
X-MailFrom: gorg@gorgnet.net
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/AWSO7XHFNKEXEBB4ODNTZBIFX7JLRRVT/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

(Resending this to adjust for mailing list limits on message size)

On Sun, 20 Sep 2026 17:18:02 +0200
Jaroslav Kysela <perex@perex.cz> wrote:

> Do you have standard dmix defaults ?

I obtain the following output for the dmix default configuration:

$ alsactl dump-cfg | grep -E "^defaults.pcm.dmix"
defaults.pcm.dmix.max_periods 0
defaults.pcm.dmix.channels 2
defaults.pcm.dmix.rate 48000
defaults.pcm.dmix.format unchanged
defaults.pcm.dmix.card 'defaults.pcm.card'
defaults.pcm.dmix.device 'defaults.pcm.device'

I also obtain the follwing output from aplay:

$ aplay -v -D dmixT -f float_le -r 44100 --buffer-size=8192 --period-size=1024 /dev/zero
Playing raw data '/dev/zero' : Float 32 bit Little Endian, Rate 44100 Hz, Mono
aplay: set_params:1462: Unable to install hw params:
ACCESS: RW_INTERLEAVED
FORMAT: FLOAT_LE
SUBFORMAT: STD
SAMPLE_BITS: 32
FRAME_BITS: 32
CHANNELS: 1
RATE: NONE
PERIOD_TIME: 21000
PERIOD_SIZE: NONE
PERIOD_BYTES: (3704 3708)
PERIODS: (8 9)
BUFFER_TIME: (188979 188980)
BUFFER_SIZE: 8334
BUFFER_BYTES: 33336
TICK_TIME: 0

when using the following asound.conf contents:

pcm.dmixT {
    type plug
    slave {
        pcm "dmix:1"
        rate 48000
    }
}

Here is the output of the same command with REFINE_DEBUG and
RULES_DEBUG enabled in pcm_params.c:

https://gitlab.com/-/snippets/6058384

> Show verbose log from aplay when working to see the period setup on the dmix side (and the used kernel driver). Also, do you use alsa-lib 1.2.16 ?

I am indeed using alsa-lib 1.2.16. I wasn't able to find anything
relevant in the last lines of dmesg, however, I believe I am using the
snd_soc_sst_cht_bsw_rt5645 driver. I apologize if this is not the
information that was requested.

Thank you again for your help with this.

Regards,
    George
