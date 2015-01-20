From: Chris Rorvick <chris@rorvick.com>
Subject: Re: [PATCH 10/17] ALSA: line6: Reorganize card
	resource handling
Date: Tue, 20 Jan 2015 00:14:08 -0600
Message-ID: <CAEUsAPbOey1LzxLxSQHJmDau9d3FkSWid3DehtE+qOgce772nA@mail.gmail.com>
References: <1421682891-11594-1-git-send-email-tiwai@suse.de>
 <1421682891-11594-11-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qc0-f173.google.com (mail-qc0-f173.google.com
 [209.85.216.173])
 by alsa0.perex.cz (Postfix) with ESMTP id ED757260635
 for <alsa-devel@alsa-project.org>; Tue, 20 Jan 2015 07:14:08 +0100 (CET)
Received: by mail-qc0-f173.google.com with SMTP id m20so18459391qcx.4
 for <alsa-devel@alsa-project.org>; Mon, 19 Jan 2015 22:14:08 -0800 (PST)
In-Reply-To: <1421682891-11594-11-git-send-email-tiwai@suse.de>
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
Cc: Stefan Hajnoczi <stefanha@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Jan 19, 2015 at 9:54 AM, Takashi Iwai <tiwai@suse.de> wrote:
> This is a fairly big rewrite regarding the card resource management in
> line6 drivers:
>
> - The card creation is moved into line6_probe().  This adds the global
>   destructor to private_free, so that each driver doesn't have to call
>   it any longer.
>
> - The USB disconnect callback handles the card release, thus each
>   driver needs to concentrate on only its own resources.  No need to
>   snd_card_*() call in the destructor.
>
> - Fix the potential stall in disconnection by removing
>   snd_card_free().   It's replaced with snd_card_free_when_closed()
>   for asynchronous release.
>
> - The only remaining operation for the card in each driver is the call
>   of snd_card_register().  All the rest are dealt in the common module
>   by itself.
>
> - These ended up with removal of audio.[ch] as a result of a reduction
>   of one layer.  Each driver just needs to call line6_probe().

Nice looking diff --stat.  :-)

Seems like this could be nicely split up into a few patches to make it
a bit easier to review.  I'd be happy to take a stab at that if you
thought it was worth it.  Otherwise, looks good to me.

Chris
