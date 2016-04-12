From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Alsamixer: missing Speakers entry in analog output
 choice (chipset AV200)
Date: Tue, 12 Apr 2016 20:49:33 +0800
Message-ID: <CAN8cciZq5DjwfpOTi33Ts468mxLqHSCE3L7sVhD3-R-5F1jvig@mail.gmail.com>
References: <570785F9.3020402@gmail.com>
	<570BA7DA.8010602@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lf0-f68.google.com (mail-lf0-f68.google.com
 [209.85.215.68])
 by alsa0.perex.cz (Postfix) with ESMTP id 46F32265158
 for <alsa-devel@alsa-project.org>; Tue, 12 Apr 2016 14:49:34 +0200 (CEST)
Received: by mail-lf0-f68.google.com with SMTP id p81so2413859lfb.3
 for <alsa-devel@alsa-project.org>; Tue, 12 Apr 2016 05:49:34 -0700 (PDT)
In-Reply-To: <570BA7DA.8010602@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Germano Massullo <germano.massullo@gmail.com>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

> > I have a Asus Xonar Essence ST soundboard
> >
> > Sometimes the Speakers output disappears from alsamixer.
>
> From alsamixer, or from PulseAudio?
>
> > I attach 3 logs taken when the problem was occurring.
>
> > Simple mixer control 'Analog Output',0
> >   Capabilities: enum
> >   Items: 'Speakers' 'Headphones' 'FP Headphones'
>
> It's there.
>
>

device.product.name = "CMI8788 [Oxygen HD Audio] (Virtuoso 100 (Xonar ST))"
device.string = "front:0" device.buffering.buffer_size = "352800"
device.buffering.fragment_size = "352800"
device.access_mode = "mmap+timer"
device.profile.name = "analog-stereo"
device.profile.description = "Stereo analogico"
device.description = "CMI8788 [Oxygen HD Audio] (Virtuoso 100 (Xonar ST))
Stereo analogico"
alsa.mixer_name = "AV200"
alsa.components = "PCM1792A CS5381 CS2000 AV200"
module-udev-detect.discovered = "1"
device.icon_name = "audio-card-pci"

Porte: analog-output;output-speaker: Uscita analogica / Altoparlante
(priority: 9910)
analog-output;output-headphones-1: Uscita analogica / Cuffie analogiche 1
(priority: 9909)
analog-output;output-headphones-2: Uscita analogica / Cuffie analogiche 2
(priority: 9908)
Porta attiva: analog-output;output-speaker

https://cgit.freedesktop.org/pulseaudio/pulseaudio/tree/src/modules/alsa/mixer/paths

https://cgit.freedesktop.org/pulseaudio/pulseaudio/tree/src/modules/alsa/mixer/paths/analog-output.conf.common

You need to put [Option Analog Output:xxx] in three corresponding conf files

https://bugs.freedesktop.org/show_bug.cgi?id=39814
