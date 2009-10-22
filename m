From: James Courtier-Dutton <james.dutton@gmail.com>
Subject: Re: patchmix application for EMU1616m
Date: Thu, 22 Oct 2009 15:35:36 +0100
Message-ID: <ad2655cb0910220735t573537b4j562e6ad46ab46f1c@mail.gmail.com>
References: <8282c2500910190031x3c65a3d4je5d77fb1c66b1dab@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.152])
	by alsa0.perex.cz (Postfix) with ESMTP id 8987C103806
	for <alsa-devel@alsa-project.org>;
	Thu, 22 Oct 2009 16:35:36 +0200 (CEST)
Received: by fg-out-1718.google.com with SMTP id d23so2582480fga.2
	for <alsa-devel@alsa-project.org>; Thu, 22 Oct 2009 07:35:36 -0700 (PDT)
In-Reply-To: <8282c2500910190031x3c65a3d4je5d77fb1c66b1dab@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dominik Zalewski <dominikz@genijusz.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

2009/10/19 Dominik Zalewski <dominikz@genijusz.org>:
> Is there anybody working on patchmix application for alsa?
> I'm wondering what would be the guidelines.
> - Should it be a clone of a patchmix for Windows: a separate program?
> - Or maybe there is already some infrastructure in Alsa that should be
> extended with that functionality?
> - Alsamixer already has some of that functionality, should be
> replicated in new patchmix application?
> - Are there any restrictions for the GUI libraries that may be used?
> - Does it have to be written in C/C++, or is Java also applicable?
>

It can be written in any language you like.
It will need to be able to interface with the alsa-lib.
Note that each sample rate requires different DSP code.
For example.
48khz uses one DSP channel, but can do more streams.
96khz uses two DSP channels, so can only have fewer streams.
192khz uses four DSP channels, so can only have fewer streams still.

So, for example, in the patchmix app, it will have to know about these
low level details, so that if the user changes the rate in the app,
patchmix clears the DSP and then reloads it with the correct DSP code
for that rate.
It is my view that all these different DSP codes for each of the
different sample rates should not be stored in the kernel, but instead
in the patchmix app. This is how it is done in windows.
There is currently fixed DSP code, ie. does not have patches, for
48khz in the ALSA kernel module.
