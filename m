From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: forking in user-space; mmap refcounting bug in
 alsa-kernel
Date: Mon, 17 Jun 2002 12:22:40 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0206171221090.2238-100000@pnote.perex-int.cz>
References: <Pine.LNX.4.44.0206170454320.2887-100000@ecabase.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0206170454320.2887-100000@ecabase.localdomain>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Kai Vehmanen <kai.vehmanen@wakkanet.fi>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Mon, 17 Jun 2002, Kai Vehmanen wrote:

> Running the following test program with current ALSA-CVS and with Delta44
> as the soundcard, I always get a failure from
> alsa-lib/src/pcm/pcm_hw.c:snd_pcm_hw_hw_free():
> 
> SYSERR("SNDRV_PCM_IOCTL_HW_FREE failed");
> 
> ... in kernel side, the following assertation fails in
> alsa-kernel/core/pcm_native.c:snd_pcm_release():
> 
> snd_assert(!atomic_read(&substream->runtime->mmap_count), );
> 
> After a long debug session I think I finally found the reason why this
> happens. When the forked child process exits, kernel will cleanup the mmap
> areas by calling snd_pcm_mmap_data_close(). As there are two processes,
> this gets called twice and substream->runtime->mmap_count goes to -1. When
> snd_pcm_release() finally gets called (following the user-space
> snd_pcm_close()), the assertion fails.
> 
> The most harmful failure happens in pcm_native.c:snd_pcm_hw_free() where
> 'if (atomic_read(&runtime->mmap_count)) {' fails, which means that device
> status is never resetted back to SNDRV_PCM_STATE_OPEN.
> 
> As for the fix, well, it's already 5am so it's probably better for me to
> continue tomorrow. :) As a simple fix, I moved mmap_count decrease code to
> snd_pcm_hw_free(). This fixes all my test cases, but might break something
> else. Comments are welcome.
> 
> Btw; running standard 2.4.17 kernel.

Bellow patch should fix this problem, but I need to do more tests with 
latest 2.5 and older 2.2 kernels, if it's a correct fix.

Index: pcm_native.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/core/pcm_native.c,v
retrieving revision 1.13
diff -u -r1.13 pcm_native.c
--- pcm_native.c	23 May 2002 08:20:38 -0000	1.13
+++ pcm_native.c	17 Jun 2002 10:21:21 -0000
@@ -2573,16 +2573,16 @@
 
 static void snd_pcm_mmap_data_open(struct vm_area_struct *area)
 {
-#if 0
 	snd_pcm_substream_t *substream = (snd_pcm_substream_t *)area->vm_private_data;
 	atomic_inc(&substream->runtime->mmap_count);
-#endif
+	printk("mmap_data_open!!!\n");
 }
 
 static void snd_pcm_mmap_data_close(struct vm_area_struct *area)
 {
 	snd_pcm_substream_t *substream = (snd_pcm_substream_t *)area->vm_private_data;
 	atomic_dec(&substream->runtime->mmap_count);
+	printk("mmap_data_close!!!\n");
 }
 
 #ifndef LINUX_2_2
@@ -2674,6 +2674,7 @@
 #ifdef VM_RESERVED
 	area->vm_flags |= VM_RESERVED;
 #endif
+	printk("mmaping data!!!\n");
 	atomic_inc(&runtime->mmap_count);
 	return 0;
 }


> 
> --cut--
> #include <assert.h>
> #include <stdio.h>
> #include <sys/types.h>
> #include <unistd.h>
> #include <alsa/asoundlib.h>
> 
> int main(int argc, char* argv[])
> {
>   snd_pcm_t *handle;
>   snd_pcm_hw_params_t* hwparams;
>   int n, pid;
> 
>   int err = snd_pcm_open(&handle, "default", 
> 		         SND_PCM_STREAM_PLAYBACK, 
> 			 SND_PCM_NONBLOCK);
>   assert(err == 0);
> 
>   err += snd_pcm_hw_params_malloc(&hwparams);
>   err += snd_pcm_hw_params_any(handle, hwparams);
>   err += snd_pcm_hw_params(handle, hwparams);
>   assert(err == 0);
> 
>   pid = fork();
>   if (pid == 0) { /* child */
>     fprintf(stderr, "child pid=%d.\n", getpid());
>     exit(1);
>   }
>   else { /* parent */
>     fprintf(stderr, "parent pid=%d.\n", getpid());
>     sleep(1);
> 
>     snd_pcm_close(handle);
>   }
> }
> --cut---
> 
> -- 
>  http://www.eca.cx
>  Audio software for Linux!
> 
> 
> _______________________________________________________________
> 
> Sponsored by:
> ThinkGeek at http://www.ThinkGeek.com/
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel
> 

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com


_______________________________________________________________

Sponsored by:
ThinkGeek at http://www.ThinkGeek.com/
