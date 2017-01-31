From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 14/17] ASoC: rt5645: fix error handling for
 gpio detection
Date: Tue, 31 Jan 2017 14:29:37 -0600
Message-ID: <2e74f204-05c1-6fa5-6ec4-e95351e7a80a@linux.intel.com>
References: <1485461385-14544-1-git-send-email-pierre-louis.bossart@linux.intel.com>
 <1485461385-14544-15-git-send-email-pierre-louis.bossart@linux.intel.com>
 <20170131200049.atw7euwvbgsqt7pl@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id D36B0267395
 for <alsa-devel@alsa-project.org>; Tue, 31 Jan 2017 21:29:39 +0100 (CET)
In-Reply-To: <20170131200049.atw7euwvbgsqt7pl@sirena.org.uk>
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
Cc: tiwai@suse.de, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org



On 01/31/2017 02:00 PM, Mark Brown wrote:
> On Thu, Jan 26, 2017 at 02:09:42PM -0600, Pierre-Louis Bossart wrote:
>> Optional gpio handling should not cause an error status
>> and prevent probing.
>> Remove error return and move error message to dev_info
>> @@ -3660,8 +3660,7 @@ static int rt5645_i2c_probe(struct i2c_client *i2c,
>>   						       GPIOD_IN);
>>   
>>   	if (IS_ERR(rt5645->gpiod_hp_det)) {
>> -		dev_err(&i2c->dev, "failed to initialize gpiod\n");
>> -		return PTR_ERR(rt5645->gpiod_hp_det);
>> +		dev_info(&i2c->dev, "failed to initialize gpiod\n");
>>   	}
> I'd expect this to depend on what the error is - the normal pattern is
> to check for whatever the error code for "this doesn't exist" is and
> ignore that while treating other things (especially -EPROBE_DEFER but
> also other things) as errors.
yes, I'll apply the same filter on -ENOENT as for the test for the 
mclock last month. I should have thought about it, thanks for pointing 
this out.
