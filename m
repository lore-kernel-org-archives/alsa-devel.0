From: Andreas Mohr <andi@lisas.de>
Subject: Re: Bugs on aspire one A150
Date: Sun, 9 Nov 2008 14:31:12 +0100
Message-ID: <20081109133112.GA4968@rhlx01.hs-esslingen.de>
References: <s5h3ai11dpt.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rhlx01.hs-esslingen.de (rhlx01.hs-esslingen.de [129.143.116.10])
	by alsa0.perex.cz (Postfix) with ESMTP id 0A74524330
	for <alsa-devel@alsa-project.org>; Sun,  9 Nov 2008 14:31:12 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5h3ai11dpt.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Kernel Testers List <kernel-testers@vger.kernel.org>, linux-kernel@vger.kernel.org, Maxim Levitsky <maximlevitsky@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hi,

[Takashi]:
> Interesting.  Is it with or without model option?  There is a model
> option specific for aspire one (acer-aspire).  Doesn't it work better?

I had already tried 2.6.28-rc3 on A110L (also plus hand-patched digital-mic patch of
patch_realtek.c) and it still didn't work for me.
I didn't use the acer one model parameter, though.

Well, now I just did use it, and it didn't work either AFAICT, with lots
of mixer fumbling again.

And I'm not sure whether the model name should be "acer-aspire" instead
of "acer-aspireone" since Aspire is the name of an entire series
which might possibly have incompatible requirements.
Also, I'm not really happy with the fact that snd_hda_intel doesn't even
log the model name chosen/selected on module initialisation.

Frankly I've had so much snd_hda_intel codec-specific trouble on pretty much all of the
few notebooks/machines that I touched in the last year (that's not an
understatement!) that I think it would be a very nice idea to write a _very_ visible
HOWTO (search words: intel-hda alsa HOWTO codec etc.) detailling how to improve
codec-specific support for snd_hda_intel (this should best be done by explaining
how one arrived at a particular patch for a certain codec, e.g. take the
recent ALC268 work, i.e. check /proc/asound/Intel/codec#0 and look at which part
is not supported by the snd_hda_intel patch file yet and then explain how to add stuff
to it, in very verbose and generic words to let layman people know how to do
this).

As already said, I've (and certainly not only me!) been bitten
again and again and AGAIN by incomplete codec support in snd_hda_intel, thus
we need to make damn sure people can help themselves as well as remotely
possible, to ensure sufficiently fast and sufficiently complete support
for new HDA codecs (which seem to appear each new month or week even,
unfortunately!).
If people don't even know how to tackle this easily, then patch submissions for new
codecs aren't too likely...

And the A110L has been on the shelves for 4 or 5 months already (with 5 to 6
million units sold, they say!!), a time where full support would have been in order.
But it's certainly a major fault of Acer to not have provided full ALSA
support for this (note that I'm not sure about Mic support in its
pre-installed Linpus installation), the ALSA people certainly don't have
any responsibility for this.

Thanks,

Andreas Mohr
