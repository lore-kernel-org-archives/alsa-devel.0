From: Riku Voipio <riku.voipio@linaro.org>
Subject: Re: [PATCH][RFC] alsa-lib: heavy pcm atomics cleanup
Date: Wed, 12 Feb 2014 09:52:57 +0200
Message-ID: <CAAqcGHmO-5HD4-q37eLPdgoRBYTJWHp_dfM6z6Q6Jk4Rd+JmzQ@mail.gmail.com>
References: <1391780338-13077-1-git-send-email-riku.voipio@linaro.org>
 <s5hiosl95mg.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yh0-f52.google.com (mail-yh0-f52.google.com
 [209.85.213.52])
 by alsa0.perex.cz (Postfix) with ESMTP id 00065261B25
 for <alsa-devel@alsa-project.org>; Wed, 12 Feb 2014 08:52:58 +0100 (CET)
Received: by mail-yh0-f52.google.com with SMTP id a41so8034116yho.11
 for <alsa-devel@alsa-project.org>; Tue, 11 Feb 2014 23:52:57 -0800 (PST)
In-Reply-To: <s5hiosl95mg.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 11 February 2014 14:49, Takashi Iwai <tiwai@suse.de> wrote:

> At Fri,  7 Feb 2014 15:38:58 +0200,
> riku.voipio@linaro.org wrote:
> >
> > From: Riku Voipio <riku.voipio@linaro.org>
> >
> > The following patch comes from the realization that at least ARM code
> > for atomics is quite broken and nobody has cared for a decade.
> >
> > A quick dive shows that only snd_atomic_{read,write}_{begin,end}
> > appear to be used widely. These are implemented using wmb/rmb.
> >
> > Only other use of atomic functions is in pcm_meter.c.
> > The #SND_PCM_TYPE_METER plugin type appears rarely, if ever, used.
> > I presume these days anyone who wants a meter/scope will do in pulseaudio
> > layer instead of alsa.
> >
> > It would seem better fit to have pcm_meter in alsa-plugins instead
> > of alsa-lib, but I guess that would be an ABI break...
> >
> > So instead, I'm proposing here
> >
> > 1. Removal of all hand-crafted atomics from iatomic.h apart from
> barriers,
> >    which are used in snd_atomic_{read,write}_{begin,end}.
> >
> > 2. Using __sync_synchronize as the default fallback for barriers. This
> >    has been available since gcc 4.1, so it shouldn't be a problem.
> >
> > 3. Defining the few atomics used by pcm_meter.c withing pcm_meter.c
> >    itself, using gcc atomic builtins[1].
> >
> > 4. Since gcc atomic builtins are available only since gcc 4.7, add a
> check for
> >    that in gcc configure.in, and don't build pcm meter plugin if using
> >    older gcc.
> >
> > The last point has the impact, that if there actually is someone who 1)
> > uses the meter plugin 2) wants to upgrade to 2014 alsa-lib 3) but
> > does not want to use a 2012+ gcc - that someone will be inconvenienced.
> >
> > Finally remove the unneeded configure check for cpu type. We can
> > trust the gcc to set right flags for us.
> >
> > [1] http://gcc.gnu.org/onlinedocs/gcc/_005f_005fatomic-Builtins.html
> >
> > Signed-off-by: Riku Voipio <riku.voipio@linaro.org>
>
> This looks like a good cleanup.
> I applied it now.
>

Thanks, if you get any issues from this change, please contact me and I'll
try to get it fixed quickly.

Riku
