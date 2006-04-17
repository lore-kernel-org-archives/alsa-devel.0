From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0001882]: Use ESC key to stop the speaker-test instead of using ctrl-C
Date: Mon, 17 Apr 2006 05:20:34 +0200
Message-ID: <fb25533dc6720c8d15e2a434b1ca31b6@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 3715F19F
	for <alsa-devel@alsa-project.org>; Mon, 17 Apr 2006 05:20:35 +0200 (MEST)
Sender: alsa-devel-admin@lists.sourceforge.net
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


The following issue has been CLOSED
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1882> 
======================================================================
Reported By:                Raymond
Assigned To:                tiwai
======================================================================
Project:                    ALSA - utils
Issue ID:                   1882
Category:                   speakertest
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     closed
Resolution:                 reopened
Fixed in Version:           
======================================================================
Date Submitted:             02-27-2006 03:57 CET
Last Modified:              04-17-2006 05:20 CEST
======================================================================
Summary:                    Use ESC key to stop the speaker-test instead of
using ctrl-C
Description: 
Is it possible to use ESC key to stop the speaker-test instead of abort the
test by using control-C ?

https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1726
======================================================================

----------------------------------------------------------------------
 Raymond - 04-15-06 10:04 
----------------------------------------------------------------------
values return by read_wav seem strange at end of loop in write_loop 


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
write_loop - channel=4  periods=281  period_size=512 bufsize=4096
read_wav n=1024  err=1024
read_wav n=2048  err=1024
read_wav n=3072  err=1024
read_wav n=4096  err=1024
read_wav n=5120  err=1024
read_wav n=6144  err=1024
read_wav n=7168  err=1024
read_wav n=8192  err=1024
read_wav n=9216  err=1024
read_wav n=10240  err=1024
read_wav n=11264  err=1024
read_wav n=12288  err=1024
read_wav n=13312  err=1024
read_wav n=14336  err=1024
read_wav n=15360  err=1024
read_wav n=16384  err=1024
read_wav n=17408  err=1024
read_wav n=18432  err=1024
read_wav n=19456  err=1024
read_wav n=20480  err=1024
read_wav n=21504  err=1024
read_wav n=22528  err=1024
read_wav n=23552  err=1024
read_wav n=24576  err=1024
read_wav n=25600  err=1024
read_wav n=26624  err=1024
read_wav n=27648  err=1024
read_wav n=28672  err=1024
read_wav n=29696  err=1024
read_wav n=30720  err=1024
read_wav n=31744  err=1024
read_wav n=32768  err=1024
read_wav n=33792  err=1024
read_wav n=34816  err=1024
read_wav n=35840  err=1024
read_wav n=36864  err=1024
read_wav n=37888  err=1024
read_wav n=38912  err=1024
read_wav n=39936  err=1024
read_wav n=40960  err=1024
read_wav n=41984  err=1024
read_wav n=43008  err=1024
read_wav n=44032  err=1024
read_wav n=45056  err=1024
read_wav n=46080  err=1024
read_wav n=47104  err=1024
read_wav n=48128  err=1024
read_wav n=49152  err=1024
read_wav n=50176  err=1024
read_wav n=51200  err=1024
read_wav n=52224  err=1024
read_wav n=53248  err=1024
read_wav n=54272  err=1024
read_wav n=55296  err=1024
read_wav n=56320  err=1024
read_wav n=57344  err=1024
read_wav n=58368  err=1024
read_wav n=59392  err=1024
read_wav n=60416  err=1024
read_wav n=61440  err=1024
read_wav n=62464  err=1024
read_wav n=63488  err=1024
read_wav n=64512  err=1024
read_wav n=65536  err=1024
read_wav n=66560  err=1024
read_wav n=67584  err=1024
read_wav n=68608  err=1024
read_wav n=69632  err=1024
read_wav n=70656  err=1024
read_wav n=71680  err=1024
read_wav n=72704  err=1024
read_wav n=73728  err=1024
read_wav n=74752  err=1024
read_wav n=75776  err=1024
read_wav n=76800  err=1024
read_wav n=77824  err=1024
read_wav n=78848  err=1024
read_wav n=79872  err=1024
read_wav n=80896  err=1024
read_wav n=81920  err=1024
read_wav n=82944  err=1024
read_wav n=83968  err=1024
read_wav n=84992  err=1024
read_wav n=86016  err=1024
read_wav n=87040  err=1024
read_wav n=88064  err=1024
read_wav n=89088  err=1024
read_wav n=90112  err=1024
read_wav n=91136  err=1024
read_wav n=92160  err=1024
read_wav n=93184  err=1024
read_wav n=94208  err=1024
read_wav n=95232  err=1024
read_wav n=96256  err=1024
read_wav n=97280  err=1024
read_wav n=98304  err=1024
read_wav n=99328  err=1024
read_wav n=100352  err=1024
read_wav n=101376  err=1024
read_wav n=102400  err=1024
read_wav n=103424  err=1024
read_wav n=104448  err=1024
read_wav n=105472  err=1024
read_wav n=106496  err=1024
read_wav n=107520  err=1024
read_wav n=108544  err=1024
read_wav n=109568  err=1024
read_wav n=110592  err=1024
read_wav n=111616  err=1024
read_wav n=112640  err=1024
read_wav n=113664  err=1024
read_wav n=114688  err=1024
read_wav n=115712  err=1024
read_wav n=116736  err=1024
read_wav n=117760  err=1024
read_wav n=118784  err=1024
read_wav n=119808  err=1024
read_wav n=120832  err=1024
read_wav n=121856  err=1024
read_wav n=122880  err=1024
read_wav n=123904  err=1024
read_wav n=124928  err=1024
read_wav n=125952  err=1024
read_wav n=126976  err=1024
read_wav n=128000  err=1024
read_wav n=129024  err=1024
read_wav n=130048  err=1024
read_wav n=131072  err=1024
read_wav n=132096  err=1024
read_wav n=133120  err=1024
read_wav n=134144  err=1024
read_wav n=135168  err=1024
read_wav n=136192  err=1024
read_wav n=137216  err=1024
read_wav n=138240  err=1024
read_wav n=139202  err=962
read_wav n=139922  err=720
read_wav n=140462  err=540
read_wav n=140868  err=406
read_wav n=141172  err=304
read_wav n=141400  err=228
read_wav n=141572  err=172
read_wav n=141700  err=128
read_wav n=141796  err=96
read_wav n=141868  err=72
read_wav n=141922  err=54
read_wav n=141962  err=40
read_wav n=141992  err=30
read_wav n=142016  err=24
read_wav n=142034  err=18
read_wav n=142046  err=12
read_wav n=142056  err=10
read_wav n=142064  err=8
read_wav n=142070  err=6
read_wav n=142074  err=4
read_wav n=142076  err=2
read_wav n=142078  err=2
read_wav n=142080  err=2
read_wav n=142082  err=2
 1 - Front Right
write_loop - channel=4  periods=281  period_size=512 bufsize=4096
read_wav n=1024  err=1024
read_wav n=2048  err=1024
read_wav n=3072  err=1024
read_wav n=4096  err=1024
read_wav n=5120  err=1024
read_wav n=6144  err=1024
read_wav n=7168  err=1024
read_wav n=8192  err=1024
read_wav n=9216  err=1024
read_wav n=10240  err=1024
read_wav n=11264  err=1024
read_wav n=12288  err=1024
read_wav n=13312  err=1024
read_wav n=14336  err=1024
read_wav n=15360  err=1024
read_wav n=16384  err=1024
read_wav n=17408  err=1024
read_wav n=18432  err=1024
read_wav n=19456  err=1024
read_wav n=20480  err=1024
read_wav n=21504  err=1024
read_wav n=22528  err=1024
read_wav n=23552  err=1024
read_wav n=24576  err=1024
read_wav n=25600  err=1024
read_wav n=26624  err=1024
read_wav n=27648  err=1024
read_wav n=28672  err=1024
read_wav n=29696  err=1024
read_wav n=30720  err=1024
read_wav n=31744  err=1024
read_wav n=32768  err=1024
read_wav n=33792  err=1024
read_wav n=34816  err=1024
read_wav n=35840  err=1024
read_wav n=36864  err=1024
read_wav n=37888  err=1024
read_wav n=38912  err=1024
read_wav n=39936  err=1024
read_wav n=40960  err=1024
read_wav n=41984  err=1024
read_wav n=43008  err=1024
read_wav n=44032  err=1024
read_wav n=45056  err=1024
read_wav n=46080  err=1024
read_wav n=47104  err=1024
read_wav n=48128  err=1024
read_wav n=49152  err=1024
read_wav n=50176  err=1024
read_wav n=51200  err=1024
read_wav n=52224  err=1024
read_wav n=53248  err=1024
read_wav n=54272  err=1024
read_wav n=55296  err=1024
read_wav n=56320  err=1024
read_wav n=57344  err=1024
read_wav n=58368  err=1024
read_wav n=59392  err=1024
read_wav n=60416  err=1024
read_wav n=61440  err=1024
read_wav n=62464  err=1024
read_wav n=63488  err=1024
read_wav n=64512  err=1024
read_wav n=65536  err=1024
read_wav n=66560  err=1024
read_wav n=67584  err=1024
read_wav n=68608  err=1024
read_wav n=69632  err=1024
read_wav n=70656  err=1024
read_wav n=71680  err=1024
read_wav n=72704  err=1024
read_wav n=73728  err=1024
read_wav n=74752  err=1024
read_wav n=75776  err=1024
read_wav n=76800  err=1024
read_wav n=77824  err=1024
read_wav n=78848  err=1024
read_wav n=79872  err=1024
read_wav n=80896  err=1024
read_wav n=81920  err=1024
read_wav n=82944  err=1024
read_wav n=83968  err=1024
read_wav n=84992  err=1024
read_wav n=86016  err=1024
read_wav n=87040  err=1024
read_wav n=88064  err=1024
read_wav n=89088  err=1024
read_wav n=90112  err=1024
read_wav n=91136  err=1024
read_wav n=92160  err=1024
read_wav n=93184  err=1024
read_wav n=94208  err=1024
read_wav n=95232  err=1024
read_wav n=96256  err=1024
read_wav n=97280  err=1024
read_wav n=98304  err=1024
read_wav n=99328  err=1024
read_wav n=100352  err=1024
read_wav n=101376  err=1024
read_wav n=102400  err=1024
read_wav n=103424  err=1024
read_wav n=104448  err=1024
read_wav n=105472  err=1024
read_wav n=106496  err=1024
read_wav n=107520  err=1024
read_wav n=108544  err=1024
read_wav n=109568  err=1024
read_wav n=110592  err=1024
read_wav n=111616  err=1024
read_wav n=112640  err=1024
read_wav n=113664  err=1024
read_wav n=114688  err=1024
read_wav n=115712  err=1024
read_wav n=116736  err=1024
read_wav n=117760  err=1024
read_wav n=118784  err=1024
read_wav n=119808  err=1024
read_wav n=120832  err=1024
read_wav n=121856  err=1024
read_wav n=122880  err=1024
read_wav n=123904  err=1024
read_wav n=124928  err=1024
read_wav n=125952  err=1024
read_wav n=126976  err=1024
read_wav n=128000  err=1024
read_wav n=129024  err=1024
read_wav n=130048  err=1024
read_wav n=131072  err=1024
read_wav n=132096  err=1024
read_wav n=133120  err=1024
read_wav n=134144  err=1024
read_wav n=135168  err=1024
read_wav n=136192  err=1024
read_wav n=137216  err=1024
read_wav n=138240  err=1024
read_wav n=139264  err=1024
read_wav n=140288  err=1024
read_wav n=141312  err=1024
read_wav n=142336  err=1024
read_wav n=143360  err=1024
read_wav n=144256  err=896
read_wav n=144928  err=672
read_wav n=145432  err=504
read_wav n=145810  err=378
read_wav n=146094  err=284
read_wav n=146308  err=214
read_wav n=146468  err=160
read_wav n=146588  err=120
read_wav n=146678  err=90
read_wav n=146746  err=68
read_wav n=146796  err=50
read_wav n=146834  err=38
read_wav n=146862  err=28
read_wav n=146884  err=22
read_wav n=146900  err=16
read_wav n=146912  err=12
read_wav n=146920  err=8
read_wav n=146926  err=6
read_wav n=146932  err=6
read_wav n=146936  err=4
read_wav n=146938  err=2
read_wav n=146940  err=2
read_wav n=146942  err=2
read_wav n=146944  err=2
 3 - Rear Right
write_loop - channel=4  periods=281  period_size=512 bufsize=4096
read_wav n=1024  err=1024
read_wav n=2048  err=1024

----------------------------------------------------------------------
 rlrevell - 04-17-06 05:20 
----------------------------------------------------------------------
Please don't reopen bugs to add information unrelated to the original bug -
open a  new one

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-27-06 03:57 Raymond        New Issue                                    
02-27-06 04:01 rlrevell       Note Added: 0008212                          
03-01-06 09:51 Raymond        Note Added: 0008277                          
03-01-06 09:53 Raymond        Note Edited: 0008277                         
03-01-06 18:01 rlrevell       Note Added: 0008284                          
03-02-06 04:36 Raymond        Note Added: 0008293                          
03-02-06 04:46 Raymond        Note Edited: 0008293                         
03-02-06 04:49 Raymond        Note Edited: 0008293                         
03-02-06 12:44 tiwai          Status                   new => resolved     
03-02-06 12:44 tiwai          Resolution               open => won't fix   
03-02-06 12:44 tiwai          Assigned To               => tiwai           
03-02-06 12:44 tiwai          Note Added: 0008298                          
03-24-06 17:29 Raymond        Status                   resolved => feedback
03-24-06 17:29 Raymond        Resolution               won't fix => reopened
03-24-06 17:29 Raymond        Note Added: 0008924                          
03-24-06 17:32 Raymond        Note Edited: 0008924                         
03-24-06 17:42 tiwai          Status                   feedback => resolved
03-24-06 17:42 tiwai          Resolution               reopened => fixed   
03-24-06 17:42 tiwai          Note Added: 0008929                          
03-25-06 13:22 Raymond        Status                   resolved => feedback
03-25-06 13:22 Raymond        Resolution               fixed => reopened   
03-25-06 13:22 Raymond        Note Added: 0008947                          
03-29-06 19:06 tiwai          Status                   feedback => resolved
03-29-06 19:06 tiwai          Resolution               reopened => fixed   
03-29-06 19:06 tiwai          Note Added: 0009007                          
04-15-06 10:04 Raymond        Status                   resolved => feedback
04-15-06 10:04 Raymond        Resolution               fixed => reopened   
04-15-06 10:04 Raymond        Note Added: 0009292                          
04-17-06 05:20 rlrevell       Status                   feedback => closed  
04-17-06 05:20 rlrevell       Note Added: 0009299                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
