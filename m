From: Jerry Geis <geisj@pagestation.com>
Subject: seg fault with 1.0.17rc2
Date: Thu, 26 Jun 2008 10:38:57 -0400
Message-ID: <4863AA01.7080900@pagestation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from unifiedpaging.messagenetsystems.com
	(www.emergencycommunicationsystems.com [24.123.23.170])
	by alsa0.perex.cz (Postfix) with ESMTP id 130A4103807
	for <alsa-devel@alsa-project.org>;
	Thu, 26 Jun 2008 16:39:00 +0200 (CEST)
Received: from devcentos5x64.msgnet.com (devcentos5x64 [192.168.1.8])
	by unifiedpaging.messagenetsystems.com (8.13.1/8.13.1) with ESMTP id
	m5QEcwUe005586
	for <alsa-devel@alsa-project.org>; Thu, 26 Jun 2008 10:38:58 -0400
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

#0  0xb7e892ff in memcpy () from /lib/tls/libc.so.6
#1  0xb74e40a9 in snd_pcm_area_copy (dst_area=0xb7125b70, dst_offset=0, 
src_area=0x81dc1c0, src_offset=170, samples=0, 
format=SND_PCM_FORMAT_S16_LE) at pcm.c:2589
#2  0xb74e438d in snd_pcm_areas_copy (dst_areas=0xb7125b7c, 
dst_offset=0, src_areas=0x81dc1cc, src_offset=170, channels=1, 
frames=122, format=SND_PCM_FORMAT_S16_LE) at pcm.c:2736
#3  0xb74ee0a1 in snd_pcm_mmap_read_areas (pcm=0x81de3b8, 
areas=0xb7125b70, offset=0, size=122) at pcm_mmap.c:151
#4  0xb74e350d in snd1_pcm_read_areas (pcm=0x81de3b8, areas=0xb7125b70, 
offset=0, size=122, func=0xb74edfd0 <snd_pcm_mmap_read_areas>) at pcm.c:6501
#5  0xb74ed2df in snd_pcm_mmap_readi (pcm=0x81de3b8, buffer=0xb6352a04, 
size=122) at pcm_mmap.c:236
#6  0xb74dbb14 in snd_pcm_readi (pcm=0x81de110, buffer=0xb6352a04, 
size=61) at pcm_local.h:526
#7  0xb756279b in alsa_read (chan=0x821c928) at chan_alsa.c:683
#8  0x080855b1 in __ast_read (chan=0x821c928, dropaudio=0) at channel.c:2100

I am using a usb-audio device.

Bus 003 Device 001: ID 0000:0000 
Bus 003 Device 002: ID 0d8c:000c C-Media Electronics, Inc. Audio Adapter
Bus 002 Device 002: ID 13fe:1f00 
Bus 002 Device 001: ID 0000:0000 
Bus 004 Device 001: ID 0000:0000 
Bus 001 Device 001: ID 0000:0000 

I am using this as my asound.conf file

       pcm.usb-audio {
          type hw
          card 0
       }
      
       ctl.usb-audio {
          type hw
          card 0
       }

I am using debian etch  2.6.18-6-486 #1 Fri Jun 6 21:47:01 UTC 2008 i486 
GNU/Linux

It works for a couple times then I get the seg fault. I am using the 
Console output from asterisk.

help? Thanks,

Jerry
