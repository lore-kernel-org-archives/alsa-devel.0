From: "Nobin Mathew" <nobin.mathew@gmail.com>
Subject: Re: [ASoC]one Small Suggestion
Date: Fri, 8 Jun 2007 13:56:14 +0530
Message-ID: <8d6898730706080126x27575de7k645e2bf280201037@mail.gmail.com>
References: <8d6898730706070558r6c5c08aft8e00563b7a8ba607@mail.gmail.com>
	<8d6898730706080047x37a2ddb4m9766246017e43029@mail.gmail.com>
	<1181289387.9717.3.camel@gg-desktop.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from qb-out-0506.google.com (qb-out-0506.google.com [72.14.204.225])
	by alsa0.perex.cz (Postfix) with ESMTP id 097EF2468C
	for <alsa-devel@alsa-project.org>;
	Fri,  8 Jun 2007 10:26:15 +0200 (CEST)
Received: by qb-out-0506.google.com with SMTP id c7so848238qbc
	for <alsa-devel@alsa-project.org>; Fri, 08 Jun 2007 01:26:14 -0700 (PDT)
In-Reply-To: <1181289387.9717.3.camel@gg-desktop.wolfsonmicro.main>
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
To: Graeme Gregory <gg@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Like we have in /proc/asound/card0/codec97#0/ac97#0-0+regs

On 6/8/07, Graeme Gregory <gg@opensource.wolfsonmicro.com> wrote:
> On Fri, 2007-06-08 at 13:17 +0530, Nobin Mathew wrote:
> > Adding a nice proc interface to read codec registers will be a nice
> > feature have, like we have in generic ac97 registers, i added that
> > that in wm9713.c by using ac97_proc.c
> >
> You mean like /sys/devices/platform/soc-audio/codec_reg :-)
>
> Liam is working currently on the private data issue in his new edition
> of ASoC coming soon.
>
> Graeme (sitting 4 feet to left of Liam).
>
>
>
