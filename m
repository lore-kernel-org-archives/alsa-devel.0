From: Bernard Urban <Bernard.Urban@meteo.fr>
Subject: Re: Requested: CMI8330 testers?
Date: 27 Dec 2002 10:19:10 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <87el83q0oh.fsf@merceron.meteo.fr>
References: <s5hy96qro4i.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hy96qro4i.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai <tiwai@suse.de> writes:

> Hi,
> 
> can anyone who owns the CMI8330 ISA test the attached patch?

I am your man !!! Happy to see that this card is no longer forgotten.
1 month ago, I have written the following to
alsa-devel@lists.sourceforge.net, but it never got there (I was not a
subscriber at this time). 

******************************************

Short story: (and main problem)
=========
I have tried to hack the cmi8330 driver version 0.9.0beta10, which 
does not work, by relying on the (semi) functional last 0.5 driver. It
is difficult to appreciate the changes done between 0.5 and 0.9,
as the CVS Changelog misses the 0.5 era.
Any hint to fill this hole would be appreciated.

More generally, I am wondering if ALSA is still considering
maintenance on old sound chips drivers?
As an alsa-1.0 release is near, this topic seems important to the
credibility of the project. 

Long story: (plus a lot of other minor problems)
=========
I have access to 4 different Linux machines, with different sound
cards. All the machine run Debian Woody, kernel 2.4.18, 
same config for 4 machines, as far as hardware permits: 
AMD K6-II with a SB Vibra 16x PnP
AMD K6-II with a CMI8330
PIII with a intel 810
Athlon with a VIA8233

First, the two K6-II machines run fine the OSS sb driver.
When I got the Athlon machines, as via8233 is not supported by OSS
drivers, I decided to switch to ALSA 0.9 (woody packages 0.9.0beta12). 

The Athlon with snd-via8233 runs fine, no problems with using the OSS
compatibility level.
The PIII with snd-intel8x0 runs well, except that xquake (original bin
from Id) runs without producing any sound. Moot point, because
quakeforge version works well (alsa plugin).

So the problem here seems to be in the oss compatibility level ?

Now the AMD K6-II with a SB Vibra 16X PnP: runs with snd-sb16. In the
mixer I must force the 16 bit DMA to be allocated to Capture 
to have PCM sound for all kind of audio formats. If set to Auto, for instance
.au format is not recognized. Also, xquake runs and  produces sound only with
option 8bits sound. quakeforge works well, but there is a time lag in
producing sound, which does not exist with the OSS driver. 
Tuning snd-mixahead does not help. 

Finally the AMD K6-II with the CMI8330 and the snd-cmi8330 driver.
Version 0.9 does not produce sound at all. But going back to alsa 0.5,
I was able to produce PCM sound and play CDs. The mixer tuning is very
buggy (this was documented in the alsa-user mail list 2 years ago!), 
but you can have it working. xquake does not produce sound though.
quakeforge cannot be run (they use the 0.9 alsa API).

Another real pain with this driver is the use of
two devices (pcmC0D1p and pcmC0d0c) on the same card. This requires
editing several configuration files to have OSS applications work.
For instance, I must switch /dev/dsp with /dev/adsp and change in
alsa.conf to the following line:
defaults.pcm.device 1

This was corrected in the 0.9 snd-cmi8330 driver, but as it now does not
produce sound... I have analyzed the driver code differences between
0.5 and 0.9. The main difference in handling the hardware seems to be that
in the 0.5 version, the SB mixer part is initialized, not in the 0.9
one. So I added such an initialization step. I added also the SB mixer
controls to the cmi8330 ones, as it is no more possible to add a second
mixer device in the 0.9 API, at least I do not see how. 
(This addition is not understood
by alsamixer, but amixer with the complex controls works, with the
same kind of curious behaviour as amixer-0.5)

And guess what, bingo, I got PCM sound ! But an horrible sound, very
distorted, so something is still working badly. This
was just after removing the 0.5 driver and installing the modified 0.9 one.
After rebooting the machine with the 0.9 running, no more sound!

So there is obviously something which has not been initialized well in
the 0.9 driver alone. I have also tried to suppress completely any
handling of the SB part (mixer + PCM), or only resetting it, to no avail so far.

As sb16 and cmi8330 are now old chips, I am wondering if there is
today any action on the corresponding drivers more than "edit the driver file
source to make it compile if there is an API change".

***************************************

Meanwhile, I have started to read your document "Writing an Alsa
driver". This explains a lot of things, and fills a huge hole in the
Alsa project, thanks ! 

> the patch will change the pcm interface of this soundchip as a more
> reasonable way.  the playback and capture are combined into one pcm.
> it's for the latest cvs version.  not sure whether it's applicable to
> rc6.
> 
> please check whether the full-duplex works.  it's enough to run aplay
> and arecord simultaneously.

I hope to be able to test your patch for next Monday.

Regards.

-- 

Bernard Urban


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
