Return-Path: <SRS0=NmsS=EY=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5B95C56202
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Nov 2020 09:08:30 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 406B52463B
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Nov 2020 09:08:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="gDJXVdjT";
	dkim=pass (1024-bit key) header.d=perex.cz header.i=@perex.cz header.b="zu8COH6H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 406B52463B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=perex.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6123884B;
	Wed, 18 Nov 2020 10:07:35 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6123884B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1605690505;
	bh=o6QvrESxy9qhh34v17m498xkcTNHiS/81sX1lvzrmT0=;
	h=To:From:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=gDJXVdjT0AFLI9fxAkMCDsFjyKnsf9uCwknI4nFY53qbzyHfhMV6w3Jg8IlPwa8mH
	 DuGCufBXGA4ESIdFpo+Eva7mdocpoExDbZgpO5GBy4oWrzJyYjDY9RIqByuv4xBERZ
	 qLWoTSVvT8uFhX9wURdiQuRgLqFyOMSmv6+fTQc8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C94A4F80158;
	Wed, 18 Nov 2020 10:07:34 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C0A03F8016C; Wed, 18 Nov 2020 10:07:32 +0100 (CET)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D70C5F8010A
 for <alsa-devel@alsa-project.org>; Wed, 18 Nov 2020 10:07:20 +0100 (CET)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 997F6A0040;
 Wed, 18 Nov 2020 10:07:17 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 997F6A0040
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1605690437; bh=ITKl31Szh5P3rtdrYUCXc7EXbPgObReLBqsVsGywAQ4=;
 h=To:Cc:From:Subject:Date:From;
 b=zu8COH6Hcfm4UPGRWRy/qbYQN6ec7uTy8C7wZezyBDdBbJXsrhF3sD0Ibxsrxbue7
 fiwaJqkwuS57plDNhnXMCqNCIRtCdQOhGPOL4NbpNhkvK+uOLf4I77BalVbJrcXRS3
 jQn+zS3RseX07cShK2Zn/7PPUquWI2i4D7xHfoUw=
Received: from p1gen2.perex-int.cz (unknown [192.168.100.98])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Wed, 18 Nov 2020 10:07:15 +0100 (CET)
To: "Mukunda, Vijendar" <Vijendar.Mukunda@amd.com>
From: Jaroslav Kysela <perex@perex.cz>
Subject: snd-rn-pci-acp3x - auto dmic detection unreliable
Message-ID: <a13f4f45-513e-0b99-8cf4-0ae89bf7d6bd@perex.cz>
Date: Wed, 18 Nov 2020 10:07:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: ALSA development <alsa-devel@alsa-project.org>
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

Hi,

	it seems that the ACPI auto-detection of the presence the digital microphone
connected to AMD Renoir audio bridge is unreliable. It may be that hardware
vendors do not provide the correct ACPI tables.
	Could you clarify the usage of _WOV integer value? It seems that this value
is set on those plaforms which do not have the digital microphone (the
microphone is connected to the HDA codec):

Lenovo IdeaPad 5 (15ARE05)
Lenovo Thinkpad X395

	In any case, we should probably improve the auto-detection using DMI or other
platform info.

					Jaroslav

BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1892115

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
