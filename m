From: James Stafford <jstafford@ampltd.com>
Subject: Re: AUDIO2000 and DShare plugin
Date: Mon, 24 Apr 2006 09:30:11 +0100
Message-ID: <4.2.2.20060424092309.018063d8@192.168.1.6>
References: <4.2.2.20060420160712.02ab55f8@192.168.1.6>
 <4.2.2.20060418153155.0514e5d0@192.168.1.6>
 <s5hfyk8b8n4.wl%tiwai@suse.de>
 <4.2.2.20060420160712.02ab55f8@192.168.1.6> <s5h8xq0b5vs.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h8xq0b5vs.wl%tiwai@suse.de>
References: <4.2.2.20060420160712.02ab55f8@192.168.1.6>
 <4.2.2.20060418153155.0514e5d0@192.168.1.6>
 <s5hfyk8b8n4.wl%tiwai@suse.de>
 <4.2.2.20060420160712.02ab55f8@192.168.1.6>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


> > I tried with 1.0.11rc5 and still had the problem (I don't currently have
> > the hardware setup to try 1.0.11).
>
>OK, then please show the backtrace if possible.

I tried 1.0.11 and also got the same seg fault.

With pcm -Dplug:dshare_frontl running in one terminal, I used gdb to run 
pcm -Dplug:dshare_frontr in another.
This is the output I got (using ALSA libs 1.0.11):

Starting program: /home/james/audio2000/alsa-lib-1.0.11/test/pcm 
-Dplug:dshare_frontr
[Thread debugging using libthread_db enabled]
[New Thread 16384 (LWP 1148)]
Playback device is plug:dshare_frontr
Stream parameters are 44100Hz, S16_LE, 1 channels
Sine wave rate is 440.0000Hz
Using transfer method: write

Program received signal SIGSEGV, Segmentation fault.
[Switching to Thread 16384 (LWP 1148)]
0x4003bc6c in snd_pcm_area_copy (dst_area=0xc, dst_offset=12000,
     src_area=0x804d150, src_offset=0, samples=6000,
     format=SND_PCM_FORMAT_S32_LE) at pcm.c:2537
2537            if (!dst_area->addr)
(gdb) bt
#0  0x4003bc6c in snd_pcm_area_copy (dst_area=0xc, dst_offset=12000,
     src_area=0x804d150, src_offset=0, samples=6000,
     format=SND_PCM_FORMAT_S32_LE) at pcm.c:2537
#1  0x40069d0a in share_areas (dshare=0x80555b0, src_areas=0x804d150,
     dst_areas=0x0, src_ofs=0, dst_ofs=12000, size=6000) at pcm_dshare.c:94
#2  0x40069eb8 in snd_pcm_dshare_sync_area (pcm=0x8055670) at pcm_dshare.c:146
#3  0x4006a497 in snd_pcm_dshare_start (pcm=0x8055670) at pcm_dshare.c:351
#4  0x40039a11 in snd_pcm_start (pcm=0x8056390) at pcm.c:1053
#5  0x4004b5b3 in snd_pcm_generic_start (pcm=0xc) at pcm_generic.c:155
#6  0x40039a11 in snd_pcm_start (pcm=0x8056390) at pcm.c:1053
#7  0x4004006a in snd_pcm_write_areas (pcm=0x8056210, areas=0xbffff570,
     offset=0, size=5512, func=0x40049ffc <snd_pcm_mmap_write_areas>)
     at pcm.c:6506
#8  0x4004a288 in snd_pcm_mmap_writei (pcm=0x8056210, buffer=0x8079c78,
     size=5512) at pcm_mmap.c:186
#9  0x40039d67 in snd_pcm_writei (pcm=0x8056390, buffer=0x8079c78, size=0)
     at pcm_local.h:401
#10 0x08049977 in write_loop (handle=0x8055ff8, samples=0x8079c78,
     areas=0x8055b68) at pcm.c:236
#11 0x0804aa40 in main (argc=2, argv=0xbffffa24) at pcm.c:876
(gdb)

The relevant entries in my .asoundrc are

pcm.dshare_frontl {
         type dshare
         ipc_key 9874545
         ipc_key_add_uid yes
         slave {
                 pcm "hw:0,0"
                 format S32_LE
                 rate 48000
         }
         bindings {
                 0 0
         }
}

pcm.dshare_frontr {
         type dshare
         ipc_key 9874545
         ipc_key_add_uid yes
         slave {
                 pcm "hw:0,0"
                 format S32_LE
                 rate 48000
         }
         bindings {
                 0 1
         }
}

--
James Stafford


mailto:jstafford@ampltd.com

Advanced Micro Peripherals Ltd
Unit 1
Harrier House
Sedgeway Business Park
Witchford
Cambridge
CB6 2HY

Fax:+44 1353 659 600




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
