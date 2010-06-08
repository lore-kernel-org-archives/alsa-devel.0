From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Mixer volume/decibel mapping
Date: Tue, 8 Jun 2010 10:23:45 +0800
Message-ID: <AANLkTimtfPazdWEWAarovOa1NTk6BwnU7w5Zn3M8d7By@mail.gmail.com>
References: <201005191834.57919.vand2@gmx.de>
	<AANLkTimRTIwmzU2Dq4lgBSSwtcmSxfMcBfcll9YDC_l5@mail.gmail.com>
	<AANLkTikWaBVuo-Vo8LIN6jS19cuPv4nDZbgYKzzZeLWg@mail.gmail.com>
	<201005211018.41802.vand2@gmx.de>
	<AANLkTikylA_oo6GBKuLHewVX9oMCNjQMeS90HThDR47K@mail.gmail.com>
	<4C0CB996.5010202@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f189.google.com (mail-pz0-f189.google.com
	[209.85.222.189])
	by alsa0.perex.cz (Postfix) with ESMTP id D6D061038A0
	for <alsa-devel@alsa-project.org>;
	Tue,  8 Jun 2010 04:23:46 +0200 (CEST)
Received: by pzk27 with SMTP id 27so2207533pzk.2
	for <alsa-devel@alsa-project.org>; Mon, 07 Jun 2010 19:23:45 -0700 (PDT)
In-Reply-To: <4C0CB996.5010202@gmx.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2010/6/7 Sebastian H. <vand2@gmx.de>

> Am 07.06.2010 05:37, schrieb Raymond Yau:
> At the moment the sliders are simply sliding linearly from vol. min.
> to vol. max. and there is a label which shows the current dB value.
>
> (This made me realize that the neutral (0dB) position of some HDA-Intel
> record sliders is somwhere in the middle and not at the ends.)
>

For capture volume control , there is gain instead of atten

HDA sepcification define the 0dB offset, so the volume range must contain
0dB somewhere


but some driver may not has 0dB within the volume range any more

http://thread.gmane.org/gmane.linux.alsa.devel/73114/focus=73125
