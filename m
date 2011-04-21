From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [PATCH] Alsa-plugins: Pulse: Fix snd_pcm_avail
 returning 0 in some cases
Date: Fri, 22 Apr 2011 07:25:53 +0800
Message-ID: <BANLkTikb0uuEw9-gbbGW6Kcf0LkPHsgxdw@mail.gmail.com>
References: <4DB02F8A.4040001@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 67C0410395E
	for <alsa-devel@alsa-project.org>;
	Fri, 22 Apr 2011 01:25:54 +0200 (CEST)
Received: by fxm5 with SMTP id 5so152220fxm.38
	for <alsa-devel@alsa-project.org>; Thu, 21 Apr 2011 16:25:54 -0700 (PDT)
In-Reply-To: <4DB02F8A.4040001@canonical.com>
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

2011/4/21 David Henningsson <david.henningsson@canonical.com>

> Due to a round-off error, snd_pcm_avail could in some cases
> return 0 even though more data could be written to the stream.
>
> This was discovered by Maarten Lankhorst [1], and there is also a test
> program available that triggers this error [2].
>
> [1]
> https://tango.0pointer.de/pipermail/pulseaudio-discuss/2011-April/009935.html
>
> [2]
> https://tango.0pointer.de/pipermail/pulseaudio-discuss/attachments/20110420/3c852d6e/attachment.c
>
>
> --
> David Henningsson, Canonical Ltd.
> http://launchpad.net/~diwic
>

if the test program can force under-run occur with "hw" device and "pulse"
device with his patch in
https://tango.0pointer.de/pipermail/pulseaudio-discuss/2011-April/009918.html

Is it normal that underrun does not occur with the test program and your
patch
