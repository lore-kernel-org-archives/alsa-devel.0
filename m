From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: ALSA/pulseaudio problem workaround
Date: Sat, 19 Mar 2011 11:18:29 +0800
Message-ID: <AANLkTikSL7zqSY0RN3-M2wGzAcMR-hGjKOef5tNATC7H@mail.gmail.com>
References: <AANLkTinGB1-Ft0B98_Z9TnFkL+Pqd8VPVKy4bEC57c8n@mail.gmail.com>
	<4D7E2BB0.7080108@colin.guthr.ie>
	<AANLkTi=MXXxkcbA2h=jkJzm4BWm7_4vEwuNoaNDGE-CN@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) by alsa0.perex.cz (Postfix) with ESMTP id 3A58F24362
	for <alsa-devel@alsa-project.org>; Sat, 19 Mar 2011 04:18:30 +0100 (CET)
Received: by fxm6 with SMTP id 6so4034885fxm.38
	for <alsa-devel@alsa-project.org>; Fri, 18 Mar 2011 20:18:29 -0700 (PDT)
In-Reply-To: <AANLkTi=MXXxkcbA2h=jkJzm4BWm7_4vEwuNoaNDGE-CN@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2011/3/15 Craig Bourne <craigbourne@gmail.com>

>
>
> [cbourne@speedy ~]$ audacity
> Cannot connect to server socket err = No such file or directory
> Cannot connect to server socket
> jack server is not running or cannot be started
> Expression 'stream->capture.pcm' failed in
> 'src/hostapi/alsa/pa_linux_alsa.c', line: 3653
>
[ It should be noted that, despite the error response, audacity produce
> audible output only if jack is NOT running-- else, if jack is running,
> everything looks normal but there is no sound ]
>
>
 [ Here sound is produced by audacity 1) without jack running, 2)  with
jackrunning using the startup/shutdown scripts 3) with jack running but
without

> the scripts.  Though I have no metrics to share with you to support this,
> it
> is my repeated observation that procedures 1) and 3) produce far more noise
> than does procedure 2) in this testing scenario. ]
>

it is because audacity use portaudio and there are three hostapi ( backend )
: alsa ,oss and jack on linux

"Host :ALSA " or "Host :JACK" in audacity preference - "Devices" -
"Interface"

When portauio initialise , it will probe all the devices of available
hostapi for the user to select in "Preference"

so it will try to connect to JACK server to find out whether it support
duplex or not

For alsa  builddevicelist()  add those "hw" devices of the sound cards , it
also add some"plugin" which is not in ignored list and finally two devices
"dmix" and "default"

seem the message 'stream->capture.pcm' is related to "dmix" since "dsnoop"
is in the ignored list

if you are still using "pcm.pulse" as "default" and does not disable
autospwan of PA server ,PA server may autospawn to compete with JACK server
for the sound card

I have dobut about using "Jack" and "Pulse" at the same time since "Jack"
application usually aim at "low latency" while "Pulseaudio" is aim at
reducing the number of wakeup for "power saving"
