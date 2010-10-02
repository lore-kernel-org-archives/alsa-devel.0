From: "Sebastian H." <vand2@gmx.de>
Subject: Re: asihpi: Control naming
Date: Sat, 02 Oct 2010 13:10:25 +0200
Message-ID: <4CA71321.7030804@gmx.de>
References: <4CA4078E.6010601@audioscience.com>
	<s5h62xng4wm.wl%tiwai@suse.de>	<4CA4F1D8.50800@audioscience.com>
	<s5haamz9che.wl%tiwai@suse.de>	<4CA5010E.4050705@gmx.de>
	<4CA58856.8070505@ladisch.de>	<4CA5C69B.4000703@gmx.de>
	<4CA5DFFC.40004@ladisch.de>	<4CA63F38.7000307@gmx.de>
	<AANLkTikZ7tHB2YhBT496DSvSCE85Qm-s3dfVLPVwCXLb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mailout-de.gmx.net [213.165.64.23])
	by alsa0.perex.cz (Postfix) with SMTP id 47980245D6
	for <alsa-devel@alsa-project.org>;
	Sat,  2 Oct 2010 13:12:02 +0200 (CEST)
In-Reply-To: <AANLkTikZ7tHB2YhBT496DSvSCE85Qm-s3dfVLPVwCXLb@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Am 02.10.2010 06:10, schrieb Raymond Yau:
> 2010/10/2 Sebastian H. <vand2@gmx.de>
> 
>> Am 01.10.2010 15:19, schrieb Clemens Ladisch:
>>> Sebastian H. wrote:
>>>> Am 01.10.2010 09:05, schrieb Clemens Ladisch:
>>>>> Those are elements where the simple mixer code doesn't know the
>>>>> direction (because the driver author didn't put "Playback" or "Capture"
>>>>> into the name).
>>>>
>>>> Ok, but I wonder how to interpret this state in which both functions
>>>> return zero.
>>>
>>> There are cases where the playback/capture direction is obvious from the
>>> name ("just implement an AI!"), but these can be considered bugs.
>>
>> Ok, I'll stick to the element name list from Raymond then for an
>> automated detection.
>>
> 
> I just only mention the keywords in those capture controls in sound card
> drivers.
> They may have slightly different name (e.g. 'Mic Boost (+20dB)' , 'Front Mic
> Boost' )
> 

For sure, I won't do an exact match comparison but rather look for
occurences of a "Mic" strings or so.

> In simple_none.c , it also defined some keywords for stanard ac97 control
> too

Thanks, I'll have a look into that one.

The whole issue is probably no big deal at all. In the worst case the
elements just ends up in the playback page.

> some of them are used (e.g. "3D Control - Switch" is regarded a pswitch) but
> "Depth and Rear Depth are regarded as volume )
> 
> 
> Simple mixer control '3D Control - Switch',0
>   Capabilities: pswitch pswitch-joined penum
>   Playback channels: Mono
>   Mono: Playback [off]
> Simple mixer control '3D Control Sigmatel - Depth',0
>   Capabilities: volume volume-joined penum
>   Playback channels: Mono
>   Capture channels: Mono
>   Limits: 0 - 3
>   Mono: 0 [0%]
> Simple mixer control '3D Control Sigmatel - Rear Depth',0
>   Capabilities: volume volume-joined penum
>   Playback channels: Mono
>   Capture channels: Mono
>   Limits: 0 - 3
>   Mono: 0 [0%]
> 
> They are just 3D effect and have no dB information.
> 
> However alsa-python return run-time error when you try to use the function
> get_volume_range_dB() to find out whether the mixer elem has dB Info or not

The ambiguity can only appear for enum elements because the following
functions allow uncertain return value combinations.

snd_mixer_selem_is_enumerated ( ... )
snd_mixer_selem_is_enum_playback ( ... )
snd_mixer_selem_is_enum_capture ( ... )

Volumes and Switches are always playback and/or capture
because they can be detected by direction aware functions.

snd_mixer_selem_has_playback_volume ( ... )
snd_mixer_selem_has_capture_volume ( ... )

snd_mixer_selem_has_playback_switch ( ... )
snd_mixer_selem_has_capture_switch ( ... )

Sebastian
