From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [Re: Crash when snd_pcm_open is called from a
 thread with "pulse" as playback]
Date: Mon, 9 Mar 2009 15:51:27 +0100 (CET)
Message-ID: <Pine.LNX.4.61.0903091541290.25713@tm8103.perex-int.cz>
References: <2210.93.1.202.94.1236528705.squirrel@acroe.imag.fr>   
	<s5h4oy2debq.wl%tiwai@suse.de>
	<Pine.LNX.4.61.0903091433430.25713@tm8103.perex-int.cz>
	<55892.147.171.149.152.1236608283.squirrel@acroe.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 9774B10384D
	for <alsa-devel@alsa-project.org>; Mon,  9 Mar 2009 15:51:27 +0100 (CET)
In-Reply-To: <55892.147.171.149.152.1236608283.squirrel@acroe.imag.fr>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Nicolas.Castagne@imag.fr
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, 9 Mar 2009 Nicolas.Castagne@imag.fr wrote:

> Hi Jaroslav, Takashi and all,
> 
> thx for you answers.
> 
> 
> Takashi :
> > Hm, I don't see any reason, and I cannot reproduce a crash on my machine...
> 
> I can reproduce it on my three Fedora10 machines, using 2 hardware.
> 
> Jaroslav
> > I would suggest to comment out code from snd_config_update_free_global().
> > Try to comment out snd_dlobj_cache_cleanup() at first. You may compile
> > alsa-lib from the tar ball on www.alsa-project.org and use
> > LD_PRELOAD=alsa-lib/src/.libs/libasound.so.2.0.0 <your_program> for tests.
> 
> Done.
> 
> * First, no more bug when commenting    snd_dlobj_cache_cleanup
> 
> * Also,  no more bug when commenting    dlclose
>        in snd_dlclose
>        called from snd_dlobj_cache_cleanup
> 
> 
> 
> The only dynamically loaded lib is  _snd_pcm_pulse_open
> 
> 
> Seems once again that pulse is involved somewhere.

Maybe. I guess it's a glibc bug which might be Fedora specific. Could you 
try glibc from different distribution (or maybe rawhide) using LD_PRELOAD 
hack if this bug can be reproduced? Just unpack glibc rpm with rpm2cpio 
and use libc.so, libdl.so and libphread.so files for LD_PRELOAD.

						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
