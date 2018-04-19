From: Hui Wang <hui.wang@canonical.com>
Subject: Re: [alsa-devel] [PATCH 1/2] ALSA: hda/realtek - set
 PINCFG_HEADSET_MIC to parse_flags
Date: Thu, 19 Apr 2018 18:54:02 +0800
Message-ID: <a194773e-9040-73f2-a790-ae8ef2448696@canonical.com>
References: <1524115745-7868-1-git-send-email-hui.wang@canonical.com>
 <s5hfu3rzfyp.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <s5hfu3rzfyp.wl-tiwai@suse.de>
Content-Language: en-US
Sender: stable-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 2018年04月19日 17:46, Takashi Iwai wrote:
> On Thu, 19 Apr 2018 07:29:04 +0200,
> Hui Wang wrote:
>> Otherwise, the pin will be regarded as microphone, and the jack name
>> is "Mic Phantom", it is always on in the pulseaudio even nothing is
>> plugged into the jack. So the UI is confusing to users since the
>> microphone always shows up in the UI even there is no microphone
>> plugged.
>>
>> After adding this flag, the jack name is "Headset Mic Phantom", then
>> the pulseaudio can handle its detection correctly.
>>
>> Cc: <stable@vger.kernel.org>
>> Signed-off-by: Hui Wang <hui.wang@canonical.com>
> Applied now.
> But at the next time, please put "Fixes:" tag pointing to the commit
> that introduced the problem.  In this case, it was f0ba9d699e5c.
Got it. Thanks.

>
> thanks,
>
> Takashi
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
