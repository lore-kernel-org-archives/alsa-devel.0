From: Daniel Mack <daniel@zonque.org>
Subject: Re: Alsa for OSX
Date: Wed, 7 Sep 2011 10:29:59 +0200
Message-ID: <CACTFLAM_wFLPWjpAJFB8zJ-L6NuBkZP9TRbWnTY_sT-FM2og8Q@mail.gmail.com>
References: <CAMaDG4ReSbhUx-PXFLTXHHdHxjM4DFSe1H8jjOygNRtd66HGoQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f43.google.com (mail-pz0-f43.google.com
	[209.85.210.43])
	by alsa0.perex.cz (Postfix) with ESMTP id E48C1103874
	for <alsa-devel@alsa-project.org>;
	Wed,  7 Sep 2011 10:30:00 +0200 (CEST)
Received: by pzk1 with SMTP id 1so11968909pzk.2
	for <alsa-devel@alsa-project.org>; Wed, 07 Sep 2011 01:29:59 -0700 (PDT)
In-Reply-To: <CAMaDG4ReSbhUx-PXFLTXHHdHxjM4DFSe1H8jjOygNRtd66HGoQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Lapisu <p.lapisu@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Sep 7, 2011 at 10:24 AM, Peter Lapisu <p.lapisu@gmail.com> wrote:
> hello
>
> iam using a Lion 10.7.2 hackintosh with the ASUS Maximus IV Gene Z
>
> my adudio is SupremeFX X-Fi 2
>
> is there any version of Alsa for OSX ? as the Voodoo drivers causes a kernel
> panic and the AppleHDA drivers causes problems too
>
> i read that under linux, to use my audio (SupremeFX X-Fi 2), i need ALSA...
> i know OSX isnt linux, but is there an OSX support?

ALSA has nothing to do with OSX at all. The native sound system under
OSX is called CoreAudio, and it's entirely incompatible to ALSA.

So if you need to have support for this specific sound card, you have
to find a driver for CoreAudio, or develop one on your own.


Daniel
