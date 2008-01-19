From: "Claudio Matsuoka" <cmatsuoka@gmail.com>
Subject: Re: Splitting up the HDA-INTEL modules
Date: Sat, 19 Jan 2008 17:19:25 -0200
Message-ID: <5f52f6d70801191119m27f20a6bn3183c44ddb3635bd@mail.gmail.com>
References: <478CFD32.50405@harddisk.is-a-geek.org>
	<5f52f6d70801151120y76407dd4s4c876643ddc8ba95@mail.gmail.com>
	<s5h1w8ivvd4.wl%tiwai@suse.de>
	<5f52f6d70801160451p37a8c94ofbbbd2018f88531b@mail.gmail.com>
	<s5hejchvn0e.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0910.google.com (rv-out-0910.google.com [209.85.198.185])
	by alsa0.perex.cz (Postfix) with ESMTP id A89D12437B
	for <alsa-devel@alsa-project.org>; Sat, 19 Jan 2008 20:19:27 +0100 (CET)
Received: by rv-out-0910.google.com with SMTP id k20so1033308rvb.32
	for <alsa-devel@alsa-project.org>; Sat, 19 Jan 2008 11:19:25 -0800 (PST)
In-Reply-To: <s5hejchvn0e.wl%tiwai@suse.de>
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

On Jan 16, 2008 12:54 PM, Takashi Iwai <tiwai@suse.de> wrote:

> I put the versoin 0.0.10b now.  It includes the patches to the latest
> ALSA tree but no other changes.
>         ftp://ftp.suse.com/pub/people/tiwai/hda-tools/hda-tools-0.0.10b.tar.bz2
>
> (it might take some time to be exported to the outside.)

I see that, while in userspace, this is very similar in overall
structure to the current kernelspace driver (the file layout being
much more organized, however). Have you considered the option to have
codec_config_preset for each model specified in a description file
that is parsed and sent to the actual driver at runtime, instead of
hard-wired inside the library? The parser itself doesn't seem hard to
implement, especially if we use the C preprocessor to handle includes
and macros. Handling of unsol events would be less flexible, but I
don't know if there are many uses for it except muting/unmuting other
channels when using external microphones and headphones (and these
cases could be well covered by specifying what to mute/unmute in the
description file).

The description file could also be very similar to the format
currently used in the C source, just making it easier to parse and
having one model per file (with common definitions included via
preprocessor). I'm not sure how well this would fit for Sigmatel
codecs, but seems to be apropriate for Realtek.
