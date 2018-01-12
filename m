From: "Kumar, Abhijeet" <abhijeet.kumar@intel.com>
Subject: Re: [PATCH] ASoC: hdac_hdmi: Ensuring proper setting
 of output widget power state
Date: Fri, 12 Jan 2018 13:55:54 +0530
Message-ID: <d84bdde7-2eda-ab2b-adce-b689b4222838@intel.com>
References: <1515670468-9198-1-git-send-email-abhijeet.kumar@intel.com>
 <20180112054638.GL18649@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 521B4266F50
 for <alsa-devel@alsa-project.org>; Fri, 12 Jan 2018 09:25:59 +0100 (CET)
In-Reply-To: <20180112054638.GL18649@localhost>
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
To: Vinod Koul <vinod.koul@intel.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Guneshwor Singh <guneshwor.o.singh@intel.com>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jeeja KP <jeeja.kp@intel.com>, Sandeep Tayal <sandeepx.tayal@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org



On 1/12/2018 11:16 AM, Vinod Koul wrote:
> On Thu, Jan 11, 2018 at 05:04:27PM +0530, abhijeet.kumar@intel.com wrote:
>> From: Abhijeet Kumar <abhijeet.kumar@intel.com>
>>
>> When we change the resolution of DP pannel or hot plug-unplug it while
>> playing an audio clip,sometimes we observe a silent playback(no audio).
> can you rephrase this please
done please review v2!
>> During no audio condition, we have noticed that the power state of the
>> pin or the connector is D3. Optimzing the way we set the power could
>> mitigate the issue.With this changes the verb is sent to set the power
> space after .
>
>> state and response is received. Thus ensuring power state is set.
> am not sure I fully understood the problem here

This appears to be an timing issue, while performing a stress test, we 
found out that sometimes either pin or converters are not powered up. 
Thus ensuring it that the power state is set correctly.

>
>> Signed-off-by: Abhijeet Kumar <abhijeet.kumar@intel.com>
>> ---
>>   sound/soc/codecs/hdac_hdmi.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
>> index f3b4f4dfae6a..e24caecf0a4f 100644
>> --- a/sound/soc/codecs/hdac_hdmi.c
>> +++ b/sound/soc/codecs/hdac_hdmi.c
>> @@ -718,7 +718,7 @@ static void hdac_hdmi_set_power_state(struct hdac_ext_device *edev,
>>   {
>>   	if (get_wcaps(&edev->hdac, nid) & AC_WCAP_POWER) {
>>   		if (!snd_hdac_check_power_state(&edev->hdac, nid, pwr_state))
>> -			snd_hdac_codec_write(&edev->hdac, nid, 0,
>> +			snd_hdac_codec_read(&edev->hdac, nid, 0,
> how does read help instead of write?

Indeed i'm making use of read instead of write to send the set command.

But unlike codec_write, codec_read send the verb synchronously. Maybe if 
you read the comment while powering up and down in hdmi_codec_prepare 
and hdmi_codec_complete you would understand better.

"codec_read is preferred over codec_write to set the power state.

This way verb is send to set the power state and response is received. 
So setting power state is ensured without using loop to read the state."

>
