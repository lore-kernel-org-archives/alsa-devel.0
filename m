From: Oleksandr Andrushchenko <andr2000@gmail.com>
Subject: Re: [Xen-devel][PATCH 0/2] sndif: add explicit back
 and front synchronization
Date: Tue, 6 Mar 2018 18:04:41 +0200
Message-ID: <670e6d78-1dbd-dcc9-fd82-813c2f45c5d3@gmail.com>
References: <1517819100-1029-1-git-send-email-andr2000@gmail.com>
 <s5hd10hcw6t.wl-tiwai@suse.de>
 <d460d2f9-8a93-7046-dbe3-fe921c2da130@gmail.com>
 <s5h4lltcud4.wl-tiwai@suse.de>
 <1531a22b-5df6-a66e-72ee-775538aeff4d@gmail.com>
 <s5hwoypbc3c.wl-tiwai@suse.de>
 <e11de1a2-5095-6297-184b-00405300bfe7@gmail.com>
 <s5hpo4hb9hg.wl-tiwai@suse.de>
 <621aaaa9-5994-176c-b243-c2fc9823a699@gmail.com>
 <s5hfu5db7pd.wl-tiwai@suse.de>
 <18f6eced-a932-ad82-0097-e18ac1a562ae@gmail.com>
 <s5ha7vlb5vl.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lf0-f51.google.com (mail-lf0-f51.google.com
 [209.85.215.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 3BF85266F68
 for <alsa-devel@alsa-project.org>; Tue,  6 Mar 2018 17:04:44 +0100 (CET)
Received: by mail-lf0-f51.google.com with SMTP id i80so29291257lfg.5
 for <alsa-devel@alsa-project.org>; Tue, 06 Mar 2018 08:04:43 -0800 (PST)
In-Reply-To: <s5ha7vlb5vl.wl-tiwai@suse.de>
Content-Language: en-US
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
Cc: xen-devel@lists.xenproject.org, alsa-devel@alsa-project.org, Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
List-Id: alsa-devel@alsa-project.org

On 03/06/2018 05:06 PM, Takashi Iwai wrote:
> On Tue, 06 Mar 2018 15:48:53 +0100,
> Oleksandr Andrushchenko wrote:
>>>>>>> And, now an open question for XEN comes: what kind of restriction
>>>>>>> should be applied to the frontend.  Obviously it depends on the
>>>>>>> backend, so there must be some communication, and the restriction must
>>>>>>> be propagated at open, i.e. *before* actually hw_params is performed.
>>>>>> Could you please give me a hint of what those restrictions
>>>>>> could look like? E.g. map of supported buffer/period sizes, what else?
>>>>> Heh, that very much depends on the hardware -- and in this case, on
>>>>> the implementation of the backend.
>>>> That is correct, but we try to be backend agnostic, though
>>>>> Practically seen, the buffer and the period size setups are mandatory,
>>>>> yes.  Here is the question whether you want to limit them by list
>>>>> (e.g. read via some XENSND_* protocol), or negotiate the size at each
>>>>> hw_params setup (e.g. getting only min/max at open, and at each
>>>>> hw_params call, negotiate with the backend for period and buffer size
>>>>> changes).
>>>> The problem I see here is that at .open real HW driver
>>>> already knows its constraints and can properly setup.
>>>> So, in our case at open we should already have all the
>>>> constraints available to the frontend as well.
>>>> That will lead to lots of text in domain configuration file
>>>> if propagated via XenStore (e.g. you have to put all possible
>>>> combinations of buffers/periods depending on number of
>>>> channels, sample rates etc., you cannot use logic here as you can
>>>> in a real HW driver, only values). So, such configuration doesn't
>>>> seem to be an option here.
>>> It depends.  If we do limit the configuration intentionally to only
>>> some subsets that should suffice for most use cases, then the list
>>> would be relatively short.
>> Ok, if we go with a limited set of supported buffer/period
>> sizes (and number of channels?), what could a constraint entry
>> look like? E.g. [buffer, period, num_channels, xxx]
>> What is that xxx in question? Sample rate, sample format,
>> anything else? Or [buffer, period, num_channels, rate, format]
>> is enough?
> The buffer, period, channels, rate and format are the basic
> parameters, and that should be enough for 99.9% cases.
Excellent, will use this set as the constraint entry.
Just to clarify for the upcoming Xen sound protocol change:
the values in this constraint are not ALSA specific and
could be used in implementation/OS agnostic Xen protocol.
>> I am still thinking on having the above sent at run-time with
>> a new protocol command, which I will call on .open, so I can
>> apply the constraints where most of the drivers do.
>> This way backend can also determine its capabilities at run-time
>> and report those to the frontend, as a bonus eliminating the
>> need for huge domain configuration file/XenStore entries.
> You don't have to list up all combinations of the parameters above at
> open time.  For example, declaring min/max of each of them at open
> would suffice at first.  (But this min/max might be even unnecessary
> if we implement the proper hw constraints.  See below)
>
> The rest fine-tuning is done via the hw constraints...
>
>>>> If we decide to negotiate the parameters, then it can't be done
>>>> at .open stage as well, as at this moment we don't know stream
>>>> parameters yet, e.g. we don't know the number of channels, PCM
>>>> format etc., so we cannot explain to the backend what we want.
>>>> Thus, it seems that we need to move the negotiation to .hw_params
>>>> callback where stream properties are known. But this leaves the
>>>> only option to ask the backend if it can handle the requested
>>>> buffer/period and other parameters or not... This is what I do now :(
>>> The additional parameter setup can be done via hw_constraints.  The hw
>>> constraint is basically a function call for each parameter change to
>>> narrow down the range of the given parameter.
>>>
>>> snd_pcm_hw_constraint_integer() in the above is just an example.
>>> The actual function to adjust values can be freely written.
>> Yes, this is clear, the question here mostly was not
>> *how* to set the constraints, but *where* to get those
> ... and here comes the hw constraint into the play.
>
> For each parameter change, for example, the frontend just passes the
> inquiry to the backend.  The basis of the hw constraint is nothing but
> to reduce the range of the given parameter.  It's either interval
> (range, used for period/buffer size or sample rate) or the list (for
> the format).  When any parameter is changed, ALSA PCM core invokes the
> corresponding hw constraint function, and the function reduces the
> range.  It's repeated until all parameters are set and settled down.
>
> So, for your driver, the frontend just passes the hw constraint for
> each of basic 5 parameters to the backend.  For example, at beginning,
> the hw constraint for the buffer size will pass the range (1,INTMAX).
> Then the backend returns the range like (1024,65536).   This already
> gives users the min/max buffer size information.  The similar
> procedure will be done for all other parameters.
>
> In addition, you can put the implicit rule like the integer periods,
> which makes things easier.
>
Thank you very much for such a detailed explanation.
Could you please give me an example of ALSA driver which
code I can read in order to understand how it is supposed
to be used, e.g. which meets the expectations we have for
Xen PV sound driver?
>>>> Am I missing something here?
>>>>> The format, the channels and the sample rate are already included in
>>>>> snd_pcm_hardware setup, so this should be OK, unless they have
>>>>> implicit limitations with each other (e.g. some format is available
>>>>> only under some rate).
>>>> Thank you, this should be up to the one who sets up the
>>>> domain configuration. Taking into account embedded nature of
>>>> our use-cases this is almost always doable, as these are
>>>> defined at system design time, e.g. we define number of channels
>>>> and their properties depending on domain functionality and needs.
>>>>> Maybe the channels need to be revisited, though; usually you can't
>>>>> handle all number of channels between min and max but only even
>>>>> numbers or such.
>>>> But if backend can implement some fancy stuff with software
>>>> mixing etc... This is why I didn't limit on that
>>> But if the backend doesn't support fancy numbers like 3 channels?
>>> That's the same situation as buffer / periods.  The frontend needs to
>>> know exactly what configuration the backend would allow.
>> Ok, did I understand you correctly that you see it as
>> described above, e.g. backend communicates (limited)
>> set of constraints to the frontend, so frontend sets
>> these constraints at .open?
> Well, what set at the open time is only the constraint "rule".
> And the rule is a function call, not necessarily static.
> The actual parameters are determined at hw_params call time, and this
> is called even repeatedly.
I need some time to think about all the above ;)
>> The way these are communicated could be either XenStore/
>> domain configuration or extension to the protocol, no preference
>> from your side?
> Again, the parameter setup pretty depends on the hardware, and in this
> case, the backend (and its communication).
>
>
> Takashi
Thank you!
Oleksandr
