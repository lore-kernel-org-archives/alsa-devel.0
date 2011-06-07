From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: Re: Issues with HDSPM
Date: Tue, 07 Jun 2011 14:48:02 +0200
Message-ID: <4DEE1E02.10705@drcomp.erfurt.thur.de>
References: <20110606210425.0a4c2901@revell.mafea.no-ip.org>
	<4DEDDB0D.4000709@stackingdwarves.net>
	<4DEDF326.7080909@drcomp.erfurt.thur.de>
	<4DEE1D92.8030207@stackingdwarves.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ltw.loris.tv (ltw.loris.tv [85.14.220.160])
	by alsa0.perex.cz (Postfix) with ESMTP id 2C3D824469
	for <alsa-devel@alsa-project.org>;
	Tue,  7 Jun 2011 14:48:21 +0200 (CEST)
In-Reply-To: <4DEE1D92.8030207@stackingdwarves.net>
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
Cc: Andre Schramm <andre.schramm@iosono-sound.com>
List-Id: alsa-devel@alsa-project.org


>>>> the HDSPM driver seems to be broken in the current ALSA release.
>>>> We're using CentOS 5 with 2.6.33.9-rt31.64.el5rt and ALSA 1.0.24
>>>> compiled from source, the card is a PCIe Hammerfall DSP MADI (rev d2).
>>>> As already mentioned in [1], the card operates in master mode, but the
>>>> system clock mode can't be set to anything higher than 48kHz.
> i can switch to 192k no problem, but if i start jack while at 48k, i can
> only go down, not up. my guess is that i had a half-dead jack around
> when i tried to reproduce your issue. andre, can you confirm you do not
> have any processes running on the card when the problem occurs? i guess
> lsof /dev/snd/* might be useful...

There's an easier way to acquire this information:

   $ cat /proc/asound/default/pcm0*/sub0/status

If it reads "closed", then nobody is using the card, otherwise, there
would be an entry for owner_pid, thus preventing the card to change
clock modes outside the multiples of 32/44.1/48 (*1, *2 or *4 depending
on SS/DS/QS).


Ciao
