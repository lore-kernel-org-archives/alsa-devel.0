From: =?UTF-8?B?Um9iZXJ0IEdyw7xuZGxlcg==?= <doobre@gmail.com>
Subject: Re: Hammerfall hdsploader not working in ubuntu 8.10
Date: Fri, 20 Feb 2009 16:13:43 +0100
Message-ID: <499EC8A7.9040702@gmail.com>
References: <499EB3A6.8020200@gmail.com> <499EC779.3060708@klingt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ey-out-1920.google.com (ey-out-1920.google.com [74.125.78.148])
	by alsa0.perex.cz (Postfix) with ESMTP id 4BE86103918
	for <alsa-devel@alsa-project.org>; Fri, 20 Feb 2009 16:13:47 +0100 (CET)
Received: by ey-out-1920.google.com with SMTP id 3so82515eyh.56
	for <alsa-devel@alsa-project.org>; Fri, 20 Feb 2009 07:13:46 -0800 (PST)
In-Reply-To: <499EC779.3060708@klingt.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Tim Blechmann <tim@klingt.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

hi tim,

i've just followed an advice from florian that it's probably related to 
pulseaudio
which apparently now is the default sound server in ubuntu.

After disabling pulsaudio, the card works fine again. I didn't know that 
hdsploader
is obsolete now, i had to use it from time to time in my old system.

If anyone else stumbles upon this, here's how to disable pulseaudio in 
ubuntu intrepid:

http://idyllictux.wordpress.com/2008/10/29/alsa-instead-of-pulseaudio-for-ubuntu-810-intrepid-a-non-destructive-way/

best

-robert


Tim Blechmann schrieb:
> hi robert,
>
>   
>> i'm using a rme Hammerfall hdsp multiface card which i've never had 
>> problems so far, due to
>> the fact that it's pretty well supported.
>>
>> However, after upgrading to Ubuntu 8.10 the hdsploader fails to upload 
>> the firmware to the card with the
>> following error:
>>
>> hdsploader - firmware loader for RME Hammerfall DSP cards
>> Looking for HDSP + Multiface or Digiface cards :
>> Card 0 : RME Hammerfall DSP + Multiface at 0xf87f0000, irq 22
>> Upload firmware for card hw:0
>> Hwdep ioctl error on card hw:0 : Device or resource busy.
>>     
>
> i did experience some `strange' behavior on my hdsp as well, starting a
> few months ago.
> in my case, the hdsp tells me, that the io box is not connected. my
> workaround was to unload/reload the module.
> maybe related to that issue, sometimes, the hdspmixer doesn't read the
> meter values from the interface, giving me the same `hwdep ioctl error',
> you are experiencing with hdsploader (i don't use hdsploader, since it
> is basically obsolete).
>
> i suppose, it is a similar issue, that i am experiencing ... btw are you
> running a 32bit or 64bit system?
>
> cheers, tim
>
>   
