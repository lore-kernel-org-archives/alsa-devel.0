From: The Source <thesourcehim@gmail.com>
Subject: Re: Will there ever be emu20k1/x-fi support in Alsa?
Date: Thu, 09 Oct 2008 14:06:52 +0400
Message-ID: <48EDD7BC.3090709@gmail.com>
References: <1223248483.19560.9.camel@home>	<20081006212526.219130@gmx.net>	<1223361156.20470.0.camel@home>	<48EB049C.1010002@gmail.com>	<1223426782.11647.5.camel@home>
	<s5hprmahyue.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.168])
	by alsa0.perex.cz (Postfix) with ESMTP id 2A6F7243EC
	for <alsa-devel@alsa-project.org>;
	Thu,  9 Oct 2008 12:05:15 +0200 (CEST)
Received: by ug-out-1314.google.com with SMTP id 30so840962ugs.24
	for <alsa-devel@alsa-project.org>; Thu, 09 Oct 2008 03:04:57 -0700 (PDT)
In-Reply-To: <s5hprmahyue.wl%tiwai@suse.de>
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

About multi playback: look at the latest codes from their mercurial repo 
- vmix with 4 PCMs was restored there.

Takashi Iwai ?????:
> At Tue, 07 Oct 2008 19:46:22 -0500,
> Ted T. Logian wrote:
>   
>> Yes, but it is better than nothing, and perhaps some of that is a
>> limitation of oss4:).
>>     
>
> Just looking at their code, and I can conclude it's a half-baked
> driver, indeed.  Fixed rate, no full duplex, no multi playback, no
> multi channel, etc, etc.
>
> OTOH, it's pretty easy to port right now because of its shortness.
> More comprehensive be more longer codes.
>
> OK, if the code is that long, I'll try to port as experimental.
> It's always good to have a reference at the beginning.
> Maybe it'll take one or two days...  Will inform you when it's ready.
>
> Note that I have neither XFi hardware nor datasheet, so someone brave
> has to test it :)
>      
>
> Takashi
>
>   
>> On Tue, 2008-10-07 at 10:41 +0400, The Source wrote:
>>
>>     
>>> That driver isn't too good unfortunately. No surround support, sample 
>>> rate stuck at 96000Hz and is read-only (this makes apps that require 
>>> explicit sample rate to fail to use sound), no pulse-audio compatibility 
>>> (pulse-audio fails to load oss modules).
>>>
>>> Ted T. Logian ?????:
>>>       
>>>> >From what I understand, they did not use creative code/license for the
>>>> oss4 support, so I wouldn't see why not.
>>>>
>>>> On Mon, 2008-10-06 at 23:25 +0200, Sebastian Schneider wrote:
>>>>
>>>>   
>>>>         
>>>>> Isn't it a question of the license? I mean is it allowed just to port the OSS Code with the Creative Part to Alsa?
>>>>>
>>>>>     
>>>>>           
>>>>>> I had to ask because oss4 has had emu20k1/x-fi support for a long time
>>>>>> now.  However, it has the obvious limitations of oss4 and also you
>>>>>> cannot use usb microphones, so I can't use skype which I'd really like
>>>>>> to do.
>>>>>>
>>>>>>       
>>>>>>             
>>>> _______________________________________________
>>>> Alsa-devel mailing list
>>>> Alsa-devel@alsa-project.org
>>>> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>>>>
>>>>   
>>>>         
>>> _______________________________________________
>>> Alsa-devel mailing list
>>> Alsa-devel@alsa-project.org
>>> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>>>       
>> _______________________________________________
>> Alsa-devel mailing list
>> Alsa-devel@alsa-project.org
>> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>>
>>     
>
>   
