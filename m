From: "Fred ." <eldmannen@gmail.com>
Subject: Audio on Linux is a mess
Date: Fri, 17 Oct 2008 15:24:20 +0200
Message-ID: <f188924b0810170624k78e74116o19fba5adb0eaf533@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ey-out-1920.google.com (ey-out-1920.google.com [74.125.78.146])
	by alsa0.perex.cz (Postfix) with ESMTP id F122E24355
	for <alsa-devel@alsa-project.org>;
	Fri, 17 Oct 2008 15:24:38 +0200 (CEST)
Received: by ey-out-1920.google.com with SMTP id 21so204264eyc.56
	for <alsa-devel@alsa-project.org>; Fri, 17 Oct 2008 06:24:21 -0700 (PDT)
Content-Disposition: inline
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

ALSA lib pulse.c:272:(pulse_connect) PulseAudio: Unable to connect: Timeout
ALSA lib pulse.c:272:(pulse_connect) PulseAudio: Unable to connect: Timeout
AL lib: alsa.c:344: Could not open playback device 'default': Connection refused
AL lib: oss.c:179: Could not open /dev/dsp: Device or resource busy
  File "/var/lib/python-support/python2.5/pyglet/media/drivers/openal/__init__.py",
line 340, in driver_init_device = alc.alcOpenDevice(device_name)

Audio on Linux is a mess.
I launch an Python script that uses audio then it breaks, and when the
Python script is closed, I still hear the audio skipping and repeating
like,
"kakakakakakaka" in infinite loop.
And PulseAudio seems to be frozen.
Then I kill PulseAudio and finally the audio noise stops.

Oh, and I heard OpenAL downsamples stereo to mono on Linux due to a bug.

Whole audio on Linux is just a big mess.
