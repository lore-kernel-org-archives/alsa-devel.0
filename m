From: "Eric C. Weaver" <weav@sigma.net>
Subject: Buffering Patch to aplay / arecord 1.0.2
Date: Fri, 05 Mar 2004 16:55:52 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <40492198.3000309@sigma.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020405030800040009070104"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------020405030800040009070104
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


The attached diff has my change to aplay.c:capture_go and supporting globals, 
to implement a two-thread double-buffering approach to capture.  I kept having 
overruns, due apparently to file system lock contention in RedHat 9 (2.4.20-8).

The approach is to allocate a 10-second-long buffer (rounded up to a multiple 
of chunk-size), start a disk-write thread to follow behind the original 
thread, and if the file system lock causes the write to block for a while, 
capturing continues unabated.  10 seconds has been sufficient so far; the 
longest FS lock I could cause was 9.5 seconds.  No overruns (with a big enough 
buffer-size) since this patch has been in use!

I release the IP in this patch to the ALSA project for inclusion, should the 
pertinent community members find it worthwhile.

Cheers...

Eric Weaver
Palo Alto, CA


--------------020405030800040009070104
Content-Type: text/plain;
 name="aplay.diff.text"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="aplay.diff.text"

*** aplay.c.orig	2003-11-28 02:24:53.000000000 -0800
--- aplay.c	2004-03-03 16:38:47.000000000 -0800
***************
*** 38,47 ****
--- 38,49 ----
  #include <errno.h>
  #include <alsa/asoundlib.h>
  #include <assert.h>
+ #include <sched.h>		/* Weav */
  #include <sys/poll.h>
  #include <sys/uio.h>
  #include <sys/time.h>
  #include <sys/signal.h>
+ #include <sys/wait.h>
  #include "aconfig.h"
  #include "formats.h"
  #include "version.h"
***************
*** 78,83 ****
--- 80,88 ----
  static int interleaved = 1;
  static int nonblock = 0;
  static char *audiobuf = NULL;
+ static char *audiobuf_writep = NULL; /* Weav */
+ static char *audiobuf_readp = NULL; /* Weav */
+ static int capture_done = 0;
  static snd_pcm_uframes_t chunk_size = 0;
  static unsigned period_time = 0;
  static unsigned buffer_time = 0;
***************
*** 90,101 ****
--- 95,111 ----
  static int buffer_pos = 0;
  static size_t bits_per_sample, bits_per_frame;
  static size_t chunk_bytes;
+ static size_t audiobuf_bytes;	/* Weav */
  static snd_output_t *log;
  
  static int fd = -1;
  static off64_t pbrec_count = (size_t)-1, fdcount;
  static int vocmajor, vocminor;
  
+ static int thread_stack_elts = 10240;
+ static char *thread_stack[10240];
+ 
+ 
  /* needed prototypes */
  
  static void playback(char *filename);
***************
*** 524,529 ****
--- 534,540 ----
  		error("not enough memory");
  		return 1;
  	}
+ 	audiobuf_writep = audiobuf_readp = audiobuf; /* Weav */
  
  	if (mmap_flag) {
  		writei_func = snd_pcm_mmap_writei;
***************
*** 932,942 ****
  	bits_per_sample = snd_pcm_format_physical_width(hwparams.format);
  	bits_per_frame = bits_per_sample * hwparams.channels;
  	chunk_bytes = chunk_size * bits_per_frame / 8;
! 	audiobuf = realloc(audiobuf, chunk_bytes);
  	if (audiobuf == NULL) {
  		error("not enough memory");
  		exit(EXIT_FAILURE);
  	}
  	// fprintf(stderr, "real chunk_size = %i, frags = %i, total = %i\n", chunk_size, setup.buf.block.frags, setup.buf.block.frags * chunk_size);
  }
  
--- 943,960 ----
  	bits_per_sample = snd_pcm_format_physical_width(hwparams.format);
  	bits_per_frame = bits_per_sample * hwparams.channels;
  	chunk_bytes = chunk_size * bits_per_frame / 8;
! 	audiobuf_bytes = 10 * rate * bits_per_frame / 8; /* Weav */
! 	audiobuf_bytes += chunk_bytes - (audiobuf_bytes % chunk_bytes);
! #if 0
! 	d_printf("audiobuf size = %d (0x%x) bytes\n",
! 		 audiobuf_bytes, audiobuf_bytes);
! #endif
! 	audiobuf = realloc(audiobuf, audiobuf_bytes); /* Weav */
  	if (audiobuf == NULL) {
  		error("not enough memory");
  		exit(EXIT_FAILURE);
  	}
+ 	audiobuf_writep = audiobuf_readp = audiobuf; /* Weav */
  	// fprintf(stderr, "real chunk_size = %i, frags = %i, total = %i\n", chunk_size, setup.buf.block.frags, setup.buf.block.frags * chunk_size);
  }
  
***************
*** 1817,1847 ****
  
  /* capturing raw data, this proc handels WAVE files and .VOCs (as one block) */
  
  void capture_go(int fd, size_t count, int rtype, char *name)
  {
  	size_t c, cur;
  	ssize_t r, err;
  
  	header(rtype, name);
  	set_params();
! 
  	do {
  		for (cur = count; cur > 0; cur -= r) {
  			c = cur;
  			if (c > chunk_bytes)
  				c = chunk_bytes;
  			c = c * 8 / bits_per_frame;
! 			if ((size_t)(r = pcm_read(audiobuf, c)) != c)
  				break;
  			r = r * bits_per_frame / 8;
  			if ((err = write(fd, audiobuf, r)) != r) {
  				perror(name);
  				exit(EXIT_FAILURE);
  			}
  			if (err > 0)
  				fdcount += err;
  		}
  	} while (rtype == FORMAT_RAW && !timelimit);
  }
  
  /*
--- 1835,1976 ----
  
  /* capturing raw data, this proc handels WAVE files and .VOCs (as one block) */
  
+ 
+ int capture_writeloop (void *arg)
+ {
+   int fd = *(int*)arg;
+ 
+ #if 0
+   d_printf("Entering capture_writeloop; fd = %d\n", fd);
+ #endif
+   do {
+ #if 0
+     d_printf("readp = 0x%x; writep = 0x%x; cd=%d\n",
+ 	     audiobuf_readp, audiobuf_writep, capture_done);
+ #endif
+     if (audiobuf_readp > audiobuf_writep) {	/* wrapped */
+       int bytes = write(fd, audiobuf_readp, audiobuf_bytes - (audiobuf_readp - audiobuf));
+       if (bytes < 0) {
+ 	perror("capture_writeloop: write");
+ 	return 0;
+       }
+       fdcount += bytes;
+ #if 0
+       d_printf("Wrote %d bytes from 0x%x\n", bytes, audiobuf_readp);
+ #endif
+       audiobuf_readp += bytes;
+       if (audiobuf_readp >= audiobuf + audiobuf_bytes) /* (un)wrap... */
+ 	audiobuf_readp = audiobuf;
+     }
+     if (audiobuf_writep > audiobuf_readp) { /* Got some ahead of us */
+       int bytes = write (fd, audiobuf_readp, audiobuf_writep - audiobuf_readp);
+       if (bytes < 0) {
+ 	perror("capture_writeloop: write");
+ 	return 0;
+       }
+       fdcount += bytes;
+ #if 0
+       d_printf("Wrote %d bytes from 0x%x\n", bytes, audiobuf_readp);
+ #endif
+       audiobuf_readp += bytes;
+     }
+     else
+       /* nanosleep(500000000);	/* 1/2 sec. */
+       sleep(1);
+   } while (!capture_done || (audiobuf_readp != audiobuf_writep));
+   return 0;
+ }
+ 
+ 
  void capture_go(int fd, size_t count, int rtype, char *name)
  {
  	size_t c, cur;
  	ssize_t r, err;
+ 	int cloneid;
+ 	pthread_t threadid;
+ 	pthread_attr_t thread_attr;
+ 	/*
+ 	int writeloop_stack_elts = 1024 * 10;
+ 	char *writeloop_stack = malloc(writeloop_stack_elts);
+ 	*/
+ 	void *clone_stack_ptr = &thread_stack[(thread_stack_elts - 8) & ~7];
  
  	header(rtype, name);
  	set_params();
! 	capture_done = 0;
! #if 0
! 	d_printf("thread_stack = 0x%x; &fd = 0x%x, fd = %d\n",
! 		thread_stack, &fd, fd);
! 	d_printf("clone_stack_ptr = 0x%x\n", clone_stack_ptr);
! #endif
! 	cloneid = clone(&capture_writeloop, clone_stack_ptr,
! 			CLONE_FS | CLONE_FILES | CLONE_SIGHAND |
! 			CLONE_PTRACE | CLONE_VM |
! 			/* CLONE_THREAD | */ /* gives EINVAL */
! 			SIGCHLD,
! 			&fd);
! 	/* pthread_attr_init(&thread_attr);
! 	cloneid = pthread_create(&thread,
! 	*/
! 	if (cloneid < 0) {
! 	  perror("capture_go: clone");
! 	  exit(1);
! 	}
! #if 0
! 	d_printf("cloneid = %d\n", cloneid);
! #endif
  	do {
  		for (cur = count; cur > 0; cur -= r) {
  			c = cur;
  			if (c > chunk_bytes)
  				c = chunk_bytes;
+ 			/* Limit to audiobuf extent... */
+ 			if (audiobuf_writep + c > audiobuf + audiobuf_bytes)
+ 			  c = (audiobuf + audiobuf_bytes - audiobuf_writep) ;
  			c = c * 8 / bits_per_frame;
! 			if (c == 0) {
! 			  struct timespec howlong = {0, 100000000};
! #if 0
! 			  d_printf ("No room! Waiting...\n");
! #endif
! 			  r = 0;
! 			  nanosleep(&howlong, NULL); /* 1/10 sec. */
! 			  continue;
! 			}
! 			if (audiobuf_writep < audiobuf_readp  &&
! 			    audiobuf_writep + c >= audiobuf_readp )
! 			  c = (audiobuf_readp - audiobuf_writep) * 8 / bits_per_frame;
! #if 0
! 			d_printf("Calling pcm_read for %d frames at 0x%x\n",
! 				c, audiobuf_writep);
! #endif
! 			if ((size_t)(r = pcm_read(audiobuf_writep, c)) != c)
  				break;
  			r = r * bits_per_frame / 8;
+ #if 0
+ 			d_printf("Read %d (0x%x) PCM bytes out of %d requested at 0x%x\n",
+ 				r, r, c * bits_per_frame / 8, audiobuf_writep);
+ #endif
+ 			if (audiobuf_writep + r >= audiobuf + audiobuf_bytes)
+ 			  audiobuf_writep = audiobuf;
+ 			else
+ 			  audiobuf_writep += r;
+ 			/*
  			if ((err = write(fd, audiobuf, r)) != r) {
  				perror(name);
  				exit(EXIT_FAILURE);
  			}
  			if (err > 0)
  				fdcount += err;
+ 			*/
  		}
  	} while (rtype == FORMAT_RAW && !timelimit);
+ 	capture_done = 1;	/* tells writeloop thread to finish & exit */
+ 	waitpid(cloneid, NULL, __WALL);	/* Hold on until it does so */
+ #if 0
+ 	d_printf("capture_go: Writeloop thread %d exited; returning\n",
+ 		cloneid);
+ #endif
  }
  
  /*

--------------020405030800040009070104--



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
