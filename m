Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68C9DC433EF
	for <alsa-devel@archiver.kernel.org>; Mon, 17 Jan 2022 10:48:40 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 07C5B16E3;
	Mon, 17 Jan 2022 11:47:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 07C5B16E3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1642416518;
	bh=w672rcrCbbEHMelr5rBkdV+uVpmtz+KSC+RdUqvW5JU=;
	h=Date:From:To:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=U1Z5B0ALRXLBu3cQxP1SeClod17jxx1oZlERJ2BMv01v88KwhQ6CPkA7xwh7Vo0CJ
	 rE0f/1QAZWyGsr6LMVmAUOIQne2safYACrgsxYTcXXrMLXg6+5i/5dnpKYYWmr3R9O
	 Bgw9VKr8QDdgRwnDhYOMJ9i2LxanfhDPNH/gi+Ko=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 933C5F800CE;
	Mon, 17 Jan 2022 11:47:47 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3A965F80249; Mon, 17 Jan 2022 11:47:45 +0100 (CET)
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0E621F800CE
 for <alsa-devel@alsa-project.org>; Mon, 17 Jan 2022 11:47:37 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0E621F800CE
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com
 header.b="m0n8apO1"
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
 by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20H7WQjK008705;
 Mon, 17 Jan 2022 04:47:35 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com;
 h=message-id : date :
 mime-version : from : to : subject : references : in-reply-to :
 content-type : content-transfer-encoding; s=PODMain02222019;
 bh=NWU+5VvMON2Rs3VaV3OVIvcyV57zKDXnVQdpixkc4ME=;
 b=m0n8apO1JSgS/k1JNJDxtkZdWhVTpOkLbPl0S4mHw9PLQRYMNYViovBSyze51UXDlVAV
 Qdmw0YZX+AfhoTMQLe/YFauKADYEsu0uHwHqhOBVDke+H2l536mSYtT9OIZWznJr0+bf
 hz4mdYABM7LSSXOBP8HYhWpuwRgn6gca8F6nLoF8PxWPGCis+S8pzu32BjSvAnOK+bMl
 4Q/TjcUs27JGv4S56LFoIKliTIvyZ99kbV7T2ME8vGFRSqTKC+K/GLR6M1oWj4cJ8iyh
 S18yKp2QNmj8W+YMauaNTYg/C6miAwCamSZycYB4K0TJjTpi/wz9n8BaryQZKvcRdkRM RA== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
 by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3dkvj5a1rc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Mon, 17 Jan 2022 04:47:35 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 17 Jan
 2022 10:47:33 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.18 via
 Frontend Transport; Mon, 17 Jan 2022 10:47:33 +0000
Received: from [198.61.64.122] (unknown [198.61.64.122])
 by ediswmail.ad.cirrus.com (Postfix) with ESMTP id B6133459;
 Mon, 17 Jan 2022 10:47:32 +0000 (UTC)
Message-ID: <605c6a69-0542-458c-2ea0-1ed26f6e28f5@opensource.cirrus.com>
Date: Mon, 17 Jan 2022 10:47:32 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
From: <tanureal@opensource.cirrus.com>
To: Takashi Iwai <tiwai@suse.de>, Hans de Goede <hdegoede@redhat.com>, "Rafael
 J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Mark Gross
 <markgross@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
 <tiwai@suse.com>, moderated list: "SOUND - SOC LAYER / DYNAMIC AUDIO POWER
 MANAGEM..." <alsa-devel@alsa-project.org>, ACPI Devel Maling List
 <linux-acpi@vger.kernel.org>, <patches@opensource.cirrus.com>, Platform
 Driver <platform-driver-x86@vger.kernel.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>;
Subject: Re: [PATCH 5/5] ACPI / scan: Create platform device for CLSA0100
References: <20220113170728.1953559-1-tanureal@opensource.cirrus.com>
 <20220113170728.1953559-5-tanureal@opensource.cirrus.com>
 <s5hee5a47et.wl-tiwai@suse.de>
 <CAJZ5v0ijGWNd9s-4mrFgK-QbPDhnj2K3DF+Z45t7ckV6ET0hpQ@mail.gmail.com>
 <55cb8127-65e2-4d56-5127-2722c5bfe11f@redhat.com>
 <s5hy23h32mq.wl-tiwai@suse.de>
In-Reply-To: <s5hy23h32mq.wl-tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: oMlFO-dp5RMipIYl8hGjZOMBWtcZMljS
X-Proofpoint-GUID: oMlFO-dp5RMipIYl8hGjZOMBWtcZMljS
X-Proofpoint-Spam-Reason: safe
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

On 1/15/22 6:59 AM, Takashi Iwai <tiwai@suse.de> wrote:
> On Fri, 14 Jan 2022 19:56:04 +0100,
> Hans de Goede wrote:
> >
> > Hi,
> >
> > On 1/14/22 18:51, Rafael J. Wysocki wrote:
> >> On Fri, Jan 14, 2022 at 5:19 PM Takashi Iwai <tiwai@suse.de> wrote:
> >>>
> >>> On Thu, 13 Jan 2022 18:07:28 +0100,
> >>> Lucas Tanure wrote:
> >>>>
> >>>> The ACPI device with CLSA0100 is a sound card with
> >>>> multiple instances of CS35L41 connected by I2C to
> >>>> the main CPU.
> >>>>
> >>>> We add an ID to the i2c_multi_instantiate_idsi list
> >>>> to enumerate all I2C slaves correctly.
> >>>>
> >>>> Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
> >>>
> >>> I think it's better to merge this from sound git tree together with
> >>> others in the patch set, presumably for rc1.
> >>>
> >>> It'd be great if ACPI people can take a review and give an ack/nack.
> >>
> >> Hans, what do you think?
> >
> > This patch (5/5) applies on top of:
> >
> > https://lore.kernel.org/linux-acpi/20211210154050.3713-1-sbinding@opensource.cirrus.com/
> >
> > Which still needs some work and which really should be merged
> > through the ACPI tree. IMHO it would be best to simply drop
> > this (5/5) from this series and move it to the v3 of the
> > series which I've linked to above.
> >
> > 1-4 can be merged through the alsa tree independently of 5/5 AFAIK.
> 
> OK, that's fine.
> 
> Lucas, could you submit v3 patches in the suggested way?
Yes, we will do that.
Thanks
> 
> 
> thanks,
> 
> Takashi
> 
