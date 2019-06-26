From: Evan Green <evgreen@chromium.org>
Subject: Re: [PATCH] ALSA: hda: Use correct start/count for sysfs init
Date: Wed, 26 Jun 2019 13:34:28 -0700
Message-ID: <CAE=gft62iv=V=auOhocRRfPV2Tuc2WiRYJOH5_M+HkM0qH-Jhw@mail.gmail.com>
References: <20190625215418.17548-1-evgreen@chromium.org> <s5himsssqe8.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5himsssqe8.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Thomas Gleixner <tglx@linutronix.de>, Amadeusz S*awi*ski <amadeuszx.slawinski@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jaroslav Kysela <perex@perex.cz>, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Jun 26, 2019 at 1:27 AM Takashi Iwai <tiwai@suse.de> wrote:
>
> On Tue, 25 Jun 2019 23:54:18 +0200,
> Evan Green wrote:
> >
> > The normal flow through the widget sysfs codepath is that
> > snd_hdac_refresh_widgets() is called once without the sysfs bool set
> > to set up codec->num_nodes and friends, then another time with the
> > bool set to actually allocate all the sysfs widgets. However, during
> > the first time allocation, hda_widget_sysfs_reinit() ignores the new
> > num_nodes passed in via parameter and just calls hda_widget_sysfs_init(),
> > using whatever was in codec->num_nodes before the update. This is not
> > correct in cases where num_nodes changes. Here's an example:
> >
> > Sometime earlier:
> > snd_hdac_refresh_widgets(hdac, false)
> >   sets codec->num_nodes to 2, widgets is still not allocated
> >
> > Now:
> > snd_hdac_refresh_widgets(hdac, true)
> >   hda_widget_sysfs_reinit(num_nodes=7)
> >     hda_widget_sysfs_init()
> >       widget_tree_create()
> >         alloc(codec->num_nodes) // this is still 2
> >   codec->num_nodes = 7
> >
> > Pass num_nodes and start_nid down into widget_tree_create() so that
> > the right number of nodes are allocated in all cases.
> >
> > Signed-off-by: Evan Green <evgreen@chromium.org>
>
> Thanks for the patch.  That's indeed a problem, but I guess a simpler
> approach is just to return if sysfs didn't exist.  If the sysfs
> entries aren't present at the second call with sysfs=true, it implies
> that the codec object will be exposed anyway later, and the sysfs will
> be created there.  So, something like below would work instead?

Hi Takashi,
Thanks for taking a look. I'm not sure you'd want to do that because
then you end up returning from sysfs_reinit without having allocated
any of the sysfs widgets. You'd be relying on the implicit behavior
that another call to init is coming later (despite having updated
num_nodes and start node), which is difficult to follow and easy to
break. In my opinion the slight bit of extra diffs is well worth the
clarity of having widget_tree_create always allocate the correct
start/count.

Actually, in looking at the widget lock patch, I don't think it's
sufficient either. It adds a lock around sysfs_reinit, but the setting
of codec->num_nodes and codec->start_nid is unprotected by the lock.
So you could have the two threads politely serialize through
sysfs_reinit, but then get reordered before setting codec->num_nodes,
landing you with an array whose length doesn't match num_nodes.

Let me craft up an additional patch to fix the locking.
-Evan

>
>
> thanks,
>
> Takashi
>
> --- a/sound/hda/hdac_sysfs.c
> +++ b/sound/hda/hdac_sysfs.c
> @@ -428,7 +428,7 @@ int hda_widget_sysfs_reinit(struct hdac_device *codec,
>         int i;
>
>         if (!codec->widgets)
> -               return hda_widget_sysfs_init(codec);
> +               return 0;
>
>         tree = kmemdup(codec->widgets, sizeof(*tree), GFP_KERNEL);
>         if (!tree)
