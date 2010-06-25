From: Hans-Kristian Arntzen <maister@archlinux.us>
Subject: Re: redirecting audio to another desktop machine
Date: Fri, 25 Jun 2010 12:26:17 +0200
Message-ID: <4C248449.2060903@archlinux.us>
References: <mailman.1.1277114401.21597.alsa-devel@alsa-project.org>,
	<4C1F4420.3060904@archlinux.us>	<70376CA23424B34D86F1C7DE6B9973430254343B42@VSHINMSMBX01.vshodc.lntinfotech.com>
	<4C1F6E57.2060708@archlinux.us>
	<70376CA23424B34D86F1C7DE6B99734304E7B77FE9@VSHINMSMBX01.vshodc.lntinfotech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id D07EB2454E
	for <alsa-devel@alsa-project.org>;
	Fri, 25 Jun 2010 12:27:15 +0200 (CEST)
Received: by wwb39 with SMTP id 39so205926wwb.38
	for <alsa-devel@alsa-project.org>; Fri, 25 Jun 2010 03:27:14 -0700 (PDT)
In-Reply-To: <70376CA23424B34D86F1C7DE6B99734304E7B77FE9@VSHINMSMBX01.vshodc.lntinfotech.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Viral Mehta <Viral.Mehta@lntinfotech.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 06/25/2010 10:53 AM, Viral Mehta wrote:
> Hi,
>
>    
>> -----Original Message-----
>> From: alsa-devel-bounces@alsa-project.org [mailto:alsa-devel-
>> bounces@alsa-project.org] On Behalf Of Hans-Kristian Arntzen
>> Sent: Monday, June 21, 2010 7:21 PM
>> To: Viral Mehta
>> Cc: alsa-devel@alsa-project.org
>> Subject: Re: [alsa-devel] redirecting audio to another desktop machine
>>
>> On 06/21/2010 02:10 PM, Viral Mehta wrote:
>>      
>>>        
>>>> On 06/21/2010 12:00 PM, alsa-devel-request@alsa-project.org wrote:
>>>>
>>>>          
>>>>> Date: Mon, 21 Jun 2010 14:57:00 +0530
>>>>> From: Viral Mehta<Viral.Mehta@lntinfotech.com>
>>>>> Subject: [alsa-devel] redirecting audio to another desktop machine
>>>>> To: "alsa-devel@alsa-project.org"<alsa-devel@alsa-project.org>
>>>>> Message-ID:
>>>>>
>>>>>            
>> <70376CA23424B34D86F1C7DE6B9973430254343B3E@VSHINMSMBX01.vshodc.lntinfo
>> tech.com>
>>      
>>>>> Content-Type: text/plain; charset="us-ascii"
>>>>>
>>>>> Hi list,
>>>>>
>>>>> I have an embedded device running linux kernel and a minimal
>>>>>            
>> filesystem.
>>      
>>>>> I want to access this device remotely which means I should be able
>>>>>            
>> to connect to the device just like we do Remote Desktop over ethernet.
>>      
>>>>> I am able to do this. I am able to send key-event and framebuffer
>>>>>            
>> data whenever my desktop machine connects to the device.
>>      
>>>>> But, I am not able to send audio data on remote side.
>>>>> I am really not sure which device file (/dev/snd/ ???) I should
>>>>>            
>> read and capture the data and should send across....
>>      
>>>>> Or can I read the playback device ? I think NO.
>>>>> Do I need to create some kind of virtual sound device ?
>>>>>
>>>>> Any pointers/suggestions are appreciated.
>>>>>
>>>>> Thanks,
>>>>> Viral
>>>>>
>>>>>
>>>>>
>>>>>
>>>>>            
>>>> If you want to reroute an ALSA application over the network, you can
>>>>          
>> use
>>      
>>>> output plugins. Afaik, both PulseAudio and RSound provides plugins
>>>>          
>> for
>>      
>>>> this. You generally want to set up a virtual device in .asoundrc or
>>>> similar.
>>>> -- Hans-Kristian Arntzen
>>>>
>>>>          
>>> Hi,
>>> thanks for the reply.
>>>
>>> Let me make sure I understood it in general..... Is it possible to
>>>        
>> use same plugins (or any other) if my embedded device is connected to
>> my  desktop machine via USB (assuming that I have all USB data transfer
>> mechanism/drivers underlying).
>>      
>>> If I setup a virtual device in .asoundrc, audio (or say aplay)
>>>        
>> applications will pass audio data to my virtual device ??
>>      
>>> Do I also need to create any such virtual interface from kernel code
>>>        
>> as well ?
>>      
>>>
>>>        
>> With output plugins for ALSA, you can in general do whatever you want.
>> The plugins will receive audio data, and they can do anything. When you
>> say you want to output to your device via USB cable, I'm not sure if
>> that is supplied ootb. I assumed you wanted to output via ethernet.
>> Pulse might do USB, but I'm not sure.
>>
>> In any case, your output plugin will probably look something like this:
>>
>> pcm.usb_device {
>>      type usb_output # there's no output plugin like this, just a random
>> name to illustrate
>>      device "your device"
>> }
>>
>> Then you could use aplay -Dusb_device.
>>      
> Thanks for the reply.
> I think neither Pulse nor Rsound supports USB.
>
> So, I believe I will have to write something mine.
> First thing as you explained, I would write one plugin.
>
> And then my ALSA user space application will throw data on that virtual
> Device; so I need to have one kernel space driver as well, right ?
> Is it in anycase relevant to Sound Dummy (/dev/null) device ?
>
> And in my Virtual Driver, I may do usb_register and then submit data through
> URBs. Am I on a right path ?
>
> Thanks,
> Viral
>
>
>
> This Email may contain confidential or privileged information for the intended recipient (s) If you are not the intended recipient, please do not use or disseminate the information, notify the sender and delete it from your system.
>
> ______________________________________________________________________
>    
If you can communicate with your USB device using userspace libraries, I 
doubt you'd need to make a driver.
I don't think /dev/null is relevant here. I assume that usb_register 
opens up a USB device, so you can communicate with it, if so, then I 
think you're on the right path. You could probably have a look at the 
OSS plugin in the alsa-plugins package, and use it as a base to 
implement your usb output.
