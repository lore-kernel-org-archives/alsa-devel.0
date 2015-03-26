From: Pascal Huerst <pascal.huerst@gmail.com>
Subject: Re: [PATCH] ASoC: snd_soc_tas5086: Reinit register
	values on probe
Date: Thu, 26 Mar 2015 13:17:35 +0100
Message-ID: <5513F8DF.3070001@gmail.com>
References: <1427297379-17736-1-git-send-email-pascal.huerst@gmail.com>
 <20150325162029.GF3572@sirena.org.uk> <5512F06B.1030301@gmail.com>
 <20150325174831.GK3572@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f50.google.com (mail-wg0-f50.google.com [74.125.82.50])
 by alsa0.perex.cz (Postfix) with ESMTP id C190C26571D
 for <alsa-devel@alsa-project.org>; Thu, 26 Mar 2015 13:17:39 +0100 (CET)
Received: by wgbcc7 with SMTP id cc7so61528721wgb.0
 for <alsa-devel@alsa-project.org>; Thu, 26 Mar 2015 05:17:38 -0700 (PDT)
In-Reply-To: <20150325174831.GK3572@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, tiwai@suse.de, lgirdwood@gmail.com, zonque@gmail.com, ckeepax@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org



On 25.03.2015 18:48, Mark Brown wrote:
> On Wed, Mar 25, 2015 at 06:29:15PM +0100, Pascal Huerst wrote:
>> On 25.03.2015 17:20, Mark Brown wrote:
>>> On Wed, Mar 25, 2015 at 04:29:39PM +0100, Pascal Huerst wrote:
> 
>>>> If the machine driver has been un/reloaded, the register values of
>>>> the codec driver have to be reinitialized in order to run properly.
> 
>>> Hrm.  This isn't something that I'd expect to be required - I'd expect
>>> that as part of the machine driver teardown to put the hardware into a
>>> reasonable default state so that things come back as normal.  Can you be
>>> a bit more specific about the problem that you are seeing?  We probably
>>> shouldn't need the existing reset that's in the ASoC level probe either.
> 
>> The symptom is, that if I rmmod the machine driver and then modprobe it
>> again. The codec does not play audio at all. I can call aplay without
>> any problems, but there is no output. My guess was that I have to
>> rewrite the default values after a reset. May be regmap_reinit_cache()
>> is the better choice to reinit the register values? Not sure about that.
> 
> That's not really answering my question at a low enough level - what
> exactly is changed in the device as a result of rewriting all the
> registers?
> 
>>> I do think a version of this is useful regardless of the above...
> 
>>>>  	tas5086_reset(priv);
>>>> +	regcache_mark_dirty(priv->regmap);
> 
>>> Since the device has hardware reset support we really ought to be able
>>> to do the register cache resync only if the reset GPIO is missing.  How
>>> about putting your code into the reset function and doing it in the
>>> case where the reset GPIO is missing?  That way anything that thinks
>>> it's resetting the device will get the benefit of your code.
> 
>> I thing this would not fix the issue. I do have a hardware reset. In
>> that case my code would not be called at all and I would face the same
>> issue (no audio output) again.
> 
> So you're saying that doing a hardware reset of the device isn't
> actually resetting the device?  That suggests that either the hardware
> reset code isn't working for some reason or there's a bug somewhere
> else.
> 
> If the rewrite of all the registers is doing anything other than writing
> the values that the registers already have that suggests we're just
> randomly bashing on the device in the hope that it works...

Aargh... I have had this patch in use for quite some time and assumed
it's working properly, but after some more testing now, I have to admit
that the cause for my problem is something else... I does not even make
a difference anymore, if applied or not... Sorry for bothering!
