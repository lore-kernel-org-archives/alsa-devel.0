From: Adam Goode <agoode@google.com>
Subject: Re: [PATCH - seq 1/1] ALSA seq: expose the card number
	of ALSA seq clients
Date: Fri, 12 Jun 2015 12:13:16 -0400
Message-ID: <CAOf41N=PsN-KhbcMOnWnHApsYHGMZntcUr_Lx10qjjto33D82w@mail.gmail.com>
References: <1433466290-31244-1-git-send-email-agoode@google.com>
 <s5hvbeyigtz.wl-tiwai@suse.de>
 <CAOf41NkjzBSAJgpX_OL_5D0u6BqMAj++BSxVA8YVZzqCESBDbw@mail.gmail.com>
 <s5hlhfp7b7p.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f170.google.com (mail-wi0-f170.google.com
 [209.85.212.170])
 by alsa0.perex.cz (Postfix) with ESMTP id B114126048C
 for <alsa-devel@alsa-project.org>; Fri, 12 Jun 2015 18:13:37 +0200 (CEST)
Received: by wiwd19 with SMTP id d19so22736357wiw.0
 for <alsa-devel@alsa-project.org>; Fri, 12 Jun 2015 09:13:37 -0700 (PDT)
In-Reply-To: <s5hlhfp7b7p.wl-tiwai@suse.de>
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

On Fri, Jun 12, 2015 at 1:22 AM, Takashi Iwai <tiwai@suse.de> wrote:

> At Thu, 11 Jun 2015 23:43:53 -0400,
> Adam Goode wrote:
> >
> > On Mon, Jun 8, 2015 at 7:23 AM, Takashi Iwai <tiwai@suse.de> wrote:
> >
> > > At Thu,  4 Jun 2015 21:04:50 -0400,
> > > Adam Goode wrote:
> > > >
> > > > Expose the card number of seq clients. This allows interested
> userspace
> > > > programs to discover the hardware device that backs a particular seq
> > > > client. Before this change, the only way to get information about the
> > > > hardware for a client was by using brittle heuristics.
> > > >
> > > > Signed-off-by: Adam Goode <agoode@google.com>
> > >
> > > The patch looks almost good.  (One coding style fix about one-line if
> > > would be better, though.)
> > >
> > > However, if we want to have more changes, I'd prefer the protocol
> > > version bump after all changes are merged.
> > > Are you going to submit any further changes?
> > >
> > >
> > > thanks,
> > >
> > > Takashi
> > >
> >
> > Hi Takashi,
> >
> > I fixed up the patch in v2. It fixes the style issue and delays updating
> > protocol for now.
> >
> > I think there might be another useful field to expose (the hardware midi
> > device number), but I'm not sure yet. It is complicated since OPL3 does
> > expose a client but does not use rawmidi. Otherwise, the rawmidi device
> > number would be the obvious choice. I'm pretty sure I just need the card
> > number to solve my problems in Chrome, but I will have to think about it.
>
> IMO, we need to give the interface type (rawmidi, hwdep), too.  Then
> the client can open the device and query more detailed information.
>
>
Ah, that is a good idea. Let me prepare another patch with this extra
information.



> > The only other interesting change to make right now would be a tstamp
> field
> > (something like PCM), but it might be too complex for a quick fix. I do
> > like the PCM timestamp mode selection, and would like to see such a thing
> > in seq.
>
> Yeah, this one would be more intrusive changes.
>
>
Ok, I will defer this for now.


>
> thanks,
>
> Takashi
>

Thanks,

Adam
