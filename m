From: "Pharaoh ." <pharaoh137@gmail.com>
Subject: Re: aplay: can't resolve symbol 'snd_dlsym_start
Date: Tue, 11 Mar 2008 15:37:15 -0700
Message-ID: <61445c750803111537w209e799fn5f98e19fc0d3da8c@mail.gmail.com>
References: <61445c750803101341m30db6b1oa518c32cdd7fc437@mail.gmail.com>
	<20080310135843.57b0777e@jutz-gnto64>
	<61445c750803101503h68e69e22yff709a3cc45d6d08@mail.gmail.com>
	<61445c750803101641w6d70f210l2a02731e1eb16ccf@mail.gmail.com>
	<20080311103228.1897ad98@jutz-gnto64>
	<61445c750803111343h42572808u193029b5495a8716@mail.gmail.com>
	<20080311143140.4758fdc1@jutz-gnto64>
	<61445c750803111436x448957carefc6c805be26d39@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.178])
	by alsa0.perex.cz (Postfix) with ESMTP id 5020D103876
	for <alsa-devel@alsa-project.org>; Tue, 11 Mar 2008 23:37:22 +0100 (CET)
Received: by wa-out-1112.google.com with SMTP id m33so2713251wag.8
	for <alsa-devel@alsa-project.org>; Tue, 11 Mar 2008 15:37:16 -0700 (PDT)
In-Reply-To: <61445c750803111436x448957carefc6c805be26d39@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: John Utz <john.utz@dmx.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Mar 11, 2008 at 2:36 PM, Pharaoh . <pharaoh137@gmail.com> wrote:

>
>
> On Tue, Mar 11, 2008 at 2:31 PM, John Utz <john.utz@dmx.com> wrote:
>
> > On Tue, 11 Mar 2008 13:43:35 -0700
> > "Pharaoh ." <pharaoh137@gmail.com> wrote:
> >
> > > On Tue, Mar 11, 2008 at 10:32 AM, John Utz <john.utz@dmx.com> wrote:
> > >
> > > > On Mon, 10 Mar 2008 16:41:03 -0700
> > > > "Pharaoh ." <pharaoh137@gmail.com> wrote:
> > > >
> > > > > On Mon, Mar 10, 2008 at 3:03 PM, Pharaoh . <pharaoh137@gmail.com>
> > > > > wrote:
> > > > > >
> > > > > > On Mon, Mar 10, 2008 at 1:58 PM, John Utz <john.utz@dmx.com>
> > > > > > wrote:
> > > > > >  > here's some places to start:
> > > > > >  >
> > > > > >  >  did you compile the lib as static but the app as shared or
> > > > > >  > vice versa?
> > > > > >  >
> > > > > >  >  also, do an ldd on our libasound.so and see if it wants
> > > > > >  > libdl:
> > > > > >  >
> > > > > >  >  utz-gnto64 NewProD # ldd /usr/lib/libasound.so
> > > > > >  >         libm.so.6 => /lib/libm.so.6 (0x00002acc4444d000)
> > > > > >  >         libdl.so.2 => /lib/libdl.so.2 (0x00002acc446ce000)
> > > > > >  >         libpthread.so.0 => /lib/libpthread.so.0
> > > > > >  > (0x00002acc448d2000) libc.so.6 => /lib/libc.so.6
> > > > > >  > (0x00002acc44aee000) /lib64/ld-linux-x86-64.so.2
> > > > > >  > (0x0000555555554000) jutz-gnto64 NewProD #
> > > > > >  >
> > > > > >  >
> > > > > >  >
> > > > > >  >
> > > > > >  >  On Mon, 10 Mar 2008 13:41:10 -0700
> > > > > >  >  "Pharaoh ." <pharaoh137@gmail.com> wrote:
> > > > > >  >
> > > > > >  >  > Hi,
> > > > > >  >  >
> > > > > >  >  > I have written an user space plugin and the plugin shared
> > > > > >  >  > library is copied on board
> > > > > >  >  > appropriately, libasound.so is also copied.
> > > > > >  >  >
> > > > > >  >  >
> > > > > >  >  > When I try:
> > > > > >  >  >
> > > > > >  >  > #aplay -D omx    test.wav  //omx is my plugin
> > > > > >  >  >
> > > > > >  >  > I get following error:
> > > > > >  >  >
> > > > > >  >  > aplay: can't resolve symbol 'snd_dlsym_start
> > > > > >  >  >
> > > > > >  >  >
> > > > > >  >  > Any idea what is the problem?
> > > > > >  >  >
> > > > > >  >  > -pharaoh
> > > > > >  >  > _______________________________________________
> > > > > >  >  > Alsa-devel mailing list
> > > > > >  >  > Alsa-devel@alsa-project.org
> > > > > >  >  >
> > http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> > > > > >  >  >
> > > > > >  >
> > > > > >  >
> > > > > >
> > > > > >  I have compiled both alsa-lib and alsa-utils as shared
> > > > > > libraries. After doing ldd, I can see that it needs libdl.so
> > > > > > and it is present on the board. Let me try with a clean build
> > > > > > again.
> > > > > >
> > > > >
> > > > > Still no luck, I get the same error. Is there any way by which I
> > > > > can find out list of unresolved sumbols in a shared library?
> > > > >
> > > >
> > > > nm -D /usr/lib/libasound.so | grep U
> > > >
> > > >
> > > I get this, when I run nm on my alsa-lib which is used on board.
> > >          U __addsf3
> > >          U __assert
> > >          U __ctype_b
> > >          U __ctype_tolower
> > >          U __eqsf2
> > >          U __errno_location
> > >          U __fgetc_unlocked
> > >          U __fixdfsi
> > >          U __fixsfsi
> > >          U __floatsisf
> > >          U __fputc_unlocked
> > >          U __gesf2
> > >          U __gtsf2
> > >          U __lesf2
> > >          U __ltsf2
> > >          U __nesf2
> > >          U _exit
> > >          U accept
> > >          U access
> > >          U atof
> > >          U atoi
> > >          U atol
> > >          U bind
> > >          U bsearch
> > >          U calloc
> > >          U ceil
> > >          U chmod
> > >          U chown
> > >          U close
> > >          U closedir
> > >          U connect
> > >          U dladdr
> > >          U dlclose
> > >          U dlopen
> > >          U dlsym
> > >          U exit
> > >          U exp
> > >          U fclose
> > >          U fcntl
> > >          U fflush
> > >          U ffs
> > >          U fgetc
> > >          U fgets
> > >          U floor
> > >          U fmod
> > >          U fopen
> > >          U fork
> > >          U fprintf
> > >          U fputc
> > >          U fputs
> > >          U free
> > >          U fwrite
> > >          U getenv
> > >          U getgrnam
> > >          U gethostbyname
> > >          U getpid
> > >          U gettimeofday
> > >          U getuid
> > >          U ioctl
> > >          U listen
> > >          U localeconv
> > >          U log
> > >          U log10
> > >          U lseek
> > >          U malloc
> > >          U memcmp
> > >          U memcpy
> > >          U memmove
> > >          U memset
> > >          U mlock
> > >          U mmap
> > >          U munmap
> > >          U nanosleep
> > >          U open
> > >          U opendir
> > >          U pipe
> > >          U poll
> > >          U pow
> > >          U pthread_cond_destroy
> > >          U pthread_cond_init
> > >          U pthread_cond_signal
> > >          U pthread_cond_wait
> > >          U pthread_create
> > >          U pthread_join
> > >          U pthread_mutex_destroy
> > >          U pthread_mutex_init
> > >          U pthread_mutex_lock
> > >          U pthread_mutex_trylock
> > >          U pthread_mutex_unlock
> > >          U qsort
> > >          U raise
> > >          U read
> > >          U readdir
> > >          U realloc
> > >          U recvmsg
> > >          U rintf
> > >          U sched_yield
> > >          U semctl
> > >          U semget
> > >          U semop
> > >          U sendmsg
> > >          U setlocale
> > >          U setsid
> > >          U setsockopt
> > >          U shmat
> > >          U shmctl
> > >          U shmdt
> > >          U shmget
> > >          U sigaction
> > >          U sigemptyset
> > >          U signal
> > >          U snprintf
> > >          U socket
> > >          U socketpair
> > >          U sprintf
> > >          U sqrt
> > >          U sqrtf
> > >          U sscanf
> > >          U stat
> > >          U stderr
> > >          U stdout
> > >          U strcasecmp
> > >          U strcat
> > >          U strchr
> > >          U strcmp
> > >          U strcpy
> > >          U strcspn
> > >          U strdup
> > >          U strerror
> > >          U strlen
> > >          U strncmp
> > >          U strncpy
> > >          U strpbrk
> > >          U strrchr
> > >          U strtod
> > >          U strtol
> > >          U sysconf
> > >          U ungetc
> > >          U unlink
> > >          U usleep
> > >          U vfprintf
> > >          U vfscanf
> > >          U vsnprintf
> > >          U vsscanf
> > >          U waitpid
> > >          U wordexp
> > >          U wordfree
> > >          U write
> > >
> > >
> > > But, I get almost same thing when I do nm on my laptop's alsa-lib,
> > > this alsa-lib works.
> > >
> > >          U _IO_getc
> > >          U _IO_putc
> > >          U __assert_fail
> > >          U __ctype_b_loc
> > >          U __ctype_tolower_loc
> > >          U __errno_location
> > >          U __stack_chk_fail
> > >          U __strdup
> > >          U __strtod_internal
> > >          U __strtol_internal
> > >          U __xstat
> > >          U _exit
> > >          U accept
> > >          U access
> > >          U bind
> > >          U bsearch
> > >          U calloc
> > >          U chmod
> > >          U chown
> > >          U close
> > >          U closedir
> > >          U connect
> > >          U dladdr
> > >          U dlclose
> > >          U dlopen
> > >          U dlsym
> > >          U exit
> > >          U exp
> > >          U fclose
> > >          U fcntl
> > >          U feof
> > >          U fflush
> > >          U fgets
> > >          U floor
> > >          U fmod
> > >          U fopen
> > >          U fork
> > >          U fprintf
> > >          U fputs
> > >          U free
> > >          U fwrite
> > >          U getenv
> > >          U getgrnam
> > >          U gethostbyname
> > >          U getpid
> > >          U gettimeofday
> > >          U getuid
> > >          U ioctl
> > >          U listen
> > >          U localeconv
> > >          U log
> > >          U log10
> > >          U lseek
> > >          U malloc
> > >          U memcpy
> > >          U memmove
> > >          U memset
> > >          U mlock
> > >          U mmap
> > >          U munmap
> > >          U nanosleep
> > >          U open
> > >          U opendir
> > >          U pipe
> > >          U poll
> > >          U pow
> > >          U pthread_cond_destroy
> > >          U pthread_cond_init
> > >          U pthread_cond_signal
> > >          U pthread_cond_wait
> > >          U pthread_create
> > >          U pthread_join
> > >          U pthread_mutex_destroy
> > >          U pthread_mutex_init
> > >          U pthread_mutex_lock
> > >          U pthread_mutex_trylock
> > >          U pthread_mutex_unlock
> > >          U qsort
> > >          U read
> > >          U readdir
> > >          U realloc
> > >          U recvmsg
> > >          U rintf
> > >          U sched_yield
> > >          U semctl
> > >          U semget
> > >          U semop
> > >          U sendmsg
> > >          U setlocale
> > >          U setsid
> > >          U setsockopt
> > >          U shmat
> > >          U shmctl
> > >          U shmdt
> > >          U shmget
> > >          U sigaction
> > >          U sigemptyset
> > >          U signal
> > >          U snprintf
> > >          U socket
> > >          U socketpair
> > >          U sprintf
> > >          U sqrtf
> > >          U sscanf
> > >          U stderr
> > >          U stdout
> > >          U strcasecmp
> > >          U strcat
> > >          U strchr
> > >          U strcmp
> > >          U strcpy
> > >          U strcspn
> > >          U strerror
> > >          U strlen
> > >          U strncmp
> > >          U strncpy
> > >          U strpbrk
> > >          U strrchr
> > >          U strstr
> > >          U sysconf
> > >          U ungetc
> > >          U unlink
> > >          U usleep
> > >          U vfprintf
> > >          U vfscanf
> > >          U vsnprintf
> > >          U waitpid
> > >          U wordexp
> > >          U wordfree
> > >          U write
> >
> > hmm, i am out of ideas then. other than one more, are you compiling on
> > one platform and then running on another platform that isnt quite the
> > same, ie compiling on x86_64 then running on i586?
> >
> > these things can cause strange non-obvious errors.
> >
> > other than that, i am out of ideas. sorry!
> >
> >
> I am compiling on my x86 machine for an arm based board, using appropriate
> toolchain. Thanks John.
>

I dont have ld-linux.so in my /lib on board, I think that is the reason the
symbols are not getting resolved. Let me check.
