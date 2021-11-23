Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48799C433EF
	for <alsa-devel@archiver.kernel.org>; Wed, 24 Nov 2021 07:13:16 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 76E651767;
	Wed, 24 Nov 2021 08:12:24 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 76E651767
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1637737994;
	bh=ujd/or5iN565wDOdChsLFPi0FyAOQXdkKmmiQ6KiHyg=;
	h=Date:From:To:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rWxFV7GPbQdhGZ8O2T2qTsFV+Jd5hCZFuz0uh/YoEG4sunsI6zoqB680LCMPxxFzv
	 u8vizMp5QeBJAv/6eJoJxBhv/Yxs4bQj+GL+Sm2y8tF9jD+B55Cs7Zml2pf9Njipa5
	 /FTiZB1MYKYwK0ZlvZe09bvCNTh2FKbwwRlAJJAc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 235E7F805AA;
	Wed, 24 Nov 2021 08:06:12 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 30D2BF804B1; Tue, 23 Nov 2021 18:06:42 +0100 (CET)
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6E725F80154
 for <alsa-devel@alsa-project.org>; Tue, 23 Nov 2021 18:06:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6E725F80154
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com
 header.b="d9ATGvqg"
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
 by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1AN7k0DE013868;
 Tue, 23 Nov 2021 11:06:33 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com;
 h=message-id : date :
 mime-version : from : to : subject : references : in-reply-to :
 content-type : content-transfer-encoding; s=PODMain02222019;
 bh=amQU7FZ/5g8QJDCHA86K0HOZeFaQBYccT1e3/wxVmZo=;
 b=d9ATGvqg538Vpg4nOsV8jFtKyuj/+QUi/oPnQKYM4FEtAnqyikfeJyXi7Fdx0JuuCjXn
 uSBbDQlfWDBhm77fbn6zkIkzB0sKN1WDaoBh3L0WQLeBVVkCS8j3GDoJ17gt3jMlY/7f
 7+RsPnwN+7OjmE87M1ZRA+0qiqA/pGj3UcWclyR//evlP554a1bPhS893LQnWRpdqidT
 V1YgKIwoG3pXFfE50PqzP0c84joCr6CEFCaoepst4dmyCVyepgXL5QX3axNHu9nqjFN2
 ZLiDCIeLXLCTj8TOFpd/yYsO38lxo8yvG/U9fzmcPzpESEmpZKmW93L/FSPyJMi4o2x2 6w== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
 by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3cg3v7a3ee-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Tue, 23 Nov 2021 11:06:32 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 23 Nov
 2021 17:06:30 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.17 via
 Frontend Transport; Tue, 23 Nov 2021 17:06:30 +0000
Received: from [198.61.65.11] (unknown [198.61.65.11])
 by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 5DFFB2A3;
 Tue, 23 Nov 2021 17:06:30 +0000 (UTC)
Message-ID: <ebb877d5-e348-e5fe-a5cb-9ef579a312f5@opensource.cirrus.com>
Date: Tue, 23 Nov 2021 17:06:30 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
From: <tanureal@opensource.cirrus.com>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, "Rafael
 J.Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Hans de Goede
 <hdegoede@redhat.com>, Mark Gross <markgross@kernel.org>, Liam Girdwood
 <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Mark Brown
 <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>, Kailang Yang
 <kailang@realtek.com>, Shuming Fan <shumingf@realtek.com>, David Rhodes
 <david.rhodes@cirrus.com>, Vitaly Rodionov <vitalyr@opensource.cirrus.com>,
 Jeremy Szu <jeremy.szu@canonical.com>, Hui Wang <hui.wang@canonical.com>,
 Werner Sembach <wse@tuxedocomputers.com>, Chris Chiu
 <chris.chiu@canonical.com>, Cameron Berkenpas <cam@neo-zeon.de>, Sami Loone
 <sami@loone.fi>, Elia Devito <eliadevito@gmail.com>, Srinivas Kandagatla
 <srinivas.kandagatla@linaro.org>, Jack Yu <jack.yu@realtek.com>, "Arnd
 Bergmann" <arnd@arndb.de>, Lars-Peter Clausen <lars@metafoo.de>, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>,
 <alsa-devel@alsa-project.org>, <linux-acpi@vger.kernel.org>,
 <patches@opensource.cirrus.com>, <platform-driver-x86@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 10/11] hda: cs35l41: Add support for CS35L41 in HDA systems
References: <20211123163149.1530535-1-tanureal@opensource.cirrus.com>
 <20211123163149.1530535-11-tanureal@opensource.cirrus.com>
 <d8fe13f2-ac84-51b6-8eb5-095176a65c39@linux.intel.com>
In-Reply-To: <d8fe13f2-ac84-51b6-8eb5-095176a65c39@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: jNP0KH8DmaKZaqeUPB5H2Q11BR3PWT0N
X-Proofpoint-ORIG-GUID: jNP0KH8DmaKZaqeUPB5H2Q11BR3PWT0N
X-Proofpoint-Spam-Reason: safe
X-Mailman-Approved-At: Wed, 24 Nov 2021 08:05:53 +0100
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

On 11/23/21 4:59 PM, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com> wrote:
> 
> > +#ifdef CONFIG_ACPI
> > +static const struct acpi_device_id cs35l41_acpi_hda_match[] = {
> > +	{"CLSA0100", 0 },
> 
> I could be wrong but this doesn't look like a legit ACPI _HID?
> 
> Cirrus Logic can use 'CIR', "CLI", or 'CSC' PNP ID, or an PCI ID.
> 
> in the past you used
> 
> +#ifdef CONFIG_ACPI
> +static const struct acpi_device_id cs35l41_acpi_match[] = {
> +	{ "CSC3541", 0 }, /* Cirrus Logic PnP ID + part ID */
> +	{},
> +};
> +MODULE_DEVICE_TABLE(acpi, cs35l41_acpi_match);
> +#endif
> 
> 
> 

This ACPI _HID is already released, there is nothing I can do about it.
Future devices will use 'CSC' PnP ID.
