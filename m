From: Rajeev kumar <rajeev-dlh.kumar@st.com>
Subject: Re: Exporting playback and capture capability to user
 space
Date: Mon, 9 Jan 2012 12:01:41 +0530
Message-ID: <4F0A89CD.9000602@st.com>
References: <4E65E934.2070706@st.com>
	<20110906180138.GC2924@opensource.wolfsonmicro.com>
	<4E66EFC3.2070706@st.com> <4EC50DB2.6090009@st.com>
	<4EC9E656.1050706@st.com> <1321856626.1516.208.camel@vkoul-udesk3>
	<4ECB24C7.4080908@st.com> <4ED8AD60.6060000@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog116.obsmtp.com (eu1sys200aog116.obsmtp.com
	[207.126.144.141])
	by alsa0.perex.cz (Postfix) with ESMTP id D1962103966
	for <alsa-devel@alsa-project.org>; Mon,  9 Jan 2012 07:32:01 +0100 (CET)
In-Reply-To: <4ED8AD60.6060000@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@linux.intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On 12/2/2011 4:20 PM, Rajeev kumar wrote:
> Hello Vinod,
>
> On 11/22/2011 9:57 AM, Rajeev kumar wrote:
>> Hello Vinod, Mark
>>
>>
>> On 11/21/2011 11:53 AM, Vinod Koul wrote:
>>> On Mon, 2011-11-21 at 11:19 +0530, Rajeev kumar wrote:
>>>> Hello Mark
>>>>
>>>> Could you please help me by answering these questions?
>>>>
>>>> Best Regards
>>>> Rajeev
>>>>
>>> Pls don't top-post!!
>>>> On 11/17/2011 7:05 PM, Rajeev kumar wrote:
>>>>> Hello Mark
>>>>>
>>>>> I have a single codec with playback and capture capability. We are
>>>>> using
>>>>> it for different i2s controller. Below are the details for that.
>>>>>
>>>>> case 1: I2S controller-1: with playback and capture capability
>>>>> case 2: I2S controller-2: with playback capability only
>>>>> case 3: I2S controller-3: with capture capability only.
>>>>>
>>>>> We are registering all the I2S controller with there respective
>>>>> capability.
>>>>>
>>>>> In command 'aplay -l' or 'cat /proc/asound/pcm', among playback
>>>>> devices,
>>>>> capture device is also listed. This is true in case-1 but for case-2
>>>>> and
>>>>> case-3 also it is showing the same behavior. According to my
>>>>> understanding it should not show the list of all devices i.e. in
>>>>> case of
>>>>> controller having playback capability it should show only playback
>>>>> devices not capture devices and vice versa. Please correct me if I am
>>>>> wrong.
>>>>>
>>>>> So my questions are
>>>>> 1. How to separate playback and capture devices in case-2 and case-3.
>>>>> Are we need to register different codec for different i2s controller?
>>> How asoc builds this is based on dailinks you have provided. If for the
>>> device 2 and device 3 the cpu and codec dais support both playback and
>>> capture devices, it will go ahead and register these device.
>>> The fact that for device 2 and device 3 capture is also registered
>>> suggests me that your cpu dais are not correct.
>>>
>>> Would help if you post your code, esp the codec, cpu dais and dialinks.
>>>
>>
>> Codec dai:
>>
>> static struct snd_soc_dai_driver sta529_dai = {
>> .name = "sta529-audio",
>> .playback = {
>> .stream_name = "Playback",
>> .channels_min = 2,
>> .channels_max = 2,
>> .rates = SPEAR_PCM_RATES,
>> .formats = SPEAR_PCM_FORMAT,
>> },
>> .capture = {
>> .stream_name = "Capture",
>> .channels_min = 2,
>> .channels_max = 2,
>> .rates = SPEAR_PCM_RATES,
>> .formats = SPEAR_PCM_FORMAT,
>> },
>> .ops = &sta529_dai_ops,
>> };
>>
>> cpu dai: In case of cpu dai, we are passing the playback and capture
>> capability from the platform code and depending on the capability we are
>> filling the cpu dai structure in probe function, like
>>
>> if (cap & PLAY) {
>>
>> /* Fill Playback capability */
>> }
>>
>> if (cap & RECORD) {
>> /* Fill Capture capability */
>> }
>>
>> dai links:
>>
>> static struct snd_soc_dai_link spear_evb_dai[] = {
>> {
>> .name = "sta529-pcm0",
>> .stream_name = "I2S Playback",
>> .cpu_dai_name = "designware-i2s.0",
>> .platform_name = "spear-pcm-audio",
>> .codec_dai_name = "sta529-audio",
>> .codec_name = "sta529-codec.0-001a",
>> .ops = &sta529_ops,
>> }, {
>> .name = "sta529-pcm1",
>> .stream_name = "I2S Capture",
>> .cpu_dai_name = "designware-i2s.1",
>> .platform_name = "spear-pcm-audio",
>> .codec_dai_name = "sta529-audio",
>> .codec_name = "sta529-codec.0-001a",
>> .ops = &sta529_ops,
>> },
>> };
>>
>> static struct snd_soc_card spear_snd_card = {
>> .name = "spear-evb",
>> .dai_link = spear_evb_dai,
>> .num_links = ARRAY_SIZE(spear_evb_dai),
>> };
>>
>
> I had actually missed the last mail by mark. I dont know why? . So sorry
> for replying on the top of this mail.
>
> Vinod, have you gone through the cpu_dai, codec_dai and dailink ? Could
> you please make any suggestion?
>

Ping

> Best Regards
> ~Rajeev
>
>
>
>> Best Regards
>> ~Rajeev
>
