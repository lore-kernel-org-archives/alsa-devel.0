From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 10/10] ASoC: dapm: Implement mixer input
	auto-disable
Date: Thu, 01 Aug 2013 21:24:11 +0200
Message-ID: <51FAB5DB.20607@metafoo.de>
References: <1375110845-8069-1-git-send-email-lars@metafoo.de>
 <1375110845-8069-10-git-send-email-lars@metafoo.de>
 <20130801104800.GO9858@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailhost.informatik.uni-hamburg.de
 (mailhost.informatik.uni-hamburg.de [134.100.9.70])
 by alsa0.perex.cz (Postfix) with ESMTP id 3C42226166B
 for <alsa-devel@alsa-project.org>; Thu,  1 Aug 2013 21:24:13 +0200 (CEST)
In-Reply-To: <20130801104800.GO9858@sirena.org.uk>
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

On 08/01/2013 12:48 PM, Mark Brown wrote:
> On Mon, Jul 29, 2013 at 05:14:04PM +0200, Lars-Peter Clausen wrote:
>
>> -	ucontrol->value.integer.value[0] =
>> -		(snd_soc_read(codec, reg) >> shift) & mask;
>> +	mutex_lock_nested(&card->dapm_mutex, SND_SOC_DAPM_CLASS_RUNTIME);
>> +	if (dapm_kcontrol_is_powered(kcontrol))
>> +		val = (snd_soc_read(codec, reg) >> shift) & mask;
>> +	else
>> +		val = dapm_kcontrol_get_value(kcontrol);
>> +	mutex_unlock(&card->dapm_mutex);
>> +
>
> My first thought looking at this is that I would expect this to be
> encapsulated in kcntrol_get_value(), though at the minute it's actually
> only returning the virtual value which makes sense for the existing use.
>
> Equally well I'd expect the value to always be a functioning cache of
> the real value so I think what I'm really saying here is that I don't
> think we should really be checking if the control is powered at all.  We
> do need the I/O path but the power isn't the reason for it, the fact
> that we have the value stashed locally is.
>

There might be some corner cases where the driver directly modifies the 
register value outside of put_volsw() which would break. But otherwise I agree.

> Another thing that's bothering me here is that this only works for mono
> controls but many of the uses are stereo mutes and/or volumes.  We'd
> need to add back the support for those.

But that's a general limitation for DAPM controls. Right now 
snd_soc_dapm_put_volsw() only supports mono controls. If we have a left and a 
right mixer we usually have one mono control for each side. But I of course it 
would be nice to have support for stereo controls here. I guess with the shared 
control infrastructure we actually have most of what we need in place. The only 
thing missing is a way to express which channel of the control controls which 
path. E.g. an extra field per path or per mixer widget selecting the index.

- Lars
