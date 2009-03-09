From: Nicolas.Castagne@imag.fr
Subject: Re: [Re: Crash when snd_pcm_open is called from a
 thread with "pulse" as playback]
Date: Mon, 9 Mar 2009 14:18:03 -0000 (GMT)
Message-ID: <55892.147.171.149.152.1236608283.squirrel@acroe.imag.fr>
References: <2210.93.1.202.94.1236528705.squirrel@acroe.imag.fr>
	<s5h4oy2debq.wl%tiwai@suse.de>
	<Pine.LNX.4.61.0903091433430.25713@tm8103.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from imag.imag.fr (imag.imag.fr [129.88.30.1])
	by alsa0.perex.cz (Postfix) with ESMTP id AAE28103849
	for <alsa-devel@alsa-project.org>; Mon,  9 Mar 2009 15:26:44 +0100 (CET)
In-Reply-To: <Pine.LNX.4.61.0903091433430.25713@tm8103.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: ALSA development <alsa-devel@alsa-project.org>, nicolas.castagne@imag.fr
List-Id: alsa-devel@alsa-project.org

Hi Jaroslav, Takashi and all,

thx for you answers.


Takashi :
> Hm, I don't see any reason, and I cannot reproduce a crash on my machine...

I can reproduce it on my three Fedora10 machines, using 2 hardware.



Jaroslav
> I would suggest to comment out code from snd_config_update_free_global().
> Try to comment out snd_dlobj_cache_cleanup() at first. You may compile
> alsa-lib from the tar ball on www.alsa-project.org and use
> LD_PRELOAD=alsa-lib/src/.libs/libasound.so.2.0.0 <your_program> for tests.

Done.

* First, no more bug when commenting    snd_dlobj_cache_cleanup

* Also,  no more bug when commenting    dlclose
       in snd_dlclose
       called from snd_dlobj_cache_cleanup



The only dynamically loaded lib is  _snd_pcm_pulse_open


Seems once again that pulse is involved somewhere.


But dunno where to look at from this point :/


I upload these new inputs on the tracker.

Best-
Nicolas


> On Mon, 9 Mar 2009, Takashi Iwai wrote:
>
>> At Sun, 8 Mar 2009 16:11:45 -0000 (GMT),
>> Nicolas.Castagne@imag.fr wrote:
>> >
>> > Hi folks,
>> >
>> > I'd need the help of some alsa developpers regarding the bug report :
>> > https://bugtrack.alsa-project.org/alsa-bug/view.php?id=4426
>> >
>> > We've made a few progress on it, but we are stuck again.
>> >
>> > Basically, it seems that calling snd_config_update_free_global() from
>> a
>> > pthread causes the program to crash when the thread terminates.
>> >
>> >
>> >
>> > Questions are:
>> >
>> > Should config_update_free_global NOT be called from a thread ?
>> >
>> > In other words, is the following code valid (though dumb :=)) ?
>> > Or is there some reason for it to crash ?
>>
>> Hm, I don't see any reason, and I cannot reproduce a crash on my
>> machine...
>
> I would suggest to comment out code from snd_config_update_free_global().
> Try to comment out snd_dlobj_cache_cleanup() at first. You may compile
> alsa-lib from the tar ball on www.alsa-project.org and use
> LD_PRELOAD=alsa-lib/src/.libs/libasound.so.2.0.0 <your_program> for tests.
>
> 						Jaroslav
>
> -----
> Jaroslav Kysela <perex@perex.cz>
> Linux Kernel Sound Maintainer
> ALSA Project, Red Hat, Inc.
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
