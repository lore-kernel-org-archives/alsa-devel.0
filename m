From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0002026]: random swapping of channels
	when running speaker-test
Date: Tue, 18 Jul 2006 14:30:06 +0200
Message-ID: <edca498285c612d2d3ff23d2e64ba0dd@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 5302319A
	for <alsa-devel@alsa-project.org>;
	Tue, 18 Jul 2006 14:30:06 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


The following issue has been ASSIGNED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2026> 
======================================================================
Reported By:                Raymond
Assigned To:                jcdutton
======================================================================
Project:                    ALSA - utils
Issue ID:                   2026
Category:                   speakertest
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
======================================================================
Date Submitted:             04-17-2006 07:26 CEST
Last Modified:              07-18-2006 14:30 CEST
======================================================================
Summary:                    random swapping of channels when running
speaker-test
Description: 

values return by read_wav seem strange at end of loop in write_loop.


speaker-test -c 4 -t wav -D hw:0,0
 
speaker-test 1.0.11rc5
 
Playback device is hw:0,0
Stream parameters are 48000Hz, S16_LE, 4 channels
WAV file(s)
Rate set to 48000Hz (requested 48000Hz)
Buffer size range from 2 to 8192
Period size range from 1 to 512
Using max buffer size 8192
Periods = 4
was set period_size = 512
was set buffer_size = 8192
 0 - Front Left
write_loop - channel=4 periods=281 period_size=512 bufsize=4096
read_wav n=1024 err=1024
read_wav n=2048 err=1024
read_wav n=3072 err=1024
read_wav n=4096 err=1024
read_wav n=5120 err=1024
read_wav n=6144 err=1024
read_wav n=7168 err=1024
read_wav n=8192 err=1024
read_wav n=9216 err=1024
read_wav n=10240 err=1024
read_wav n=11264 err=1024
read_wav n=12288 err=1024
read_wav n=13312 err=1024
read_wav n=14336 err=1024
read_wav n=15360 err=1024
read_wav n=16384 err=1024
read_wav n=17408 err=1024
read_wav n=18432 err=1024
read_wav n=19456 err=1024
read_wav n=20480 err=1024
read_wav n=21504 err=1024
read_wav n=22528 err=1024
read_wav n=23552 err=1024
read_wav n=24576 err=1024
read_wav n=25600 err=1024
read_wav n=26624 err=1024
read_wav n=27648 err=1024
read_wav n=28672 err=1024
read_wav n=29696 err=1024
read_wav n=30720 err=1024
read_wav n=31744 err=1024
read_wav n=32768 err=1024
read_wav n=33792 err=1024
read_wav n=34816 err=1024
read_wav n=35840 err=1024
read_wav n=36864 err=1024
read_wav n=37888 err=1024
read_wav n=38912 err=1024
read_wav n=39936 err=1024
read_wav n=40960 err=1024
read_wav n=41984 err=1024
read_wav n=43008 err=1024
read_wav n=44032 err=1024
read_wav n=45056 err=1024
read_wav n=46080 err=1024
read_wav n=47104 err=1024
read_wav n=48128 err=1024
read_wav n=49152 err=1024
read_wav n=50176 err=1024
read_wav n=51200 err=1024
read_wav n=52224 err=1024
read_wav n=53248 err=1024
read_wav n=54272 err=1024
read_wav n=55296 err=1024
read_wav n=56320 err=1024
read_wav n=57344 err=1024
read_wav n=58368 err=1024
read_wav n=59392 err=1024
read_wav n=60416 err=1024
read_wav n=61440 err=1024
read_wav n=62464 err=1024
read_wav n=63488 err=1024
read_wav n=64512 err=1024
read_wav n=65536 err=1024
read_wav n=66560 err=1024
read_wav n=67584 err=1024
read_wav n=68608 err=1024
read_wav n=69632 err=1024
read_wav n=70656 err=1024
read_wav n=71680 err=1024
read_wav n=72704 err=1024
read_wav n=73728 err=1024
read_wav n=74752 err=1024
read_wav n=75776 err=1024
read_wav n=76800 err=1024
read_wav n=77824 err=1024
read_wav n=78848 err=1024
read_wav n=79872 err=1024
read_wav n=80896 err=1024
read_wav n=81920 err=1024
read_wav n=82944 err=1024
read_wav n=83968 err=1024
read_wav n=84992 err=1024
read_wav n=86016 err=1024
read_wav n=87040 err=1024
read_wav n=88064 err=1024
read_wav n=89088 err=1024
read_wav n=90112 err=1024
read_wav n=91136 err=1024
read_wav n=92160 err=1024
read_wav n=93184 err=1024
read_wav n=94208 err=1024
read_wav n=95232 err=1024
read_wav n=96256 err=1024
read_wav n=97280 err=1024
read_wav n=98304 err=1024
read_wav n=99328 err=1024
read_wav n=100352 err=1024
read_wav n=101376 err=1024
read_wav n=102400 err=1024
read_wav n=103424 err=1024
read_wav n=104448 err=1024
read_wav n=105472 err=1024
read_wav n=106496 err=1024
read_wav n=107520 err=1024
read_wav n=108544 err=1024
read_wav n=109568 err=1024
read_wav n=110592 err=1024
read_wav n=111616 err=1024
read_wav n=112640 err=1024
read_wav n=113664 err=1024
read_wav n=114688 err=1024
read_wav n=115712 err=1024
read_wav n=116736 err=1024
read_wav n=117760 err=1024
read_wav n=118784 err=1024
read_wav n=119808 err=1024
read_wav n=120832 err=1024
read_wav n=121856 err=1024
read_wav n=122880 err=1024
read_wav n=123904 err=1024
read_wav n=124928 err=1024
read_wav n=125952 err=1024
read_wav n=126976 err=1024
read_wav n=128000 err=1024
read_wav n=129024 err=1024
read_wav n=130048 err=1024
read_wav n=131072 err=1024
read_wav n=132096 err=1024
read_wav n=133120 err=1024
read_wav n=134144 err=1024
read_wav n=135168 err=1024
read_wav n=136192 err=1024
read_wav n=137216 err=1024
read_wav n=138240 err=1024
read_wav n=139202 err=962
read_wav n=139922 err=720
read_wav n=140462 err=540
read_wav n=140868 err=406
read_wav n=141172 err=304
read_wav n=141400 err=228
read_wav n=141572 err=172
read_wav n=141700 err=128
read_wav n=141796 err=96
read_wav n=141868 err=72
read_wav n=141922 err=54
read_wav n=141962 err=40
read_wav n=141992 err=30
read_wav n=142016 err=24
read_wav n=142034 err=18
read_wav n=142046 err=12
read_wav n=142056 err=10
read_wav n=142064 err=8
read_wav n=142070 err=6
read_wav n=142074 err=4
read_wav n=142076 err=2
read_wav n=142078 err=2
read_wav n=142080 err=2
read_wav n=142082 err=2
 1 - Front Right
write_loop - channel=4 periods=281 period_size=512 bufsize=4096
read_wav n=1024 err=1024
read_wav n=2048 err=1024
read_wav n=3072 err=1024
read_wav n=4096 err=1024
read_wav n=5120 err=1024
read_wav n=6144 err=1024
read_wav n=7168 err=1024
read_wav n=8192 err=1024
read_wav n=9216 err=1024
read_wav n=10240 err=1024
read_wav n=11264 err=1024
read_wav n=12288 err=1024
read_wav n=13312 err=1024
read_wav n=14336 err=1024
read_wav n=15360 err=1024
read_wav n=16384 err=1024
read_wav n=17408 err=1024
read_wav n=18432 err=1024
read_wav n=19456 err=1024
read_wav n=20480 err=1024
read_wav n=21504 err=1024
read_wav n=22528 err=1024
read_wav n=23552 err=1024
read_wav n=24576 err=1024
read_wav n=25600 err=1024
read_wav n=26624 err=1024
read_wav n=27648 err=1024
read_wav n=28672 err=1024
read_wav n=29696 err=1024
read_wav n=30720 err=1024
read_wav n=31744 err=1024
read_wav n=32768 err=1024
read_wav n=33792 err=1024
read_wav n=34816 err=1024
read_wav n=35840 err=1024
read_wav n=36864 err=1024
read_wav n=37888 err=1024
read_wav n=38912 err=1024
read_wav n=39936 err=1024
read_wav n=40960 err=1024
read_wav n=41984 err=1024
read_wav n=43008 err=1024
read_wav n=44032 err=1024
read_wav n=45056 err=1024
read_wav n=46080 err=1024
read_wav n=47104 err=1024
read_wav n=48128 err=1024
read_wav n=49152 err=1024
read_wav n=50176 err=1024
read_wav n=51200 err=1024
read_wav n=52224 err=1024
read_wav n=53248 err=1024
read_wav n=54272 err=1024
read_wav n=55296 err=1024
read_wav n=56320 err=1024
read_wav n=57344 err=1024
read_wav n=58368 err=1024
read_wav n=59392 err=1024
read_wav n=60416 err=1024
read_wav n=61440 err=1024
read_wav n=62464 err=1024
read_wav n=63488 err=1024
read_wav n=64512 err=1024
read_wav n=65536 err=1024
read_wav n=66560 err=1024
read_wav n=67584 err=1024
read_wav n=68608 err=1024
read_wav n=69632 err=1024
read_wav n=70656 err=1024
read_wav n=71680 err=1024
read_wav n=72704 err=1024
read_wav n=73728 err=1024
read_wav n=74752 err=1024
read_wav n=75776 err=1024
read_wav n=76800 err=1024
read_wav n=77824 err=1024
read_wav n=78848 err=1024
read_wav n=79872 err=1024
read_wav n=80896 err=1024
read_wav n=81920 err=1024
read_wav n=82944 err=1024
read_wav n=83968 err=1024
read_wav n=84992 err=1024
read_wav n=86016 err=1024
read_wav n=87040 err=1024
read_wav n=88064 err=1024
read_wav n=89088 err=1024
read_wav n=90112 err=1024
read_wav n=91136 err=1024
read_wav n=92160 err=1024
read_wav n=93184 err=1024
read_wav n=94208 err=1024
read_wav n=95232 err=1024
read_wav n=96256 err=1024
read_wav n=97280 err=1024
read_wav n=98304 err=1024
read_wav n=99328 err=1024
read_wav n=100352 err=1024
read_wav n=101376 err=1024
read_wav n=102400 err=1024
read_wav n=103424 err=1024
read_wav n=104448 err=1024
read_wav n=105472 err=1024
read_wav n=106496 err=1024
read_wav n=107520 err=1024
read_wav n=108544 err=1024
read_wav n=109568 err=1024
read_wav n=110592 err=1024
read_wav n=111616 err=1024
read_wav n=112640 err=1024
read_wav n=113664 err=1024
read_wav n=114688 err=1024
read_wav n=115712 err=1024
read_wav n=116736 err=1024
read_wav n=117760 err=1024
read_wav n=118784 err=1024
read_wav n=119808 err=1024
read_wav n=120832 err=1024
read_wav n=121856 err=1024
read_wav n=122880 err=1024
read_wav n=123904 err=1024
read_wav n=124928 err=1024
read_wav n=125952 err=1024
read_wav n=126976 err=1024
read_wav n=128000 err=1024
read_wav n=129024 err=1024
read_wav n=130048 err=1024
read_wav n=131072 err=1024
read_wav n=132096 err=1024
read_wav n=133120 err=1024
read_wav n=134144 err=1024
read_wav n=135168 err=1024
read_wav n=136192 err=1024
read_wav n=137216 err=1024
read_wav n=138240 err=1024
read_wav n=139264 err=1024
read_wav n=140288 err=1024
read_wav n=141312 err=1024
read_wav n=142336 err=1024
read_wav n=143360 err=1024
read_wav n=144256 err=896
read_wav n=144928 err=672
read_wav n=145432 err=504
read_wav n=145810 err=378
read_wav n=146094 err=284
read_wav n=146308 err=214
read_wav n=146468 err=160
read_wav n=146588 err=120
read_wav n=146678 err=90
read_wav n=146746 err=68
read_wav n=146796 err=50
read_wav n=146834 err=38
read_wav n=146862 err=28
read_wav n=146884 err=22
read_wav n=146900 err=16
read_wav n=146912 err=12
read_wav n=146920 err=8
read_wav n=146926 err=6
read_wav n=146932 err=6
read_wav n=146936 err=4
read_wav n=146938 err=2
read_wav n=146940 err=2
read_wav n=146942 err=2
read_wav n=146944 err=2
 3 - Rear Right
write_loop - channel=4 periods=281 period_size=512 bufsize=4096
read_wav n=1024 err=1024
read_wav n=2048 err=1024
======================================================================

----------------------------------------------------------------------
 Raymond - 04-18-06 14:33 
----------------------------------------------------------------------
int bufsize = snd_pcm_frames_to_bytes(handle, period_size);

The value bufsize is the size of n-channels pcm but the wav file is mono

----------------------------------------------------------------------
 Raymond - 04-28-06 06:16 
----------------------------------------------------------------------
James,
  speaker-test -t wav has some strange behaviour when writing the last few
buffers ( it split them to many small fragments ),it seem to be a bug in
read_wav()

----------------------------------------------------------------------
 Raymond - 04-29-06 13:16 
----------------------------------------------------------------------
--- alsa-utils-1.0.11/speaker-test/speaker-test.c.orig	2006-04-07
01:24:12.000000000 +0800
+++ alsa-utils-1.0.11/speaker-test/speaker-test.c	2006-04-29
19:10:27.000000000 +0800
@@ -613,7 +613,6 @@
   }
   if (offset + bufsize > wav_file_size[channel])
     bufsize = wav_file_size[channel] - offset;
-  bufsize /= channels;
   for (size = 0; size < bufsize; size += 2) {
     int chn;
     for (chn = 0; chn < channels; chn++) {

----------------------------------------------------------------------
 Raymond - 05-31-06 15:23 
----------------------------------------------------------------------
Why do speaker-test split the last 2/3 buffers into smaller fragments ? 

This seem to be the cause of random channel swapping  

----------------------------------------------------------------------
 Raymond - 06-03-06 03:02 
----------------------------------------------------------------------
This strange behaviour of read_wav() also occur when using 2 channels

speaker-test -c2 -t wav -Dhw:1,0
 
speaker-test 1.0.11
 
Playback device is hw:1,0
Stream parameters are 48000Hz, S16_LE, 2 channels
WAV file(s)
Rate set to 48000Hz (requested 48000Hz)
Buffer size range from 8 to 16384
Period size range from 8 to 16384
Using max buffer size 16384
Periods = 4
was set period_size = 4096
was set buffer_size = 16384
 0 - Front Left
n=8192 err=8192
n=16384 err=8192
n=24576 err=8192
n=32768 err=8192
n=40960 err=8192
n=49152 err=8192
n=57344 err=8192
n=65536 err=8192
n=73728 err=8192
n=81920 err=8192
n=90112 err=8192
n=98304 err=8192
n=106496 err=8192
n=114688 err=8192
n=122880 err=8192
n=131072 err=8192
n=136578 err=5506
n=139332 err=2754
n=140708 err=1376
n=141396 err=688
n=141740 err=344
n=141912 err=172
n=141998 err=86
n=142042 err=44
n=142064 err=22
n=142074 err=10
n=142080 err=6
n=142082 err=2
n=142084 err=2
 1 - Front Right
n=8192 err=8192
n=16384 err=8192
n=24576 err=8192
n=32768 err=8192
n=40960 err=8192
n=49152 err=8192
n=57344 err=8192
n=65536 err=8192
n=73728 err=8192
n=81920 err=8192
n=90112 err=8192
n=98304 err=8192
n=106496 err=8192
n=114688 err=8192
n=122880 err=8192
n=131072 err=8192
n=139010 err=7938
n=142978 err=3968
n=144962 err=1984
n=145954 err=992
n=146450 err=496
n=146698 err=248
n=146822 err=124
n=146884 err=62
n=146916 err=32
n=146932 err=16
n=146940 err=8
n=146944 err=4
n=146946 err=2
Time per period = 2.790380
 0 - Front Left

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-17-06 07:26 Raymond        New Issue                                    
04-18-06 14:33 Raymond        Note Added: 0009334                          
04-28-06 06:16 Raymond        Issue Monitored: jcdutton                    
04-28-06 06:16 Raymond        Note Added: 0009539                          
04-29-06 13:16 Raymond        Note Added: 0009542                          
05-31-06 15:23 Raymond        Issue Monitored: tiwai                       
05-31-06 15:23 Raymond        Note Added: 0010022                          
06-03-06 03:02 Raymond        Note Added: 0010059                          
07-18-06 14:30 jcdutton       Status                   new => assigned     
07-18-06 14:30 jcdutton       Assigned To               => jcdutton        
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
