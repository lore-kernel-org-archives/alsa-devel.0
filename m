From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH] ASoC: max98090: Fix missing free_irq (part
	2)
Date: Fri, 19 Sep 2014 10:51:13 +0300
Message-ID: <541BE071.1090600@linux.intel.com>
References: <1411037324-5996-1-git-send-email-jarkko.nikula@linux.intel.com>
 <20140918175434.GA7960@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 9F5BB2615F7
 for <alsa-devel@alsa-project.org>; Fri, 19 Sep 2014 09:51:36 +0200 (CEST)
In-Reply-To: <20140918175434.GA7960@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 09/18/2014 08:54 PM, Mark Brown wrote:
> On Thu, Sep 18, 2014 at 01:48:44PM +0300, Jarkko Nikula wrote:
>
>> ---
>> for-next, I don't think this is critical enough for stable.
>> ---
>> @@ -2413,6 +2413,7 @@ static int max98090_remove(struct snd_soc_codec *codec)
>>   {
>>   	struct max98090_priv *max98090 = snd_soc_codec_get_drvdata(codec);
>>   
>> +	devm_free_irq(codec->dev, max98090->irq, codec);
> If this is a fix for -next shouldn't we be doing the proper fix and
> moving the resource acquisition to the bus probe?
Fair enough. I'll cook another version.

-- 
Jarkko
