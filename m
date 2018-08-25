From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [RFC - AAF PCM plugin 3/5] aaf: Implement Playback
	mode support
Date: Sat, 25 Aug 2018 17:13:03 +0900
Message-ID: <d553d212-d3ce-ec5f-86f3-062cd51d50ec@sakamocchi.jp>
References: <20180821010653.15838-1-andre.guedes@intel.com>
 <20180821010653.15838-4-andre.guedes@intel.com>
 <294236b7-ace1-af42-508a-635fe9709f0e@linux.intel.com>
 <1534888610.4547.104.camel@intel.com>
 <8211a507-da5e-8504-a048-2ec86dbfbf4b@linux.intel.com>
 <1534985162.3235.50.camel@intel.com>
 <73a0095c-b58c-366b-424b-c2c518fd6f70@linux.intel.com>
 <1535049162.3323.5.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com
 [209.85.210.170])
 by alsa0.perex.cz (Postfix) with ESMTP id 24BED267668
 for <alsa-devel@alsa-project.org>; Sat, 25 Aug 2018 10:13:07 +0200 (CEST)
Received: by mail-pf1-f170.google.com with SMTP id x17-v6so5552117pfh.5
 for <alsa-devel@alsa-project.org>; Sat, 25 Aug 2018 01:13:07 -0700 (PDT)
In-Reply-To: <1535049162.3323.5.camel@intel.com>
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

Hi,

On Aug 24 2018 03:32, Guedes, Andre wrote:
> On Wed, 2018-08-22 at 21:25 -0500, Pierre-Louis Bossart wrote:
>> On 08/22/2018 07:46 PM, Guedes, Andre wrote:
>>> On Tue, 2018-08-21 at 17:51 -0500, Pierre-Louis Bossart wrote:
>>>>>>> +static int aaf_mclk_start_playback(snd_pcm_aaf_t *aaf)
>>>>>>> +{
>>>>>>> +	int res;
>>>>>>> +	struct timespec now;
>>>>>>> +	struct itimerspec itspec;
>>>>>>> +	snd_pcm_ioplug_t *io = &aaf->io;
>>>>>>> +
>>>>>>> +	res = clock_gettime(CLOCK_REF, &now);
>>>>>>> +	if (res < 0) {
>>>>>>> +		SNDERR("Failed to get time from clock");
>>>>>>> +		return -errno;
>>>>>>> +	}
>>>>>>> +
>>>>>>> +	aaf->mclk_period = (NSEC_PER_SEC * aaf-
>>>>>>>> frames_per_pkt) /
>>>>>>>
>>>>>>> io->rate;
>>>>>>
>>>>>> is this always an integer? If not, don't you have a
>>>>>> systematic
>>>>>> arithmetic error?
>>>>>
>>>>> NSEC_PER_SEC is 64-bit so I don't see an arithmetic error
>>>>> during
>>>>> calculation (e.g. integer overflow). Not sure this was your
>>>>> concern,
>>>>> though. Let me know otherwise.
>>>>
>>>> No, I was talking about the fractional part, e.g with 256 frames
>>>> with
>>>> 44.1kHz you have a period of 5804988.662131519274376 - so your
>>>> math
>>>> adds
>>>> a truncation. same with 48khz, the fractional part is .333
>>>>
>>>> I burned a number of my remaining neurons chasing a <100 ppb
>>>> error
>>>> which
>>>> led to underruns after 10 hours, so careful now with
>>>> truncation...
>>>
>>> Thanks for clarifying.
>>>
>>> Yes, we can end up having a fractional period which is truncated.
>>> Note
>>> that both 'frames' and 'rate' are configured by the user. The user
>>> should set 'frames' as multiple of 'rate' whenever possible to
>>> avoid
>>> inaccuracy.
>>
>> It's unlikely to happen. it's classic in audio that people want
>> powers
>> of two for fast filtering, and don't really care that the periods
>> are
>> fractional. If you cannot guarantee long-term operation without
>> timing
>> issues, you should add constraints to the frames and rates so that
>> there
>> is no surprise.
> 
> Fair enough. So for now I'll add a constraint on frames and rates to
> unsure no surprises. Later we can revisit this and implement the
> compesation mechanism you described below.

In my understanding, transmission timing of 'AVTP Audio format' in IEEE
1722:2016 is similar to 'blocking transmission' of IEC 61883-6. Packets
have fixed size of data in its payload, thus include the same number of
PCM frames. Talkers are expected to fill data till the size, then
transmit the packet. Receivers are expected to perform buffering till
presentation timestamp is elapsed, with one (or more) AVTPDUs.

In clause 7.7 'AAF and SRP', I can see below sentence:
'... A 44.1-kHz stream with 6 samples per AAF AVTPDU and an FQTSS
observation interval of 125 us also has an SRP reservation of 1 frame 
per observation interval even though there will periodically be an
observation interval where no AAF AVTPDU will be transmitted since
it has a transmission interval of 136.054 us as can be seen in the
example given in Figure 36.' This means that packet transmission is
not always periodically. There's a blank cycle per several cycles; like
IEC 61883-1/6.

In my opinion, it's better calculate proper interval of timerfd to
create the black interval, without truncate the fraction. Then, give
proper constrains to SND_PCM_IOPLUG_HW_PERIOD_BYTES to prevent
applications from underrun.

Furthermore, in your proposal, the number of PCM frames in one AVTPDU is
decided according to plugin parameter. However, if compliant to
specification, it's better to decide the number according to 'FQTSS
observation interval'. I can see recommendations in two cases;
FQTSS = 125 us and 256 us, in Table 17 and 18 of IEEE 1212:2016.


Regards

Takashi Sakamoto
