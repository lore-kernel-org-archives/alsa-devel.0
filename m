From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH] snd-usb-audio with multiple audio functions
Date: Mon, 6 Jun 2011 10:45:49 +0200
Message-ID: <BANLkTi=pZYO4SEhYxmfh9-vAucFumeQ=JQ@mail.gmail.com>
References: <4DEC787C.3050805@yahoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pw0-f51.google.com (mail-pw0-f51.google.com
	[209.85.160.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 01907103821
	for <alsa-devel@alsa-project.org>;
	Mon,  6 Jun 2011 10:45:50 +0200 (CEST)
Received: by pwi9 with SMTP id 9so2024139pwi.38
	for <alsa-devel@alsa-project.org>; Mon, 06 Jun 2011 01:45:49 -0700 (PDT)
In-Reply-To: <4DEC787C.3050805@yahoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Rolf Meeser <rolfm_9dq@yahoo.de>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Rolf,

On Mon, Jun 6, 2011 at 8:49 AM, Rolf Meeser <rolfm_9dq@yahoo.de> wrote:
> Hello,
>
> This patch fixes the currently broken support for multiple audio functions
> (AF) in snd-usb-audio.
> The patch is against the stable 2.6.39.1 kernel.
>
> It addresses three issues:
> 1. Controls of the second and any further AF are currently not accessibly
> (controls of the first AF are duplicated!)
> 2. Multiple AF's are currently incorrectly combined into one sound card
> index.
> 3. Module usage count of snd-usb-audio does not drop to zero after
> disconnecting a multiple AF device.
>
> All three issues are fixed by assigning a new card index for each AF in a
> USB device.

I assume you have such a device? Which model is that?

> Rationale:
>
> - A USB audio function (AF) consists of a control interface and zero or more
> streaming interfaces. USB devices can have multiple AF, where the individual
> AF are completely independent of each other. In particular, it cannot be
> assumed that the controls of one AF can be manipulated through the control
> interface of another (the first) AF.
>
> - Older kernels (up to 2.6.32? at least before the major rewrite of USB
> audio code) supported multiple AF's. However, they combined the streams into
> one sound card: For instance hw:1,0 for the stream interface of the first
> AF, and hw:1,1 for the stream interface of the second AF.
> I believe this is incorrect, as different AF's must be treated as an
> independent entity. Each AF must get its own card index, for the example
> this would be hw:1,0 and hw:2,0. This is also the way THE OTHER OS
> implements it.
>
> - Newer kernels have broken multiple AF support. In a dual AF setup these
> kernels detect the second AF, but they duplicate the controls of the first
> AF, and ignore the controls of the second one!
>
> - The patch also fixes a problem with module usage: When you unplug a
> multiple AF device, the snd-usb-audio module usage count currently stays at
> 1, while you could expect it to go to zero.
>
> This is the first time I'm sending a patch to this list. Please be patient
> with me if I did something in a wrong way :-)

The patch itself looks reasonable to be, and I doubt it would break
any existing functions.

However, please have a look at Documentation/SubmittingPatches. In
particular, you need to have a comprehensive commit log (which can be
taken from your explanations in this email) and your "Signed-off-by:"
line above the actual patch. Would you care to resend?

Thanks a lot for sharing your work!

Daniel
