From: =?iso-8859-1?q?Chris=20Rankin?= <rankincj@yahoo.com>
Subject: Cannot allocate memory (on a 1GB box???)
Date: Fri, 20 Sep 2002 23:14:40 +0100 (BST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020920221440.3880.qmail@web40604.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

[Linux 2.4.19-SMP, SB Live!, alsa-lib CVS, alsa-utils
rc3]

I have just tried to play a WAV file on my machine,
but have triggered these errors instead. The machine
didn't crash, fortunately, but it's very irritating to
have memory problems on a 1 GB machine:

$ aplay /usr/lib/sounds/jungle_exit.wav 
Playing WAVE '/usr/lib/sounds/jungle_exit.wav' :
Signed 16 bit Little Endian, Rate 22050 Hz, Stereo
ALSA lib pcm_hw.c:295:(snd_pcm_hw_hw_params)
SNDRV_PCM_IOCTL_HW_PARAMS failed: Cannot allocate
memory
aplay: set_params:787: Unable to install hw params:
ACCESS:  RW_INTERLEAVED
FORMAT:  S16_LE
SUBFORMAT:  STD
SAMPLE_BITS: 16
FRAME_BITS: 32
CHANNELS: 2
RATE: 22050
PERIOD_TIME: 100000
PERIOD_SIZE: 2205
PERIOD_BYTES: 8820
PERIODS: 5
BUFFER_TIME: 500000
BUFFER_SIZE: 11025
BUFFER_BYTES: 44100
TICK_TIME: 10000

My machine's memory looks like this:

$ free -t
             total       used       free     shared   
buffers     cached
Mem:       1033544    1008608      24936          0   
  42292     747088
-/+ buffers/cache:     219228     814316
Swap:       498004       4788     493216
Total:     1531548    1013396     518152

$ cat /proc/slabinfo
slabinfo - version: 1.1 (SMP)
kmem_cache            96     96    244    6    6    1
:  252  126
fib6_nodes             5    226     32    2    2    1
:  252  126
ip6_dst_cache          5     40    192    2    2    1
:  252  126
ndisc_cache            1     30    128    1    1    1
:  252  126
nfs_write_data         0      0    384    0    0    1
:  124   62
nfs_read_data          0      0    384    0    0    1
:  124   62
nfs_page               0      0     96    0    0    1
:  252  126
uhci_urb_priv          1     63     60    1    1    1
:  252  126
hpsb_packet            0      0     96    0    0    1
:  252  126
tcp_tw_bucket          1     30    128    1    1    1
:  252  126
tcp_bind_bucket       19    339     32    3    3    1
:  252  126
tcp_open_request       0      0     96    0    0    1
:  252  126
inet_peer_cache        2     59     64    1    1    1
:  252  126
ip_fib_hash           10    226     32    2    2    1
:  252  126
ip_dst_cache          13    168    160    7    7    1
:  252  126
arp_cache              1     30    128    1    1    1
:  252  126
blkdev_requests      512    560     96   14   14    1
:  252  126
devfsd_event         127    169     20    1    1    1
:  252  126
journal_head          14    234     48    3    3    1
:  252  126
revoke_table           1    253     12    1    1    1
:  252  126
revoke_record          0      0     32    0    0    1
:  252  126
dnotify cache          0      0     20    0    0    1
:  252  126
file lock cache        5     84     92    2    2    1
:  252  126
fasync cache           3    202     16    1    1    1
:  252  126
uid_cache              3    113     32    1    1    1
:  252  126
skbuff_head_cache    209    552    160   23   23    1
:  252  126
sock                 116    176    928   44   44    1
:  124   62
sigqueue              12     58    132    1    2    1
:  252  126
cdev_cache           109    236     64    4    4    1
:  252  126
bdev_cache             9    118     64    2    2    1
:  252  126
mnt_cache             18    118     64    2    2    1
:  252  126
inode_cache        15646  22896    480 2862 2862    1
:  124   62
dentry_cache         679   4020    128  134  134    1
:  252  126
dquot                  3     60    128    2    2    1
:  252  126
filp                1567   1590    128   53   53    1
:  252  126
names_cache            3      3   4096    3    3    1
:   60   30
buffer_head       202510 207760     96 5194 5194    1
:  252  126
mm_struct            240    240    160   10   10    1
:  252  126
vm_area_struct      1981   2720     96   68   68    1
:  252  126
fs_cache             302    354     64    6    6    1
:  252  126
files_cache          144    144    416   16   16    1
:  124   62
signal_act            96     96   1312   32   32    1
:   60   30
size-131072(DMA)       0      0 131072    0    0   32
:    0    0
size-131072            0      0 131072    0    0   32
:    0    0
size-65536(DMA)        0      0  65536    0    0   16
:    0    0
size-65536             1      1  65536    1    1   16
:    0    0
size-32768(DMA)        0      0  32768    0    0    8
:    0    0
size-32768             0      0  32768    0    0    8
:    0    0
size-16384(DMA)        0      0  16384    0    0    4
:    0    0
size-16384             5      6  16384    5    6    4
:    0    0
size-8192(DMA)         0      0   8192    0    0    2
:    0    0
size-8192              9      9   8192    9    9    2
:    0    0
size-4096(DMA)         0      0   4096    0    0    1
:   60   30
size-4096             69     69   4096   69   69    1
:   60   30
size-2048(DMA)         0      0   2048    0    0    1
:   60   30
size-2048             85    112   2048   56   56    1
:   60   30
size-1024(DMA)         0      0   1024    0    0    1
:  124   62
size-1024            172    204   1024   51   51    1
:  124   62
size-512(DMA)          0      0    512    0    0    1
:  124   62
size-512             199    264    512   33   33    1
:  124   62
size-256(DMA)          0      0    256    0    0    1
:  252  126
size-256             345    345    256   23   23    1
:  252  126
size-128(DMA)          2     30    128    1    1    1
:  252  126
size-128            2952   3000    128  100  100    1
:  252  126
size-64(DMA)           0      0     64    0    0    1
:  252  126
size-64              914   1357     64   23   23    1
:  252  126
size-32(DMA)           2    113     32    1    1    1
:  252  126
size-32             2466   4972     32   44   44    1
:  252  126

It was apparently the 16 bit nature of the WAV file
which was causing trouble, because I got my sound back
by playing an 8 bit one instead. It's all very odd.
Was my memory just momentarily too fragmented for ALSA
to allocate a big enough DMA buffer?

Chris


__________________________________________________
Do You Yahoo!?
Everything you'll ever need on one web page
from News and Sport to Email and Music Charts
http://uk.my.yahoo.com


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
