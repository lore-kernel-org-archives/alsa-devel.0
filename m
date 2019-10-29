Return-Path: <SRS0=9b6r=YW=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CE84CA9EAE
	for <alsa-devel@archiver.kernel.org>; Tue, 29 Oct 2019 22:22:53 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10EFC2087E
	for <alsa-devel@archiver.kernel.org>; Tue, 29 Oct 2019 22:22:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="l0tihkRq";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ab3.no header.i=@ab3.no header.b="Ctx1c+V0";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ab3.no header.i=@ab3.no header.b="Ctx1c+V0";
	dkim=neutral (0-bit key) header.d=ab3.no header.i=@ab3.no header.b="dLbcmcA8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10EFC2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=ab3.no
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CDD1F20A2;
	Tue, 29 Oct 2019 23:21:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CDD1F20A2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1572387769;
	bh=VxAI8vG7hds4NYsd2xduz1/IsjrHAEkOl7Xl6vcEP0M=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=l0tihkRqxH/GR4iT2cL/NhButWWso0eOh2vm1tjyAsmL+B1eHPWAaN0kTS0fcUqkK
	 iq5hFcroyj/Tiyc5ohU795XEW7Kya7wTFgEN7N+9Cd2WDJJhLCd0KWy48PS+M1W+k5
	 R/Zp++Dh7pLS/91VsoZBTBBHDYoxCEw8yoo8q8uU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5F5C2F8036C;
	Tue, 29 Oct 2019 23:21:59 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A0253F80392; Tue, 29 Oct 2019 23:21:57 +0100 (CET)
Received: from mail.ab3.no (mail.ab3.no [176.58.113.160])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5D7D4F8015A
 for <alsa-devel@alsa-project.org>; Tue, 29 Oct 2019 23:21:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5D7D4F8015A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=ab3.no header.i=@ab3.no header.b="Ctx1c+V0"; 
 dkim=pass (1024-bit key) header.d=ab3.no header.i=@ab3.no header.b="Ctx1c+V0"; 
 dkim=pass (1024-bit key) header.d=ab3.no header.i=@ab3.no header.b="dLbcmcA8"
X-Virus-Scanned: amavisd-new at ab3.no
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ab3.no 4041748A69B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ab3.no; s=default;
 t=1572387713; bh=zVMzYy7dtRLOSJ8JSuYAIlIQTxFxwX2gXBG6kBAGZvw=;
 h=Date:From:To:Subject:From;
 b=Ctx1c+V0ePWmBwive9+FNVIIM3SxbLoppEtvIMW/jthN4dk4k1z7utOdRwYyLFlmz
 pF3jJw+WlqXO80sEPIWAzZQpgrcXBbeIPadcdv4xcIGMjXNeqER4sEnMFPjT59Fvw5
 Rh3fXIp4hD5RNwG64Ov6KT1RPFwhEvXch87MlFE0=
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ab3.no 2DC2548A69B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ab3.no; s=default;
 t=1572387713; bh=zVMzYy7dtRLOSJ8JSuYAIlIQTxFxwX2gXBG6kBAGZvw=;
 h=Date:From:To:Subject:From;
 b=Ctx1c+V0ePWmBwive9+FNVIIM3SxbLoppEtvIMW/jthN4dk4k1z7utOdRwYyLFlmz
 pF3jJw+WlqXO80sEPIWAzZQpgrcXBbeIPadcdv4xcIGMjXNeqER4sEnMFPjT59Fvw5
 Rh3fXIp4hD5RNwG64Ov6KT1RPFwhEvXch87MlFE0=
MIME-Version: 1.0
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ab3.no 4380148A697
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ab3.no; s=default;
 t=1572387712; bh=zVMzYy7dtRLOSJ8JSuYAIlIQTxFxwX2gXBG6kBAGZvw=;
 h=Date:From:To:Subject:From;
 b=dLbcmcA8BvZSSijO6UOOyU999Dc9WQiJiMB0Hk9f+FrowZu2XSIJzUKouiWk2t5gV
 ouKN23+YYgqj9XEHMZNudiTYdWY0heE8oPnCZZrbnKqaHqQ39+E/V2FEh44Qs2HPWk
 Oy/7iAD+86YLYX4pIbvFA3ksgvT4PHl3B93AGIKY=
Date: Tue, 29 Oct 2019 23:21:51 +0100
From: =?UTF-8?Q?Mads_L=C3=B8nsethagen?= <mads@ab3.no>
To: alsa-devel@alsa-project.org
Message-ID: <1db41ac5ab54f11d904e4f8d6cbb3970@ab3.no>
X-Sender: mads@ab3.no
Subject: [alsa-devel] Adding support for Android's Wired Audio Headset
	Specification v1.1
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Posting this to alsa-devel without being actually sure it belongs here, 
so please do tell if it belongs elsewhere. But here goes:

If you have e.g. a Bose QC25 headset (wired, not bluetooth) in Linux, 
you can't get the volume buttons nor the play/pause button on the 
headphone cable itself to work. As far as I know, these buttons works in 
both Android and Windows 10, so it would be nice if they would work with 
plain Linux too.

This StackExchange thread discusses how it works: 
https://electronics.stackexchange.com/questions/242883/how-do-media-buttons-on-a-plain-wired-headset-work

As one poster on StackExchange mentions, Android has a defined standard 
on these kind of buttons: 
https://source.android.com/devices/accessories/headset/plug-headset-spec

Since these kind of button presses must be decoded from impedance 
changes in the 3.5mm jack connector, does it belong in  alsa somewhere? 
Bose QC25 buttons works on Intel HDA cards on new Dell XPS laptops, so 
I'm guessing it should be possible within snd-hda-intel...

- Mads
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
