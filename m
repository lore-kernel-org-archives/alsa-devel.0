From: Mengdong Lin <mengdong.lin@linux.intel.com>
Subject: Re: [RFC 0/4] Add support for DAI link addition
 dynamically
Date: Thu, 18 Feb 2016 13:23:27 +0800
Message-ID: <56C5554F.6060800@linux.intel.com>
References: <1455538772-24926-1-git-send-email-vaibhav.agarwal@linaro.org>
 <56C1DF0F.4080503@metafoo.de> <56C40AA9.4050008@linux.intel.com>
 <56C42E71.8030805@linux.intel.com>
 <CANQOkFEnNn8JVeFfgFzBd+-SdFB6jF4fbNHo64ArmDcXypJNAg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 53D4526067A
 for <alsa-devel@alsa-project.org>; Thu, 18 Feb 2016 06:22:20 +0100 (CET)
In-Reply-To: <CANQOkFEnNn8JVeFfgFzBd+-SdFB6jF4fbNHo64ArmDcXypJNAg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vaibhav Agarwal <vaibhav.agarwal@linaro.org>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, vinod.koul@intel.com, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On 02/17/2016 05:31 PM, Vaibhav Agarwal wrote:
> On 17 February 2016 at 13:55, Mengdong Lin <mengdong.lin@linux.intel.com> wrote:
>> On 02/17/2016 01:52 PM, Mengdong Lin wrote:
>>>
>>>
>>>
>>> On 02/15/2016 10:22 PM, Lars-Peter Clausen wrote:
>>>>
>>>> Can you outline how exactly that would work?
>>>>
>>>> Thanks,
>>>> - Lars
>>>>
>>>>
>>>
>>> In Agarwal's use case, it seems a removable codec driver can be
>>> registered after the sound card is registered. And the Pandaboard
>>> machine driver need to add new BE links brought by the new codec
>>> component, which will further trigger probing of the codec components.
>>>
>>> How can the machine driver know a new codec component is registered
>>> automatically?
>>>
>>> Can we add a notification ops like "new_component" to a soc card?
>>> A machine driver can implement this ops.  So when a new component is
>>> registered to the ASoC core, all instantiated soc cards can get notified
>>> and the machine driver can check if the new component brings some new
>>> links to the soc card in this ops. e.g. the Pandaboard machine driver
>>> can add new BE links for the new codec.
>>>
>>> Thanks
>>> Mengdong
>>>
>>
>> Sorry, I missed the case that the codec component can be still be registered
>> before the machine driver register the card. In this situation, the machine
>> driver cannot get the notification.
>
> Yes, the codec component can be registered before the sound card
> registration or even later. All we need is, to add & bind DAI link to
> an already registered/active soc card dynamically.
>
> Also, w.r.t .new_component() callback approach proposed, it can be a
> good solution assuming any device would have limited no. of soc cards
> registered (with support for dynamic codec modules). In this case, can
> a client codec choose to which soc card, it can register DAI links?

Maybe we should not let a client codec driver choose the soc card, but 
let the machine driver (owner of the soc card) to specify a removable codec.

Since the codec driver is generic and can be used for many machines so I 
feel we should avoid adding too machine-specific code to it (e.g. the 
soc card name) as much as possible.

I think the machine driver can understand all use cases for a platform, 
including static or removable connections between the SOC and codecs. So 
it's able to specify the removable codec and the codec DAIs needed by 
the machine, as well as these removable links. Please correct me if my 
understanding is wrong.

>>
>> I wonder if the machine driver can still predefine these links but flag them
>> as "dynamically_registered". For such links, asoc core will not abort
>> instantiating the card, i.e. the sound card will be created even if these
>> links are not bound because lack of some DAIs (e.g. the DAIs of the codec
>> component not registered yet).
>
> Pre-defining links can be a good idea, but honestly, I'm not convinced
> with that. Since, I can have N no. of codec modules to be added
> dynamically. And each may have different number of DAIs, corresponding
> to which I can have different no. of DAI links.

Do you mean the machine driver has no idea about these removal codecs?
And could you share more info about the removal codec in your use case?

If we let the codec driver to add the links, there is gap: a dai link 
needs info from both cpu (soc) side and codec side. A generic codec 
driver only knows the codec info, but has no idea about the cpu side or 
the connection between the codec & cpu. E.g. a codec may have 2 i2s 
interface, but maybe only 1 is connected to the soc.

>>
>> Then when the missing component is added, the ASOC core will automatically
>> check these the unbound links and bind them. When the component is
>> unregistered, ASoC will try to remove the affected links and then remove the
>> components.
>
> I would prefer defining & binding DAI links at the same time as I
> mentioned above. Similarly, cleanup all resources during removal path.
>
>>
>> Thus we may not need add new APIs or let the machine driver monitor when the
>> codec component is registered.
>
> My original idea was:
> Let machine driver export APIs to register/unregister DAI links to its
> registered card. Now, client codec driver can use those exported APIs
> to register DAI link with the card.
>
> In case codec driver is supposed to register dynamically, during probe
> itself it can use machine driver APIs to register relevant DAI links.
>
> And in case codec driver is already registered, a separate mechanism
> can be used to register relevant DAI link using machine driver's
> exposed API.

Is it unavoidable to define a private API of a machine driver and let a 
generic codec driver call this API to add/remove BE DAI links?

If it's really unavoidable, maybe this machine API can just let the 
codec driver to add/remove codec DAIs. And the machine driver can decide 
by itself what links to add/remove for the soc card by ASoC API. Maybe 
you could extend the existing API snd_soc_add_dai_link() for your case.

But IMHO I hope we can avoid this. So I suggested let machine driver 
define some 'removable' links and ASoC core can bind/unbind them 
automatically with the registration/unregistration of the codec 
component. I think most of your code for ASoC core can still be reused.

Thanks
Mengdong
