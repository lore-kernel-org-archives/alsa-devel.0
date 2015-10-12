From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: Audio Mini Summit 2015, 8th October, Dublin
Date: Mon, 12 Oct 2015 17:54:35 +0200
Message-ID: <561BD7BB.2090200@metafoo.de>
References: <20151004231752.GA22609@sirena.org.uk>	<20151007152047.GQ12635@sirena.org.uk>	<561679FE.3060809@metafoo.de>	<56167DBF.9090106@metafoo.de>	<5617C133.1080006@metafoo.de>
 <s5hlhb8lbi7.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-100.synserver.de (smtp-out-101.synserver.de
 [212.40.185.101])
 by alsa0.perex.cz (Postfix) with ESMTP id 315E926149E
 for <alsa-devel@alsa-project.org>; Mon, 12 Oct 2015 17:54:39 +0200 (CEST)
In-Reply-To: <s5hlhb8lbi7.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 10/12/2015 10:46 AM, Takashi Iwai wrote:
> On Fri, 09 Oct 2015 15:29:23 +0200,
> Lars-Peter Clausen wrote:
>>
>> On 10/08/2015 04:29 PM, Lars-Peter Clausen wrote:
>>> On 10/08/2015 04:13 PM, Lars-Peter Clausen wrote:
>>>> On 10/07/2015 05:20 PM, Mark Brown wrote:
>>>>> On Mon, Oct 05, 2015 at 12:17:52AM +0100, Mark Brown wrote:
>>>>>> [This message is BCCed to everyone currently on the signup list]
>>>>>>
>>>>>> As previously announce the audio mini-summit for this year will be this
>>>>>> Thursday (8th August) at CCD in Dublin.  Topics we currently have on the
>>>>>> list for discussion are:
>>>>>
>>>>> Current list:
>>>>>
>>>>>  - Power saving and general system design decisions (is what we're doing
>>>>>    lining up with modern hardware with things like multiple output
>>>>>    streams?).
>>>>>  - Documentation.
>>>>>  - alsa-lib releae plans.
>>>>>  - What to do with HDMI and its integration with graphics.
>>>>>  - Test tools (Intel BAT and others).
>>>>>  - BATCH flag.
>>>>>  - Fuzz control PCM APIs.
>>>>>  - Splitting out root only controls.
>>>>>  - ACPI simple-card and general generic card support.
>>>>>  - Topology & media controller integration.
>>>>>  - Kernel tinification.
>>>>>  - Android <-> alsa-lib configuration translation.
>>>>>  - HDA restructuring.
>>>>>   - Support for DisplayPort MST.
>>>>>  - PCM core simplification - the code is currently quite complex!
>>>>>  - Soundwire driver support plans.
>>>>>  - ASoC multichannel.
>>>>>  - Random DAPM changes.
>>>>
>>>> Media controller:
>>>> http://blogs.s-osg.org/working-complicated-problems-media-controller-workshop/
>>>
>>> And to give some more background information on how the constraints
>>> refinement works: http://metafoo.de/alsa_constraints.html
>>>
>>> It's not yet complete but should still give you and idea
>>
>> Btw. when you try to size optimize the kernel have you tried to build stuff
>> with link-time-optimization? A lot of the constraints refinement code is
>> helper function that are only used by certain drivers. So with LTO also
>> those helper function would be removed.
> 
> Yeah, I suggested a similar thing to Keyon before the meeting.
> But I wonder whether LTO takes effect if the module is enabled.
> AFAIK, Intel want to keep the modules (despite of the demanded code
> reduction), as they seem to try the generic solution.  If the module
> is enabled, essentially all exported symbols have to stay, so LTO
> can't rip off anything.

Well, even if you do a modular build you still need to build both modules
and the kernel from the same Kconfig. You can't decide that you later on
want to enable or disable certain modules and then only re-build those. So
at least in theory all the information about which functions are used in the
modules and which are not is available and could be used by the LTO phase.
But I've never worked with kernel LTO and have no idea whether that works in
practice or not.

But I think this is still the path that I'd recommend people to peruse.
Since this is a generic approach and once you've figure it out you should be
able to see the maximum amount of savings rather than the approch where you
look at each module separately and need to go through them and identify
functionality that can be removed. Or even try to remove vital parts of the
framework completely.

E.g. I'd consider parameter refining a vital part of ALSA and the core
functionality of it is rather compact. But it provides a lot of helper
functions of which only some are going to be used if you built a reduced
kernel. So rather then completely disabling parameter refining use LTO to
remove the unused helper functions.

> 
> A possible workaround that came to my mind is to build both built-in
> and modules.  The former contains only symbols referred inside the
> built-in kernel while the latter module contains the rest exported
> symbols.  But, the initialization is the problem in this case, so it's
> not so straightforward for now...
> 
> 
> Takashi
> 
