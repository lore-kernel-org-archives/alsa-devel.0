From: Guido Aulisi <guido.aulisi@gmail.com>
Subject: Re: Regression in kernel 3.19-rc5 for usb2 scarlett
 18i20
Date: Mon, 26 Jan 2015 23:32:58 +0100
Message-ID: <1422311578.3689.8.camel@yoda.heavyware>
References: <1422186142.4719.8.camel@yoda.heavyware>
 <s5hh9vd1ymg.wl-tiwai@suse.de>
 <CAEw7SVG58Pbc==U5abDTYvUA0ukHnpSU4eQ5FNL77fr6Q47gGQ@mail.gmail.com>
 <54C64F76.4010904@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f42.google.com (mail-wg0-f42.google.com [74.125.82.42])
 by alsa0.perex.cz (Postfix) with ESMTP id ED561260501
 for <alsa-devel@alsa-project.org>; Mon, 26 Jan 2015 23:33:00 +0100 (CET)
Received: by mail-wg0-f42.google.com with SMTP id x13so11683039wgg.1
 for <alsa-devel@alsa-project.org>; Mon, 26 Jan 2015 14:33:00 -0800 (PST)
In-Reply-To: <54C64F76.4010904@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Chris J Arges <chris.j.arges@canonical.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I tried 3.19-rc6 and it seems to work well...
I compiled it myself using fedora config from
http://pkgs.fedoraproject.org/cgit/kernel.git/

Also the mixer is present and I could switch headphones on and off
(great thing).
I still have to understand most of the controls...
Thank you for the support.
If I have some time the next days, I'll try to bisect from rc5 to rc6,
to see if some commit fixed this issue, or if more probably I did
something wrong.
I always used the same usb port on my laptop, these are some info about
it:

Linux 3.19.0-rc6 #1 SMP Mon Jan 26 22:21:16 CET 2015 x86_64 x86_64
x86_64 GNU/Linux

Bus 002 Device 003: ID 1235:800c Focusrite-Novation Scarlett 18i20
Bus 002 Device 002: ID 8087:0024 Intel Corp. Integrated Rate Matching
Hub
Bus 002 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 001 Device 004: ID 0cf3:3005 Atheros Communications, Inc. AR3011
Bluetooth
Bus 001 Device 003: ID 0c45:6436 Microdia 
Bus 001 Device 002: ID 8087:0024 Intel Corp. Integrated Rate Matching
Hub
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub

System Information
	Manufacturer: Sony Corporation
	Product Name: VPCEH2H1E
	Version: C105Z1UX
	Serial Number:
	UUID:
	Wake-up Type: Power Switch
	SKU Number: N/A
	Family: VAIO


Il giorno lun, 26/01/2015 alle 08.30 -0600, Chris J Arges ha scritto:
> 
> On 01/26/2015 07:28 AM, Guido Aulisi wrote:
> > I will ASAP, now I'm not at home.
> > IMHO I think this is something about usb than the mixer,
> > because I didn't use it, I only noticed the xruns even without playing audio.
> > I didn't try 3.18, because it isn't shipped with fedora yet.
> > 
> > Ciao
> > 
> > 2015-01-26 14:04 GMT+01:00 Takashi Iwai <tiwai@suse.de>:
> >> At Sun, 25 Jan 2015 12:42:22 +0100,
> >> Guido Aulisi wrote:
> >>>
> >>> Hi,
> >>> I noticed a regression in 3.19-rc5 kernel (as shipped by fedora rawhide)
> >>> with usb2 focusrite scarlett 18i20.
> >>> I get a lot of xruns with jack, even at 1024 frame buffer and 2 periods.
> >>> In 3.17.8 it works quite well without xruns at the same settings.
> >>>
> 
> Guido, Takashi,
> 
> I tried to reproduce this and failed on my Scarlett 18i8 (I don't have
> any other hardware).
> 
> I've just tested Ubuntu's 3.18.2 and daily mainline 3.19-r5 as follows:
> 1) Setup Scarlett 18i8 w/ jack (RT, 1024 frames/period, sample rate 48k,
> periods/buffer 2).
> 2) Launch Ardour3 and create/arm 8 tracks
> 3) Hit record
> 
> Using this I was unable to see any XRuns even when using Scarlett's
> mixer with alsamixer in the background on 3.19.
> 
> Let me know more details.
> Thanks,
> --chris j arges
> 
> 
> >>> I use a fedora 20 (64bit) laptop with 8GB ram,  I only installed the
> >>> rawhide kernel to try the new included scarlett mixer, no other software
> >>> components changed.
> >>>
> >>> I can try to do some other test, but compiling the kernel on this laptop
> >>> is time consuming.
> >>>
> >>> Thanks
> >>> Guido
> >>
> >> Looks like a regression in the recent rework for Scarlett devices.
> >> Chris, do you have any clue?
> >>
> >> In anyway, Guido, could you give lsusb -v output (for the relevant
> >> part)?
> >>
> >>
> >> thanks,
> >>
> >> Takashi
> > 
