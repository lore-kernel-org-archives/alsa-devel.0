From: Michael Trimarchi <trimarchi@gandalf.sssup.it>
Subject: Re: Fixed Re: amp power down event (resend with the
 correct email)
Date: Tue, 10 Aug 2010 09:13:36 +0200
Message-ID: <4C60FC20.8040002@gandalf.sssup.it>
References: <4C604381.2080000@gandalf.sssup.it>
	<4C60FADF.8010608@gandalf.sssup.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sssup.it (ms01.sssup.it [193.205.80.99])
	by alsa0.perex.cz (Postfix) with ESMTP id 1FBD324489
	for <alsa-devel@alsa-project.org>;
	Tue, 10 Aug 2010 09:13:38 +0200 (CEST)
Received: from [10.30.3.4] (HELO granpasso.retis)
	by sssup.it (CommuniGate Pro SMTP 5.3.2)
	with ESMTPS id 62421786 for alsa-devel@alsa-project.org;
	Tue, 10 Aug 2010 09:06:27 +0200
Received: from [10.30.3.245] (dhcp245.retis [10.30.3.245])
	by granpasso.retis (8.14.4/8.14.4) with ESMTP id o7A7DaCx047117
	for <alsa-devel@alsa-project.org>;
	Tue, 10 Aug 2010 09:13:37 +0200 (CEST)
	(envelope-from trimarchi@gandalf.sssup.it)
In-Reply-To: <4C60FADF.8010608@gandalf.sssup.it>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


Michael Trimarchi wrote:
> Hi all
>
> Michael Trimarchi wrote:
>   
>> Hi all,
>>
>> I'm t rying to unde rstand when the event a re called.
>>
>> ...
>> SND_SOC_DAPM_SPK("Front Speaker", amp_event),
>>   
>>     
> I have fixed looking in the kernel code. Change this to:
>
> SND_SOC_DAPM_PRE("Front Speaker", amp_event),
>
> Is it correct?
>   
So now:

[  400.894580] widget Right Voice ADC
[  400.894592]  Right Voice Capture stream HiFi Playback event 2
[  400.903667] widget Left Voice ADC
[  400.903673]  Left Voice Capture stream HiFi Playback event 2
[  400.912593] widget Right HiFi ADC
[  400.912599]  Right HiFi Capture stream HiFi Playback event 2
[  400.921514] widget Left HiFi ADC
[  400.921520]  Left HiFi Capture stream HiFi Playback event 2
[  400.930282] widget Aux DAC
[  400.930288]  Aux Playback stream HiFi Playback event 2
[  400.938081] widget Voice DAC
[  400.938087]  Voice Playback stream HiFi Playback event 2
[  400.946232] widget Right DAC
[  400.946237]  Right HiFi Playback stream HiFi Playback event 2
[  400.954813] widget Left DAC
[  400.954819]  Left HiFi Playback stream HiFi Playback event 2
[  400.963617] amp_event: event =>
[  400.966604] OFF

when the stream is closed.

Michael
> Michael
>   
>> ...
>>
>> My idea was:
>>
>> - set the mixe r
>> - open st ream
>>
>> amp_event: event =>
>> [  169.820558] ON
>>
>> - close st ream
>>
>> and receive the event => OFF. In the aplay example this happen
>> afte r some seconds but in my application I don't receive the OFF
>> event. What is w rong?
>>
>> Michael
>>
>> _______________________________________________
>> Alsa-devel mailing list
>> Alsa-devel@alsa-project.org
>> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>>
>>   
>>     
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
>   
