From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: OSS support in Linux specifically for ID Software games.
Date: Sat, 19 Nov 2005 14:52:20 +0000
Message-ID: <437F3C24.5040402@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010908070103010601080009"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------010908070103010601080009
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I have done an strace on enemy-territory in an effort to try and see 
what it is doing, and think of a way for Linux to work better with it.

As you can see from my extracts from the strace, ET is basically opening 
the sound device, doing a mmap, and then polling the hw_ptr of the 
buffer. It is not using a callback method or a specific snd_pcm_write 
method.

So, if we could write a module that simply diverted all IOCTL calls to 
/dev/dsp to a user land deamon, we might be able to achieve a good 
working model.

The user daemon would contain the mmaped memory, and ET would write to it.
The user daemon would have a resampler in it, and use standard alsa 
callback methods. Each time the callback happens, the user daemon would 
consume samples from the mmapped memory, resample them suitably for the 
output and use the normal alsa api to write them.

So, I am suggesting that for all OSS emulation, we use this user land 
double buffer. That will result in all OSS applications working, and not 
just a select few.

This double buffer is specifically needed so that the buffer the 
application sees can be bigger than the one the hardware has.

Any comments?

James

--------------010908070103010601080009
Content-Type: text/plain;
 name="sound.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sound.txt"

open("/dev/dsp", O_RDWR)                = 27
getuid32()                              = 1000
setresuid32(-1, 1000, -1)               = 0
ioctl(27, SNDCTL_DSP_GETCAPS, 0xbffd2bbc) = 0
ioctl(27, SNDCTL_DSP_STEREO, 0xbffd2bb4) = 0
ioctl(27, SNDCTL_DSP_SPEED or SOUND_PCM_READ_RATE, 0x925c2f4) = 0
ioctl(27, SNDCTL_DSP_SETFMT or SOUND_PCM_READ_BITS, 0xbffd2bb0) = 0
ioctl(27, SNDCTL_DSP_GETOSPACE, 0xbffd2bc0) = 0
mmap2(NULL, 65536, PROT_WRITE, MAP_SHARED, 27, 0) = 0xaf9c1000
ioctl(27, SNDCTL_DSP_GETTRIGGER, 0xbffd2bb4) = 0
ioctl(27, SNDCTL_DSP_GETTRIGGER, 0xbffd2bb4) = 0
...
gettimeofday({1132410255, 66560}, NULL) = 0
gettimeofday({1132410255, 66618}, NULL) = 0
ioctl(27, SNDCTL_DSP_GETOPTR, 0xbffc2690) = 0
gettimeofday({1132410255, 67928}, NULL) = 0
gettimeofday({1132410255, 67985}, NULL) = 0 
gettimeofday({1132410255, 68039}, NULL) = 0
...
gettimeofday({1132410255, 113937}, NULL) = 0
gettimeofday({1132410255, 113994}, NULL) = 0
ioctl(27, SNDCTL_DSP_GETOPTR, 0xbffd2bb0) = 0
...
gettimeofday({1132410255, 118952}, NULL) = 0
gettimeofday({1132410255, 119008}, NULL) = 0
ioctl(27, SNDCTL_DSP_GETOPTR, 0xbffd2bb0) = 0
...
gettimeofday({1132410255, 129800}, NULL) = 0
gettimeofday({1132410255, 129856}, NULL) = 0
ioctl(27, SNDCTL_DSP_GETOPTR, 0xbffd2bb0) = 0



--------------010908070103010601080009--


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
