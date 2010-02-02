From: Michael Trimarchi <trimarchi@gandalf.sssup.it>
Subject: Re: [Q] playing / recording mono on a stereo-only
	hardware
Date: Tue, 02 Feb 2010 16:25:21 +0100
Message-ID: <4B6843E1.4050001@gandalf.sssup.it>
References: <Pine.LNX.4.64.1001301045500.4260@axis700.grange>
	<4B645E51.900@gandalf.sssup.it>
	<Pine.LNX.4.64.1001301744580.9593@axis700.grange>
	<4B683B48.1030707@gandalf.sssup.it>
	<Pine.LNX.4.64.1002021552450.6324@axis700.grange>
	<4B683DDC.5030209@gandalf.sssup.it>
	<Pine.LNX.4.64.1002021606340.6324@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sssup.it (ms01.sssup.it [193.205.80.99])
	by alsa0.perex.cz (Postfix) with ESMTP id DF23B24436
	for <alsa-devel@alsa-project.org>; Tue,  2 Feb 2010 16:25:29 +0100 (CET)
In-Reply-To: <Pine.LNX.4.64.1002021606340.6324@axis700.grange>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Guennadi Liakhovetski wrote:
> On Tue, 2 Feb 2010, Michael Trimarchi wrote:
>
>   
>> Guennadi Liakhovetski wrote:
>>     
>>> (re-adding the list)
>>>
>>> On Tue, 2 Feb 2010, Michael Trimarchi wrote:
>>>
>>>   
>>>       
>>>> Hi,
>>>>
>>>> Guennadi Liakhovetski wrote:
>>>>     
>>>>         
>>>>> On Sat, 30 Jan 2010, Michael Trimarchi wrote:
>>>>>
>>>>>         
>>>>>           
>>>>>> Guennadi Liakhovetski wrote:
>>>>>>             
>>>>>>             
>>>>>>> Hi
>>>>>>>
>>>>>>> I know this question belongs rather to alsa-users, and I did ask it
>>>>>>> there,
>>>>>>> but got no solution so far. Maybe someone here can help.
>>>>>>>
>>>>>>> The recently posted SuperH SIU driver only supports stereo playback
>>>>>>> and
>>>>>>> capture (channels_min = channels_max = 2). Is there a way to tell
>>>>>>> alsa-lib
>>>>>>> to duplicate the mono-channel during playback and to mix recorded
>>>>>>> channels
>>>>>>> (or use one of them), if mono recording is requested?
>>>>>>>                   
>>>>>>>               
>>>>>> I'm not an expert but I think that you can use plughw support of
>>>>>> alsa-lib
>>>>>>
>>>>>> pcm.record {
>>>>>>       type plug
>>>>>>       slave {
>>>>>>               pcm record_hw
>>>>>>       }
>>>>>>       route_policy average
>>>>>>       rate_converter "linear"
>>>>>> }
>>>>>>
>>>>>> I think that automatically change rate and channel for supporting mono
>>>>>> channel
>>>>>> too
>>>>>>             
>>>>>>             
>>>>> Thanks for the snippet, but, I'm afraid, it didn't help either.
>>>>>         
>>>>>           
>>>> Sorry can you explain a little bit more why it doesn't help you?
>>>>     
>>>>         
>>> I certainly gladly would explain this, if only I knew... It just doesn't
>>> change anything. Are you using it anywhere? If yes, with which hardware
>>> configuration and software (alsa-lib) versions?
>>>   
>>>       
>> alsa-lib 1.0.16
>>     
>
> 1.0.22 here.
>
>   
>> #define BUILD_PCM_PLUGIN_RATE "1"
>> #define BUILD_PCM_PLUGIN_ROUTE "1"
>>     
>
> Yes, have these in include/config.h too.
>
>   
>> Hardware android openmoko gta02. Test it with arecord 1 month ago
>>     
>
> Ok, looks like openmoko has a few configurations, of which some are just 
> mono, and the I2S is, of course, stereo only. So, did this work with the 
> HiFi (I2S) interface and not with bluetooth?
>   
I have tested it on the no-bluetooth interface. What is your testing 
application and
the reporting error?

Michael
> Thanks
> Guennadi
> ---
> Guennadi Liakhovetski, Ph.D.
> Freelance Open-Source Software Developer
> http://www.open-technology.de/
>
>   
