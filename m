From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: Moving from OSS to ALSA
Date: Sun, 11 Jan 2004 13:28:57 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200401111828.i0BISvRO025390@dhin.linuxaudiosystems.com>
References: <20040111181311.7726a5b5.james@jigsawdezign.com>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Sun, 11 Jan 2004 18:13:11 GMT."
             <20040111181311.7726a5b5.james@jigsawdezign.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: James Wright <james@jigsawdezign.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>   I am currently looking into rewriting our current OSS sound routines to nat
>ive ALSA, as it seems OSS will invariably be phased out now that the ALSA driv
>er is distrubuted with the Linux kernel, plus ALSA seems to have a great numbe
>r of benefits for us. 
>
>  Our current sound routines perform software sound sample mixing for use in g
>ames. All the  mixing and transfers happen in a non-blocking function called u
>pdate_jsound() which we call every 1/60th of a second in our main game loop. W
>e find the total size of the hardware ring buffer and use MMAP writes to it. W
>e effectively break the ring buffer into 1024 byte "fragments", and always kee
>p one whole fragment ahead to ensure no underruns. We do this by the follwing:

best method:
-----------
1) set the avail_min s/w parameter to the period size
2) call poll on the file descriptor(s) returned from
   snd_pcm_poll_descriptors(). when you return from poll,
   you know you have at least one period of data ready (possibly
   more, so you need to check).
3) use snd_pcm_mmap_*() to handle mmap access. ALSA
   doesn't provide simple access to mmap'ped buffers 
   because this could not work for some classes of
   ALSA devices.

survey the source of JACK (jackit.sf.net) for some ideas.

however, that probably won't work so well for you it doesn't integrate
into your "game loop". for that, use snd_pcm_delay() to find out the
gap between the application (s/w) pointer and the hardware pointer,
then use the snd_pcm_mmap_*() calls from there.

its a lot more complex under ALSA. but thats because ALSA provides a
lot of things that OSS does not, and doing everything via the simple
system call interface that OSS uses makes it impossible to provide
them "appropriately".

if you were writing software for musicians and studios rather than
games and consumer media apps, check out JACK for a different, simpler
and more powerful API (that uses ALSA internally).

--p


-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
