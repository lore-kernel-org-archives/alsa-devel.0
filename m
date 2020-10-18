Return-Path: <SRS0=H+KG=D4=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62240C388F9
	for <alsa-devel@archiver.kernel.org>; Wed, 21 Oct 2020 13:39:22 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D13E20BED
	for <alsa-devel@archiver.kernel.org>; Wed, 21 Oct 2020 13:39:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="I2NSRegn";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iCDY9uZX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D13E20BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 20EA3175E;
	Wed, 21 Oct 2020 15:38:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 20EA3175E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1603287559;
	bh=kBVMPnQfqrYuRmZ0mFLSkNqYWCaxPfshC6ZYuKW12NQ=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=I2NSRegnmt6O5i0B2pbbPetCkfXCmcg7P5v1P5hpeSLHUHpA9gC6XiRaGyHjm0hjA
	 QLpj7AoQ/WyMQ3UKCfNxN+WKaG9mkB0IpNbZOygn+ovO+LnY3vOcjrWFbNrc0Nw/bB
	 DpsZfPjpvvCISLt05R12AX3Trunkg6TJCJanOx7Q=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E51C0F80277;
	Wed, 21 Oct 2020 15:37:39 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7D97DF801F2; Sun, 18 Oct 2020 16:05:05 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 766FEF80111
 for <alsa-devel@alsa-project.org>; Sun, 18 Oct 2020 16:05:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 766FEF80111
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.b="iCDY9uZX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603029900;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kBVMPnQfqrYuRmZ0mFLSkNqYWCaxPfshC6ZYuKW12NQ=;
 b=iCDY9uZXi5qR75r0A0wkCwxg3hnYhcutRY5aY06hU5WkG4gNbwsih9Dl7zSZYeQW53EmYe
 MAwEXlt8M8GYlCDIuR5p6b6Ymbw91csTZqXx+2S3izJB1XZbQrS+luRYaFoaf9IM+44W60
 fvdNe0WIquu/qf/FSwwx1DWkrc3S2a4=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-239-nXnmbgjOP9OyMiqjTDqCkw-1; Sun, 18 Oct 2020 10:04:56 -0400
X-MC-Unique: nXnmbgjOP9OyMiqjTDqCkw-1
Received: by mail-qv1-f70.google.com with SMTP id x34so2113514qvx.7
 for <alsa-devel@alsa-project.org>; Sun, 18 Oct 2020 07:04:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=kBVMPnQfqrYuRmZ0mFLSkNqYWCaxPfshC6ZYuKW12NQ=;
 b=nxhWy+DZ1KYDYDgoaIQYDzunOnrMSB+yo3H60o3pzhXf3EKiu45nmkt4zEF2uaVWQh
 1WJK08yTH1Kf7WiqALM7PnIgFzjjT20CH0DR9WYcRVyswhwBhVPv/pKYD4qtSyxNpkvX
 3b0QwwzJ2XnhuFSf2c3hkG/lE+1gPduqYCNqx/OjtRxJVxISHpKVjm2QslZFdVvba5dN
 gwBmUGoZ1xU50vZLWDrf9s8bFkWGiGic+9W6pDIRy4+Mogg/TAExxcQOlOFgDPIGcP4V
 6SdhqLhnSaW8Qh0gPH3cOplPEASKPfu2kNMGhY84ewGHhQ5a0Jyw4XuGtChzON2Q0MFL
 /YXg==
X-Gm-Message-State: AOAM530QeB9W3KUtNxpftlOkOn38B+G3fiWX4014DWQycA1u4Ze38B1A
 GXMK36QJ+vyA/f0W/GRTUyJ7yRfdpxBWIDnThUCC8/KqLRja0NlXvB6iipDAgQMVdK5KCCKI+z/
 lQEU9Sm8WyU7o5yo1IBhG+vQ=
X-Received: by 2002:a05:620a:1287:: with SMTP id
 w7mr12724329qki.436.1603029896374; 
 Sun, 18 Oct 2020 07:04:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy6z5rS79nBj0nCbIqVRZ9qmkAzjArqewdITB0rtwnhi1UUe/kvxLZTENMJDRITA4iBlrUAlw==
X-Received: by 2002:a05:620a:1287:: with SMTP id
 w7mr12724258qki.436.1603029896034; 
 Sun, 18 Oct 2020 07:04:56 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com.
 [75.142.250.213])
 by smtp.gmail.com with ESMTPSA id u16sm3288927qth.42.2020.10.18.07.04.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 18 Oct 2020 07:04:55 -0700 (PDT)
Subject: Re: [RFC] treewide: cleanup unreachable breaks
To: Greg KH <gregkh@linuxfoundation.org>
References: <20201017160928.12698-1-trix@redhat.com>
 <20201018054332.GB593954@kroah.com>
From: Tom Rix <trix@redhat.com>
Message-ID: <eecb7c3e-88b2-ec2f-0235-280da51ae69c@redhat.com>
Date: Sun, 18 Oct 2020 07:04:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201018054332.GB593954@kroah.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=trix@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Mailman-Approved-At: Wed, 21 Oct 2020 15:37:33 +0200
Cc: alsa-devel@alsa-project.org, clang-built-linux@googlegroups.com,
 linux-iio@vger.kernel.org, nouveau@lists.freedesktop.org,
 storagedev@microchip.com, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux-foundation.org, keyrings@vger.kernel.org,
 linux-mtd@lists.infradead.org, ath10k@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, usb-storage@lists.one-eyed-alien.net,
 linux-watchdog@vger.kernel.org, devel@driverdev.osuosl.org,
 linux-samsung-soc@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-nvdimm@lists.01.org, amd-gfx@lists.freedesktop.org,
 linux-acpi@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 industrypack-devel@lists.sourceforge.net, linux-pci@vger.kernel.org,
 spice-devel@lists.freedesktop.org, MPT-FusionLinux.pdl@broadcom.com,
 linux-media@vger.kernel.org, linux-serial@vger.kernel.org,
 linux-nfc@lists.01.org, linux-pm@vger.kernel.org, linux-can@vger.kernel.org,
 linux-block@vger.kernel.org, linux-gpio@vger.kernel.org,
 xen-devel@lists.xenproject.org, linux-amlogic@lists.infradead.org,
 openipmi-developer@lists.sourceforge.net, platform-driver-x86@vger.kernel.org,
 linux-integrity@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-edac@vger.kernel.org, netdev@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-security-module@vger.kernel.org, linux-crypto@vger.kernel.org,
 patches@opensource.cirrus.com, bpf@vger.kernel.org, ocfs2-devel@oss.oracle.com,
 linux-power@fi.rohmeurope.com
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


On 10/17/20 10:43 PM, Greg KH wrote:
> On Sat, Oct 17, 2020 at 09:09:28AM -0700, trix@redhat.com wrote:
>> From: Tom Rix <trix@redhat.com>
>>
>> This is a upcoming change to clean up a new warning treewide.
>> I am wondering if the change could be one mega patch (see below) or
>> normal patch per file about 100 patches or somewhere half way by collecting
>> early acks.
> Please break it up into one-patch-per-subsystem, like normal, and get it
> merged that way.

OK.

Thanks,

Tom

>
> Sending us a patch, without even a diffstat to review, isn't going to
> get you very far...
>
> thanks,
>
> greg k-h
>

