From: Damien Zammit <damien.zammit@gmail.com>
Subject: Re: [PATCH] sound: usb-audio: full
 capture/playback/spdif support for Digidesign Mbox 2
Date: Sun, 23 Dec 2012 11:31:02 +1100
Message-ID: <CABXa2sE0PK7zAyENqkPSDoAd=ag8UQHPpuw=_k+ewwQQLwiL-g@mail.gmail.com>
References: <AANLkTi=cSDq5SEh321Zy2n2RMHWFnW2-hd-=k9mz+eEz@mail.gmail.com>
 <4CEED787.9050504@gmail.com>
 <AANLkTimjaYMaqA3fFqWKi0+8nsaqENe8oWj=hph1Hv09@mail.gmail.com>
 <s5hfwukp4k4.wl%tiwai@suse.de>
 <AANLkTi=3JSsaa=P5s31+fq75Jp0WQUKD7mu0Ft8Tq+bP@mail.gmail.com>
 <4CF517BF.4020706@ladisch.de>
 <AANLkTi=Y6tA=1CW6Yu0rpAm7=JyLLjA1A-4cL-JFaBrP@mail.gmail.com>
 <AANLkTimH8OfncsS_WPtXGgFN316YeJQMtEEfkxXmEuQ8@mail.gmail.com>
 <CABXa2sE_WRgCv_Ym9gD2s0bggwBghSUsJhOamSYrNhq80_F8Bw@mail.gmail.com>
 <s5h6246saej.wl%tiwai@suse.de>
 <CABXa2sFRG7fuCnpvOhyhFre_McY7ts6caRUZeHO0didnTow3Sg@mail.gmail.com>
 <s5h4njqdraf.wl%tiwai@suse.de> <s5h38zadqvu.wl%tiwai@suse.de>
 <CABXa2sGwkOSmEXGhZ8123QFsr9T_c=+UzK5fdkZt-OE0CLF40w@mail.gmail.com>
 <s5hvcc6yp4w.wl%tiwai@suse.de>
 <CABXa2sE7wU5xJyR5QOutR9CcuR1dkqAL_LzuESCinNm89bGnaw@mail.gmail.com>
 <CABXa2sH6Kav20YBYjoii23C9C6vUb3BzW_-cT+xxji5dWaip9g@mail.gmail.com>
 <s5h8v8xx9f8.wl%tiwai@suse.de>
 <CABXa2sEKSe7AtvvYcaAP2EuvpEWUK8y1GK8Ck7-NBDiYYoJaug@mail.gmail.com>
 <s5hlicvv77n.wl%tiwai@suse.de> <s5hk3setjuj.wl%tiwai@suse.de>
 <CABXa2sHgaBr7grq=0nb=SofWMFsNP_cA-tAzLXq=A_H9a0Zgtg@mail.gmail.com>
 <CABXa2sF7rkoOriune=aWdw52g2qj3-DXjixs+pUvjF=2HgcurA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oa0-f46.google.com (mail-oa0-f46.google.com
 [209.85.219.46])
 by alsa0.perex.cz (Postfix) with ESMTP id 17D0F26007E
 for <alsa-devel@alsa-project.org>; Sun, 23 Dec 2012 01:31:03 +0100 (CET)
Received: by mail-oa0-f46.google.com with SMTP id h16so5894535oag.5
 for <alsa-devel@alsa-project.org>; Sat, 22 Dec 2012 16:31:03 -0800 (PST)
In-Reply-To: <CABXa2sF7rkoOriune=aWdw52g2qj3-DXjixs+pUvjF=2HgcurA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hi,

Not sure if this is relevant, but when I compile the module with a few
changes, then try to insert the modules snd-usbmidi-lib and
snd-usb-audio, I get

$ sudo insmod ./snd-usbmidi-lib.ko
Error: could not insert module ./snd-usbmidi-lib.ko: Unknown symbol in module

Also, I think I might have found the bug but I cant test it due to the above.

Damien

On 23 December 2012 10:38, Damien Zammit <damien.zammit@gmail.com> wrote:
> On 19 December 2012 21:37, Damien Zammit <damien.zammit@gmail.com> wrote:
>> I will be sure to compile this kernel when it comes out and double
>> check it on the hardware!
> Bad news, the kernel panics when I plug in the device on this kernel.
> I compiled the kernel yesterday with default options except I changed
> HZ=1000 and used generic X86_64 with kernel preemption:
>
> $ uname -a
> Linux zamserv 3.8.0-rc1 #1 SMP PREEMPT Sat Dec 22 21:56:06 EST 2012
> x86_64 GNU/Linux
>
> Attached is a panic dump.
>
> Damien
