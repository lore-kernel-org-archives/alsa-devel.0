From: alfp <alfp@adsmr.co.za>
Subject: crash with rc8
Date: 05 Mar 2003 12:10:42 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1046859047.2847.6.camel@didjeridu.adsmr.co.za>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I seem to have problems opening many devices quickly.
I use Mandrake 9, kernel 2.4.19-16mdkenterprise and 
gcc-3.2.1 (GCC) 3.2.1 (Mandrake Linux 9.1 3.2.1-2mdk)

When I do this:

x=32
while [ $x -ne 0 ]
do
	let x=x-1
	aplay /usr/share/sounds/phone.wav >bomb.$x 2>&1 &
done

I get a large number of segmentation faults (unfortunately no coredumps)
and messages claiming

Playing WAVE '/usr/share/sounds/phone.wav' : Signed 16 bit Little Endian, Rate 44100 Hz, Stereo

ALSA lib pcm_hw.c:325:(snd_pcm_hw_hw_params) SNDRV_PCM_IOCTL_HW_PARAMS failed: Cannot allocate memory
aplay: set_params:839: Unable to install hw params:
ACCESS:  RW_INTERLEAVED
FORMAT:  S16_LE
SUBFORMAT:  STD
SAMPLE_BITS: 16
FRAME_BITS: 32
CHANNELS: 2
RATE: 44100
PERIOD_TIME: 100000
PERIOD_SIZE: 4410
PERIOD_BYTES: 17640
PERIODS: 5
BUFFER_TIME: 500000
BUFFER_SIZE: 22050
BUFFER_BYTES: 88200
TICK_TIME: 10000

Also, dmesg gives me

Unable to handle kernel NULL pointer dereference at virtual address 00000008
 printing eip:
f8b410b7
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<f8b410b7>]    Not tainted
EFLAGS: 00010296
eax: f6384bd8   ebx: 00000000   ecx: 00000000   edx: f6384bd8
esi: 00015888   edi: 00015888   ebp: f638c000   esp: f6277c5c
ds: 0018   es: 0018   ss: 0018
Process aplay (pid: 2288, stackpage=f6277000)
Stack: 00000000 00000000 f63170f4 f6384ba0 f754b800 f8b561a3 f6384bd8 00015888 
       00000000 00000000 00000000 00000000 00000000 f63170e0 f6384ba0 f6277ce4 
       f8b66f21 f6384ba0 00015888 f754b800 00000000 f6277ce4 f6384ba0 f8b4b4e0 
Call Trace:    [<f8b561a3>] [<f8b66f21>] [<f8b4b4e0>] [<f8b4b594>] [<f8b4ed4a>]
  [<c01b87b0>] [<c0129666>] [<c01563ff>] [<c0109627>]

Code: c7 43 08 00 00 00 00 8b 02 83 f8 02 0f 84 97 00 00 00 83 f8 

(one for each crashed aplay)



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
