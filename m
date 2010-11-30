From: Vaclav Peroutka <vaclavpe@gmail.com>
Subject: Re: SND-SOC - how to test drivers ?
Date: Tue, 30 Nov 2010 22:14:42 +0100
Message-ID: <AANLkTi=SLNeQ5mEFKztB9cmDh3AUVz0fYOB6LGKzf6nL@mail.gmail.com>
References: <AANLkTikE9aF38vg9WkYAVWTSXY23E7qxkQRyfsBJas6Y@mail.gmail.com>
	<AANLkTimT0aoTP+MghUvvRru83hCyCG_ALKxbvOBOcQTW@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 95BD0103805
	for <alsa-devel@alsa-project.org>; Tue, 30 Nov 2010 22:14:44 +0100 (CET)
Received: by wyi11 with SMTP id 11so6142139wyi.38
	for <alsa-devel@alsa-project.org>; Tue, 30 Nov 2010 13:14:43 -0800 (PST)
In-Reply-To: <AANLkTimT0aoTP+MghUvvRru83hCyCG_ALKxbvOBOcQTW@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jassi Brar <jassisinghbrar@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

2010/11/23 Jassi Brar <jassisinghbrar@gmail.com>:
> On Tue, Nov 23, 2010 at 6:24 AM, Vaclav Peroutka <vaclavpe@gmail.com> wrote:
>
> How about first making the driver work with some, non-Android, rootfs
> that has alsa-utils ?
>

Hello, I did some progress, but not too much. I am getting "no
soundcards found" even if I have /dev/snd and /proc/asound like below.
What did I do wrong ?

Thank you in advance for answers.

$ ls -l /dev/snd
crw------- root     root     116,   3 2010-11-30 20:50 seq
crw------- root     root      14,   8 2010-11-30 20:50 sequencer2
crw------- root     root      14,   1 2010-11-30 20:50 sequencer
crw------- root     root     116,   2 2010-11-30 20:50 timer
crw-rw---- system   audio     14,   0 2010-11-30 20:50 mixer
crw------- root     root     116,   6 2010-11-30 20:50 controlC0
crw------- root     root      14,   4 2010-11-30 20:50 audio
crw-rw---- system   audio     14,   3 2010-11-30 20:50 dsp
crw------- root     root     116,   5 2010-11-30 20:50 pcmC0D0c
crw------- root     root     116,   4 2010-11-30 20:50 pcmC0D0p

$ ls /proc/asound
MAX9880
card0
pcm
timers
cards
devices
version
seq
oss

$ cat /proc/asound/devices
  2:        : timer
  3:        : sequencer
  4: [ 0- 0]: digital audio playback
  5: [ 0- 0]: digital audio capture
  6: [ 0]   : control

$ ls -l /proc/asound/card0
-rw-r--r-- root     root            0 2010-11-30 21:21 oss_mixer
-r--r--r-- root     root            0 2010-11-30 21:21 id
dr-xr-xr-x root     root              2010-11-30 21:21 pcm0c
dr-xr-xr-x root     root              2010-11-30 21:21 pcm0p

$ alsactl -d store card0
alsactl: save_state:1519: Cannot find soundcard 'card0'...

$ aplay -l
aplay: device_list:236: no soundcards found...
