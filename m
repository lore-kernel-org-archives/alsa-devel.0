From: Ted <ted@nowtsfree.freeserve.co.uk>
Subject: alsa-1.0.1 and linux-2.2.25
Date: Wed, 21 Jan 2004 00:53:46 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040121005347.29ECB4955@marimba.home.net>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: ted@nowtsfree.freeserve.co.uk
List-Id: alsa-devel@alsa-project.org

Hello, thanks for including fixes for my previous problems
loading alsa modules into linux-2.2.25. Unfortunately, a new
problem appeared in alsa-driver-1.0.1. It compiles happily,
but will not load:

/lib/modules/2.2.25/misc/snd-page-alloc.o:
	unresolved symbol snd_wrapper_request_region

I suspect the cause is a recent change to the file
	alsa-driver-1.0.1/acore/pci_compat_22.c

I managed to load the modules by changing acore/pci_compat_22.c:
356c356
<               snd_wrapper_request_region(pci_resource_start(pdev, bar),
---
>               request_region(pci_resource_start(pdev, bar),

but confess to not fully understand the code, so please check this.


Now a longer standing problem. I have not been able to use alsa since
the alsa-lib API changed, because I still get bad data passed by
pcm.c:6442		snd_pcm_hw_params_set_period_time_near(),
to
pcm.c:3782		__snd_pcm_hw_params_set_period_time_near(),
on its way to
pcm_params.c:786	snd_pcm_hw_param_set_near().

The argument to these functions called "val" is being dereferenced
once too often. Possibly by the macro
pcm.c:6424		__P_OLD_NEAR1

I note that no-one else is reporting this problem, and many people
seem to be able to run programs like aplay and alsaplayer without
getting nonsense like this:

aplay /home/ted/Sound/Data/drum6.wav
Playing WAVE '/home/ted/Sound/Data/drum6.wav' : Signed 16 bit Little Endian, Rate 8000 Hz, Stereo
aplay: set_params:875: Unable to install hw params:
ACCESS:  RW_INTERLEAVED
FORMAT:  S16_LE
SUBFORMAT:  STD
SAMPLE_BITS: 16
FRAME_BITS: 32
CHANNELS: 2
RATE: NONE				<---**** here's what I get!
PERIOD_TIME: (341333 341334)		<---****
PERIOD_SIZE: (46041032 46041033)	<---****
PERIOD_BYTES: (184164128 184164132)
PERIODS: (1 2)
BUFFER_TIME: (341333 341334)
BUFFER_SIZE: 46041077
BUFFER_BYTES: 184164308
TICK_TIME: 10000

I can only assume it to be related to my particular setup.
I'm using gcc-2.95.3 glibc-2.1.3 ld.so-1.9.9 libtool-1.5
modutils-2.3.17 binutils-2.10 linux-2.2.25. What else?

I configured alsa-lib with
./configure --prefix=/usr --with-versioned=no --with-debug=yes \
	CFLAGS="-g -O2" LDFLAGS="-g -O2"

and aplay with
./configure --prefix=/usr \
	CFLAGS="-g -O2" LDFLAGS="-g -O2"

I've double checked that there are no old headers or libraries
lying around from earlier versions of alsa. I tried deleting
the dynamic libasound.* and rebuilding aplay against a static
libasound, but the problem wont go away.

Suggestions?

Ted.
-- 
Ted <ted@nowtsfree.freeserve.co.uk>
   http://www.nowtsfree.freeserve.co.uk


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
