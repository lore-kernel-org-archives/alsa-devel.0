Return-Path: <SRS0=SJ4a=XT=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D93DC432C1
	for <alsa-devel@archiver.kernel.org>; Tue, 24 Sep 2019 02:05:58 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 430B2206C2
	for <alsa-devel@archiver.kernel.org>; Tue, 24 Sep 2019 02:05:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="oDW+CS1m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 430B2206C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grossmann-venter.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 08B5D168F;
	Tue, 24 Sep 2019 04:05:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 08B5D168F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1569290755;
	bh=zmYlpdvZHOzPwZK9TqkiKQ85PBcG05629E3KA0B4I7M=;
	h=Date:From:To:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oDW+CS1mYHbO48zNW4Vur5iJh761hDxD6SgJFPv0/ZPe0S1YH+L52twPaEn6jdcm5
	 e0iX3dsrKG/qwP2yj2Z8McSnEEOQq4sOm4YorVC9WR2jvztS2WiQb8kvsu01a68kZB
	 U06IBgUxcLzD2uxBndR4/jULRwWXND0HyBMsweaI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8AE01F800B4;
	Tue, 24 Sep 2019 04:05:04 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4F1ECF8045F; Tue, 24 Sep 2019 04:04:58 +0200 (CEST)
Received: from server54-2.web-hosting.com (server54-2.web-hosting.com
 [198.54.126.118])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 97CF2F80213
 for <alsa-devel@alsa-project.org>; Tue, 24 Sep 2019 04:04:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 97CF2F80213
Received: from [::1] (port=34300 helo=server54.web-hosting.com)
 by server54.web-hosting.com with esmtpa (Exim 4.92)
 (envelope-from <liebrecht@grossmann-venter.com>) id 1iCaC7-000euT-Cu
 for alsa-devel@alsa-project.org; Mon, 23 Sep 2019 22:04:52 -0400
MIME-Version: 1.0
Date: Mon, 23 Sep 2019 22:04:47 -0400
From: liebrecht@grossmann-venter.com
To: alsa-devel@alsa-project.org
In-Reply-To: <e959c950-4d92-d4a6-dbac-056fbc4b5425@ladisch.de>
References: <0c48cbff966673fe6842621e3e1317f4@grossmann-venter.com>
 <e959c950-4d92-d4a6-dbac-056fbc4b5425@ladisch.de>
Message-ID: <39e48b525efd78468d247445c0906ecc@grossmann-venter.com>
X-Sender: liebrecht@grossmann-venter.com
User-Agent: Roundcube Webmail/1.3.7
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - server54.web-hosting.com
X-AntiAbuse: Original Domain - alsa-project.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - grossmann-venter.com
X-Get-Message-Sender-Via: server54.web-hosting.com: authenticated_id:
 liebrecht@grossmann-venter.com
X-Authenticated-Sender: server54.web-hosting.com: liebrecht@grossmann-venter.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-From-Rewrite: unmodified, already matched
Subject: Re: [alsa-devel] alsa acting up
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

On 2019-09-18 07:07, Clemens Ladisch wrote:
> liebrecht@grossmann-venter.com wrote:
>> 1) As soon as pulseaudio is started Alsa says 1818VSL is 
>> unplugged....?
> 
> What is the output of "dmesg | tail" immediately afterwards?
> 
> 
> Regards,
> Clemens


Dmesg output
[28970.337926] usb 1-1: new high-speed USB device number 7 using 
ehci-pci
[28970.467327] usb 1-1: New USB device found, idVendor=194f, 
idProduct=0103, bcdDevice= 1.07
[28970.467332] usb 1-1: New USB device strings: Mfr=1, Product=2, 
SerialNumber=3
[28970.467334] usb 1-1: Product: AudioBox 1818 VSL
[28970.467335] usb 1-1: Manufacturer: PreSonus
[28970.467337] usb 1-1: SerialNumber: 2209
[28971.103709] usb 1-1: USB disconnect, device number 7
[28971.119052] usb 1-1: 2:2: cannot set freq 44100 (v2/v3): err -71
[28974.502188] usb 1-1: new high-speed USB device number 8 using 
ehci-pci
[28978.381409] usb 1-1: new high-speed USB device number 9 using 
ehci-pci
[28978.938451] usb 1-1: device not accepting address 9, error -71
[28982.306653] usb 1-1: new high-speed USB device number 11 using 
ehci-pci
[28982.866681] usb 1-1: device not accepting address 11, error -71
[28986.240898] usb 1-1: new high-speed USB device number 13 using 
ehci-pci
[28986.370321] usb 1-1: New USB device found, idVendor=194f, 
idProduct=0103, bcdDevice= 1.07

Here are some other info by means of screenshots:
"https://imgur.com/zJsvvST"
"https://imgur.com/qFGQytS"

Furthermore
pulseaudio reports:
E: [pulseaudio] udev-util.c: Failed to get card object.
E: [pulseaudio] module-alsa-card.c: Failed to find a working profile.
E: [pulseaudio] module.c: Failed to load module "module-alsa-card" 
(argument: "device_id="1" name="usb-PreSonus_AudioBox_1818_VSL_2209-00" 
card_name="alsa_card.usb-PreSonus_AudioBox_1818_VSL_2209-00" 
namereg_fail=false tsched=yes fixed_latency_range=no ignore_dB=no 
deferred_volume=yes use_ucm=yes 
card_properties="module-udev-detect.discovered=1""): initialization 
failed.
E: [pulseaudio] udev-util.c: Failed to get card object.
E: [pulseaudio] module-alsa-card.c: Failed to find a working profile.
E: [pulseaudio] module.c: Failed to load module "module-alsa-card" 
(argument: "device_id="1" name="usb-PreSonus_AudioBox_1818_VSL_2209-00" 
card_name="alsa_card.usb-PreSonus_AudioBox_1818_VSL_2209-00" 
namereg_fail=false tsched=yes fixed_latency_range=no ignore_dB=no 
deferred_volume=yes use_ucm=yes 
card_properties="module-udev-detect.discovered=1""): initialization 
failed.




_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
