From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: ProjectMix IO Feedback
Date: Mon, 5 Dec 2016 21:10:44 +0900
Message-ID: <7415d24b-216d-a2a0-fb2d-3e1ef89ca3ca@sakamocchi.jp>
References: <CAMGupfgbpK37w6KY23gzQn=udpweXDs8i6EdiBJ-SD8+6Kgnww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id 68818266C72
 for <alsa-devel@alsa-project.org>; Mon,  5 Dec 2016 13:10:48 +0100 (CET)
In-Reply-To: <CAMGupfgbpK37w6KY23gzQn=udpweXDs8i6EdiBJ-SD8+6Kgnww@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Darren Anderson <darrena092@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "ffado-user@lists.sourceforge.net" <FFADO-user@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

  \Hi Darren,
(C.C.ed to alsa-devel and ffado-user)

On Dec 1 2016 19:47, Darren Anderson wrote:
> Hi Takashi,
>
> Just wanted to give you some feedback on how the ProjectMix IO is working
> with your changes that were merged into the Linux Kernel.
>
> Out of the box, on Ubuntu with kernel version 4.4.0-31, on boot, the
> interface makes its distinctive popping sound as it sets the clock rate,
> showing that the driver is loading fine. It is also now detected by
> PulseAudio (without using a jack sink, as I previously had to). I'm then
> able to use ffado-mixer to control the device.

Thanks for your feedback to ALSA bebob driver. But it's better to post 
this kind of report to public mailing list, instead of personal address. 
There might be people who need the information.

> There are, however, three issues.
>
> Firstly, the sample rate seems to be set every time an audio stream is
> about to begin. This can be quite irritating at times, due to the
> aforementioned distinctive popping sound and lag in the starting of audio
> streams. Would it be possible to set the sample rate once at boot time, and
> leave it at this unless the user specifically instructs otherwise?

Applications can set sampling rate as they want, by ALSA PCM interface. 
I think it better to keep it what it is unless there's few special cases.

For example, ALSA dice driver performs what you expected, due to 
hardware restriction. Application can't set sampling rate by ALSA PCM 
interface and they require the other application for this purpose.

> Secondly, the main audio seems to be routed from Pulse through the "Aux
> 1/2" channel, as opposed to "Mixer 1/2". The device will output no audio
> until the "Analog 1/2" output is set to use "Aux 1/2" in FFADO mixer.
> However in fixing this issue, a separate issue may be created. As most
> distributions play some sort of "start-up sound", and the device seems to
> initialize to full volume unless instructed otherwise, the fact that the
> output channel needs to be changed may actually save some ear drums. It may
> be wise to ask the device to reduce to something reasonable like 25% volume
> when the driver is loaded. Or perhaps just mute all outputs by default.

Just after booting up, your device has no routing configuration, 
therefore it generates no sound till configured with use space 
applications. Default settings of gain/volume are 0dB, perhaps. But this 
can also be configured from user space applications.

What I can do is to produce a way to control devices for applications in 
user land, and actual way to use the device is left to application 
developers. If users have something to do, they would do it.

> And finally, I've have found that the quality of the audio output from the
> device is of a somewhat lower fidelity than the equivalent output on
> Windows. I'm currently testing the interface using my KRK Rokit monitor
> speakers and finding that the output is lacking in low frequencies. It
> sounds as if there is some high pass filtering going on.

ALSA bebob driver allows applications to use the device with both of 16 
bit sample and 24bit sample with adjusted 8 bit, for playbacking. I 
guess that your trial is to playback 16 bit PCM sample and looks with 
highpass filter. Please check the property of PCM substream.

> I hope that you find this feedback useful to your ongoing efforts. You're
> doing great work.
>
> If I can do anything else to help, don't hesitate to ask.


Cheers

Takashi Sakamoto
