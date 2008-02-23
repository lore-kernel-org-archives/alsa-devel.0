From: "Lee Revell" <rlrevell@joe-job.com>
Subject: Re: emu10k1, how to setup DMA for 24bit playback?
Date: Fri, 22 Feb 2008 20:05:34 -0500
Message-ID: <75b66ecd0802221705i77c753fdh7c30d7f7f30e7e05@mail.gmail.com>
References: <200802210009.33259.c.fertr@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0910.google.com (rv-out-0910.google.com [209.85.198.186])
	by alsa0.perex.cz (Postfix) with ESMTP id BA6D5244D3
	for <alsa-devel@alsa-project.org>; Sat, 23 Feb 2008 02:05:36 +0100 (CET)
Received: by rv-out-0910.google.com with SMTP id k20so420754rvb.32
	for <alsa-devel@alsa-project.org>; Fri, 22 Feb 2008 17:05:35 -0800 (PST)
In-Reply-To: <200802210009.33259.c.fertr@gmail.com>
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
To: Ctirad Fertr <c.fertr@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Feb 20, 2008 at 6:09 PM, Ctirad Fertr <c.fertr@gmail.com> wrote:
> Hello,
>
>  I'm trying to add 24bit playback for E-mu cards into emu10k driver. These
>  cards use an FPGA, which is 32bit internally and it is feeded via 10k2 EMU32
>  BUSes.  Unfortunatelly, the emu10k DMA cannot handle more than 16bit samples,
>  so kind of tricky stuff is needed. The already working 24bit multichannel
>  capture uses an DSP code, which splits an 32 bit sample into two halfs, sent
>  it over two DMA channels and then alsa lib (???) joins it back into S32_LE
>  sample.
>
>  I'm trying to use same technique in reverse way using a pair of A_FXBUSes for
>  one playback chanel, but I'm not able to set the DMA the way I need. Can
>  someone with emu10k knowledge help me?

I did quite a bit of work on this driver a few years back, among other
things I implemented the multichannel playback support (the hw:0,3
device).

Do you have a web page with details on your work, or can you explain
exactly what you've done so far and how it fails?  Preferably in patch
form...

How are you getting your hardware info?  I mostly used the kX drivers
and guesswork.

Lee
