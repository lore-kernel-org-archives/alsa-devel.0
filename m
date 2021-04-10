Return-Path: <SRS0=Dw+a=JH=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA3B0C433B4
	for <alsa-devel@archiver.kernel.org>; Sat, 10 Apr 2021 20:49:20 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1B226108B
	for <alsa-devel@archiver.kernel.org>; Sat, 10 Apr 2021 20:49:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1B226108B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=spliet.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7DF2D3E;
	Sat, 10 Apr 2021 22:48:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7DF2D3E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1618087756;
	bh=4Qw8rfXCZzWn2rTsuw3JBmAn1sKkH0284zKy/0Xnw28=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IztondsUDxhMBx7Fw+CDthZwbor1IfG+KLyQJ5EtktHvNe1gfPbWz3s5WF+V0M7nR
	 DsYosFu8tq1DIPXmEKHL9P/HAam91Dm3QJ9N1OzohRRg5O6yk5l2cJBXwGDVCH/NVe
	 1WyXaPgahrX/7RNM2OQpVxiP3RuL3aA7S8BaRk0U=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1D7A4F80169;
	Sat, 10 Apr 2021 22:48:25 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9B376F8020B; Sat, 10 Apr 2021 22:48:23 +0200 (CEST)
Received: from mupuf.org (mupuf.org [167.71.42.210])
 by alsa1.perex.cz (Postfix) with ESMTP id 3E3D7F80113
 for <alsa-devel@alsa-project.org>; Sat, 10 Apr 2021 22:48:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3E3D7F80113
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=spliet.org header.i=@spliet.org
 header.b="rtcv1a0X"
Received: from [IPv6:2a01:4b00:86b9:100:9ede:1593:85ef:7eda] (unknown
 [IPv6:2a01:4b00:86b9:100:9ede:1593:85ef:7eda])
 by Neelix.spliet.org (Postfix) with ESMTPSA id 03CC4F20011;
 Sat, 10 Apr 2021 21:48:15 +0100 (BST)
DKIM-Filter: OpenDKIM Filter v2.11.0 Neelix.spliet.org 03CC4F20011
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=spliet.org;
 s=default; t=1618087696;
 bh=G/KMHNxJ10tQbDe69nA++juz4fZynQZtQ/TmQnU8gZU=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=rtcv1a0XHMirOX80HxcGaWbLsoJRj6qdJd3vWIhMsW3jREz5OLGRbkylBUe31GukR
 KfHjxMcHhGdDpL4mBMubQ+bys/OMe0DzF4R6g6BgrfpZktq2tA/AFgr1s8EkUvOXgO
 11vjcgkRFBdspV765d/qjjBXIc5u//qW2yTaT+yI=
Subject: Re: [Nouveau] [PATCH v2] ALSA: hda: Continue to probe when codec
 probe fails
To: Lukas Wunner <lukas@wunner.de>
References: <CAAd53p6Ef2zFX_t3y1c6O7BmHnxYGtGSfgzXAMQSom1ainWXzg@mail.gmail.com>
 <s5hsg85n2km.wl-tiwai@suse.de> <s5hmtydn0yg.wl-tiwai@suse.de>
 <CAAd53p6MMFh=HCNF9pyrJc9hVMZWFe7_8MvBcBHVWARqHU_TTA@mail.gmail.com>
 <s5h7dpfk06y.wl-tiwai@suse.de>
 <CAAd53p53w0H6tsb4JgQtFTkYinniicTYBs2uk7tc=heP2dM_Cw@mail.gmail.com>
 <CAKb7UvjWX7xbwMKtnad5EVy16nY1M-A13YJeRWyUwHzemcVswA@mail.gmail.com>
 <CAAd53p4=bSX26QzsPyV1sxADiuVn2sowWyb5JFDoPZQ+ZYoCzA@mail.gmail.com>
 <CACO55tsPx_UC3OPf9Hq9sGdnZg9jH1+B0zOi6EAxTZ13E1tf7A@mail.gmail.com>
 <d01e375f-bf16-a005-ec66-0910956cc616@spliet.org>
 <20210410192314.GB16240@wunner.de>
From: Roy Spliet <nouveau@spliet.org>
Message-ID: <bddba2ca-15d5-7fd3-5b64-f4ba7e179ec0@spliet.org>
Date: Sat, 10 Apr 2021 21:48:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210410192314.GB16240@wunner.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.2 at Neelix
X-Virus-Status: Clean
Cc: "moderated list:SOUND" <alsa-devel@alsa-project.org>,
 open list <linux-kernel@vger.kernel.org>, Karol Herbst <kherbst@redhat.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Aaron Plattner <aplattner@nvidia.com>, Takashi Iwai <tiwai@suse.de>,
 nouveau <nouveau@lists.freedesktop.org>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, tiwai@suse.com,
 Bjorn Helgaas <bhelgaas@google.com>,
 Kai-Heng Feng <kai.heng.feng@canonical.com>,
 Alan Stern <stern@rowland.harvard.edu>, Linux PCI <linux-pci@vger.kernel.org>,
 Alex Deucher <alexander.deucher@amd.com>, Mike Rapoport <rppt@kernel.org>
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

Op 10-04-2021 om 20:23 schreef Lukas Wunner:
> On Sat, Apr 10, 2021 at 04:51:27PM +0100, Roy Spliet wrote:
>> Can I ask someone with more
>> technical knowledge of snd_hda_intel and vgaswitcheroo to brainstorm about
>> the possible challenges of nouveau taking matters into its own hand rather
>> than keeping this PCI quirk around?
> 
> It sounds to me like the HDA is not powered if no cable is plugged in.
> What is reponsible then for powering it up or down, firmware code on
> the GPU or in the host's BIOS?

Sometimes the BIOS, but definitely unconditionally the PCI quirk code: 
https://github.com/torvalds/linux/blob/master/drivers/pci/quirks.c#L5289

(CC Aaron Plattner)

> 
> Ideally, we should try to find out how to control HDA power from the
> operating system rather than trying to cooperate with whatever firmware
> is doing.  If we have that capability, the OS should power the HDA up
> and down as it sees fit.
> 
> Thanks,
> 
> Lukas
> 

