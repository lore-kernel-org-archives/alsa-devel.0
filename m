From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: Broken outmixer_event function in
	wm8400/wm8990/wm8991
Date: Tue, 13 May 2014 16:11:03 +0200
Message-ID: <537227F7.9000609@metafoo.de>
References: <5370840E.10009@metafoo.de> <20140512204734.GO12304@sirena.org.uk>
 <20140513135305.GL25203@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-016.synserver.de (smtp-out-087.synserver.de
 [212.40.185.87])
 by alsa0.perex.cz (Postfix) with ESMTP id 1A70426522D
 for <alsa-devel@alsa-project.org>; Tue, 13 May 2014 16:11:06 +0200 (CEST)
In-Reply-To: <20140513135305.GL25203@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On 05/13/2014 03:53 PM, Charles Keepax wrote:
> On Mon, May 12, 2014 at 09:47:34PM +0100, Mark Brown wrote:
>> On Mon, May 12, 2014 at 10:19:26AM +0200, Lars-Peter Clausen wrote:
>>
>>> I was looking at the drivers that were using the SND_SOC_DAPM_PRE_REG event
>>> and I noticed that the outmixer_event function for the wm8400, wm8990 and
>>> wm8991 is broken. They do a switch statement to determine which kcontrol
>>> cause the event in the form of 'switch(kcontrol->private_value) { case (REG
>>> | (SHIFT << 8)): ...'. Long long time ago we used to store the register and
>>> the shift in the same integer which was stored in private_value. But this
>>> was changed in commit 4eaa9819 ("ALSA: ASoC: Convert bitfields in ASoC into
>>> full int width"). This was long before the wm8400 and wm8991 drivers were
>>> merged and just a month after the wm8990 driver was merged. So these
>>> functions have been dead code pretty much for as long as they existed. Do
>>> you want to fix this up? If not I'm going to send a patch that removes the
>>> functions. If you want to fix this up, this should be re-implemented as a
>>> custom put handler for the kcontrols rather than a event callback, which
>>> checks whether the change is valid before doing any DAPM changes. The event
>>> callback runs in the middle of the DAPM sequence, so half of the changes
>>> will already have been applied before the check is made whether the change
>>> should be done or not.
>
> It is a PRE_REG event so should it not run before the other
> changes? But a failed event callback doesn't stop the DAPM
> sequence, so it will actually proceed with the broken config and
> all we actually do at the moment is print a message.

The PRE_REG event runs before the change to the register of the kcontrol. 
Before that we already run DAPM widgets power down sequence. (Although 
admittedly there probably won't be many power down events as a result from 
turning a switch on).

>
>>
>> Paragraphs are good for legibility...  it would be better to fix this up
>> since it's a useful example for people to have, I have seen this sort of
>> "A but not B" thing in other devices.  Looking briefly at the WM8400
>> datasheet custom put controls would be better though looking at the code
>> I'm not sure that the intention with the original code (which predates
>> me) wasn't to enforce a limitation based on the outputs being enabled.
>
> Yeah I think the intention was to avoid imposing limitations on
> the order you set the controls, as the error checking is only
> done when the power sequence runs so you can move through an
> invalid state as long as when things power up they are valid.
>
> I would be inclined to go with the custom put/get method as well,
> but it leaves a question of what to do if the user sets an
> invalid value. Refusing to set the control feels nicer, but adds
> an ordering limitation on setting the controls. Updating the
> conflicting control is also possible, but might be a little
> surprising?

The event PRE_REG event is generated as soon as the control is changed, not 
when the path powers up. So there is no difference to a custom put handler 
in this regard.

You could automatically mute the other control if one of the controls get 
unmuted, that at least solves the ordering issue.

- Lars
