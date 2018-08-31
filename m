From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [RFC - AAF PCM plugin 3/5] aaf: Implement Playback
	mode support
Date: Fri, 31 Aug 2018 13:33:54 +0900
Message-ID: <0b596f65-d71d-0999-c817-3fb76f055e95@sakamocchi.jp>
References: <20180821010653.15838-1-andre.guedes@intel.com>
 <20180821010653.15838-4-andre.guedes@intel.com>
 <294236b7-ace1-af42-508a-635fe9709f0e@linux.intel.com>
 <1534888610.4547.104.camel@intel.com>
 <8211a507-da5e-8504-a048-2ec86dbfbf4b@linux.intel.com>
 <1534985162.3235.50.camel@intel.com>
 <73a0095c-b58c-366b-424b-c2c518fd6f70@linux.intel.com>
 <1535049162.3323.5.camel@intel.com>
 <d553d212-d3ce-ec5f-86f3-062cd51d50ec@sakamocchi.jp>
 <1535504395.3198.7.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com
 [209.85.215.180])
 by alsa0.perex.cz (Postfix) with ESMTP id 28606267668
 for <alsa-devel@alsa-project.org>; Fri, 31 Aug 2018 06:33:58 +0200 (CEST)
Received: by mail-pg1-f180.google.com with SMTP id b129-v6so4864112pga.13
 for <alsa-devel@alsa-project.org>; Thu, 30 Aug 2018 21:33:58 -0700 (PDT)
In-Reply-To: <1535504395.3198.7.camel@intel.com>
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
To: "Guedes, Andre" <andre.guedes@intel.com>, "pierre-louis.bossart@linux.intel.com" <pierre-louis.bossart@linux.intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: "Girdwood, Liam R" <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org

Hi Guedes,

On Aug 29 2018 10:00, Guedes, Andre wrote:
> On Sat, 2018-08-25 at 17:13 +0900, Takashi Sakamoto wrote:
>> On Aug 24 2018 03:32, Guedes, Andre wrote:
>>> On Wed, 2018-08-22 at 21:25 -0500, Pierre-Louis Bossart wrote:
>>>> On 08/22/2018 07:46 PM, Guedes, Andre wrote:
>>>>> On Tue, 2018-08-21 at 17:51 -0500, Pierre-Louis Bossart wrote:
>>>>>>>>> +static int aaf_mclk_start_playback(snd_pcm_aaf_t *aaf)
>>>>>>>>> +{
>>>>>>>>> +	int res;
>>>>>>>>> +	struct timespec now;
>>>>>>>>> +	struct itimerspec itspec;
>>>>>>>>> +	snd_pcm_ioplug_t *io = &aaf->io;
>>>>>>>>> +
>>>>>>>>> +	res = clock_gettime(CLOCK_REF, &now);
>>>>>>>>> +	if (res < 0) {
>>>>>>>>> +		SNDERR("Failed to get time from
>>>>>>>>> clock");
>>>>>>>>> +		return -errno;
>>>>>>>>> +	}
>>>>>>>>> +
>>>>>>>>> +	aaf->mclk_period = (NSEC_PER_SEC * aaf-
>>>>>>>>>> frames_per_pkt) /
>>>>>>>>>
>>>>>>>>> io->rate;
>>>>>>>>
>>>>>>>> is this always an integer? If not, don't you have a
>>>>>>>> systematic
>>>>>>>> arithmetic error?
>>>>>>>
>>>>>>> NSEC_PER_SEC is 64-bit so I don't see an arithmetic error
>>>>>>> during
>>>>>>> calculation (e.g. integer overflow). Not sure this was your
>>>>>>> concern,
>>>>>>> though. Let me know otherwise.
>>>>>>
>>>>>> No, I was talking about the fractional part, e.g with 256
>>>>>> frames
>>>>>> with
>>>>>> 44.1kHz you have a period of 5804988.662131519274376 - so
>>>>>> your
>>>>>> math
>>>>>> adds
>>>>>> a truncation. same with 48khz, the fractional part is .333
>>>>>>
>>>>>> I burned a number of my remaining neurons chasing a <100 ppb
>>>>>> error
>>>>>> which
>>>>>> led to underruns after 10 hours, so careful now with
>>>>>> truncation...
>>>>>
>>>>> Thanks for clarifying.
>>>>>
>>>>> Yes, we can end up having a fractional period which is
>>>>> truncated.
>>>>> Note
>>>>> that both 'frames' and 'rate' are configured by the user. The
>>>>> user
>>>>> should set 'frames' as multiple of 'rate' whenever possible to
>>>>> avoid
>>>>> inaccuracy.
>>>>
>>>> It's unlikely to happen. it's classic in audio that people want
>>>> powers
>>>> of two for fast filtering, and don't really care that the periods
>>>> are
>>>> fractional. If you cannot guarantee long-term operation without
>>>> timing
>>>> issues, you should add constraints to the frames and rates so
>>>> that
>>>> there
>>>> is no surprise.
>>>
>>> Fair enough. So for now I'll add a constraint on frames and rates
>>> to
>>> unsure no surprises. Later we can revisit this and implement the
>>> compesation mechanism you described below.
>>
>> In my understanding, transmission timing of 'AVTP Audio format' in
>> IEEE
>> 1722:2016 is similar to 'blocking transmission' of IEC 61883-6.
>> Packets
>> have fixed size of data in its payload, thus include the same number
>> of
>> PCM frames. Talkers are expected to fill data till the size, then
>> transmit the packet. Receivers are expected to perform buffering till
>> presentation timestamp is elapsed, with one (or more) AVTPDUs.
> 
> I'm not familiar with the 'blocking transmission' of IEC 61883-6 but
> from the description above, yes, it looks similar indeed.

Further investigation, I realized that transmission timing of AAF is
not similar to IEC 61883-1/6 at all... I'm sorry to address to it into
this topic.

>> In clause 7.7 'AAF and SRP', I can see below sentence:
>> '... A 44.1-kHz stream with 6 samples per AAF AVTPDU and an FQTSS
>> observation interval of 125 us also has an SRP reservation of 1
>> frame
>> per observation interval even though there will periodically be an
>> observation interval where no AAF AVTPDU will be transmitted since
>> it has a transmission interval of 136.054 us as can be seen in the
>> example given in Figure 36.' This means that packet transmission is
>> not always periodically. There's a blank cycle per several cycles;
>> like
>> IEC 61883-1/6.
> 
> My understanding of the periodicity of packet transmission is
> different. I believe it is always periodic. Let me elaborate on this.
> 
> The first paragraph from Section 7.7 states that "AAF transmission
> interval is defined by the clock rate of the media rather than the
> FQTSS observation interval." Since the clock is periodic, the AAF
> transmission interval is periodic too. For instance, if we take the
> 44.1 kHz example from Figure 36, we can see the AAF transmission
> interval is always ~136us. So, from AAF perspective (i.e. the plugin
> perspective), the packet transmission is always periodic.
> 
> The AAF transmission interval isn't necessarily equal to the FQTSS
> observation interval. Again, if we take a look at the 44.1 kHz example,
> we can see the AAF transmission interval is ~136us while the FQTSS
> observation interval is 125us.  This, however, isn't an issue since the
> plugin is not expected to operate in terms of FQTSS observation
> interval, but in terms of AAF transmission interval as stated in the
> first paragraph from Section 7.7.

Indeed, thanks for your correction against my misunderstanding.

>> In my opinion, it's better calculate proper interval of timerfd to
>> create the black interval, without truncate the fraction. Then, give
>> proper constrains to SND_PCM_IOPLUG_HW_PERIOD_BYTES to prevent
>> applications from underrun.
> 
> If the above understanding is correct, I'm not sure this approach would
> work. Let me know otherwise.

I have another concern of buffering in a perspectives of delay of task
scheduling.

The interval of task scheduling for this plugin is decided mainly by
the value of 'frames_per_pkt', given by users. In your documentation,
the value is 6[1]. Of cource this is an example but in this case the
interval is calculated as 125us at 48.0kHz. In my opinion, task
scheduling in Linux kernel brings deadline misses for the interval,
in most cases such as major Linux distribution on usual personal
computers. When considering about the fact that recent motherboards
implements Intel I210/220 series, it's better to care for the low-level
realtime systems, in my opinion.

>> Furthermore, in your proposal, the number of PCM frames in one AVTPDU
>> is
>> decided according to plugin parameter. However, if compliant to
>> specification, it's better to decide the number according to 'FQTSS
>> observation interval'. I can see recommendations in two cases;
>> FQTSS = 125 us and 256 us, in Table 17 and 18 of IEEE 1212:2016.
> 
> It was designed that way on purpose. Let me share the rationale.
> 
> The values in Table 17 and 18 are just recommendations. From the plugin
> perspective, we should enable users to configure the number of frames
> according to their needs. This way, users are free to configure the
> values recommended by the spec or other values optimized to their AVTP
> application.
> 
> Besides that, as stated in the NOTE right below Table 18, 125us and
> 250us are not the only possible FQTSS observation intervals.

I addressed to the reccomendation itself. If specification describes
recommendations, there will be a reason to consider about it, just not
refer to values on the table.

I can see a sentence in section 7.7; 'in order to maintain
interoperability between devices, the transmission intervals listed in
Table 17 and Table 18 should be used.' I understand that 'if a talker
end station transfers an AVTP packet with largely different number of
sample frames from expectations on listener end station, there's a case
that the listener cannot handles the sample frames due to processor
loading or buffer overflow on listener side. To avoid this case, FQTSS
observation interval is loosely used to decide intervals of AVTPDU
transmission'. But it's within my imagination.

[1] 
http://mailman.alsa-project.org/pipermail/alsa-devel/2018-August/139495.html


Thanks

Takashi Sakamoto
