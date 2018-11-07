From: Tzung-Bi Shih <tzungbi@google.com>
Subject: Re: [PATCH] ASoC: dapm: Use less aggressive caching to
	ensure correctness
Date: Wed, 7 Nov 2018 12:03:06 +0800
Message-ID: <CA+Px+wU59XObu9C2RphG8st9TEZ4v8HTtM8s5TpyGa+tSCBTKg@mail.gmail.com>
References: <20181105111912.14464-1-tzungbi@google.com>
 <20181106171845.GF31950@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi1-f195.google.com (mail-oi1-f195.google.com
 [209.85.167.195])
 by alsa0.perex.cz (Postfix) with ESMTP id A39772678F2
 for <alsa-devel@alsa-project.org>; Wed,  7 Nov 2018 05:03:20 +0100 (CET)
Received: by mail-oi1-f195.google.com with SMTP id 192-v6so12000841oii.6
 for <alsa-devel@alsa-project.org>; Tue, 06 Nov 2018 20:03:20 -0800 (PST)
In-Reply-To: <20181106171845.GF31950@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, Dylan Reid <dgreid@google.com>, lgirdwood@gmail.com, Jimmy Cheng-Yi Chiang <cychiang@google.com>
List-Id: alsa-devel@alsa-project.org

The original assumption at the bottom of snd_soc_instantiate_card()
would be: all widget->endpoints are -1, and all widgets are in the
list card->dapm_dirty.  So that before returning from
snd_soc_instantiate_card(), the snd_soc_dapm_sync() can calculate
widget->endpoints and check power states for the whole graph of the
card.

However, if some widgets' endpoints have been polluted and get removed
from the dirty list in the middle of snd_soc_instantiate_card(), they
would have no chance to be recalculated at the bottom of
snd_soc_instantiate_card().

Two ideas so far:
The first one is protecting the endpoints cache and the dirty list
during card instantiating by checking card->instantiated in
is_connected_output_ep(), is_connected_input_ep(), and
dapm_power_widgets().  Note that is_connected_output_ep() and
is_connected_input_ep() will be invoked if someone read from debugfs.
We could return -1 to indicate the endpoints cache is disallowed to
access in the case.

The second one is forcing to recalculate the graph at the bottom of
snd_soc_instantiate_card() by additionally calling
dapm_mark_endpoints_dirty().  It would waste some computing power by
comparing with the first idea but it would be also simpler than the
first one.

Which one makes the most sense for you?  Or any other ideas?

On Wed, Nov 7, 2018 at 1:18 AM Mark Brown <broonie@kernel.org> wrote:
>
> On Mon, Nov 05, 2018 at 07:19:12PM +0800, Tzung-Bi Shih wrote:
>
> > +++ b/sound/soc/soc-dapm.c
> > @@ -2722,7 +2722,7 @@ static int snd_soc_dapm_add_path(struct snd_soc_dapm_context *dapm,
> >               dapm_mark_dirty(widgets[dir], "Route added");
> >       }
> >
> > -     if (dapm->card->instantiated && path->connect)
> > +     if (path->connect)
> >               dapm_path_invalidate(path);
> >
> >       return 0;
>
> The whole point with the instantiated check here is that when we
> instantiate the card we're supposed to go through and redo all the DAPM
> configuration for the card in one fell swoop rather than having to
> constantly redo things while we're building up the graph.  If that
> invalidation isn't happening then we should fix that.
