From: Hans-Kristian Arntzen <maister@archlinux.us>
Subject: Re: redirecting audio to another desktop machine
Date: Mon, 21 Jun 2010 15:51:19 +0200
Message-ID: <4C1F6E57.2060708@archlinux.us>
References: <mailman.1.1277114401.21597.alsa-devel@alsa-project.org>,
	<4C1F4420.3060904@archlinux.us>
	<70376CA23424B34D86F1C7DE6B9973430254343B42@VSHINMSMBX01.vshodc.lntinfotech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id B0ED1103846
	for <alsa-devel@alsa-project.org>;
	Mon, 21 Jun 2010 15:56:38 +0200 (CEST)
Received: by wyb40 with SMTP id 40so2325103wyb.38
	for <alsa-devel@alsa-project.org>; Mon, 21 Jun 2010 06:56:38 -0700 (PDT)
In-Reply-To: <70376CA23424B34D86F1C7DE6B9973430254343B42@VSHINMSMBX01.vshodc.lntinfotech.com>
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

On 06/21/2010 02:10 PM, Viral Mehta wrote:
>    
>> On 06/21/2010 12:00 PM, alsa-devel-request@alsa-project.org wrote:
>>      
>>> Date: Mon, 21 Jun 2010 14:57:00 +0530
>>> From: Viral Mehta<Viral.Mehta@lntinfotech.com>
>>> Subject: [alsa-devel] redirecting audio to another desktop machine
>>> To: "alsa-devel@alsa-project.org"<alsa-devel@alsa-project.org>
>>> Message-ID:
>>>        <70376CA23424B34D86F1C7DE6B9973430254343B3E@VSHINMSMBX01.vshodc.lntinfotech.com>
>>>
>>> Content-Type: text/plain; charset="us-ascii"
>>>
>>> Hi list,
>>>
>>> I have an embedded device running linux kernel and a minimal filesystem.
>>>
>>> I want to access this device remotely which means I should be able to connect to the device just like we do Remote Desktop over ethernet.
>>> I am able to do this. I am able to send key-event and framebuffer data whenever my desktop machine connects to the device.
>>>
>>> But, I am not able to send audio data on remote side.
>>> I am really not sure which device file (/dev/snd/ ???) I should read and capture the data and should send across....
>>> Or can I read the playback device ? I think NO.
>>> Do I need to create some kind of virtual sound device ?
>>>
>>> Any pointers/suggestions are appreciated.
>>>
>>> Thanks,
>>> Viral
>>>
>>>
>>>
>>>        
>> If you want to reroute an ALSA application over the network, you can use
>> output plugins. Afaik, both PulseAudio and RSound provides plugins for
>> this. You generally want to set up a virtual device in .asoundrc or
>> similar.
>> -- Hans-Kristian Arntzen
>>      
> Hi,
> thanks for the reply.
>
> Let me make sure I understood it in general..... Is it possible to use same plugins (or any other) if my embedded device is connected to my  desktop machine via USB (assuming that I have all USB data transfer mechanism/drivers underlying).
>
> If I setup a virtual device in .asoundrc, audio (or say aplay) applications will pass audio data to my virtual device ??
> Do I also need to create any such virtual interface from kernel code as well ?
>
>
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
> ______________________________________________________________________
>
> This Email may contain confidential or privileged information for the intended recipient (s) If you are not the intended recipient, please do not use or disseminate the information, notify the sender and delete it from your system.
>
> ______________________________________________________________________
>    
With output plugins for ALSA, you can in general do whatever you want. 
The plugins will receive audio data, and they can do anything. When you 
say you want to output to your device via USB cable, I'm not sure if 
that is supplied ootb. I assumed you wanted to output via ethernet. 
Pulse might do USB, but I'm not sure.

In any case, your output plugin will probably look something like this:

pcm.usb_device {
    type usb_output # there's no output plugin like this, just a random 
name to illustrate
    device "your device"
}

Then you could use aplay -Dusb_device.
