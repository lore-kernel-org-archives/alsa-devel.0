From: pl bossart <bossart.nospam@gmail.com>
Subject: Re: hw_ptr accuracy with intel8x0 -> PulseAudio issue
Date: Thu, 3 Dec 2009 18:50:58 -0600
Message-ID: <6160a5130912031650u5949c921jc86d0847b2844803@mail.gmail.com>
References: <6160a5130912020115t45bd4635hceb0ac3de4fb1efe@mail.gmail.com>
	<4f3252890912021826g732292ecv8959a7cfbf574446@mail.gmail.com>
	<6160a5130912030828m5b2401f3w31a67b6b51e8d8b6@mail.gmail.com>
	<4f3252890912031442i56ccc905g935a4d6ed48f40c6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f191.google.com (mail-pz0-f191.google.com
	[209.85.222.191])
	by alsa0.perex.cz (Postfix) with ESMTP id B21952415F
	for <alsa-devel@alsa-project.org>; Fri,  4 Dec 2009 01:51:00 +0100 (CET)
Received: by pzk29 with SMTP id 29so1828309pzk.17
	for <alsa-devel@alsa-project.org>; Thu, 03 Dec 2009 16:50:58 -0800 (PST)
In-Reply-To: <4f3252890912031442i56ccc905g935a4d6ed48f40c6@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

>> =A0 17. hwptr 24351 buffer 16384 appl 24332, avail=3D16403
>
> appl pointer is behind hwprtr ( =A0underrun ) , need timestamp to find out
> whether PA is unable to write audio data in time since

Nah, it's not an audio underflow. In the default PulseAudio code, the
timer value is increased by 20ms each time this errror condition is
reached. PA ends-up waking-up 150ms or so before the deadline and yet
it still encounters this error. I don't think it's a problem with PA
not refilling the buffer on time, it's more that the information
provided by snd_pcm_avail() is misleading. I commented out the portion
of the code that increases the watermark and clamped the number of
available samples to the buffer size, and it works just fine, no audio
underflows.
- P
