From: David Mohr <damailings@mcbf.net>
Subject: Re: Front jack not working with hda-intel driver
	SigmaTel STAC9271D codec
Date: Tue, 29 Dec 2009 23:54:29 +0100
Message-ID: <472d4b250912291454t6b1c155eoe621ef0ca8fbd49d@mail.gmail.com>
References: <472d4b250912290757r68b6d421id289314d1cb1ea9f@mail.gmail.com>
	<604760770912290801h3c45b49ewc7b34af5996d63aa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-px0-f185.google.com (mail-px0-f185.google.com
	[209.85.216.185])
	by alsa0.perex.cz (Postfix) with ESMTP id C379E243C7
	for <alsa-devel@alsa-project.org>; Tue, 29 Dec 2009 23:54:30 +0100 (CET)
Received: by pxi15 with SMTP id 15so8154798pxi.23
	for <alsa-devel@alsa-project.org>; Tue, 29 Dec 2009 14:54:29 -0800 (PST)
In-Reply-To: <604760770912290801h3c45b49ewc7b34af5996d63aa@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Chen <seven.steps@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Dec 29, 2009 at 5:01 PM, Daniel Chen <seven.steps@gmail.com> wrote:
> On Tue, Dec 29, 2009 at 10:57 AM, David Mohr <damailings@mcbf.net> wrote:
>> http://www.alsa-project.org/db/?f=3ed2ab9e7732bf08d2bbfbe8adb74bf037d9e618
>
> Please use a more recent snapshot:
> http://kernel.org/pub/linux/kernel/people/tiwai/snapshot/alsa-driver-snapshot.tar.bz2

My apologies, using a driver snapshot should have been pretty obvious.
Unfortunately it did not improve things; the problem remains.

I also realize that the existance of pulseaudio complicates things. Is
there a way to switch between the back and front jacks using alsa? Or
how else does pa control this?

I'd be happy to try patches to the current development code, but I
only have access to this machine for around another week. So any
timely help would be greatly appreciated.

Thanks,
~David
