From: "Arve Knudsen" <aknuds-1@broadpark.no>
Subject: Re: Improving wine support for alsa.
Date: Fri, 07 May 2004 00:30:00 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <opr7lnga2ffmr65f@mail.broadpark.no>
References: <409A80DC.2080601@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; delsp=yes; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.broadpark.no (mail.broadpark.no [217.13.4.2])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id AAA14781
	for <alsa-devel@alsa-project.org>; Fri, 7 May 2004 00:27:39 +0200
In-Reply-To: <409A80DC.2080601@superbug.demon.co.uk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: James Courtier-Dutton <James@superbug.demon.co.uk>, ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

James, I don't know if this is of any help, but you could always have a  
peek at the PortAudio (www.portaudio.com) code (pa_linux_alsa.c). We don't  
use snd_pcm_async_handler though, but implement async and blocking IO  
ourselves.

Hope this helps

Arve Knudsen


On Thu, 06 May 2004 18:15:56 +0000, James Courtier-Dutton  
<James@superbug.demon.co.uk> wrote:

> Hi,
>
> I have been updating the wine alsa driver to work better with alsa.
> So far, all I have done is update it to use the new alsa api.
> Windows uses an api called Direct Sound.
> Direct Sound uses direct hardware buffer access.
> A Win32 program can quiry the sound driver and ask for the currently  
> playing position, together with the first available possition that the  
> application could write to. I will call these "PlayPos" and "WritePos"  
> respectively.
> E.g. If the hardware is halfway through playing one period(the PlayPos  
> is in the middle of a period), the beginning of the next period's  
> position is returned as the "WritePos".
>
> The problem arrives because the Win32 app expects to have full write  
> access to the hardware buffer, and can write to any parts of it at any  
> time. The sound card should just happily move through the buffer playing  
> each sample as it goes, and when it reaches the end, just start at the  
> beginning again.
>
> The alsa api is based more around the sound card asking for the next  
> block of samples.
>
> Strangely enough, it Direct Sound works fine when using oss emulation in  
> alsa.
>
> I was trying to just get alsa to copy samples from the Direct Sound  
> buffer on a just in time basis.
>
> I was starting with writing one period to the sound card, calling  
> snd_pcm_start(), then setting snd_async_add_pcm_handler(), expecting the  
> handler to be called on each period, but the handler is never called.
>
> For some reason, the handler does not seem to get called on each period  
> elasped as I was expecting.
>
> Another problem is that if I want to stop the stream, I call  
> "snd_pcm_drop(). With this I would expect snd_pcm_delay()==0 and  
> snd_pcm_avail_update()==buffer_size.
> It seems that these values are only reset to 0 after first calling  
> snd_pcm_prepare().
> After stopping the stream in this way, I want to restart it again  
> without having to close/open the pcm.
>
> Can anyone give me advice as to what I am doing wrong ?
>
> Cheers
> James


-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to deliver
higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
