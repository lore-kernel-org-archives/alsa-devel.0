From: Andre Schramm <andre.schramm@iosono-sound.com>
Subject: Re: hdsp: 2.6.39 IRQ set-up error
Date: Fri, 9 Sep 2011 22:41:01 +0200
Message-ID: <20110909224101.04e431cd@revell>
References: <CAPhDKbEL_VCycmsKhZJ1PvDzS+vmOr54FOCZLmo7kqk9DKBN8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187])
	by alsa0.perex.cz (Postfix) with ESMTP id C701224586
	for <alsa-devel@alsa-project.org>;
	Fri,  9 Sep 2011 22:41:04 +0200 (CEST)
In-Reply-To: <CAPhDKbEL_VCycmsKhZJ1PvDzS+vmOr54FOCZLmo7kqk9DKBN8Q@mail.gmail.com>
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
Cc: Adrian Knoth <adi@drcomp.erfurt.thur.de>
List-Id: alsa-devel@alsa-project.org

On Fri, 9 Sep 2011 20:41:11 +0100
Ilya Dmitrichenko <errordeveloper@gmail.com> wrote:

> Hi,
> 
> It's rather strange that IRQ number is 0,
> I'm not too sure but I though 0 is a special
> IRQ number, isn't it ?
> 
Yes, this one should be reserved for the timer exclusively AFAIK.


> % modprobe snd_hdsp
> % dmesg | tail -3
> [115297.031548] ALSA sound/usb/pcm.c:227: setting usb interface 1:1
> [115344.320693] ALSA sound/pci/rme9652/hdsp.c:5486: Hammerfall-DSP:
> unable to use IRQ 0
> [115344.320712] RME Hammerfall DSP: probe of 0000:05:02.0 failed with
> error -16 % uname -r
> 2.6.39-gentoo-r3
> 
> I cannot see any options that the module could take.
> Could this be due to some option in kernel config?
> 
Which ALSA version does your kernel use? (cat /proc/asound/version)
We had some problems with hdspm.c on 2.6.3x kernels as there was much
work going on on the driver, maybe hdsp.c changed as well around that
time.

You should try to compile the newest stable release from
alsa-project.org and see if this fixes things for you.

If not, simply replace hdsp.c with the latest devel version from [1],
rebuild and see, if this works. (unfortunately down ATM)


Regards,
   Andre

[1] http://git.kernel.org/?p=linux/kernel/git/tiwai/sound-2.6.git
