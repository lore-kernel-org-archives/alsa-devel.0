From: Marek Vasut <marek.vasut@gmail.com>
Subject: Re: Audio on Linux is a mess
Date: Mon, 20 Oct 2008 08:35:25 +0200
Message-ID: <200810200835.25706.marek.vasut@gmail.com>
References: <f188924b0810170624k78e74116o19fba5adb0eaf533@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.175])
	by alsa0.perex.cz (Postfix) with ESMTP id 980761037F6
	for <alsa-devel@alsa-project.org>;
	Mon, 20 Oct 2008 08:31:13 +0200 (CEST)
Received: by ug-out-1314.google.com with SMTP id 30so499422ugs.24
	for <alsa-devel@alsa-project.org>; Sun, 19 Oct 2008 23:30:55 -0700 (PDT)
In-Reply-To: <f188924b0810170624k78e74116o19fba5adb0eaf533@mail.gmail.com>
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
Cc: "Fred ." <eldmannen@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Friday 17 of October 2008 15:24:20 Fred . wrote:
> ALSA lib pulse.c:272:(pulse_connect) PulseAudio: Unable to connect: Timeout
> ALSA lib pulse.c:272:(pulse_connect) PulseAudio: Unable to connect: Timeout
> AL lib: alsa.c:344: Could not open playback device 'default': Connection
> refused AL lib: oss.c:179: Could not open /dev/dsp: Device or resource busy
> File
> "/var/lib/python-support/python2.5/pyglet/media/drivers/openal/__init__.py"
>, line 340, in driver_init_device = alc.alcOpenDevice(device_name)
>
> Audio on Linux is a mess.
> I launch an Python script that uses audio then it breaks, and when the
> Python script is closed, I still hear the audio skipping and repeating
> like,
> "kakakakakakaka" in infinite loop.
> And PulseAudio seems to be frozen.
> Then I kill PulseAudio and finally the audio noise stops.
>
> Oh, and I heard OpenAL downsamples stereo to mono on Linux due to a bug.
>
> Whole audio on Linux is just a big mess.

Please behave yourself.
Is there any way we can help you (which I doubt, but ...)?
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
