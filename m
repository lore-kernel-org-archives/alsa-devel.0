From: Jonathan Andrews <jon@jonshouse.co.uk>
Subject: Re: Random process lockup on ARM board:
 alsa-lib-1.0.25, FUTEX_WAIT_PRIVATE
Date: Fri, 17 Feb 2012 21:04:41 +0000
Message-ID: <1329512682.29051.1.camel@jonspc>
References: <1329393691.6830.20.camel@jonspc>
Reply-To: jon@jonshouse.co.uk
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.jonshouse.co.uk (unknown [91.84.151.33])
	by alsa0.perex.cz (Postfix) with ESMTP id 528A6103FDE
	for <alsa-devel@alsa-project.org>; Fri, 17 Feb 2012 22:04:28 +0100 (CET)
Received: from [10.10.10.6] (jonspc [10.10.10.6])
	by mail.jonshouse.co.uk (8.14.1/8.13.8) with ESMTP id q1HL4fkP022454
	for <alsa-devel@alsa-project.org>; Fri, 17 Feb 2012 21:04:47 GMT
In-Reply-To: <1329393691.6830.20.camel@jonspc>
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

Reposting this:

# strace -p 443
> Process 443 attached - interrupt to quit
> futex(0x4030e144, FUTEX_WAIT_PRIVATE, 2, NULL
> 
locks up.  Stops, stalls ... fails to continue ....


Now tried several alsa-lib versions.  A clue would be nice?
What do I replace to fix this ?

Anyone ?


Thanks,
Jon



On Thu, 2012-02-16 at 12:01 +0000, Jonathan Andrews wrote:
> Sorry all me again.
> 
> I've written a program that picks up UDP broadcast packets containing
> audio from a number of sources, mixes it together and presents it to
> alsa for playback.
> 
> I'm experiencing random freezes.  I cant reproduce then running the
> process under strace as the process on the ARM board slows down to the
> point it underruns with ALSA all the time and the symptom doesn't show.
> 
> If I attach strace after the process has frozen I get this and nothing
> else:
> 
> # strace -p 443
> Process 443 attached - interrupt to quit
> futex(0x4030e144, FUTEX_WAIT_PRIVATE, 2, NULL
> 
> 
> This stop happens at random at any point typically after minutes but run
> time can be over an hour.
> 
> I need to work around this as I need the board for a demo.
> 
> Im using, alsa-lib-1.0.25
> kernel 2.6.36.4
> BusyBox v1.19.2
> 
> I also compiled strace for arm, but this and a busybox shell is the only
> environment I have on the board.
> 
> The problem showed when I starting using this function to poll alsa:
> 
> The same code on my PC dual core AMD does not seem to suffer the
> problem  : alsa-lib-1.0.23, Linux jonspc 2.6.32.26-175.fc12.i686 #1 SMP
> 
> Before anyone points it out I want to poll as alsa is not the only sound
> output supported by the code.
> 
> int sound_system_needs_data_now()
> {
>         int framesleft;
>         snd_pcm_status_t *status;
>         snd_pcm_status_alloca( &status );
> 
>         // If the alsa playback has stalled then it definately needs data
>         snd_pcm_status(playback_handle,status);
>         if( snd_pcm_status_get_state( status ) != SND_PCM_STATE_RUNNING )
>                 return(TRUE);
> 
>         framesleft=snd_pcm_avail (playback_handle);
> 	//printf("FL=%d\n",framesleft); fflush(stdout);
> 
>         if (framesleft>1000)
>                 return(TRUE);
>         else
>                 return(FALSE);
> }
> 
> 
> Stuck process
> 
> # cat /proc/443/status 
> Name:   udp-many-way-au
> State:  S (sleeping)
> Tgid:   443
> Pid:    443
> PPid:   392
> TracerPid:      0
> Uid:    0       0       0       0
> Gid:    0       0       0       0
> FDSize: 32
> Groups: 
> VmPeak:     4356 kB
> VmSize:     4292 kB
> VmLck:       132 kB
> VmHWM:      1788 kB
> VmRSS:      1788 kB
> VmData:      396 kB
> VmStk:       136 kB
> VmExe:        28 kB
> VmLib:      3348 kB
> VmPTE:        12 kB
> VmSwap:        0 kB
> Threads:        1
> SigQ:   0/471
> SigPnd: 0000000000000000
> ShdPnd: 0000000000000000
> SigBlk: 0000000000002000
> SigIgn: 0000000000000006
> SigCgt: 0000000180002000
> CapInh: 0000000000000000
> CapPrm: ffffffffffffffff
> CapEff: ffffffffffffffff
> CapBnd: ffffffffffffffff
> Cpus_allowed:   1
> Cpus_allowed_list:      0
> Mems_allowed:   1
> Mems_allowed_list:      0
> voluntary_ctxt_switches:        5908
> nonvoluntary_ctxt_switches:     1766
> 
> 
> Any useful suggestions welcome.
> 
> Thanks,
> Jon
> 
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
