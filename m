From: Raymond <rayau@netvigator.com>
Subject: Re: au8830 - front / rear channels swapped after first play and Surround40
Date: Sat, 12 Mar 2005 17:27:09 +0800
Message-ID: <4232B5ED.1080508@netvigator.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
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
Cc: openvortex-dev@nongnu.org
List-Id: alsa-devel@alsa-project.org

> > 3) Is the bug related to "vortex: IRQ fifo error" ?

>  No, thats not a bug. Thats normal.

http://lists.gnu.org/archive/html/openvortex-dev/2004-03/msg00007.html

I think the front/rear swap bug is related to that "vortex: IRQ fifo error".

As the hardware equalizer is only connected from the front channels to 
the CODECOUT(0/1) in the ALSA au88x0 driver when playing at 4 channel 
sound through hw:0,0 (adb)

Routes After adb_allocroute() in snd_vortex_pcm_hw_params-----------
00028100 : 00000041   ADBDMA(00) -> SRCIN(01)
00028104 : 00000042   ADBDMA(00) -> SRCIN(02)
00028108 : 00000043   ADBDMA(00) -> SRCIN(03)
00028140 : 00007151   CODECIN(1) -> MIXIN(01)
00028144 : 00002052   SRCOUT(00) -> MIXIN(02)
00028148 : 00002153   SRCOUT(01) -> MIXIN(03)
0002814c : 00002254   SRCOUT(02) -> MIXIN(04)
00028150 : 00002355   SRCOUT(03) -> MIXIN(05)
00028220 : 00007f89   EQOUT(1) -> CODECOUT(1)
00028224 : 0000328c   MIXOUT(02) -> CODECOUT(4)
00028230 : 0000338d   MIXOUT(03) -> CODECOUT(5)
00028234 : 00007050   CODECIN(0) -> MIXIN(00)
00028248 : 00003593   MIXOUT(05) -> SPDIFOUT(1)
00028280 : 000031a1   MIXOUT(01) -> EQIN(1)
00028284 : 00007e88   EQOUT(0) -> CODECOUT(0)
000282c0 : 00000040   ADBDMA(00) -> SRCIN(00)
000282f8 : 000030a0   MIXOUT(00) -> EQIN(0)
00028304 : 00003492   MIXOUT(04) -> SPDIFOUT(0)
----------------------------------------
MIXIN_MIXOUT ENABLE
21a00 : 00000004   mixin(02) -> mixout(00)
21a20 : 00000008   mixin(03) -> mixout(01)
21a44 : 00000001   mixin(04) -> mixout(02)
21a64 : 00000002   mixin(05) -> mixout(03)
21a80 : 00000004   mixin(02) -> mixout(04)
21a84 : 00000001   mixin(04) -> mixout(04)
21aa0 : 00000008   mixin(03) -> mixout(05)
21aa4 : 00000002   mixin(05) -> mixout(05)


#/etc/init.d/alsasound stop
Shutting down sound driver: done
# /etc/init.d/alsasound start
Starting sound driver: snd-au8830 done

http://cvs.sourceforge.net/viewcvs.py/alsa/alsa-utils/speaker-test/

Running "speaker-test -c 4" and watching the graphical equalizer of the
vortexcontrol

# speaker-test -c 4

  speaker-test 0.0.7

Playback device is plughw:0,0
Stream parameters are 48000Hz, S16_LE, 4 channels
Sine wave rate is 440.0000Hz
Rate set to 48000Hz (requested 48000Hz)
Buffer size range from 2 to 8192
Period size range from 1 to 512
Periods = 4
Buffer time size 2525
To choose buffer_size = 8192
To choose period_size = 2048
was set period_size = 512
was set buffer_size = 8192
  0 - Front Left
  1 - Front Right
  3 - Rear Right
  2 - Rear Left
Time per period = 11.854851
  0 - Front Left
  1 - Front Right
  3 - Rear Right
  2 - Rear Left
Time per period = 11.987920
  0 - Front Left

The 10 bands graphical equalizer in vortexcontrol show peak value at
500Hz band when speaker-test is testing the front left and front right,
no value when speaker-test is testing rear left and rear right.
(Front/Rear channels are all correct)

As there is no option to let "speaker-test" to run for a specified
number of pass and stop, it is aborted by Control-C.

When running the "speaker-test -c 4" again, the graphical equalizer show
peak value at 500Hz band only when speaker-test is testing the rear left
and rear right and no value when it is testing the Front Left and
Front Right. (Front/Rear channels are swapped until driver is reloaded).

It seem that the patch mentioned in

http://lists.gnu.org/archive/html/openvortex-dev/2003-12/msg00009.html

intened to fixed the problem in the OSS application in

http://lists.gnu.org/archive/html/openvortex-dev/2003-11/msg00016.html


1) Is the FIFO is still suspending not stopped ?












-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
