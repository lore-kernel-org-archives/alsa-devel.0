From: Yitao Duan <duan@cs.berkeley.edu>
Subject: Problem with arecord on Audigy 2 NX
Date: Fri, 26 Mar 2004 15:02:31 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <4064B687.C88E8575@cs.berkeley.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

I am having trouble recording using Creative Labs Sound Blaster Audigy 2
NX. The linux rec program worked fine. But whenever I use arecord (e.g.
arecord test.wav), I got Segmentation fault. I pinpointed the problem to
the function  pcm_read in aplay.c. Specifically it was the line:

 r = readi_func(handle, data, count);

that caused the fault. readi_func was called 3 times without problem.
But the 4th call will cause the fault. gdb showed that a NULL pointer
was encountered in function snd_pcm_rate_grab_next_period: rate->slave
was NULL. The following is a stack trace when the fault happened.
However, rate->slave was not NULL during the 3 normal readi_func calls
and I checked that the handle passed to readi_func was always the same.
What could happen that made the pointer NULL for the 4th call? I am
running 2.4.21-4.EL kernel and gcc 3.2.3. Any information will be highly
appreciated.

Thanks.

Yitao


Program received signal SIGSEGV, Segmentation fault.
[Switching to Thread -1220721088 (LWP 7171)]
0xb758de5d in snd_pcm_rate_grab_next_period (pcm=0x8052d10, hw_offset=0)
at pcm_rate.c:1047
1047                    cont = rate->slave->buffer_size - slave_offset;
(gdb) bt
#0  0xb758de5d in snd_pcm_rate_grab_next_period (pcm=0x8052d10,
hw_offset=0) at pcm_rate.c:1047
#1  0xb758e430 in snd_pcm_rate_avail_update (pcm=0x8052d10) at
pcm_rate.c:1205
#2  0xb75782fc in snd_pcm_avail_update (pcm=0x0) at pcm.c:2087
#3  0xb757c236 in snd_pcm_read_areas (pcm=0x8052d10, areas=0xbffff3b0,
offset=0, size=1000,
    func=0xb759159c <snd_pcm_mmap_read_areas>) at pcm.c:5968
#4  0xb759178f in snd_pcm_mmap_readi (pcm=0x8052d10, buffer=0x805b0a8,
size=1000) at pcm_mmap.c:230
#5  0xb7576c21 in snd_pcm_readi (pcm=0x8052d10, buffer=0x805b0a8,
size=4) at pcm_local.h:378
#6  0x0804d8d7 in pcm_read (
    data=0x805b0a8 "\200\200\200\200", '\177' <repeats 11 times>, '\200'
<repeats 24 times>, '\177' <repeats 12 times>, '\200' <repeats 29
times>, "\177\177\200\200\200\200\177\177\177\200\200\200\200\200",
'\177' <repeats 30 times>, "\200", '\177' <repeats 75 times>...,
rcount=1000) at aplay.c:1411
#7  0x0804eed5 in capture_go (fd=5, count=4294967294, rtype=2,
name=0xbffffb50 "test") at aplay.c:2096
#8  0x0804f257 in capture (name=0xbffffb50 "test") at aplay.c:2191
#9  0x0804bc5e in main (argc=2, argv=0xbffff664) at aplay.c:801
(gdb) print rate
$1 = (snd_pcm_rate_t *) 0x8052d10
(gdb) print *rate
$2 = {slave = 0x0, close_slave = 0, watom = {begin = 12, end = 1},
appl_ptr = 0, hw_ptr = 6,
  type = RATE_TYPE_BANDLIMIT, get_idx = 1, put_idx = 3, pitch = 1, func
= 0,
  sformat = SND_PCM_FORMAT_U8, srate = 8000, states = 0x3e8, pareas =
0x1e848, sareas = 0x0}
(gdb) print rate->slave
$3 = (snd_pcm_t *) 0x0
(gdb) print slave_offset
$4 = 16000
(gdb) print rate->slave
$5 = (snd_pcm_t *) 0x0
(gdb) print rate->slave->buf
buf                buffer.0           buffer_size
buffer_time        bufsize.1
buf.0              buffer_frames      buffer_size.0
buffered_vfprintf
buffer             buffer_pos         buffer_size.1      buflen.1
(gdb) print rate->slave->buffer_size
Cannot access memory at address 0x88




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
