From: Vaibhav Agarwal <vaibhav.agarwal@linaro.org>
Subject: Re: [RFC 0/4] Add support for DAI link addition
	dynamically
Date: Wed, 17 Feb 2016 15:01:10 +0530
Message-ID: <CANQOkFEnNn8JVeFfgFzBd+-SdFB6jF4fbNHo64ArmDcXypJNAg@mail.gmail.com>
References: <1455538772-24926-1-git-send-email-vaibhav.agarwal@linaro.org>
 <56C1DF0F.4080503@metafoo.de> <56C40AA9.4050008@linux.intel.com>
 <56C42E71.8030805@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f169.google.com (mail-ob0-f169.google.com
 [209.85.214.169])
 by alsa0.perex.cz (Postfix) with ESMTP id 8FF642606B8
 for <alsa-devel@alsa-project.org>; Wed, 17 Feb 2016 10:31:11 +0100 (CET)
Received: by mail-ob0-f169.google.com with SMTP id jq7so5635517obb.0
 for <alsa-devel@alsa-project.org>; Wed, 17 Feb 2016 01:31:11 -0800 (PST)
In-Reply-To: <56C42E71.8030805@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mengdong Lin <mengdong.lin@linux.intel.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, vinod.koul@intel.com, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On 17 February 2016 at 13:55, Mengdong Lin <mengdong.lin@linux.intel.com> wrote:
> On 02/17/2016 01:52 PM, Mengdong Lin wrote:
>>
>>
>>
>> On 02/15/2016 10:22 PM, Lars-Peter Clausen wrote:
>>>
>>> On 02/15/2016 01:19 PM, Vaibhav Agarwal wrote:
>>>>
>>>> Following patches are based on for-next branch from broonie tree.
>>>> First 2 patches include changes in existing soc, core framework
>>>> to prepare for adding support for dynamic DAI link addition/
>>>> removal
>>>>
>>>> Patch 3 & 4 contains actual changes to enable dynamic DAI link
>>>> support
>>>>
>>>> NOTE:
>>>> Currently, the code is tested on Pandaboad ES revB3 for playback
>>>> usecase.
>>>
>>>
>>> Can you outline how exactly that would work?
>>>
>>> Thanks,
>>> - Lars
>>>
>>>
>>
>> In Agarwal's use case, it seems a removable codec driver can be
>> registered after the sound card is registered. And the Pandaboard
>> machine driver need to add new BE links brought by the new codec
>> component, which will further trigger probing of the codec components.
>>
>> How can the machine driver know a new codec component is registered
>> automatically?
>>
>> Can we add a notification ops like "new_component" to a soc card?
>> A machine driver can implement this ops.  So when a new component is
>> registered to the ASoC core, all instantiated soc cards can get notified
>> and the machine driver can check if the new component brings some new
>> links to the soc card in this ops. e.g. the Pandaboard machine driver
>> can add new BE links for the new codec.
>>
>> Thanks
>> Mengdong
>>
>
> Sorry, I missed the case that the codec component can be still be registered
> before the machine driver register the card. In this situation, the machine
> driver cannot get the notification.

Yes, the codec component can be registered before the sound card
registration or even later. All we need is, to add & bind DAI link to
an already registered/active soc card dynamically.

Also, w.r.t .new_component() callback approach proposed, it can be a
good solution assuming any device would have limited no. of soc cards
registered (with support for dynamic codec modules). In this case, can
a client codec choose to which soc card, it can register DAI links?

>
> I wonder if the machine driver can still predefine these links but flag them
> as "dynamically_registered". For such links, asoc core will not abort
> instantiating the card, i.e. the sound card will be created even if these
> links are not bound because lack of some DAIs (e.g. the DAIs of the codec
> component not registered yet).

Pre-defining links can be a good idea, but honestly, I'm not convinced
with that. Since, I can have N no. of codec modules to be added
dynamically. And each may have different number of DAIs, corresponding
to which I can have different no. of DAI links.

>
> Then when the missing component is added, the ASOC core will automatically
> check these the unbound links and bind them. When the component is
> unregistered, ASoC will try to remove the affected links and then remove the
> components.

I would prefer defining & binding DAI links at the same time as I
mentioned above. Similarly, cleanup all resources during removal path.

>
> Thus we may not need add new APIs or let the machine driver monitor when the
> codec component is registered.

My original idea was:
Let machine driver export APIs to register/unregister DAI links to its
registered card. Now, client codec driver can use those exported APIs
to register DAI link with the card.

In case codec driver is supposed to register dynamically, during probe
itself it can use machine driver APIs to register relevant DAI links.

And in case codec driver is already registered, a separate mechanism
can be used to register relevant DAI link using machine driver's
exposed API.

Also, I plan to update card->codec_conf dynamically in response to
recently added codec module. This would help to update .prefix_name
while adding mixer controls for the codec and uniquely identify them.
The same is required in case of multiple codec modules of similar type
attached to a device.

--
Thanks,
./va

>
> Thanks
> Mengdong
>
>
