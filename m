From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001724]: au88x0 PCM configuration
	problem - buffer_size constraint
Date: Sat, 1 Jul 2006 04:20:28 +0200
Message-ID: <53efca7c0bbee7291f0fc69862395390@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 59D42235
	for <alsa-devel@alsa-project.org>;
	Sat,  1 Jul 2006 04:20:29 +0200 (MEST)
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


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1724> 
======================================================================
Reported By:                Raymond
Assigned To:                mjander
======================================================================
Project:                    ALSA - driver
Issue ID:                   1724
Category:                   PCI - au88x0
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             01-07-2006 05:10 CET
Last Modified:              07-01-2006 04:20 CEST
======================================================================
Summary:                    au88x0 PCM configuration problem - buffer_size
constraint
Description: 
/cvs/alsa-lib/test/pcm_min

ALSA lib pcm.c:7127:(snd_pcm_set_params) Unable to set buffer time
(latency) 500000 for PLAYBACK: Invalid argument
Playback open error: Invalid argument

sound card is au8830, the au88x0 driver only accept period size in power
of 2.
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
related to          0001766 jackd : ALSA: cannot set period size to...
======================================================================

----------------------------------------------------------------------
 Raymond - 06-30-06 13:55 
----------------------------------------------------------------------
The following is output of "test.c" which I upload, any idea how to refine
the constraints (period_size and buffer_size) according to the latency 0.5
second

 ./test
pcm state after pcm open : 0
period size (min=1   max=4096)
           1
           2
           4
           8
           16
           32
           64
           128
           256
           512
           1024
           2048
           4096
buffer size (min=2   max=65536)
           2
           3
           4
           5
           6
           7
           8
           9
           10
           11
           12
           13
           14
           15
           16
           17
           18
           19
           20
           21
           22
           23
           24
           25
           26
           27
           28
           29
           30
           31
           32
           34
           36
           38
           40
           42
           44
           46
           48
           50
           52
           54
           56
           58
           60
           62
           64
           68
           72
           76
           80
           84
           88
           92
           96
           100
           104
           108
           112
           116
           120
           124
           128
           136
           144
           152
           160
           168
           176
           184
           192
           200
           208
           216
           224
           232
           240
           248
           256
           272
           288
           304
           320
           336
           352
           368
           384
           400
           416
           432
           448
           464
           480
           496
           512
           544
           576
           608
           640
           672
           704
           736
           768
           800
           832
           864
           896
           928
           960
           992
           1024
           1088
           1152
           1216
           1280
           1344
           1408
           1472
           1536
           1600
           1664
           1728
           1792
           1856
           1920
           1984
           2048
           2176
           2304
           2432
           2560
           2688
           2816
           2944
           3072
           3200
           3328
           3456
           3584
           3712
           3840
           3968
           4096
           4352
           4608
           4864
           5120
           5376
           5632
           5888
           6144
           6400
           6656
           6912
           7168
           7424
           7680
           7936
           8192
           8704
           9216
           9728
           10240
           10752
           11264
           11776
           12288
           12800
           13312
           13824
           14336
           14848
           15360
           15872
           16384
           17408
           18432
           19456
           20480
           21504
           22528
           23552
           24576
           25600
           26624
           27648
           28672
           29696
           30720
           31744
           32768
           34816
           36864
           38912
           40960
           43008
           45056
           47104
           49152
           51200
           53248
           55296
           57344
           59392
           61440
           63488
           65536
pcm state before hw_params : 0
pcm state after hw_params : 2
period size = 1
buffer size = 32



----------------------------------------------------------------------
 Raymond - 07-01-06 04:20 
----------------------------------------------------------------------
The original subject of the bug report is "simple PCM helper function". 

a bug report about snd_pcm_set_params() and snd_pcm_get_params()

I just want to report some alsa driver (e.g. au88x0) has problem in using
the new alsa-lib functions

I don't know why perex change the subject to "au88x0 PCM configuration
problem - buffer_size constraint"


The DMA of au88x0 seem to have different mode, the au88x0 driver currently
seem to use IRQ_PCMOUT 0x0020 /* PCM OUT page crossing */ , this can be
verified by adding printk statement in vortex_interrupt() using 12.288Mhz
clock tick (VORTEX_SMP_TIME) to calculate the time interval between
snd_pcm_period_elapsed()

It seem that the au88x0 cannot use a very small buffer size (e.g. 2) when
using IRQ_PCMOUT

Does it mean that we need to change some constraints in
snd_vortex_pcm_open() ?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-07-06 05:10 Raymond        New Issue                                    
01-09-06 15:19 Raymond        Note Added: 0007537                          
01-19-06 15:04 Raymond        Note Deleted: 0007537                        
01-19-06 15:36 Raymond        Note Added: 0007721                          
01-28-06 07:58 Raymond        Note Added: 0007828                          
01-28-06 07:58 Raymond        Note Deleted: 0007721                        
01-30-06 18:46 Raymond        Note Added: 0007840                          
01-31-06 03:15 Raymond        Note Added: 0007844                          
01-31-06 06:41 Raymond        Note Edited: 0007840                         
01-31-06 07:03 Raymond        Note Edited: 0007840                         
01-31-06 07:08 Raymond        Note Edited: 0007840                         
01-31-06 07:11 Raymond        Note Edited: 0007840                         
01-31-06 08:31 Raymond        Note Edited: 0007840                         
01-31-06 09:48 Raymond        Note Edited: 0007844                         
01-31-06 10:19 perex          Note Added: 0007845                          
01-31-06 10:26 perex          Note Added: 0007847                          
01-31-06 10:26 perex          Note Edited: 0007847                         
01-31-06 10:48 perex          Project                  ALSA - lib => ALSA -
driver
01-31-06 10:49 perex          Category                 0_general => PCI - au88x0
01-31-06 10:49 perex          Summary                  simple PCM helper
function => au88x0 PCM configuration problem - buffer_size constraint
01-31-06 11:06 Raymond        Note Added: 0007848                          
01-31-06 13:48 perex          Status                   new => assigned     
01-31-06 13:48 perex          Assigned To               => mjander         
01-31-06 13:49 perex          Relationship added       related to 0001766  
01-31-06 15:59 Raymond        Note Added: 0007852                          
02-01-06 07:35 perex          Note Added: 0007857                          
02-01-06 10:32 Raymond        Note Added: 0007858                          
02-01-06 10:37 Raymond        Note Edited: 0007848                         
02-01-06 17:15 Raymond        Note Edited: 0007844                         
02-01-06 17:20 Raymond        Note Added: 0007860                          
02-02-06 10:23 Raymond        Note Added: 0007874                          
02-02-06 11:10 Raymond        Note Edited: 0007874                         
02-02-06 15:48 Raymond        Note Edited: 0007874                         
02-03-06 14:26 Raymond        Note Added: 0007897                          
02-04-06 02:46 Raymond        Note Edited: 0007874                         
02-04-06 02:52 Raymond        Note Edited: 0007858                         
02-04-06 02:56 Raymond        Note Edited: 0007858                         
02-05-06 16:39 Raymond        Note Added: 0007939                          
02-05-06 16:48 Raymond        Note Added: 0007940                          
02-06-06 04:40 Raymond        Note Deleted: 0007939                        
02-06-06 06:15 Raymond        Note Edited: 0007940                         
02-07-06 07:35 Raymond        Note Added: 0007954                          
02-13-06 03:11 Raymond        Note Added: 0008036                          
02-13-06 08:52 mjander        Note Added: 0008039                          
02-13-06 16:57 Raymond        Note Added: 0008055                          
02-13-06 17:02 Raymond        Note Edited: 0008055                         
02-13-06 17:02 Raymond        Note Edited: 0008055                         
02-16-06 04:01 Raymond        Note Added: 0008083                          
02-19-06 06:31 Raymond        Note Added: 0008130                          
02-19-06 06:39 Raymond        Note Edited: 0008130                         
03-07-06 11:08 Raymond        Note Added: 0008362                          
03-07-06 14:18 Raymond        Note Edited: 0007844                         
03-24-06 10:51 Raymond        File Added: snd_pcm_set_params.patch              
     
03-30-06 18:35 Raymond        Note Added: 0009036                          
05-22-06 15:11 Raymond        Note Deleted: 0008055                        
05-22-06 15:12 Raymond        Note Deleted: 0008362                        
05-22-06 15:13 Raymond        Note Deleted: 0008130                        
05-22-06 15:14 Raymond        Note Deleted: 0008083                        
05-22-06 15:15 Raymond        Note Deleted: 0009036                        
05-22-06 15:16 Raymond        Note Deleted: 0007860                        
05-22-06 15:17 Raymond        Note Deleted: 0007848                        
05-22-06 15:20 Raymond        Note Deleted: 0007940                        
05-22-06 15:24 Raymond        Note Deleted: 0007954                        
05-22-06 15:48 Raymond        Note Added: 0009912                          
05-30-06 09:36 Raymond        Note Added: 0010017                          
05-30-06 09:38 Raymond        Note Edited: 0010017                         
05-30-06 18:31 rlrevell       Note Added: 0010020                          
06-30-06 13:49 Raymond        File Added: test.c                           
06-30-06 13:53 Raymond        Note Added: 0010734                          
06-30-06 13:55 Raymond        Note Edited: 0010734                         
07-01-06 04:20 Raymond        Note Added: 0010756                          
======================================================================



Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
