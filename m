From: "Marcin Floryan" <marcin.floryan@gmail.com>
Subject: Re: ACER Aspier 5630 (snd-hda-intel ALC883)
Date: Wed, 30 Jan 2008 19:20:16 +0000
Message-ID: <14cea40a0801301120p1d76d1a6ucec17c67abf80718@mail.gmail.com>
References: <14cea40a0801260447h5582a1cflc05670c7d0077a45@mail.gmail.com>
	<20080126184535.GL1177@serv.smile.org.ua>
	<14cea40a0801300829k5a09ccdci28f9f5e6a6121ef7@mail.gmail.com>
	<s5hhcgv2ry2.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.234])
	by alsa0.perex.cz (Postfix) with ESMTP id 73D1524362
	for <alsa-devel@alsa-project.org>; Wed, 30 Jan 2008 20:20:18 +0100 (CET)
Received: by wr-out-0506.google.com with SMTP id 60so312553wri.8
	for <alsa-devel@alsa-project.org>; Wed, 30 Jan 2008 11:20:17 -0800 (PST)
In-Reply-To: <s5hhcgv2ry2.wl%tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>
Cc: Andy Shevchenko <andy@smile.org.ua>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 30/01/2008, Takashi Iwai <tiwai@suse.de> wrote:

> > > First off, try to choose all models for the given codec (see
> > > Documentation/ALSA-Configuration.txt) one by one and test it. If some model
> > > provides mic work - post it here with the PCI SSID of your sound card.
> >
> > Currently using alsa-driver-hg20080126. Sound output is perfect.
> >
> > The laptop has 2 build-in speakers and a built-in microphone and three
> > jacks in front: mic, line-in and headphones.
> >
> > With: auto, acer, acer-aspire,3stack-dig I can record sound from
> > microphone but the quality is atrocious so barely usable.
>
> Did you raise Mic Boost?

Yes. I did try changing it as well but  it was set to maximum (3) most
of the time.

> Anyway, show the content of /proc/asound/card0/codec#* files and the
> generated file via "alsactl -f somefile store".  These will be helpful
> for further analysis.
>
> > With: targa-2ch-dig I have notice that the output is on both - the
> > speakers and the headphone whereas previously the output was changed
> > by plugging the headphones in.
> >
> > Other options do not really make any difference apart from the number
> > of controls in the mixer.
> >
> > 00:1b.0 Audio device: Intel Corporation 82801G (ICH7 Family) High
> > Definition Audio Controller (rev 02)
> >         Subsystem: Acer Incorporated [ALI] Unknown device 0090
>
> To be sure, provide the output of "lspci -nv" (only for this device)
> to see the PCI SSID more exactly.

00:1b.0 Class 0403: 8086:27d8 (rev 02)
        Subsystem: 1025:0090
        Flags: bus master, fast devsel, latency 0, IRQ 22
        Memory at d2400000 (64-bit, non-prefetchable) [size=16K]
        Capabilities: [50] Power Management version 2
        Capabilities: [60] Message Signalled Interrupts: Mask- 64bit+
Queue=0/0 Enable-
        Capabilities: [70] Express Unknown type IRQ 0
        Capabilities: [100] Virtual Channel
        Capabilities: [130] Unknown (5)

Hope it help.

Regards,
-- 
Marcin Floryan
http://marcin.floryan.pl/

Please consider the environment before printing this email.
