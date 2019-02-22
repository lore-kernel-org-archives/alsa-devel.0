From: "Schulman, James" <James.Schulman@cirrus.com>
Subject: Re: [PATCH] ASoC: cs35l36: Fix an IS_ERR() vs NULL
 checking bug
Date: Fri, 22 Feb 2019 21:50:26 +0000
Message-ID: <alpine.DEB.2.10.1902221549310.5957@james-tower>
References: <20190222063151.GC30993@kadam>
 <20190222092248.GB130153@ediswmail.ad.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7C6BAF807BC
 for <alsa-devel@alsa-project.org>; Fri, 22 Feb 2019 22:50:59 +0100 (CET)
In-Reply-To: <20190222092248.GB130153@ediswmail.ad.cirrus.com>
Content-Language: en-US
Content-ID: <D627CBA2A54A444D8C5B0D3BFAA24D28@namprd19.prod.outlook.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: "Austin, Brian" <Brian.Austin@cirrus.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, "Handrigan, Paul" <Paul.Handrigan@cirrus.com>, "Schulman, James" <James.Schulman@cirrus.com>, Mark Brown <broonie@kernel.org>, Dan Carpenter <dan.carpenter@oracle.com>
List-Id: alsa-devel@alsa-project.org



On Fri, 22 Feb 2019, Charles Keepax wrote:

> On Fri, Feb 22, 2019 at 09:31:51AM +0300, Dan Carpenter wrote:
>> The irq_get_irq_data() function doesn't return error pointers, it
>> returns NULL.
>>
>> Fixes: 6ba9dd6c893b ("ASoC: cs35l36: Add support for Cirrus CS35L36 Amplifier")
>> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>> ---
>
> Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>
>
> Thanks,
> Charles
>

Thanks Dan.

Reviewed-by: James Schulman <james.schulman@cirrus.com>

- James
