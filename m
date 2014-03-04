From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] ASoC: io: Remove hw_read() operation
Date: Tue, 04 Mar 2014 12:25:59 +0100
Message-ID: <5315B847.3040203@metafoo.de>
References: <1393924251-6754-1-git-send-email-broonie@kernel.org>
 <53159AD0.5000800@metafoo.de> <20140304092723.GH13126@sirena.org.uk>
 <5315A0CB.1020300@metafoo.de> <20140304101135.GJ13126@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-014.synserver.de (smtp-out-147.synserver.de
 [212.40.185.147])
 by alsa0.perex.cz (Postfix) with ESMTP id D8A4026575F
 for <alsa-devel@alsa-project.org>; Tue,  4 Mar 2014 12:25:26 +0100 (CET)
In-Reply-To: <20140304101135.GJ13126@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 03/04/2014 11:11 AM, Mark Brown wrote:
> On Tue, Mar 04, 2014 at 10:45:47AM +0100, Lars-Peter Clausen wrote:
>
>> Yea, but we are not in a hurry. My plan was to get all the small
>
> YM "yes".  :)
>
>> independent driver cleanups necessary for componetization merged for
>> 3.15 and then for 3.16 do the componetnization in the ASoC core.
>
> I'm keen to avoid getting lots of people sitting on unmerged patches,
> it's a risk source due to interaction issues.
>
>> So what the patchset does is add a regmap pointer to the component
>> struct. For now it also adds
>> snd_soc_component_{read,write,update_bits,
>> update_bits_async} wrapper functions which have the same signature
>> as the matching regmap function. Internally it does check if the
>> regmap field of the component is set, if yes, just forwards the call
>> to the matching regmap function. If not it falls back to the read,
>> write callbacks setup by CODEC or platform drivers. Once every
>> driver has been converted to regmap we can remove the fallback and
>> make the function static inline.
>
> Yes, that's what I'd expect and roughly what I was suggesting doing
> anyway inside the existing implementation (ie, not the new function
> but making the edit inside the existing functions).
>
> I'm not sure I like the _component_ naming since it's getting a bit
> verbose, but on the other hand it probably should only be the core
> using this stuff (the drivers ought to be able to find their own
> regmaps, or at least doing the same lookup) so probably it doesn't
> matter terribly much.
>

Yes, it's only used in the core. There is still snd_soc_write(codec) and 
friends which wraps them like snd_soc_component_write(&codec->component). 
But on the long run I'd like to see all snd_soc_writes be removed from 
driver code.

- Lars
