From: Friedrich Ewaldt <friedrich.ewaldt@gmx.de>
Subject: Re: [PATCH] cs46xx Phase reversal fixes and some AC3
 pass through progress
Date: Mon, 09 Dec 2002 16:23:05 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3DF4B559.9030507@gmx.de>
References: <3DF3DFD9.2060002@cucumelo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
To: Benny Sjostrand <gorm@cucumelo.org>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi Benny,

I tested your patch and phase reversals are gone now. That's fine so 
far. But to apply your patch I had to install a version newer than rc6. 
I downloaded the cvs snapshot 2002-12-09.tar.bz2 and installed it 
successfully. After that the SPDIF ac3 mode switch is gone (like with 
rc6 + your previous patch). That seems to be ok.(?)
But now I have the following problems with my terratec xfire card that I 
didn't have with the unpatched rc6 version:

* SPDIF input doesn't work anymore: no sound. Even reinstalling 
unpatched rc6 only helps if I do a cold reboot afterwards. (restarting 
alsa after installing rc6 doesn't help)

* (probably related) SPDIF volume control can't be changed individually 
for left and right channel. If you change the volume of one channel, the 
other channel follows more or less. I get a max. volume difference betw. 
right and left channel of 4 (on the scale 0..100).

* full duplex operation causes much more xruns compared to unpatched rc6:
My application sets input and output buffer size to 1024 frames, chunk 
size to 512 and the avail_min (for the poll/wait function) to 512. Then 
I link playback and capture device and basically do the following:

// using buffer size = 2 * chunk size
// therefore, fill output buffer with 2*chunkSize frames before starting
err = snd_pcm_wait(pHandle, 1000);
    if(err < 0){fprintf(stderr, "output wait error(init0.5): %s\n", 
snd_strerror(err));return -1;}
err = snd_pcm_writei(pHandle, outbuf, chunkSize);
  if(err < 0){fprintf(stderr, "audio output error(init1): %s\n", 
snd_strerror(err));return -1;}
err = snd_pcm_wait(pHandle, 1000);
    if(err < 0){fprintf(stderr, "output wait error(init1.5): %s\n", 
snd_strerror(err));return -1;}
err = snd_pcm_writei(pHandle, outbuf, chunkSize);
    if(err < 0){fprintf(stderr, "audio output error(init2): %s\n", 
snd_strerror(err));return -1;}
// start audio device
err = snd_pcm_start(cHandle);
      if(err < 0){fprintf(stderr, "error starting streams: %s\n", 
snd_strerror(err));return -1;}

Then a loop of waits for the capture device, readi, wait for playback 
device, writei, ... follows.
This code worked with (almost) no xruns with rc6 driver. With cvs from 
2002-12-09 (patched for phase reversal or not does no difference), this 
code doesn't work anymore, the first writei fails with 'broken pipe' 
error. This shouldn't be the case since the snd_pcm_wait returned 
without error and there must be space left in the buffer. If I change 
the buffer size to 2048 frames (still chunkSize = 512), the program 
works in about 2 of 3 cases and fails after various chunks 
played/recorded otherwise with xruns. I don't know if I could have 
programmed something wrong, but it worked with rc6 without problems and 
stable. I don't see a reason why the first writei could fail if the 
buffer is empty and snd_pcm_wait has returned without error before.
Do you have an idea if the changes of the driver code could cause these 
problems?
  fe

PS. regarding the phase reversal problems: switching the 'pcm out 
path&mute' control from pre3d to post3d (or back) also reverses the 
phase of the pcm output. That's no problem for stereo sound because left 
and rigth channel always have same phase but it might cause problems 
with > 2 channels/surround sound.

Benny Sjostrand schrieb:

> Hi!
>
> In this patch the phase problems should be gone, if still think that 
> you got "phase reversal" problem
> please sendme a dump of the /proc/asound/card0/dsp/sample content 
> while you are playbacking
> whatever giving you "phase reversal" problem.
>
> On the AC3 front I've managed to get my receiver to switch on to 
> "Digital Surround" mode (instead of PCM), which
> must mean that it finally detected the AC3 stream. But still no sound, 
> got no idea why, but please if you
> have time give it a test.
>
> Consider this patch as "experimental", just in the mean, dont be 
> surprised if something that worked
> OK before is now broken.
>
> Summar of changes:
> - Phase reversal fixes.
> - Some rewrites on playback code, related to the sample rate setup.
> - AC3 stuff ....
>
> /Benny
>
>  
>



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
