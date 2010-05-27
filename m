From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: No mixers on ATI RS780 Azalia
Date: Thu, 27 May 2010 08:39:00 -0600
Message-ID: <4BFE8404.2000005@gmail.com>
References: <alpine.LSU.2.01.1005261303170.19406@obet.zrqbmnf.qr>	<s5hmxvmzwwd.wl%tiwai@suse.de>	<alpine.LSU.2.01.1005261413040.23865@obet.zrqbmnf.qr>	<4BFD2901.20800@ladisch.de>	<alpine.LSU.2.01.1005271230340.18087@obet.zrqbmnf.qr>	<4BFE5AA1.7070103@ladisch.de> <alpine.LSU.2.01.1005271420320.29122@obet.zrqbmnf.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LSU.2.01.1005271420320.29122@obet.zrqbmnf.qr>
Sender: linux-kernel-owner@vger.kernel.org
To: Jan Engelhardt <jengelh@medozas.de>
Cc: Clemens Ladisch <clemens@ladisch.de>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On 05/27/2010 06:34 AM, Jan Engelhardt wrote:
>
> On Thursday 2010-05-27 13:42, Clemens Ladisch wrote:
>>>> Try unmuting and raising both the Master and Beep controls.
>>>
>>> I unmuted everything and bumped the sliders to 100% but that does not
>>> change a thing unfortunately; opening the right device (C1D3p) ...
>>
>> Please do not assume that the "HDMI" device is the right one, since you
>> never got either one to work in Linux.  You did try playing through
>> the "SB" card, didn't you?
>
> Through all of them.
>
>> It is possible that an embedded device like this requires some custom
>> initialization.  Can you find out if the Windows driver is the standard
>> Microsoft driver or Samsung's?
>
> Looks like the Microsoft one:

Well, not Samsung, but it's not the Microsoft HDA driver either, it's 
using a Realtek driver.

>
>
>
> System: Windows XP Embedded Version 2002 Service Pack 2
>
> Devices in Device Manager:
>
> == "ATI HDMI Audio" ==
> Driver Provider: Realtek Semiconductor Corp.
> Driver Date: 4/14/2008
> Driver Version: 5.10.0.5602
> not digitally signed
>
> Matching Device Id:
> hdaudio\func_01&ven_1002&dev_791a
>
> consisting of:
> C:\WINDOWS\RtkUpd.exe
> 	Provider: Realtek Semiconductor Corp
> 	File version: 2,7,0,9
> C:\WINDOWS\system32\drivers\drmk.sys
> 	Provider: Microsoft
> 	Version: 5.1.2600.2180 (xpsp_sp2_rtm.040803-2158)
> C:\WINDOWS\system32\drivers\ks.sys
> 	Microsoft, 5.3.2600.2180 (xpsp..)
> C:\WINDOWS\system32\drivers\portcls.sys
> 	Microsoft, 5.1.2600.2180
> C:\WINDOWS\system32\drivers\RtHDMI.sys
> 	Realtek, 5.10.0.5602 built by WinDDK
> C:\WINDOWS\system32\drivers\stream.sys
> 	Microsoft,  5.3.2600.2180
> C:\WINDOWS\system32\ksproxy.ax
> 	Microsoft, 5.3.2600.2180
> C:\WINDOWS\system32\ksuser.dll
> 	Microsoft, 5.3.2600.2180
> C:\WINDOWS\system32\wdmaud.drv
> 	Microsoft, 5.1.2600.2180
>
> == "Realtek High Definition Audio" ==
> Device Type: Sound, video and game controllers
> Manufacturer: Realtek
> Location: Location 65535 (Internal High Definition Audio
>
> Driver ProvideR: Realtek Semiconductor Corp.
> Driver Date: 4/17/2008
> Driver Version: 5.10.0.5605
> not digitally signed
>
> Matching Device Id:
> hdaudio\func_01&ven_10ec&dev_0262
>
> consisting of:
> C:\WINDOWS\ALCMTR.EXE
> 	Realtek, 1.6.0.2
> C:\WINDOWS\ALCWZRD.EXE
> 	Realtek, 1.1.0.36
> C:\WINDOWS\MiCcal.exe
> 	Realtek, 1.1.1.8
> C:\WINDOWS\RTHDCPL.EXE
> 	Realtek, 2.2.0.2
> C:\WINDOWS\RTLCPL.EXE
> 	Realtek, 1.0.1.65
> C:\WINDOWS\RtlUpd.exe
> 	Realtek, 2,7,0,9
> C:\WINDOWS\SkyTel.exe
> 	Realtek, 2.0.2.0
> C:\WINDOWS\SOUNDMAN.EXE
> 	Realtek, 1,0,0,30
> C:\WINDOWS\system32\ALSNDMGR.CPL
> 	Realtek, 1,0,0,10
> C:\WINDOWS\system32\drivers\drmk.sys as above
> C:\WINDOWS\system32\drivers\ks.sys
> C:\WINDOWS\system32\drivers\portcls.sys
> C:\WINDOWS\system32\drivers\RtkHDAud.sys
> 	Realtek, 5.10.0.5605 built by WinDDK
> C:\WINDOWS\system32\drivers\stream.sys
> C:\WINDOWS\system32\ksproxy.ax
> C:\WINDOWS\system32\ksuser.dll
> C:\WINDOWS\system32\RTCOM\RTCOMDLL.dll
> 	Provider: N/A, Version: 1,0,0,96
> C:\WINDOWS\system32\RTCOM\RTLCPAPI.dll
> 	N/A, 1,0,1,9
> C:\WINDOWS\system32\RTSngMgr.CPL
> 	Realtek, 1,0,1,0
> C:\WINDOWS\system32\wdmaud.drv
