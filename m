From: James Stafford <jstafford@ampltd.com>
Subject: AUDIO2000 and DShare plugin
Date: Tue, 18 Apr 2006 16:12:09 +0100
Message-ID: <4.2.2.20060418153155.0514e5d0@192.168.1.6>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
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
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,
Almost two years ago (May 2003), the company I work for successfully used 
the DShare plugin to have each channel of our Envy24HT based PC104+ card 
controlled by a different application.
To do this, we had an entry for each channel in the .asoundrc file similar 
to this

pcm.dshare_frontl {
	type dshare
	ipc_key 9874545
	ipc_key_add_uid yes
	slave {
		pcm "hw:0,0"
	}
	bindings {
		0 0
	}
}

A customer of ours now wants to do something similar but using a later 
version of ALSA.
We have found that the old .asoundrc doesn't work with the latest ALSA. 
Using the pcm test program from ALSA-lib-1.0.10 gives the following

[james]$ ./pcm -Ddshare_frontl
Playback device is dshare_frontr
Stream parameters are 44100Hz, S16_LE, 1 channels
Sine wave rate is 440.0000Hz
Using transfer method: write
ALSA lib pcm_direct.c:812:(snd_pcm_direct_initialize_slave) requested or 
auto-format is not available
ALSA lib pcm_dshare.c:682:(snd_pcm_dshare_open) unable to initialize slave
Playback open error: Invalid argument

I can overcome this error by changing the .asoundrc entries to read

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

and using -Dplug:dshare_frontl
However, running multiple instances of pcm is causing a segmentation fault.
Running pcm from within gdb gives the following backtrace

Program received signal SIGSEGV, Segmentation fault.
[Switching to Thread -1208712096 (LWP 2605)]
0xb7f99874 in snd_pcm_area_copy (dst_area=0xc, dst_offset=6008,
     src_area=0x804d0c8, src_offset=0, samples=11992,
     format=SND_PCM_FORMAT_S32_LE) at pcm.c:2487
2487            if (!dst_area->addr)
(gdb) bt
#0  0xb7f99874 in snd_pcm_area_copy (dst_area=0xc, dst_offset=6008,
     src_area=0x804d0c8, src_offset=0, samples=11992,
     format=SND_PCM_FORMAT_S32_LE) at pcm.c:2487
#1  0xb7fc9172 in share_areas (dshare=0x8055160, src_areas=0x804d0c8,
     dst_areas=0x0, src_ofs=0, dst_ofs=6008, size=11992) at pcm_dshare.c:94
#2  0xb7fc9320 in snd_pcm_dshare_sync_area (pcm=0x8055218) at pcm_dshare.c:146
#3  0xb7fc98ff in snd_pcm_dshare_start (pcm=0x8055218) at pcm_dshare.c:351
#4  0xb7f97601 in snd_pcm_start (pcm=0x8055ee8) at pcm.c:1005
#5  0xb7fa64a3 in snd_pcm_generic_start (pcm=0xc) at pcm_generic.c:155
#6  0xb7f97601 in snd_pcm_start (pcm=0x8055ee8) at pcm.c:1005
#7  0xb7f9dc7e in snd_pcm_write_areas (pcm=0x8055d68, areas=0xbffff500,
     offset=5512, size=0, func=0xb7fb3f20 <snd_pcm_mmap_write_areas>)
     at pcm.c:6457
#8  0xb7fb41ac in snd_pcm_mmap_writei (pcm=0x8055d68, buffer=0x80797d0,
     size=5512) at pcm_mmap.c:186
#9  0xb7f97957 in snd_pcm_writei (pcm=0x8055ee8, buffer=0x80797d0, size=0)
     at pcm_local.h:401
#10 0x0804996f in write_loop (handle=0x8055b90, samples=0x80797d0,
     areas=0x8055708) at pcm.c:233
#11 0x0804aa38 in main (argc=2, argv=0xbffff9e4) at pcm.c:873

It has been almost 2 years since I used ALSA (or the Envy24HT) and so I am 
a little out of touch with the code.
Can anyone give me a clue for how to solve this problem?


--
James Stafford

Advanced Micro Peripherals Ltd
Unit 1
Harrier House
Sedgeway Business Park
Witchford
Cambridge
CB6 2HY

Fax:+44 1353 659 600




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
