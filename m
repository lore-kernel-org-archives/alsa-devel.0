From: noreply@alsa-project.org
Subject: [ALSA - driver 0000124]: 2.6.2-bk2 -> 2.6.3-rc1: change in ALSA behavior, artsd heavily loads CPU at KDE startup
Date: Fri, 16 Jul 2004 14:30:14 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040716123014.4DCBC2C005@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 88D47244
	for <alsa-devel@alsa-project.org>; Fri, 16 Jul 2004 14:30:14 +0200 (MEST)
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


The following bug has been CLOSED
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000124
======================================================================
Reported By:                vda
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Bug ID:                     124
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               
Kernel Version:             2.6.3-rc1
======================================================================
Date Submitted:             03-08-2004 00:16 CET
Last Modified:              07-16-2004 14:30 CEST
======================================================================
Summary:                    2.6.2-bk2 -> 2.6.3-rc1: change in ALSA behavior, artsd heavily loads CPU at KDE startup
Description: 
Before artsd used to send audio data mostly in 4k chunks.
Now it feeds /dev/dsp with tiny ~300 byte pieces.

As a result, artsd heavily hogs CPU at KDE startup
and after every KDE sound for 40+ seconds.
Mouse is very jerky even in framebuffer console,
not only in X, typed characters visibly lag behind
keypresses etc...

My KDE is 3.1.4.

bash-2.05b# lspci
00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev
02)
00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP]
00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South]
(rev 22)
00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 10)
00:07.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
(rev 30)
00:07.5 Multimedia audio controller: VIA Technologies, Inc. AC97 Audio
Controller (rev 20)
00:0a.0 Network controller: Harris Semiconductor: Unknown device 3890 (rev
01)
00:0f.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev
10)
01:00.0 VGA compatible controller: nVidia Corporation Vanta [NV6] (rev
15)

bash-2.05b# lsmod
Module                  Size  Used by
snd_pcm_oss            53124  1
snd_mixer_oss          19328  1 snd_pcm_oss
snd_via82xx            24704  1
snd_pcm                93824  2 snd_pcm_oss,snd_via82xx
snd_timer              25088  1 snd_pcm
snd_ac97_codec         57860  1 snd_via82xx
snd_page_alloc         12420  2 snd_via82xx,snd_pcm
snd_mpu401_uart         7680  1 snd_via82xx
snd_rawmidi            24320  1 snd_mpu401_uart
snd_seq_device          8580  1 snd_rawmidi
snd                    53508  9
snd_pcm_oss,snd_mixer_oss,snd_via82xx,snd_pcm,snd_timer,snd_ac97_codec,snd_mpu401_uart,snd_rawmidi,snd_seq_device
soundcore               9696  2 snd
iptable_mangle          2944  0
iptable_filter          2816  0
autofs                 15616  1
ip_nat_irc              4208  0
ip_conntrack_irc       71316  1 ip_nat_irc
ip_nat_ftp              4848  0
iptable_nat            23332  2 ip_nat_irc,ip_nat_ftp
ip_tables              17936  3 iptable_mangle,iptable_filter,iptable_nat
ip_conntrack_ftp       71956  1 ip_nat_ftp
ip_conntrack           32288  5
ip_nat_irc,ip_conntrack_irc,ip_nat_ftp,iptable_nat,ip_conntrack_ftp

I collected straces of artsd with this script:
#!/bin/sh
i=0; while true; do
    pid=`pidof artsd`
    test "$pid" || continue
    cmd="strace -tt -p $pid"
    echo "$cmd"
    $cmd 2>&1
    echo "Exit code: $?"
    test "$?" != 0 && exit
i=$((i+1)); done \
| tee `date +'%H:%M:%S'`

(Don't know why but strace exits when it sees SIGALARM
in artsd, is that normal?? Script was needed in order to
restart strace)

Gzipped straces for 2.6.2 and 2.6.4-rc2-bk3 are attached.
I tested those kernels and only later did binary search.
BTW, logs are abridged, grep for "<--- snipped .... --->".
2.6.4-rc2-bk3 log was over 170Mb in size....

Look here, it's 2.6.4:

20:09:02.444349 gettimeofday({1078682942, 444403}, NULL) = 0
20:09:02.444487 gettimeofday({1078682942, 444525}, NULL) = 0
20:09:02.444584 select(9, [3 5], [8], [5 8], {0, 97304}) = 1 (out [8],
left {0, 98000})
20:09:02.445035 gettimeofday({1078682942, 445104}, NULL) = 0
20:09:02.445216 gettimeofday({1078682942, 445261}, NULL) = 0
20:09:02.445362 ioctl(8, SNDCTL_DSP_GETOSPACE, 0xbffff7b0) = 0
20:09:02.445482 write(8,
"\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 344) = 344
20:09:02.445636 gettimeofday({1078682942, 445674}, NULL) = 0
20:09:02.445747 gettimeofday({1078682942, 445784}, NULL) = 0

<--- snipped ~212000 lines including several ALARM signals --->

20:10:14.135608 select(10, [3 5 9], [8], [5 8 9], {0, 6279}) = 1 (out [8],
left {0, 7000})
20:10:14.136045 ioctl(8, SNDCTL_DSP_GETOSPACE, 0xbffff7b0) = 0
20:10:14.136193 write(8,
"\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 164) = 164
20:10:14.136345 gettimeofday({1078683014, 136382}, NULL) = 0
20:10:14.136452 gettimeofday({1078683014, 136488}, NULL) = 0
20:10:14.136548 select(10, [3 5 9], [8], [5 8 9], {0, 5341}) = 1 (out [8],
left {0, 6000})
20:10:14.136863 ioctl(8, SNDCTL_DSP_GETOSPACE, 0xbffff7b0) = 0
20:10:14.137526 write(8,
"\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 220) = 220
20:10:14.137714 gettimeofday({1078683014, 137752}, NULL) = 0
20:10:14.137829 gettimeofday({1078683014, 137866}, NULL) = 0
20:10:14.137955 select(10, [3 5 9], [8], [5 8 9], {0, 3963}) = 1 (out [8],
left {0, 4000})
20:10:14.138293 ioctl(8, SNDCTL_DSP_GETOSPACE, 0xbffff7b0) = 0
20:10:14.138402 write(8,
"\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 172) = 172
20:10:14.138564 gettimeofday({1078683014, 138601}, NULL) = 0
20:10:14.138666 gettimeofday({1078683014, 138702}, NULL) = 0
20:10:14.138760 select(10, [3 5 9], [8], [5 8 9], {0, 3127}) = 1 (out [8],
left {0, 4000})
20:10:14.139108 ioctl(8, SNDCTL_DSP_GETOSPACE, 0xbffff7b0) = 0
20:10:14.139212 write(8,
"\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 144) = 144


versus 2.6.2:


20:23:59.400884 select(10, [3 5 9], [8], [5 8 9], {0, 116000}) = 1 (out
[8], left {0, 95000})
        sleeps 0.02 seconds before sending another 4k -> good, does not
hog CPU.
        In 2.6.4 there are no such sleeps.
20:23:59.423682 lseek(10, 93212, SEEK_SET) = 93212
20:23:59.423763 read(10,
"\177\22\264\22\317\22\377\0224\23?\23\332\22\375\21\352"..., 288) = 288
20:23:59.423938 lseek(10, 93468, SEEK_SET) = 93468
20:23:59.423979 read(10,
"k\2\223\2Y\2\351\1X\1\256\0\23\0\207\377\340\376\v\376"..., 288) = 288
20:23:59.427337 gettimeofday({1078683839, 427407}, NULL) = 0
20:23:59.427956 lseek(10, 93724, SEEK_SET) = 93724
20:23:59.428096 read(10,
"\221\7\237\7j\7\10\7\243\6R\6\26\6\350\5\274\5v\5 \5\6"..., 288) = 288
20:23:59.428292 lseek(10, 93980, SEEK_SET) = 93980
20:23:59.428336 read(10,
"G\363\227\362|\362\304\362\20\363=\363o\363\277\363\21"..., 288) = 288
20:23:59.431090 gettimeofday({1078683839, 431208}, NULL) = 0
20:23:59.431371 ioctl(8, SNDCTL_DSP_GETOSPACE, 0xbffff780) = 0
20:23:59.431757 write(8,
")\23)\23\2\23\2\23\250\22\250\22A\22A\22\265\21\265\021"..., 4096) =
4096

<--- skipped ~4000 lines including several ALARM events --->

20:24:05.509120 gettimeofday({1078683845, 509158}, NULL) = 0
20:24:05.509271 gettimeofday({1078683845, 509312}, NULL) = 0
20:24:05.509374 select(10, [3 5 9], [8], [5 8 9], {0, 6972}) = 0
(Timeout)
20:24:05.516275 gettimeofday({1078683845, 516313}, NULL) = 0
20:24:05.516399 gettimeofday({1078683845, 516437}, NULL) = 0
20:24:05.516497 select(10, [3 5 9], [8], [5 8 9], {0, 199847}) = 1 (out
[8], left {0, 187000})
        sleeps again
20:24:05.530118 lseek(10, 362524, SEEK_SET) = 362524
20:24:05.530281 read(10,
"\363\377\362\377\371\377\367\377\372\377\372\377\373\377"..., 288) = 288
20:24:05.530482 lseek(10, 362780, SEEK_SET) = 362780
20:24:05.530579 read(10,
"\355\377\360\377\361\377\362\377\363\377\363\377\365\377"..., 288) = 288
20:24:05.530816 gettimeofday({1078683845, 530873}, NULL) = 0
20:24:05.531000 lseek(10, 363036, SEEK_SET) = 363036
20:24:05.531110 read(10,
"3\0001\0-\0-\0.\0000\0/\0,\0)\0&\0&\0\'\0&\0$\0!\0 \0"..., 288) = 288
20:24:05.531344 lseek(10, 363292, SEEK_SET) = 363292
20:24:05.531445 read(10,
"\375\377\376\377\371\377\371\377\370\377\371\377\373\377"..., 288) = 288
20:24:05.531668 brk(0x8185000)          = 0x8185000
20:24:05.531833 gettimeofday({1078683845, 531879}, NULL) = 0
20:24:05.531953 ioctl(8, SNDCTL_DSP_GETOSPACE, 0xbffff780) = 0
20:24:05.532093 write(8,
"\373\377\373\377\373\377\373\377\372\377\372\377\370\377"..., 4096) =
4096

What is at fault, ALSA changes or artsd?
======================================================================

Bug History
Date Modified  Username       Field                    Change              
======================================================================
03-08-04 00:16 vda            New Bug                                      
03-08-04 11:46 tiwai          duplicate_id             0 => 53             
03-08-04 11:46 tiwai          Assigned To               => tiwai           
03-08-04 11:46 tiwai          Resolution               open => duplicate   
03-08-04 11:46 tiwai          Status                   new => resolved     
07-16-04 14:30 tiwai          Status                   resolved => closed  
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
