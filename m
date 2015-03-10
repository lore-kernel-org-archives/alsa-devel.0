From: Jyri Sarha <jsarha@ti.com>
Subject: Re: [PATCH 2/2] ASoC: simple-card: Add support for
 samplerate and samplewidth constraints
Date: Tue, 10 Mar 2015 17:25:30 +0200
Message-ID: <54FF0CEA.6040007@ti.com>
References: <cover.1425303942.git.jsarha@ti.com>
 <9d01aa0d0bf48d8b41d5086a7e6c9ec08c2b9c48.1425303942.git.jsarha@ti.com>
 <54F4C0F2.8000201@metafoo.de> <54F5884A.1090702@ti.com>
 <20150303113041.GM21293@sirena.org.uk> <54F5A25F.6090904@ti.com>
 <54F5D3C2.20705@metafoo.de> <54F6B8D0.4070904@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
 by alsa0.perex.cz (Postfix) with ESMTP id 83B13261567
 for <alsa-devel@alsa-project.org>; Tue, 10 Mar 2015 16:25:36 +0100 (CET)
In-Reply-To: <54F6B8D0.4070904@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>, Mark Brown <broonie@kernel.org>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, kuninori.morimoto.gx@renesas.com, peter.ujfalusi@ti.com, moinejf@free.fr, liam.r.girdwood@linux.intel.com, bcousson@baylibre.com
List-Id: alsa-devel@alsa-project.org

On 03/04/15 09:48, Jyri Sarha wrote:
> On 03/03/2015 05:31 PM, Lars-Peter Clausen wrote:
>> On 03/03/2015 01:00 PM, Jyri Sarha wrote:
>>> On 03/03/2015 01:30 PM, Mark Brown wrote:
>>>> On Tue, Mar 03, 2015 at 12:09:14PM +0200, Jyri Sarha wrote:
>>>>> On 03/02/2015 09:58 PM, Lars-Peter Clausen wrote:
>>>>
>>>>>> Can you include a description why this is needed and how and when
>>>>>> it is
>>>>>> supposed to be used?
>>>>
>>>>> Would this addition do:
>>>>> ------------------------------------------------------------
>>>>> These constraints help to disable the sample-format and sample-rate
>>>>> combinations that do not properly work on a specific HW.
>>>>> ------------------------------------------------------------
>>>>
>>>> Not entirely...
>>>>
>>>>> The reason why we need these is coming from limitations in McASP clock
>>>>> generation. With a simple divider one can only produce certain
>>>>> bit-clocks.
>>>>> With those bit-clocks we can only play/capture some sample-rate and
>>>>> sample-width combinations accurately.
>>>>
>>>>> The McASP driver could try to set the constraints automatically.
>>>>> However,
>>>>> since the constraint code can not select sample-width and sample-rate
>>>>> combinations there is a compromise to be made between them. Making
>>>>> such
>>>>> compromises automatically does not usually work that well.
>>>>
>>>> ...this is more the point.  Perhaps the constraints language needs
>>>> improvement here?
>>>>
>>>
>>> Improving constraint functionality would certainly help, however the way
>>> that code works is beyond my understanding and I do not believe such an
>>> improvement would be coming from anybody else any time soon either.
>>
>> Restricting the available sample formats based on the sample rate and
>> vice versa is possible with the current constraint framework. Take a
>> look at what Peter Rosin recently did to the pcm512x driver. Your
>> restrictions sound very similar to what he did.
>>
>
> Interesting. It indeed looks like the rule functionality could do what I
> want. I'll look into than. Thanks!
>

I went ahead and implemented in mcasp driver a similar rule to the one 
already found from pcm512x. The rule indeed forbids the sample-rate and 
fame-size combinations that can not be played accurately.

However, once a user tries to play a bad sample-rate and fame-size 
combination, aplay greets him with:

aplay: pcm_params.c:170: snd1_pcm_hw_param_get_min: Assertion 
`!snd_interval_empty(i)' failed.

And even worse, playing to plughw gives the same error. So in practice 
the rule is pretty useless. The user is in the same situation as before: 
His use-case does not work and he has no idea why.

I guess in the long run the ideal solution would making the user-space 
behave better in such a situation, but for now I thing a human selected 
constraints are the only proper way to solve the problem.

Putting the constraints into dts may not be the most elegant choice, so 
I look into adding a new compatible match for each new card and hard 
code the DAI-link configurations for each match in the code instead of dts.

I'll send the rule patch too (as soon as I have it cleaned it up) as it 
does hurt to have it, even if it is not enough to make all the 
configurations properly usable.

Best regards,
Jyri
