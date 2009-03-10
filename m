From: Nicolas.Castagne@imag.fr
Subject: Re: [Re: Crash when snd_pcm_open is called from a
 thread with "pulse" as playback]
Date: Tue, 10 Mar 2009 10:16:48 +0100 (CET)
Message-ID: <43861.147.171.149.152.1236676608.squirrel@acroe.imag.fr>
References: <2210.93.1.202.94.1236528705.squirrel@acroe.imag.fr>
	<s5h4oy2debq.wl%tiwai@suse.de>
	<Pine.LNX.4.61.0903091433430.25713@tm8103.perex-int.cz>
	<55892.147.171.149.152.1236608283.squirrel@acroe.imag.fr>
	<Pine.LNX.4.61.0903091541290.25713@tm8103.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from imag.imag.fr (imag.imag.fr [129.88.30.1])
	by alsa0.perex.cz (Postfix) with ESMTP id CCF3124456
	for <alsa-devel@alsa-project.org>; Tue, 10 Mar 2009 10:26:49 +0100 (CET)
In-Reply-To: <Pine.LNX.4.61.0903091541290.25713@tm8103.perex-int.cz>
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

Hi Jaroslav & all,

> Maybe. I guess it's a glibc bug which might be Fedora specific. Could you
> try glibc from different distribution (or maybe rawhide) using LD_PRELOAD
> hack if this bug can be reproduced? Just unpack glibc rpm with rpm2cpio
> and use libc.so, libdl.so and libphread.so files for LD_PRELOAD.

Well, these are manipulations I am not used to :(
In particular, I never installed rawhide.

But I tried the pre compiled libraries in http://download.fedora.redhat.com
then used the downloaded libc.so, libdl.so and libphread.so at run time.


-> Fedora development version glibc-2.9.90-8.1.i686.rpm
Newer than mine. Found in :
http://download.fedora.redhat.com/pub/fedora/linux/development/i386/os/Packages/


-> Fedora release version glibc-2.9-2.i686.rpm
Older than mine. Found in :
http://download.fedora.redhat.com/pub/fedora/linux/releases/10/Everything/i386/os/Packages/


The bug is still there with both these versions.


I've tried using another glibc (eg ubuntu), but I must say I have
difficulties looking into them...


Perhaps someone has Fedora Rawhide installed, and could test ?

If this is possible he sample program is alsa_main.cpp, available at :
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=4426



Cheers,
Nicolas


> On Mon, 9 Mar 2009 Nicolas.Castagne@imag.fr wrote:
>
>> Hi Jaroslav, Takashi and all,
>>
>> thx for you answers.
>>
>>
>> Takashi :
>> > Hm, I don't see any reason, and I cannot reproduce a crash on my
>> machine...
>>
>> I can reproduce it on my three Fedora10 machines, using 2 hardware.
>>
>> Jaroslav
>> > I would suggest to comment out code from
>> snd_config_update_free_global().
>> > Try to comment out snd_dlobj_cache_cleanup() at first. You may compile
>> > alsa-lib from the tar ball on www.alsa-project.org and use
>> > LD_PRELOAD=alsa-lib/src/.libs/libasound.so.2.0.0 <your_program> for
>> tests.
>>
>> Done.
>>
>> * First, no more bug when commenting    snd_dlobj_cache_cleanup
>>
>> * Also,  no more bug when commenting    dlclose
>>        in snd_dlclose
>>        called from snd_dlobj_cache_cleanup
>>
>>
>>
>> The only dynamically loaded lib is  _snd_pcm_pulse_open
>>
>>
>> Seems once again that pulse is involved somewhere.
>
> Maybe. I guess it's a glibc bug which might be Fedora specific. Could you
> try glibc from different distribution (or maybe rawhide) using LD_PRELOAD
> hack if this bug can be reproduced? Just unpack glibc rpm with rpm2cpio
> and use libc.so, libdl.so and libphread.so files for LD_PRELOAD.
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
