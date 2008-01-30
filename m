From: "Marcin Floryan" <marcin.floryan@gmail.com>
Subject: Re: ACER Aspier 5630 (snd-hda-intel ALC883)
Date: Wed, 30 Jan 2008 16:29:40 +0000
Message-ID: <14cea40a0801300829k5a09ccdci28f9f5e6a6121ef7@mail.gmail.com>
References: <14cea40a0801260447h5582a1cflc05670c7d0077a45@mail.gmail.com>
	<20080126184535.GL1177@serv.smile.org.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from el-out-1112.google.com (el-out-1112.google.com [209.85.162.180])
	by alsa0.perex.cz (Postfix) with ESMTP id B9EC724747
	for <alsa-devel@alsa-project.org>; Wed, 30 Jan 2008 17:29:42 +0100 (CET)
Received: by el-out-1112.google.com with SMTP id z25so61368ele.8
	for <alsa-devel@alsa-project.org>; Wed, 30 Jan 2008 08:29:41 -0800 (PST)
In-Reply-To: <20080126184535.GL1177@serv.smile.org.ua>
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
To: Andy Shevchenko <andy@smile.org.ua>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 26/01/2008, Andy Shevchenko <andy@smile.org.ua> wrote:

> > I was wondering now if there is anything I could do to help with
> > driver development to fine-tune for this particular hardware setup. I
> > can provide some further details or do some tests if guided a bit (I
> > am fairly comfortable modifying source code and compiling the driver)

> First off, try to choose all models for the given codec (see
> Documentation/ALSA-Configuration.txt) one by one and test it. If some model
> provides mic work - post it here with the PCI SSID of your sound card.

Currently using alsa-driver-hg20080126. Sound output is perfect.

The laptop has 2 build-in speakers and a built-in microphone and three
jacks in front: mic, line-in and headphones.

With: auto, acer, acer-aspire,3stack-dig I can record sound from
microphone but the quality is atrocious so barely usable.

With: targa-2ch-dig I have notice that the output is on both - the
speakers and the headphone whereas previously the output was changed
by plugging the headphones in.

Other options do not really make any difference apart from the number
of controls in the mixer.

In some cases the mic sound quality seems to be tiny bit better if I
switch to build-in microphone but it is far, far from good (and from
what I hear in my headphones when I enable microphone as output).

00:1b.0 Audio device: Intel Corporation 82801G (ICH7 Family) High
Definition Audio Controller (rev 02)
        Subsystem: Acer Incorporated [ALI] Unknown device 0090
        Flags: bus master, fast devsel, latency 0, IRQ 22
        Memory at d2400000 (64-bit, non-prefetchable) [size=16K]
        Capabilities: [50] Power Management version 2
        Capabilities: [60] Message Signalled Interrupts: Mask- 64bit+
Queue=0/0 Enable-
        Capabilities: [70] Express Unknown type IRQ 0
        Capabilities: [100] Virtual Channel
        Capabilities: [130] Unknown (5)

Regards,
-- 
Marcin Floryan
http://marcin.floryan.pl/

Please consider the environment before printing this email.
