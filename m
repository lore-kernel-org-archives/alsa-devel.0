From: Daniel Baluta <daniel.baluta@gmail.com>
Subject: Re: [PATCH] ASoC: simple-card: fixup refcount_t
	underflow
Date: Sat, 16 Feb 2019 12:36:04 +0200
Message-ID: <CAEnQRZCXL_QKDL_8+yFM=O2Kb0CCRrg3KwUC4YV_XXUpC72s_w@mail.gmail.com>
References: <878syh8svy.wl-kuninori.morimoto.gx@renesas.com>
 <CAEnQRZD3CRzHDd-eGbVWqBUmNuqGaXJwTboQ3v1TnZAN3B_4bw@mail.gmail.com>
 <CAEnQRZC+jDPRLhNEY5xP9AFxvqFvjBVRDxVfNbgfURudXuO1FQ@mail.gmail.com>
 <20190215170257.GE7897@sirena.org.uk> <s5h36opvugv.wl-tiwai@suse.de>
 <20190215173108.GF7897@sirena.org.uk> <s5hef88ao51.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com
 [209.85.208.68])
 by alsa0.perex.cz (Postfix) with ESMTP id B33C726700B
 for <alsa-devel@alsa-project.org>; Mon, 18 Feb 2019 09:45:10 +0100 (CET)
Received: by mail-ed1-f68.google.com with SMTP id g9so2596836eds.3
 for <alsa-devel@alsa-project.org>; Mon, 18 Feb 2019 00:45:10 -0800 (PST)
In-Reply-To: <s5hef88ao51.wl-tiwai@suse.de>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Liam Girdwood <lgirdwood@gmail.com>, Vicente Bergas <vicencb@gmail.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Fri, Feb 15, 2019 at 8:43 PM Takashi Iwai <tiwai@suse.de> wrote:
>
> On Fri, 15 Feb 2019 18:31:08 +0100,
> Mark Brown wrote:
> >
> > On Fri, Feb 15, 2019 at 06:21:04PM +0100, Takashi Iwai wrote:
> >
> > > Actually it's not all.  As mentioned in my earlier post, there are
> > > more of refcount unbalance in the code.  Lots of them, really.
> >
> > > Below is a patch I've fixed quickly over the whole scanning the sound
> > > tree.  Some might be incorrect, so more detailed review for each piece
> > > of change is needed...
> >
> > Extra references aren't such a problem for practical systems since we
> > don't actually ever free any of the DT (there's no mainline way to use
> > overlays yet...), that's how none of this stuff ever gets noticed.  I'm
> > not surprised there's loads of missing frees TBH.  In contrast if we've
> > got extra frees they will get noticed and cause problems.
>
> Yeah, the rest are just leaks, and we have already tons of them :)
>
> The point is that the commit in question introduced multiple such
> issues, so they should be addressed as well.
>
> But, the biggest problem is that OF api is very hard to use right...

Hello Mark/Takashi,

Just sent this https://lkml.org/lkml/2019/2/16/52
to fix the problem that was bugging me and to
update the patch from Kuninori.

Feel free to send a patch for the rest of the refcount issues :).

Kuninori, if you consider necessary please add your Signed-off-by to the patch
as it is mostly your work but I didn't know exactly how to give you
credit for it :(.

thanks,
Daniel.
