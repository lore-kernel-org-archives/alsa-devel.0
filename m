From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 00/13] ASoC: Move IO and kcontrols to the
 component level
Date: Tue, 18 Mar 2014 09:25:11 +0100
Message-ID: <532802E7.2060309@metafoo.de>
References: <1395129736-11938-1-git-send-email-lars@metafoo.de>
 <s5h4n2wdj75.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-224.synserver.de (smtp-out-230.synserver.de
 [212.40.185.230])
 by alsa0.perex.cz (Postfix) with ESMTP id D4CDC265091
 for <alsa-devel@alsa-project.org>; Tue, 18 Mar 2014 09:24:33 +0100 (CET)
In-Reply-To: <s5h4n2wdj75.wl%tiwai@suse.de>
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
Cc: Brian Austin <brian.austin@cirrus.com>, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lgirdwood@gmail.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Mark Brown <broonie@kernel.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 03/18/2014 09:06 AM, Takashi Iwai wrote:
> At Tue, 18 Mar 2014 09:02:03 +0100,
> Lars-Peter Clausen wrote:
>>
>> Hi,
>>
>> This series is the first step towards full componentisation of the ASoC core. It
>> moves both the IO abstraction layers within ASoC as well as the standard set of
>> kcontrols to the component level. This for example means we can get rid of
>> constructs like
>>
>> 	if (w->codec)
>> 		snd_soc_read(....)
>> 	else if(w->platform)
>> 		snd_soc_platform_read(...)
>>
>> Moving the kcontrols to the component level means we can use the same
>> implementation also for other non-CODEC components. E.g. there seems to be an
>> increasing amount of CPU components that have basic signal processing and things
>> like volume controls etc. whose register layout is similar to those used in
>> CODECs. Currently each CPU component driver re-implements these controls by
>> hand.
>>
>> The first two patches introduce two new helper functions which hide the actual
>> implementation on how the CODEC or platform struct that register a control can
>> be obtained from the control. This means that when the actual implementation is
>> changed only the two helper functions need to be updated and not every single
>> driver. The patches that follow that are just cleanups removing unused IO stuff
>> and move all IO functions to soc-io.c. The next step is to make platforms also
>> components. And then finally first the IO abstraction layers in ASoC are unified
>> at the component level and then on top of that the kcontrol helpers are moved to
>> the component level.
>>
>> The series depends on quite a few topic branches related to changes to the core
>> and cleanups for individual drivers. It is probably best to place it on top of
>> asoc-v3.15-2. The patch that moves the kcontrols to the component level also has
>> a runtime dependency on the not yet applied patches that move the ams-delta and
>> mfld_machine controls to the card level.
>
> I'd love to have seen this one or two weeks ago, if this is intended
> for 3.15 upstream.  But I guess it's still OK if anyone can test the
> stuff well.

My initial plan was to submit it after the 3.15 merge window, but I realized 
that that's probably still one month away and I already mentioned the 
patches a few, so its probably better to have them send out to the ml. They 
don't have to go into 3.15. It would be good if the first two patches could 
make it though, they are trivial and having them merged before the rest 
gives a bit more time for not yet merged drivers to update to the new helper 
functions.

- Lars
