From: Kai Vehmanen <kai.vehmanen@wakkanet.fi>
Subject: Re: forking in user-space; mmap refcounting bug in
 alsa-kernel
Date: Wed, 19 Jun 2002 02:16:58 +0300 (EEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0206190144040.2887-100000@ecabase.localdomain>
References: <Pine.LNX.4.33.0206171221090.2238-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.33.0206171221090.2238-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Mon, 17 Jun 2002, Jaroslav Kysela wrote:

> Bellow patch should fix this problem, but I need to do more tests with 
> latest 2.5 and older 2.2 kernels, if it's a correct fix.

Hmm, this doesn't solve the problem at least when using the 2.4.17 
kernel. With the test program I still get the assertation. 
snd_pcm_mmap_data_open() is called right after fork() is called. And 
then snd_pcm_data_close() is called with the pid of the 
forked child. This seems a bit strange to me - why does a user-space 
fork() cause a vmops open() in parent, and vmops close() in the child.

Anyways, after the fork() is done and snd_pcm_close() gets called in the 
parent, snd_pcm_data_close() is called again in pcm_native.c.
This means that with the below patch mmap_count gets incremented once, 
but decremented twice and so the assertion fails.

> Index: pcm_native.c
> ===================================================================
> RCS file: /cvsroot/alsa/alsa-kernel/core/pcm_native.c,v
> retrieving revision 1.13
> diff -u -r1.13 pcm_native.c
> --- pcm_native.c	23 May 2002 08:20:38 -0000	1.13
> +++ pcm_native.c	17 Jun 2002 10:21:21 -0000
> @@ -2573,16 +2573,16 @@
>  
>  static void snd_pcm_mmap_data_open(struct vm_area_struct *area)
>  {
> -#if 0
>  	snd_pcm_substream_t *substream = (snd_pcm_substream_t *)area->vm_private_data;
>  	atomic_inc(&substream->runtime->mmap_count);
> -#endif
> +	printk("mmap_data_open!!!\n");
>  }
>  
>  static void snd_pcm_mmap_data_close(struct vm_area_struct *area)
>  {
>  	snd_pcm_substream_t *substream = (snd_pcm_substream_t *)area->vm_private_data;
>  	atomic_dec(&substream->runtime->mmap_count);
> +	printk("mmap_data_close!!!\n");
>  }
>  
>  #ifndef LINUX_2_2
> @@ -2674,6 +2674,7 @@
>  #ifdef VM_RESERVED
>  	area->vm_flags |= VM_RESERVED;
>  #endif
> +	printk("mmaping data!!!\n");
>  	atomic_inc(&runtime->mmap_count);
>  	return 0;
>  }
> 
> 
> > 
> > --cut--
> > #include <assert.h>
> > #include <stdio.h>
> > #include <sys/types.h>
> > #include <unistd.h>
> > #include <alsa/asoundlib.h>
> > 
> > int main(int argc, char* argv[])
> > {
> >   snd_pcm_t *handle;
> >   snd_pcm_hw_params_t* hwparams;
> >   int n, pid;
> > 
> >   int err = snd_pcm_open(&handle, "default", 
> > 		         SND_PCM_STREAM_PLAYBACK, 
> > 			 SND_PCM_NONBLOCK);
> >   assert(err == 0);
> > 
> >   err += snd_pcm_hw_params_malloc(&hwparams);
> >   err += snd_pcm_hw_params_any(handle, hwparams);
> >   err += snd_pcm_hw_params(handle, hwparams);
> >   assert(err == 0);
> > 
> >   pid = fork();
> >   if (pid == 0) { /* child */
> >     fprintf(stderr, "child pid=%d.\n", getpid());
> >     exit(1);
> >   }
> >   else { /* parent */
> >     fprintf(stderr, "parent pid=%d.\n", getpid());
> >     sleep(1);
> > 
> >     snd_pcm_close(handle);
> >   }
> > }
> > --cut---
> > 
> > -- 
> >  http://www.eca.cx
> >  Audio software for Linux!
> > 
> > 
> > _______________________________________________________________

-- 
 http://www.eca.cx
 Audio software for Linux!


----------------------------------------------------------------------------
                   Bringing you mounds of caffeinated joy
                   >>>     http://thinkgeek.com/sf    <<<
