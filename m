From: Michael Duelli <m.duelli@web.de>
Subject: Problems with via686a and aplay
Date: Sat, 2 Mar 2002 15:07:26 +0100
Message-ID: <20020302150726.B4427@Unimatrix01.surf-callino.de>
References: <20020302150620.A4208@Unimatrix01.surf-callino.de>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Received: from smtp.web.de (smtp02.web.de [217.72.192.151])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id PAA25092
	for <alsa-devel@alsa-project.org>; Sat, 2 Mar 2002 15:08:16 +0100
Received: from [213.7.149.18] (helo=Unimatrix01)
	by smtp.web.de with esmtp (WEB.DE(Exim) 4.29 #47)
	id 16hAAf-0007Qx-00
	for alsa-devel@alsa-project.org; Sat, 02 Mar 2002 15:07:34 +0100
In-Reply-To: =?iso-8859-1?Q?=3C20020302150620=2EA4208?=
	=?iso-8859-1?Q?=40Unimatrix01=2Esurf-callino=2Ede=3E=3B_from_m=2Eduelli?=
	=?iso-8859-1?Q?=40web=2Ede_on_Sam=2C_M=E4r?= 02, 2002 at 15:06:20 +0100
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi

I am using alsa 0.9beta12 and a via686a soundchip which works fine.

But aplay seems to have a problem for me:
Everytime I start aplay with a sound file, it gives a SEGFAULT!

This is what gdb says:

GNU gdb 4.18
Copyright 1998 Free Software Foundation, Inc.
GDB is free software, covered by the GNU General Public License, and you
are
welcome to change it and/or distribute copies of it under certain
conditions.
Type "show copying" to see the conditions.
There is absolutely no warranty for GDB.  Type "show warranty" for details.
This GDB was configured as "i386-suse-linux"...
(gdb) run /usr/local/share/licq/sounds/fun/Message.wav
Starting program: /usr/bin/aplay
/usr/local/share/licq/sounds/fun/Message.wav
Playing WAVE '/usr/local/share/licq/sounds/fun/Message.wav' : Signed 16
bit Litt
le Endian, Rate 8012 Hz, Mono

Program received signal SIGSEGV, Segmentation fault.
snd_pcm_rate_expand (dst_areas=0x80588f0, dst_offset=5997,
dst_framesp=0xbffff4d8, src_areas=0xbffff554, src_offset=5997,
src_frames=4294962300, channels=1, getidx=4, putidx=4,
get_threshold=392627, states=0x8058900) at plugin_ops.h:321
321     get16_12_12: sample = as_u16c(src); goto GET16_END;
(gdb) list
316
317     #ifdef GET16_END
318     while(0) {
319     get16_1_10: sample = (u_int16_t)as_u8c(src) << 8; goto GET16_END;
320     get16_1_90: sample = (u_int16_t)(as_u8c(src) ^ 0x80) << 8; goto
GET16_EN
D;
321     get16_12_12: sample = as_u16c(src); goto GET16_END;
322     get16_12_92: sample = as_u16c(src) ^ 0x8000; goto GET16_END;
323     get16_12_21: sample = bswap_16(as_u16c(src)); goto GET16_END;
324     get16_12_A1: sample = bswap_16(as_u16c(src) ^ 0x80); goto
GET16_END;
325     get16_0123_12: sample = as_u32c(src) >> 8; goto GET16_END;
(gdb)
Can you make anything of that ?

I am not in the list, so please cc to me, just tell me if you need more
information

TIA,
Michael
___________________________________
Michael Duelli
m.duelli@web.de
http://glchess.sf.net - A 3D chess interface


_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
