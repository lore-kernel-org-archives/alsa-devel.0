From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: no external mic
Date: Fri, 25 Mar 2011 09:19:21 +0800
Message-ID: <AANLkTinEKEpqEF7_VPYt_LpoVjFWOtYasGwveX7Dwtnn@mail.gmail.com>
References: <20110323150255.26552.qmail@info15.gawab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) by alsa0.perex.cz (Postfix) with ESMTP id 899C924467
	for <alsa-devel@alsa-project.org>; Fri, 25 Mar 2011 02:19:21 +0100 (CET)
Received: by fxm6 with SMTP id 6so684067fxm.38
	for <alsa-devel@alsa-project.org>; Thu, 24 Mar 2011 18:19:21 -0700 (PDT)
In-Reply-To: <20110323150255.26552.qmail@info15.gawab.com>
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

2011/3/23 leon <leon3000@gawab.com>

>
> Hello,
> i've Laptop Dell Inspiron 1520,
> the internal mic works perfectly, but external mic doesn't work,
>
> i've followed this link:
> http://ubuntuforums.org/showthread.php?p=10352564
> but it didn't help me,
>
> here's the output of ALSA Information Script:
> http://www.alsa-project.org/db/?f=3aa8a44412081f533b2de3e32aae76ff4370eae9
> btw, i've been using Ubuntu, and Debian now, both have same
> problem. so i haven't tried other Distributions.
>
> any idea?
>

The digital mic at 0x17 is connected to [audio selector] 0x1d

The other analog input (e.g. ext mic 0x0b,..) are connected to [audio
selector] 0x19

[audio selector 0x1d] can select either 0x17 or 0x19

There are two [audio selector] in the audio path from input pins to [Audio
Input]

Refer to the owner of Dell Vostro 1500

https://bugtrack.alsa-project.org/alsa-bug/view.php?id=5288

It seem that alsa-driver-1.0.24 still has these bug since tthe driver does
not call set_mic_route() to setup those dmix_idx of mux_idx of ext mic and
digital mic
