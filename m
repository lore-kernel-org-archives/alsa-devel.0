From: =?UTF-8?Q?Andrej_Krut=C3=A1k?= <dev@andree.sk>
Subject: Re: [PATCH 00/15] Line6 POD X3/X3Live suport
Date: Fri, 12 Aug 2016 12:31:31 +0200
Message-ID: <CAFnc+wVY+f1mgOXvzJRojfprE+fsf9d-1b6DG8Ythqbk3f-vuA@mail.gmail.com>
References: <1470942147-19848-1-git-send-email-dev@andree.sk>
 <s5hd1leflpl.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f42.google.com (mail-wm0-f42.google.com [74.125.82.42])
 by alsa0.perex.cz (Postfix) with ESMTP id A7AD7265E17
 for <alsa-devel@alsa-project.org>; Fri, 12 Aug 2016 12:31:52 +0200 (CEST)
Received: by mail-wm0-f42.google.com with SMTP id i5so24053491wmg.0
 for <alsa-devel@alsa-project.org>; Fri, 12 Aug 2016 03:31:52 -0700 (PDT)
In-Reply-To: <s5hd1leflpl.wl-tiwai@suse.de>
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

Hi!

On Fri, Aug 12, 2016 at 10:14 AM, Takashi Iwai <tiwai@suse.de> wrote:

> On Thu, 11 Aug 2016 21:02:12 +0200,
> Andrej Krutak wrote:
> >
> > Hello all,
> >
> >
> > attached is the first version of the driver, based on POD HD. They share
> a lot
> > of similarities, but at the same time there were some generalizations
> needed. I
> > think POD HD could follow up on these patches to add hwdep support,
> perhaps
> > helix too... I tried to not introduce regressions to the old HW.
> >
> > Anyhow, this is probably not the final version of the patches, as it is
> my
> > first submission to upstream - I'm sure there will be some issues.
> > Especially the patch
> > "Use device_create_file instead of snd_card_add_dev_attr" I have to
> revisit,
> > it may not be necessarry in the end.
> >
> > Other than that, the patches mostly pass `make checkpatches`. I've been
> > testing the driver for a while now, including lock debugging options
> etc.,
> > and there don't seem to be functional problems.
> >
> > There's one missing thing - the driver uses bulk USB interface of the
> > device, but so far I wasn't able to make the usb_driver_claim_interface()
> > work... I hope this can be added later, if someone (or I) finds time.
> >
> >
> > Thanks for your inputs, greetings,
>
> Thanks for the patches.  Many of them look good, but we'd need
> revisiting some of them.  But at the next time, please put maintainers
> to Cc, not only to sending to ML.
>
> I'll comment on each patch.
>
>
Thanks for the quick feedback! I'll rework the patches where obvious, and
respond to the comments where I "object"...

-- 
Andrej
