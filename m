From: Raymond <rayau@netvigator.com>
Subject: Re: Alsa mix in HW
Date: Sat, 10 Sep 2005 08:22:17 +0800
Message-ID: <43222739.7030402@netvigator.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Dino Puller <dino@e4a.it>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


Dino wrote:

> Raymond wrote:
>
> > Dino wrote:
> >
> > > Raymond wrote:
> > >
> > > > How can I link the demo.cpp (a simple openal/opengl program) 
with the
> > > > openal-alsa ? (It can be executed when link with openal)
> > >
> > > No problem here for compile/linking, i've attached a simple tested
> > > Makefile, i used dynamic library with the name: libopenal.so.0 . If
> > > you have problem tell me.
> > >
> > > CC = g++
> > >
> > > TARGET = lesson3
> > >
> > > COMPILEFLAGS = -g
> > > LIBS = -lopenal -lglut
> > > INC = -I../../include
> > >
> > > $(TARGET): demo.o
> > > $(CC) -o $(TARGET) demo.o $(COMPILEFLAGS) $(LIBS) $(INC)
> > >
> > > demo.o: demo.cpp
> > > $(CC) -c demo.cpp -Wno-deprecated
> > >
> > > clean:
> > > rm -f $(TARGET) demo.o
> >
> > It seem to me that your Makefile is wrong.
> >
> > $(COMPILEFLAGS) and $(INC) should be in $(CC) -c demo.cpp
> >
> >
> > # demo]# make
> > Makefile:10: *** missing separator. Stop.
>
> Yes, but now it compile for you?
>

NO. :(

I don't know how to fix your Makefile

Just change my Makefile

-I/openal-alsa/include
-L/openal-alsa/src

cp libopenal.a /usr/local/lib
cp libopenal.so.0.1.3 /usr/local/lib
ln libopenal.so.0.1.3 /usr/local/lib/libopenal.so.0

demo]#  ./demo
demo: mask_inline.h:160: snd_mask_leave: Assertion `val <= 64' failed.
Aborted


I have no idea the bug is caused by linking wrong library, it is rather 
diffcult to find out the problem when using strace ?

demo]# strace ./demo

...

open("/dev/js0", O_RDONLY)              = 4
ioctl(4, JSIOCGAXES, 0x8c0d1c4)         = 0
ioctl(4, JSIOCGBUTTONS, 0x8c0d1c8)      = 0
fcntl64(4, F_SETFL, O_RDONLY|O_NONBLOCK) = 0
stat64("/usr/share/alsa/alsa.conf", {st_mode=S_IFREG|0644, st_size=7467, 
...}) = 0
open("/usr/share/alsa/alsa.conf", O_RDONLY) = 5
fstat64(5, {st_mode=S_IFREG|0644, st_size=7467, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 
0) = 0xbf58d000
read(5, "#\n#  ALSA library configuration "..., 4096) = 4096
read(5, "if cards.pcm.iec958\npcm.modem ca"..., 4096) = 3371
read(5, "", 4096)                       = 0
read(5, "", 4096)                       = 0
close(5)                                = 0
munmap(0xbf58d000, 4096)                = 0
futex(0x852f70, FUTEX_WAKE, 2147483647) = 0
access("/etc/asound.conf", R_OK)        = -1 ENOENT (No such file or 
directory)
access("/xxxx/.asoundrc", R_OK)         = -1 ENOENT (No such file or 
directory)
open("/dev/snd/controlC0", O_RDONLY)    = 5
close(5)                                = 0
open("/dev/snd/controlC0", O_RDWR)      = 5
ioctl(5, USBDEVFS_CONTROL, 0xbffa48a4)  = 0
stat64("/usr/share/alsa/alsa.conf", {st_mode=S_IFREG|0644, st_size=7467, 
...}) = 0
open("/dev/snd/controlC0", O_RDONLY)    = 6
close(6)                                = 0
open("/dev/snd/controlC0", O_RDWR)      = 6
ioctl(6, USBDEVFS_CONTROL, 0xbffa46d8)  = 0
ioctl(6, 0x40045532, 0xbffa4700)        = 0
open("/dev/snd/pcmC0D0p", O_RDWR|O_NONBLOCK) = 7
close(6)                                = 0
ioctl(7, AGPIOC_ACQUIRE or APM_IOC_STANDBY, 0xbffa45cc) = 0
fcntl64(7, F_GETFL)                     = 0x802 (flags O_RDWR|O_NONBLOCK)
ioctl(7, AGPIOC_INFO, 0xbffa45c8)       = 0
ioctl(7, AGPIOC_RELEASE or APM_IOC_SUSPEND, 0xbffa45c4) = 0
mmap2(NULL, 4096, PROT_READ, MAP_SHARED, 7, 0x80000) = 0xbf58d000
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_SHARED, 7, 0x81000) = 0xbf58c000
ioctl(7, 0xc25c4110, 0xbffa47b0)        = 0
ioctl(7, 0xc25c4110, 0xbffa47b0)        = 0
write(2, "demo: mask_inline.h:160: snd_mas"..., 71demo: 
mask_inline.h:160: snd_mask_leave: Assertion `val <= 64' failed.
) = 71
rt_sigprocmask(SIG_UNBLOCK, [ABRT], NULL, 8) = 0
tgkill(4738, 4738, SIGABRT)             = 0
--- SIGABRT (Aborted) @ 0 (0) ---
+++ killed by SIGABRT +++


> >
> >
> > Have you run the demo when linked with openal-alsa ?
>
> Of course, can you send me your wav?
>

According to the specification, you can use any MONO (8bits/16bits) wav.

The sample rate of audio of those moving objects need to be half of 
44100Hz/48000Hz, this allow the soundcard playback the audio at
higher/lower rate to perform pitch shifting











-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
