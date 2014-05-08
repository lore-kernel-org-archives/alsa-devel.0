From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v6] ASoC: add RT286 CODEC driver
Date: Thu, 08 May 2014 10:57:44 +0200
Message-ID: <536B4708.8080203@metafoo.de>
References: <536B2C9D.9040807@metafoo.de>
 <20140508080025.GA12304@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-016.synserver.de (smtp-out-032.synserver.de
 [212.40.185.32])
 by alsa0.perex.cz (Postfix) with ESMTP id 22F0E260851
 for <alsa-devel@alsa-project.org>; Thu,  8 May 2014 10:57:51 +0200 (CEST)
In-Reply-To: <20140508080025.GA12304@sirena.org.uk>
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
Cc: Oder Chiou <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, Bard Liao <bardliao@realtek.com>, Gustaw Lewandowski <gustaw.lewandowski@intel.com>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org

On 05/08/2014 10:00 AM, Mark Brown wrote:
[...]
>> So the address of the register in which the amplifier gain is stored is the
>> NID + It's a amplifier you want to access + whether it's a input or output
>> amplifier + whether it's left or right amplifier + amplifier index. You can
>> map that onto a linear address space and in the regmap read/write callback
>> do the mapping to the appropriate verb payload layout.
>
> It is of course always going to be possible to map any set of settings
> onto a register map, the question is if it accomplishes anything to do
> so.  Once you're talking about having a mapping function like that
> which understands the contents of all the registers it sounds like the
> contortions to fit into a register map are more effort than is being
> saved and doing nothing for comprehensibility.

There is still structure, the mapping function does not have to understand 
each register it only has to understand each verb and the driver uses maybe 
6-7 different verbs, so it is not that bad. The code would basically look 
like this:

write_reg(addr, val)
{
	verb = EXTRACT_VERB(addr);
	nid = EXTRACT_NID(addr);
	pid = EXTRACT_PID(addr);

	switch (verb) {
	case VERB1:
		return write_verb1(nid, pid, val):
	case VERB2:
		return write_verb2(nid, pid, val):
	....
	}
}

Where pid is verb specific additional addressing information that is used in 
the verbs payload.

>
>>>> the same data). In a sense this is similar to devices which have registers
>>>> with different sizes, we also support these with custom regmap callbacks.
>
>>> But those are only breaking that one assumption so they fit into the
>>> idea of a register map much more readily - it's really only the physical
>>> I/O code that actually notices anything, all the cache and other
>>> operations can carry on uninterrupted.
>
>> This is one of the reasons why I suggest using regmap. You probably still
>> want caching, you probably still be able to sync the register cache, etc. If
>> you don't use regmap you'd have to implement this on your own.
>
> So how does HDA handle this?  We can obviously keep recording settings
> in the same way as we do for virtual enums, writing them out shouldn't
> be so hard.   The cache code isn't going to buy us much if we have to
> write things out control by control anyway, it essentially just boils
> down to a fancy list walk.

It's not just the DAPM stuff, but also the normal controls, for which we do 
not have per control caching.

>
> If you really want to reuse regmap having a write only regmap internal
> to the driver (not presented to ASoC) which just remembers the last
> value written to every NID/VID combination might work and at least
> avoids the ugly bits with trying to convince ASoC there are registers
> since you don't need to worry about reading the data back and can just
> pretend that read values match written values since we never look at
> them except to write them back out.

Yes kind of.
