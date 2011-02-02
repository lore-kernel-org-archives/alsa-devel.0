From: Rods Bobavich <rodnisms@gmail.com>
Subject: Re: snd-usb-audio dying on jackd xruns
Date: Wed, 2 Feb 2011 11:08:37 -0700
Message-ID: <AANLkTikiNx6H_v+y0j7FnnqfJox3_Oq4kAqhpw=O8c77@mail.gmail.com>
References: <AANLkTinc02yXS=axf5wCQMq3e+nhiJj_ZaHmjk-bcorS@mail.gmail.com>
	<4D499550.2070508@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51]) by alsa0.perex.cz (Postfix) with ESMTP id 3D2EF243B1
	for <alsa-devel@alsa-project.org>; Wed,  2 Feb 2011 19:08:58 +0100 (CET)
Received: by ewy19 with SMTP id 19so206930ewy.38
	for <alsa-devel@alsa-project.org>; Wed, 02 Feb 2011 10:08:57 -0800 (PST)
In-Reply-To: <4D499550.2070508@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Clemens,

USB bug. This is exactly what I thought. Here's a tail of the syslog:

Feb  2 11:04:45 studio1 kernel: [  997.880412] ALSA pcm.c:226: setting usb
interface 2:1
Feb  2 11:04:45 studio1 kernel: [  997.889440] ALSA pcm.c:226: setting usb
interface 1:1
Feb  2 11:05:03 studio1 kernel: [ 1015.338527] CE: hpet increased
min_delta_ns to 7500 nsec
Feb  2 11:05:28 studio1 kernel: [ 1040.071773] ALSA urb.c:146: timeout:
still 7 active urbs..
Feb  2 11:05:34 studio1 kernel: [ 1046.070072] ALSA urb.c:146: timeout:
still 2 active urbs..
Feb  2 11:05:56 studio1 kernel: [ 1068.660883] ALSA pcm.c:223: 4:2:1:
usb_set_interface failed

It seems that the error happened about the time of the hpet increase. Do we
have a timer problem?

...Rods ;-)

On Wed, Feb 2, 2011 at 10:33, Clemens Ladisch <clemens@ladisch.de> wrote:

> Rods Bobavich wrote:
> > So I start jackd and it runs fine for a while. Then ALSA crashes and
> > triggers an xrun. Jackd continues to do its merry thing - minus the part
> > about spitting info out to my soundcard...
> >
> > At first I thought this was a Jackd issue but when I looked deeper it
> seems
> > to be ALSA. Once this happens I cannot restart jackd and resume an audio
> > session. In fact, I cannot even rmmod snd-usb-audio. Sometimes I cannot
> > lsusb. So it looks like something is getting seriously hosed!
>
> Looks like a bug in the USB controller driver, probably triggered by some
> unexpected behaviour of your USB controller.
>
> When this happens, are there any error messages in the system log?
>
>
> Regards,
> Clemens
>
