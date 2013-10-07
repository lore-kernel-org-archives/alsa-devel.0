From: Eldad Zack <eldad@fogrefinery.com>
Subject: Re: [PATCH v4 07/15] ALSA: usb-audio: correct ep
 use_count semantics (add set_param flag)
Date: Mon, 7 Oct 2013 21:31:35 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1310072032200.1463@anubis>
References: <1381091480-23636-1-git-send-email-eldad@fogrefinery.com>
 <1381091480-23636-8-git-send-email-eldad@fogrefinery.com>
 <s5hiox9safi.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f54.google.com (mail-bk0-f54.google.com
 [209.85.214.54])
 by alsa0.perex.cz (Postfix) with ESMTP id 50806265176
 for <alsa-devel@alsa-project.org>; Mon,  7 Oct 2013 21:31:39 +0200 (CEST)
Received: by mail-bk0-f54.google.com with SMTP id mz12so2820694bkb.41
 for <alsa-devel@alsa-project.org>; Mon, 07 Oct 2013 12:31:39 -0700 (PDT)
In-Reply-To: <s5hiox9safi.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Nikolay Martynov <mar.kolya@gmail.com>, Clemens Ladisch <clemens@ladisch.de>, alsa-devel@alsa-project.org, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org



On Mon, 7 Oct 2013, Takashi Iwai wrote:

> At Sun,  6 Oct 2013 22:31:12 +0200,
> Eldad Zack wrote:
> > 
> > Currently, use_count is used in snd_usb_endpoint_set_params to
> > ensure the parameters don't get changed for an in-use endpoint.
> > 
> > However, there is a subtle condition where this check fails -
> > if hw_params is called on both substreams before calling prepare (for
> > playback) or start trigger (for capture): the endpoint is not yet
> > started, i.e., snd_usb_endpoint_start() does not yet increment use_count.
> > 
> > This adds a flag to check if the parameters are set, but does not
> > omit checking the use_count.
> > 
> > Signed-off-by: Eldad Zack <eldad@fogrefinery.com>
> > 
> > ---
> > v2: Cleaned up the patch, now it does only one thing (add the flag
> > and the check).
> 
> I guess this logic doesn't work if a capture stream is re-prepared
> before started.  I know that you'll change the capture stream starting
> in the later patch, but then this patch must be applied after that,
> because it implicitly assumes the scheme.

Yes and it causes a regression too, it prevents full-duplex usage
(with jack or client that use the same sequence). Sorry, I forgot to add 
that to the commit message.

I left this so the change is clear, I figured it helps when reading the 
history.
Should I combine this with the later patch? Or should I put a notice in
this commit message that "this patch breaks... will be fixed later 
by..."?

BTW - sorry if that's a trivial question - is it possible for ops to 
race, or do the ops get serialized?
If it is possible, I believe there's a few places that need locking.

Cheers,
Eldad
