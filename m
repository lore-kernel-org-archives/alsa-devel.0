From: Miguel Aguilar <miguel.aguilar@ridgerun.com>
Subject: Re: [PATCH 3/5] ASoC: DaVinci: CQ93VC Voice Codec
Date: Mon, 08 Mar 2010 11:26:47 -0600
Message-ID: <4B953357.9080904@ridgerun.com>
References: <1264095660-1323-1-git-send-email-miguel.aguilar@ridgerun.com>
	<20100125111104.GC22909@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.navvo.net (mail.navvo.net [74.208.67.6])
	by alsa0.perex.cz (Postfix) with ESMTP id 63FB62454C
	for <alsa-devel@alsa-project.org>; Mon,  8 Mar 2010 18:30:56 +0100 (CET)
In-Reply-To: <20100125111104.GC22909@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: davinci-linux-open-source@linux.davincidsp.com, nsekhar@ti.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Mark,

What is the status of this patch series?, I'm still missing the change pointed 
below for third patch.

Regards,
Miguel Aguilar

Mark Brown wrote:
> On Thu, Jan 21, 2010 at 11:41:00AM -0600, miguel.aguilar@ridgerun.com wrote:
> 
>> +static __init int cq93vc_codec_probe(struct platform_device *pdev)
>> +{
> 
> ...
> 
>> +	cq93vc_codec = codec;
>> +
>> +	ret = snd_soc_register_dai(&cq93vc_dai);
>> +	if (ret != 0) {
>> +		dev_err(davinci_vc->dev, "could register dai\n");
>> +		goto fail1;
>> +	}
>> +	return 0;
> 
> There should also be a snd_soc_register_codec() before this, and
> similarly on the remove.  Otherwise this looks good.
