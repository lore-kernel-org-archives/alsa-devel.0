From: "Claudio Matsuoka" <cmatsuoka@gmail.com>
Subject: Re: Splitting up the HDA-INTEL modules
Date: Wed, 23 Jan 2008 17:46:25 -0200
Message-ID: <5f52f6d70801231146m2b668f6yd02df8422d78490d@mail.gmail.com>
References: <478CFD32.50405@harddisk.is-a-geek.org>
	<5f52f6d70801151120y76407dd4s4c876643ddc8ba95@mail.gmail.com>
	<s5h1w8ivvd4.wl%tiwai@suse.de>
	<5f52f6d70801160451p37a8c94ofbbbd2018f88531b@mail.gmail.com>
	<s5hejchvn0e.wl%tiwai@suse.de>
	<5f52f6d70801191119m27f20a6bn3183c44ddb3635bd@mail.gmail.com>
	<s5hfxwre22v.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0910.google.com (rv-out-0910.google.com [209.85.198.185])
	by alsa0.perex.cz (Postfix) with ESMTP id 967F4243BA
	for <alsa-devel@alsa-project.org>; Wed, 23 Jan 2008 20:46:29 +0100 (CET)
Received: by rv-out-0910.google.com with SMTP id k20so2143934rvb.32
	for <alsa-devel@alsa-project.org>; Wed, 23 Jan 2008 11:46:26 -0800 (PST)
In-Reply-To: <s5hfxwre22v.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Marco Schuster <marco@harddisk.is-a-geek.org>
List-Id: alsa-devel@alsa-project.org

On Jan 21, 2008 11:32 AM, Takashi Iwai <tiwai@suse.de> wrote:

> The current implementation is in such a form intentionally to make a
> transition smoothly.  In this way, you can port the existing kernel
> code quite easily to the new framework without losing functionality.
> The worst thing is that the machine doesn't work any longer by this
> transition.  That's why I don't want to move to a generic parser or a
> dynamic parsing at the very first step.

Right, it's a good strategy.. I've built 0.0.10b against hg with only
minor changes (notably 3 instances of
-Werror-implicit-function-declaration had to be removed from
configure.in). However, hda-config still complains about ioctl
PVERSION error (ioctl() with HDA_IOCTL_PVERSION returns -1). Known
problem or should I investigate further?
