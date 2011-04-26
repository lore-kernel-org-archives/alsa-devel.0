From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH] Alsa-plugins: Pulse: Fix snd_pcm_avail
 returning 0 in some cases
Date: Tue, 26 Apr 2011 10:01:23 +0200
Message-ID: <4DB67BD3.7090706@canonical.com>
References: <4DB02F8A.4040001@canonical.com>
	<BANLkTikb0uuEw9-gbbGW6Kcf0LkPHsgxdw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id A710A1037EC
	for <alsa-devel@alsa-project.org>;
	Tue, 26 Apr 2011 10:01:20 +0200 (CEST)
In-Reply-To: <BANLkTikb0uuEw9-gbbGW6Kcf0LkPHsgxdw@mail.gmail.com>
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
Cc: Maarten Lankhorst <m.b.lankhorst@gmail.com>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 2011-04-22 01:25, Raymond Yau wrote:
> 2011/4/21 David Henningsson<david.henningsson@canonical.com>
>
>> Due to a round-off error, snd_pcm_avail could in some cases
>> return 0 even though more data could be written to the stream.
>>
>> This was discovered by Maarten Lankhorst [1], and there is also a test
>> program available that triggers this error [2].
>>
>> [1]
>> https://tango.0pointer.de/pipermail/pulseaudio-discuss/2011-April/009935.html
>>
>> [2]
>> https://tango.0pointer.de/pipermail/pulseaudio-discuss/attachments/20110420/3c852d6e/attachment.c
>>
>
> if the test program can force under-run occur with "hw" device and "pulse"
> device with his patch in
> https://tango.0pointer.de/pipermail/pulseaudio-discuss/2011-April/009918.html
>
> Is it normal that underrun does not occur with the test program and your
> patch

Yes; underruns are not reported to the application due to the risk of 
the underrun being obsolete at that time. As for Maarten's patch in the 
post you refer to,

1) if underruns are being reported (this is configurable), it might be a 
good idea to call "pulse_start".

2) it changes underruns to being reported by default, which is what I'm 
opposed to.

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic
