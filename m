From: "Yang, Libin" <libin.yang@intel.com>
Subject: Re: [PATCH] ASoC: cAVS: add device_link to HDMI audio
Date: Wed, 10 Apr 2019 13:07:26 +0000
Message-ID: <96A12704CE18D347B625EE2D4A099D1952817B8C@SHSMSX103.ccr.corp.intel.com>
References: <1554686513-7770-1-git-send-email-libin.yang@intel.com>
 <20190410112949.GM6106@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C2013F89616
 for <alsa-devel@alsa-project.org>; Wed, 10 Apr 2019 15:07:33 +0200 (CEST)
In-Reply-To: <20190410112949.GM6106@sirena.org.uk>
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Mark Brown <broonie@kernel.org>
Cc: "tiwai@suse.de" <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "pierre-louis.bossart@linux.intel.com" <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Hi Mark,

>-----Original Message-----
>From: Mark Brown [mailto:broonie@kernel.org]
>Sent: Wednesday, April 10, 2019 7:30 PM
>To: Yang, Libin <libin.yang@intel.com>
>Cc: alsa-devel@alsa-project.org; tiwai@suse.de; pierre-
>louis.bossart@linux.intel.com
>Subject: Re: [alsa-devel] [PATCH] ASoC: cAVS: add device_link to HDMI audio
>
>On Mon, Apr 08, 2019 at 09:21:53AM +0800, libin.yang@intel.com wrote:
>> From: Libin Yang <libin.yang@intel.com>
>>
>> In resume from S3, HDAC HDMI codec driver dapm event callback may be
>> operated before HDMI codec driver turns on the display audio power
>> domain because of the contest between display driver and hdmi codec
>driver.
>
>This doesn't apply against current code, please check and resend.

Got it. Thanks. I will update the patch based on the latest code.

Regards,
Libin
