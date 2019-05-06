From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [RFC PATCH] ASoC: codec: hdac_hdmi: no checking
 monitor in hw_params
Date: Mon, 6 May 2019 10:54:02 -0500
Message-ID: <e735010d-f6c0-5b20-98bb-ecfa52b8cfe8@linux.intel.com>
References: <1557125960-29353-1-git-send-email-libin.yang@intel.com>
 <bebcb1f6-1d8b-63aa-a22d-b48047b64809@linux.intel.com>
 <s5hzhnz3817.wl-tiwai@suse.de>
 <5286a2bd-cb71-8094-84d5-6ac2ad2b1c02@linux.intel.com>
 <s5hwoj337lw.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9F93FF80C07
 for <alsa-devel@alsa-project.org>; Mon,  6 May 2019 17:54:05 +0200 (CEST)
In-Reply-To: <s5hwoj337lw.wl-tiwai@suse.de>
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: libin.yang@intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, subhransu.s.prusty@intel.com, samreen.nilofer@intel.com
List-Id: alsa-devel@alsa-project.org

On 5/6/19 10:50 AM, Takashi Iwai wrote:
> On Mon, 06 May 2019 17:47:25 +0200,
> Pierre-Louis Bossart wrote:
>>
>> On 5/6/19 10:41 AM, Takashi Iwai wrote:
>>> On Mon, 06 May 2019 17:37:32 +0200,
>>> Pierre-Louis Bossart wrote:
>>>>
>>>> On 5/6/19 1:59 AM, libin.yang@intel.com wrote:
>>>>> From: Libin Yang <libin.yang@intel.com>
>>>>>
>>>>> This patch move the check of monitor from hw_params to trigger callback.
>>>>>
>>>>> The original code will check the monitor presence in hw_params. If the
>>>>> monitor doesn't exist, hw_params will return -ENODEV. Mostly this is OK.
>>>>>
>>>>> However, pulseaudio will check the pcm devices when kernel is booting up.
>>>>> It will try to open, set hw_params, prepare such pcm devices. We can't
>>>>> guarantee that the monitor will be connected when kernel is booting up.
>>>>> Especially, hdac_hdmi will export 3 pcms at most. It's hard to say users
>>>>> will connect 3 monitors to the HDMI/DP ports. This will cause pulseaudio
>>>>> fail in parsing the pcm devices because the driver will return -ENODEV in
>>>>> hw_params.
>>>>>
>>>>> This patch tries to move the check of monitor presence into trigger
>>>>> callback. This can "trick" the pulseaudio the pcm is ready.
>>>>>
>>>>> This bug is found when we try to enable HDMI detection in
>>>>> gnome-sound-setting for ASoC hdac_hdmi. After we enable the hdmi in UCM,
>>>>> pulseaudio will try to parse the hdmi pcm devices. It will cause failure if
>>>>> there are no monitors connected.
>>>>
>>>> Out of curiosity, how is this handled in the legacy driver? I haven't
>>>> done this for a long time but I remember very clearly being able to
>>>> play on the HDMI:3,7, etc devices without any monitors
>>>> connected. You'd get of course no sound but there was no error
>>>> reported to userspace. The hardware is perfectly capable of pushing
>>>> samples into the display controller using the HDAudio/iDisp link.
>>>
>>> As mentioned in the thread, PA just picks up the stream that is
>>> connected via a monitor by checking / notified by the corresponding
>>> Jack control.  On hdac_hdmi driver, the jack control has different
>>> base name that is irrelevant with the output pins, so PA doesn't know
>>> how to interpret it, hence it's ignored.
>>
>> Yes, but do we have any error checks in the hw_params or trigger cases
>> with the legacy driver?
> 
> No, it just continues playing without the actual output.

ok, so could we remove all these error checks then for hdac_hdmi? The 
problem is really the output selection on jack detect/monitor 
reconfigurations, those checks don't add much value, do they?
