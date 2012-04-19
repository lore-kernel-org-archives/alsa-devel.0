From: Grant Diffey <gdiffey@gmail.com>
Subject: Re: M-Audio FastTrack C400
Date: Thu, 19 Apr 2012 21:09:06 +1000
Message-ID: <CACckToWQr=XBNH+p+twGzKQscjZs5WyG3jazJ79x9jpU=DteGg@mail.gmail.com>
References: <4F8D63F4.1040208@rauros.net>
	<CACckToXF6yW+GzhzJ3zVBKi3e+thwrpDVnFmMCtjQOqePuixZg@mail.gmail.com>
	<4F8DF29B.9090907@rauros.net>
	<CACckToU47usDbT7Cj6DiBNcCQc_4AmxnDJgW07PMALzjv9a52Q@mail.gmail.com>
	<4F8E6CA2.8010005@ladisch.de> <4F8F7213.8070206@rauros.net>
	<4F8FD2A7.60700@ladisch.de> <4F8FE83E.2070600@rauros.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f41.google.com (mail-wg0-f41.google.com [74.125.82.41])
	by alsa0.perex.cz (Postfix) with ESMTP id A313524595
	for <alsa-devel@alsa-project.org>;
	Thu, 19 Apr 2012 13:09:06 +0200 (CEST)
Received: by wgbds1 with SMTP id ds1so1575303wgb.2
	for <alsa-devel@alsa-project.org>; Thu, 19 Apr 2012 04:09:06 -0700 (PDT)
In-Reply-To: <4F8FE83E.2070600@rauros.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: chris-alsa@rauros.net
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 19, 2012 at 8:26 PM, Chris Cavey <chris-alsa@rauros.net> wrote:

> Complete snippet from the log
>
> [  374.104138] usbcore: deregistering interface driver snd-usb-audio
> [  374.875660] snd-usb-audio: probe of 1-1:1.1 failed with error -5
> [  374.881649] snd-usb-audio: probe of 1-1:1.2 failed with error -5
> [  374.887654] snd-usb-audio: probe of 1-1:1.3 failed with error -5
> [  374.895366] usbcore: registered new interface driver snd-usb-audio
>
> Sidenote - While I don't have a midi device to test with, it would
> appear that the midi portion registers correctly and is accessible (at
> least through amidi and aplaymidi)
>
> On 04/19/2012 04:53 AM, Clemens Ladisch wrote:
> > Chris Cavey wrote:
> >>   snd-usb-audio: probe of 1-1:1.1 failed with error -5
> >>   snd-usb-audio: probe of 1-1:1.2 failed with error -5
> >>   snd-usb-audio: probe of 1-1:1.3 failed with error -5
> > Are there no other messages immediately before this?
> >
>
that looks like a snippet on unload can I have another 10 lines either side?
