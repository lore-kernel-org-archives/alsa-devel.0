From: "Benjamin van den Hout" <bvdhout@gmail.com>
Subject: Re: Problem with aloop
Date: Fri, 9 May 2008 14:46:07 +0200
Message-ID: <d5eabee70805090546t5219e9e3v63df15b5d64fd7dd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yw-out-1718.google.com (yw-out-1718.google.com [74.125.46.154])
	by alsa0.perex.cz (Postfix) with ESMTP id 8411824450
	for <alsa-devel@alsa-project.org>;
	Fri,  9 May 2008 14:46:36 +0200 (CEST)
Received: by yw-out-1718.google.com with SMTP id 9so747900ywk.2
	for <alsa-devel@alsa-project.org>; Fri, 09 May 2008 05:46:07 -0700 (PDT)
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

Gustavo da Silva Serra wrote:

>    I am developing an application that captures sound and send it
> through a network, just like a sound server. To test it I am using
> kaffeine with alsa output plugin. After some time playing continuously,
> or if I keep moving the position slider backward and forward, I get
> choppy sound. If I close and reopen the capture stream opened by my
> sound server, the sound is restored to good quality. Sometimes I have to
> reopen many times before I get a good sound. When I use kaffeine oss
> output plugin I don't have this issue. I don't have an audio sound card,
> so I don't know if this is an *aloop* issue.

> Here are some details:
>- RedHat EL 4 kernel 2.6.9.55-ELsmp 64bit
>- Alsa 1.0.16
>- Xinelib 1.1.12

Hi all,

I'm experiencing the same problem as Gustavo. In my case I have a SIP
client calling to another PC and I'm injecting audio with aplay (or
amarok, no difference there) into that SIP call. About 8/10 times
everything goes well, the other two times the audio that comes out at
the other PC sounds really choppy. Both PC's are on the same local
network so that is probably not the problem.

What I found out is that if I patch aloop-kernel.c in the 'static
struct snd_pcm_hardware snd_card_loopback_info' to have ".formats =
 (SNDRV_PCM_FMTBIT_S8 )," this problem goes away. But then I'm stuck
with 8 bit audio. It sounds a bit like the aloop device sometimes
doesn't properly synchronise the 16 bit (or 32bit, tried that as well)
samples on both PCM devices and things get mis-aligned. I'm quite new
to ALSA so please don't laugh too hard if I'm missing something here
:)

Any input is greatly appreciated!

Kind regards,
Benjamin van den Hout
