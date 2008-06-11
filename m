From: Colin Guthrie <gmane@colin.guthr.ie>
Subject: Re: What does snd_pcm_delay() actually return?
Date: Wed, 11 Jun 2008 21:24:20 +0100
Message-ID: <g2pc9p$16h$1@ger.gmane.org>
References: <20080609190225.GA4534@tango.0pointer.de>
	<s5h1w333o7r.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by alsa0.perex.cz (Postfix) with ESMTP id 11990248DA
	for <alsa-devel@alsa-project.org>;
	Wed, 11 Jun 2008 22:24:36 +0200 (CEST)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1K6Wrz-0008Sp-IO
	for alsa-devel@alsa-project.org; Wed, 11 Jun 2008 20:24:36 +0000
Received: from 80-192-67-147.cable.ubr10.edin.blueyonder.co.uk
	([80.192.67.147]) by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Wed, 11 Jun 2008 20:24:35 +0000
Received: from gmane by 80-192-67-147.cable.ubr10.edin.blueyonder.co.uk with
	local (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Wed, 11 Jun 2008 20:24:35 +0000
In-Reply-To: <s5h1w333o7r.wl%tiwai@suse.de>
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

Takashi Iwai wrote:
> At Mon, 9 Jun 2008 21:02:25 +0200,
> Lennart Poettering wrote:
>> Takashi, Jaroslav,
>>
>> could you please explain what exactly snd_pcm_delay() returns? 
>>
>> Some applications (such as WINE) assume it is the time that would pass
>> until we reach an underrun if we would stop writing any further data
>> to the PCM device.
>>
>> Other applications (such as most media players) use it for time
>> synchronisation. i.e. assume that it is the time that passes until a
>> sample I write to a PCM device now would take to be played.
> 
> As James already pointed, the correct answer is the latter.
> In the driver implementation level, snd_pcm_delay() simply returns the
> difference between appl_ptr and hw_ptr.  It means how many samples are
> ahead on the buffer from the point currently being played.
> 
> However, if you stop feeding samples now, snd_pcm_delay() returns the
> least time XRUN occurs.  So the first understanding isn't 100% wrong.

snip

> The implementation of snd_pcm_delay() (at least in the driver level)
> purely depends on the accuracy of PCM pointer callback of each
> driver.  So, if the driver returns more accurate hw_ptr via pointer
> callback, you'll get more accurate value of snd_pcm_delay().  In the
> worst case, it may be bigger up to one period size than the real
> delay.

I could be wrong here as I'm only going on discussions I've had with 
wine folks rather than poking at the code myself (I did look a while 
back but I've forgotten it all now!).

AFAIK, the way Wine uses snd_pcm_delay() is to check when a sample is 
fully played. e.g. they wait for the function to return 0. I think this 
was done due to the docs specifically say that it is the "difference 
between appl_ptr and hw_ptr" so it makes sense to assume this will 
return 0 when there is nothing waiting to be played. I would strongly 
recommend that you remove the implementation detail from the (supposedly 
high level) docs.

Given this clarification can this bug please be closed as invalid?
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3943

In the mean time, can you suggest how the wine code can check to see if 
there is any data waiting to be played (e.g. things are idle) so that 
they can refactor their use of snd_pcm_delay()?


Col

Disclaimer: Any wine person, please feel free to correct me if I'd 
misunderstood things!
