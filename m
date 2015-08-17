From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v2] ASoC: ics43432: Add codec driver for
 InvenSense ICS-43432
Date: Mon, 17 Aug 2015 09:48:11 +0200
Message-ID: <55D191BB.1000204@metafoo.de>
References: <alpine.DEB.2.02.1508141106040.27635@lnxricardw1.se.axis.com>
 <20150814160731.GS10748@sirena.org.uk>
 <alpine.DEB.2.02.1508170844030.27635@lnxricardw1.se.axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-241.synserver.de (smtp-out-241.synserver.de
 [212.40.185.241])
 by alsa0.perex.cz (Postfix) with ESMTP id E03E9260547
 for <alsa-devel@alsa-project.org>; Mon, 17 Aug 2015 09:48:14 +0200 (CEST)
In-Reply-To: <alpine.DEB.2.02.1508170844030.27635@lnxricardw1.se.axis.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ricard Wanderlof <ricard.wanderlof@axis.com>, Mark Brown <broonie@kernel.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 08/17/2015 09:09 AM, Ricard Wanderlof wrote:
> 
> On Fri, 14 Aug 2015, Mark Brown wrote:
> 
>> On Fri, Aug 14, 2015 at 11:10:10AM +0200, Ricard Wanderlof wrote:
>>>
>>> V2: Update after comments from Lars-Peter yesterday: set rate to 
>>> CONTINUOUS and let ALSA figure out the details, also removing hw_params as 
>>> it is then not needed.
>>
>> Please add any non-changelog content like this after the --- as covered
>> in SubmittingPatches.
> 
> Ok, sorry.
> 
>>> +static int ics43432_set_dai_fmt(struct snd_soc_dai *dai, unsigned int fmt)
>>> +{
>>> +	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
>>
>> This still seems redundant (IIRC Lars mentioned this...).
> 
> I though Lars was referring solely to the hw_params function, not 
> set_dai_fmt, but of course I could have misunderstood him.

Yes, I was. In my opinion this set_dai_fmt() implementation is useful to
have as a mechanism to detect invalid configurations. E.g. if you don't
implement the callback the CODEC will accept any setting while with he
callback it will error out with the wrong configuration. Given that a I2S
link typically at least somewhat works, even if you have the wrong setting,
I think it makes sense to keep it to catch errors early on.
