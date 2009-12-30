From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: alsa-util.c: snd_pcm_avail() returned a value that
	is exceptionally large: 349696 bytes (1821 ms).
Date: Wed, 30 Dec 2009 15:07:14 +0800
Message-ID: <4f3252890912292307qc3c4b29m98c7d6e4c8fd6a7d@mail.gmail.com>
References: <1261191766.18070.10.camel@localhost.localdomain>
	<4f3252890912191547x1996cf7es190e8dac71dacaae@mail.gmail.com>
	<1261352484.18070.47.camel@localhost.localdomain>
	<1261869811.30924.69.camel@localhost.localdomain>
	<4f3252890912261739x372fb678yde8a8e0edb93fe6e@mail.gmail.com>
	<1261947691.24632.29.camel@localhost.localdomain>
	<4f3252890912272114t6dcfa58bj4d5b5e6e606c5004@mail.gmail.com>
	<1262058553.20808.15.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f179.google.com (mail-pz0-f179.google.com
	[209.85.222.179])
	by alsa0.perex.cz (Postfix) with ESMTP id EDB952458B
	for <alsa-devel@alsa-project.org>; Wed, 30 Dec 2009 08:07:15 +0100 (CET)
Received: by pzk9 with SMTP id 9so7783999pzk.16
	for <alsa-devel@alsa-project.org>; Tue, 29 Dec 2009 23:07:14 -0800 (PST)
In-Reply-To: <1262058553.20808.15.camel@localhost.localdomain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Please post the output of alsa-info.sh

Do your VIA 8237/ens1371 has any digital output/input ?

D: alsa-util.c: Trying iec958:0 with SND_PCM_NO_AUTO_FORMAT ...
I: alsa-util.c: Error opening PCM device iec958:0: Device or resource busy
...
D: alsa-mixer.c: Checking for recording on Digital Stereo (IEC958)
(iec958-stereo)
D: alsa-util.c: Trying iec958:0 with SND_PCM_NO_AUTO_FORMAT ...
I: alsa-util.c: Error opening PCM device iec958:0: Device or resource busy
...
D: alsa-mixer.c: Looking at profile
output:analog-surround-40+input:iec958-surround-40
D: alsa-mixer.c: Checking for recording on Digital Surround 4.0 (IEC958)
(iec958-surround-40)
D: alsa-util.c: Trying iec958:0 with SND_PCM_NO_AUTO_FORMAT ...
I: alsa-util.c: Error opening PCM device iec958:0: Device or resource busy


Why do PA server try to open an non-existing device iec958 so many times ?

Have the PA developer ever tested those profiles on their machines "
recording on Digital Surround 4.0 (IEC958) (iec958-surround-40)" ?


D: alsa-mixer.c: Looking at profile output:analog-surround-71
D: alsa-mixer.c: Checking for playback on Analog Surround 7.1
(analog-surround-71)
D: alsa-util.c: Trying surround71:0 with SND_PCM_NO_AUTO_FORMAT ...
I: (alsa-lib)conf.c: Unknown parameters 0
I: (alsa-lib)pcm.c: Unknown PCM surround71:0

Did PA server check any error when open those device ?

it is quite strange that PA still call snd_pcm_hw_params() when there is
error "Cannot lock ctl elem" ?


D: alsa-mixer.c: Checking for recording on Digital Stereo (IEC958)
(iec958-stereo)
D: alsa-util.c: Trying iec958:1 with SND_PCM_NO_AUTO_FORMAT ...
D: alsa-util.c: Managed to open iec958:1
D: alsa-util.c: Maximum hw buffer size is 371 ms
I: (alsa-lib)setup.c: Cannot lock ctl elem
I: (alsa-lib)setup.c: Cannot lock ctl elem
I: (alsa-lib)setup.c: Cannot lock ctl elem
I: (alsa-lib)setup.c: Cannot lock ctl elem
D: alsa-util.c: Set neither period nor buffer size.

Cannot obtain info for CTL elem (MIXER,'AC97 2ch->4ch Copy Switch',0,0,0):
No such file or directory

D: alsa-util.c: Trying surround40:1 with SND_PCM_NO_AUTO_FORMAT ...
I: (alsa-lib)setup.c: Cannot obtain info for CTL elem (MIXER,'AC97 2ch->4ch
Copy Switch',0,0,0): No such file or directory
I: alsa-util.c: Error opening PCM device surround40:1: No such file or
directory
D: alsa-mixer.c: Looking at profile
output:analog-surround-40+input:analog-mono
D: alsa-mixer.c: Checking for playback on Analog Surround 4.0
(analog-surround-40)
D: alsa-util.c: Trying surround40:1 with SND_PCM_NO_AUTO_FORMAT ...
I: (alsa-lib)setup.c: Cannot obtain info for CTL elem (MIXER,'AC97 2ch->4ch
Copy Switch',0,0,0): No such file or directory
I: alsa-util.c: Error opening PCM device surround40:1: No such file or
directory
D: alsa-mixer.c: Looking at profile
output:analog-surround-40+input:analog-stereo
D: alsa-mixer.c: Checking for playback on Analog Surround 4.0
(analog-surround-40)
D: alsa-util.c: Trying surround40:1 with SND_PCM_NO_AUTO_FORMAT ...
I: (alsa-lib)setup.c: Cannot obtain info for CTL elem (MIXER,'AC97 2ch->4ch
Copy Switch',0,0,0): No such file or directory
I: alsa-util.c: Error opening PCM device surround40:1: No such file or
directory
D: alsa-mixer.c: Looking at profile
output:analog-surround-40+input:iec958-stereo
D: alsa-mixer.c: Checking for playback on Analog Surround 4.0
(analog-surround-40)
D: alsa-util.c: Trying surround40:1 with SND_PCM_NO_AUTO_FORMAT ...
I: (alsa-lib)setup.c: Cannot obtain info for CTL elem (MIXER,'AC97 2ch->4ch
Copy Switch',0,0,0): No such file or directory
I: alsa-util.c: Error opening PCM device surround40:1: No such file or
directory
D: alsa-mixer.c: Looking at profile
output:analog-surround-40+input:iec958-surround-40
D: alsa-mixer.c: Checking for playback on Analog Surround 4.0
(analog-surround-40)
D: alsa-util.c: Trying surround40:1 with SND_PCM_NO_AUTO_FORMAT ...
I: (alsa-lib)setup.c: Cannot obtain info for CTL elem (MIXER,'AC97 2ch->4ch
Copy Switch',0,0,0): No such file or directory
I: alsa-util.c: Error opening PCM device surround40:1: No such file or
directory
D: alsa-mixer.c: Looking at profile output:analog-surround-41
D: alsa-mixer.c: Checking for playback on Analog Surround 4.1
(analog-surround-41)
D: alsa-util.c: Trying surround41:1 with SND_PCM_NO_AUTO_FORMAT ...
I: (alsa-lib)confmisc.c: Unable to find definition
'cards.ENS1371.pcm.surround51.0:CARD=1'
I: (alsa-lib)conf.c: function snd_func_refer returned error: No such file or
directory
I: (alsa-lib)conf.c: Evaluate error: No such file or directory




D: alsa-mixer.c: Checking for playback on Analog Surround 5.0
(analog-surround-50)
D: alsa-util.c: Trying surround50:1 with SND_PCM_NO_AUTO_FORMAT ...
I: (alsa-lib)confmisc.c: Unable to find definition
'cards.ENS1371.pcm.surround51.0:CARD=1'
I: (alsa-lib)conf.c: function snd_func_refer returned error: No such file or
directory
I: (alsa-lib)conf.c: Evaluate error: No such file or directory
I: (alsa-lib)pcm.c: Unknown PCM surround50:1
I: alsa-util.c: Error opening PCM device surround50:1: No such file or
directory
D: alsa-mixer.c: Looking at profile
output:analog-surround-50+input:analog-stereo
D: alsa-mixer.c: Checking for playback on Analog Surround 5.0
(analog-surround-50)
D: alsa-util.c: Trying surround50:1 with SND_PCM_NO_AUTO_FORMAT ...
I: (alsa-lib)confmisc.c: Unable to find definition
'cards.ENS1371.pcm.surround51.0:CARD=1'
I: (alsa-lib)conf.c: function snd_func_refer returned error: No such file or
directory
I: (alsa-lib)conf.c: Evaluate error: No such file or directory
I: (alsa-lib)pcm.c: Unknown PCM surround50:1
I: alsa-util.c: Error opening PCM device surround50:1: No such file or
directory
D: alsa-mixer.c: Looking at profile
output:analog-surround-50+input:iec958-stereo
D: alsa-mixer.c: Checking for playback on Analog Surround 5.0
(analog-surround-50)
D: alsa-util.c: Trying surround50:1 with SND_PCM_NO_AUTO_FORMAT ...
I: (alsa-lib)confmisc.c: Unable to find definition
'cards.ENS1371.pcm.surround51.0:CARD=1'
I: (alsa-lib)conf.c: function snd_func_refer returned error: No such file or
directory
I: (alsa-lib)conf.c: Evaluate error: No such file or directory
I: (alsa-lib)pcm.c: Unknown PCM surround50:1
I: alsa-util.c: Error opening PCM device surround50:1: No such file or
directory
D: alsa-mixer.c: Looking at profile
output:analog-surround-50+input:iec958-surround-40
D: alsa-mixer.c: Checking for playback on Analog Surround 5.0
(analog-surround-50)
D: alsa-util.c: Trying surround50:1 with SND_PCM_NO_AUTO_FORMAT ...
I: (alsa-lib)confmisc.c: Unable to find definition
'cards.ENS1371.pcm.surround51.0:CARD=1'
I: (alsa-lib)conf.c: function snd_func_refer returned error: No such file or
directory
I: (alsa-lib)conf.c: Evaluate error: No such file or directory
I: (alsa-lib)pcm.c: Unknown PCM surround50:1
I: alsa-util.c: Error opening PCM device surround50:1: No such file or
directory
D: alsa-mixer.c: Looking at profile output:analog-surround-51
D: alsa-mixer.c: Checking for playback on Analog Surround 5.1
(analog-surround-51)
D: alsa-util.c: Trying surround51:1 with SND_PCM_NO_AUTO_FORMAT ...
I: (alsa-lib)confmisc.c: Unable to find definition
'cards.ENS1371.pcm.surround51.0:CARD=1'
I: (alsa-lib)conf.c: function snd_func_refer returned error: No such file or
directory
I: (alsa-lib)conf.c: Evaluate error: No such file or directory
I: (alsa-lib)pcm.c: Unknown PCM surround51:1
I: alsa-util.c: Error opening PCM device surround51:1: No such file or
directory
D: alsa-mixer.c: Looking at profile
output:analog-surround-51+input:analog-mono
D: alsa-mixer.c: Checking for playback on Analog Surround 5.1
(analog-surround-51)
D: alsa-util.c: Trying surround51:1 with SND_PCM_NO_AUTO_FORMAT ...
I: (alsa-lib)confmisc.c: Unable to find definition
'cards.ENS1371.pcm.surround51.0:CARD=1'
I: (alsa-lib)conf.c: function snd_func_refer returned error: No such file or
directory
I: (alsa-lib)conf.c: Evaluate error: No such file or directory
I: (alsa-lib)pcm.c: Unknown PCM surround51:1
I: alsa-util.c: Error opening PCM device surround51:1: No such file or
directory
D: alsa-mixer.c: Looking at profile
output:analog-surround-51+input:analog-stereo
D: alsa-mixer.c: Checking for playback on Analog Surround 5.1
(analog-surround-51)
D: alsa-util.c: Trying surround51:1 with SND_PCM_NO_AUTO_FORMAT ...
I: (alsa-lib)confmisc.c: Unable to find definition
'cards.ENS1371.pcm.surround51.0:CARD=1'
I: (alsa-lib)conf.c: function snd_func_refer returned error: No such file or
directory
I: (alsa-lib)conf.c: Evaluate error: No such file or directory
I: (alsa-lib)pcm.c: Unknown PCM surround51:1
I: alsa-util.c: Error opening PCM device surround51:1: No such file or
directory
D: alsa-mixer.c: Looking at profile
output:analog-surround-51+input:iec958-stereo
D: alsa-mixer.c: Checking for playback on Analog Surround 5.1
(analog-surround-51)
D: alsa-util.c: Trying surround51:1 with SND_PCM_NO_AUTO_FORMAT ...
I: (alsa-lib)confmisc.c: Unable to find definition
'cards.ENS1371.pcm.surround51.0:CARD=1'
I: (alsa-lib)conf.c: function snd_func_refer returned error: No such file or
directory
I: (alsa-lib)conf.c: Evaluate error: No such file or directory
I: (alsa-lib)pcm.c: Unknown PCM surround51:1
I: alsa-util.c: Error opening PCM device surround51:1: No such file or
directory
D: alsa-mixer.c: Looking at profile
output:analog-surround-51+input:iec958-surround-40
D: alsa-mixer.c: Checking for playback on Analog Surround 5.1
(analog-surround-51)
D: alsa-util.c: Trying surround51:1 with SND_PCM_NO_AUTO_FORMAT ...
I: (alsa-lib)confmisc.c: Unable to find definition
'cards.ENS1371.pcm.surround51.0:CARD=1'
I: (alsa-lib)conf.c: function snd_func_refer returned error: No such file or
directory
I: (alsa-lib)conf.c: Evaluate error: No such file or directory
I: (alsa-lib)pcm.c: Unknown PCM surround51:1
I: alsa-util.c: Error opening PCM device surround51:1: No such file or
directory
D: alsa-mixer.c: Looking at profile output:analog-surround-71
D: alsa-mixer.c: Checking for playback on Analog Surround 7.1
(analog-surround-71)
D: alsa-util.c: Trying surround71:1 with SND_PCM_NO_AUTO_FORMAT ...
I: (alsa-lib)conf.c: Unknown parameters 1
I: (alsa-lib)pcm.c: Unknown PCM surround71:1
I: alsa-util.c: Error opening PCM device surround71:1: Invalid argument



2009/12/29 Chris <cpollock@embarqmail.com>

> On Mon, 2009-12-28 at 13:14 +0800, Raymond Yau wrote:
> > Do you mean that you cannot find a test case to reproduce the bug ?
>
> Not exactly, for instance 20 seconds after freshclam ran I see this in
> my syslog:
>
> Dec 28 21:26:30 localhost pulseaudio[11266]: ratelimit.c: 52 events
> suppressed
> Dec 28 21:26:30 localhost pulseaudio[11266]: asyncq.c: q overrun,
> queuing locally
> Dec 28 21:26:30 localhost last message repeated 10 times
>
> then this:
>
> Dec 28 21:27:24 localhost pulseaudio[11266]: asyncq.c: q overrun,
> queuing locally
> Dec 28 21:27:24 localhost last message repeated 10 times
> Dec 28 21:27:37 localhost pulseaudio[11266]: alsa-util.c:
> snd_pcm_avail() returned a value that is exceptionally large: 839968
> bytes (4761 ms).
>
> The above is while the drive was 'thrashing' for a couple of minutes
>
> I've also determined via experimentation that with pulseaudio running
> copying a 1.2Gb file to a thumb drive takes an average of 30minutes.
> This what I've done:
>
> 1. Using Gnome Commander I attempted to copy the 1.2 Gb file to a thumb
> drive, after about 30 minutes I had to stop the transfer at about 35%.
> 2. Disabled pulseaudio in Mandriva command center, logged out and back
> in again.
> 3. Again tried to copy the save file to the thumb drive, this time it
> took about 3 minutes.
> 4. Re-enabled pulseaudio and again tried to copy the file, this time
> using pulseaudio -k ; pulseaudio -vvvv on the command line. I saw
> outputs like this:
>
> W: asyncq.c: q overrun, queuing locally
> W: asyncq.c: q overrun, queuing locally
> W: asyncq.c: q overrun, queuing locally
> W: asyncq.c: q overrun, queuing locally
> W: asyncq.c: q overrun, queuing locally
> W: asyncq.c: q overrun, queuing locally
> W: asyncq.c: q overrun, queuing locally
> W: asyncq.c: q overrun, queuing locally
> W: asyncq.c: q overrun, queuing locally
> W: asyncq.c: q overrun, queuing locally
> W: asyncq.c: q overrun, queuing locally
> W: ratelimit.c: 600 events suppressed
>
> I have the complete log as a 15k bziped file. Can it be sent to the
> list?
>
> Chris
>
> --
> KeyID 0xE372A7DA98E6705C
>
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
>
