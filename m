From: Evan Green <evgreen@chromium.org>
Subject: Re: [PATCH v2 1/2] ALSA: hda: Fix widget_mutex incomplete protection
Date: Mon, 1 Jul 2019 08:57:21 -0700
Message-ID: <CAE=gft43b6RsLMO9LDSD+uhomr4pV9-WFs5aB1u5Z=q-zsV-hQ@mail.gmail.com>
References: <20190626212220.239897-1-evgreen@chromium.org> <20190626212220.239897-2-evgreen@chromium.org>
 <s5hlfxh6e4p.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5hlfxh6e4p.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Thomas Gleixner <tglx@linutronix.de>, Amadeusz S*awi*ski <amadeuszx.slawinski@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jaroslav Kysela <perex@perex.cz>, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Jul 1, 2019 at 7:09 AM Takashi Iwai <tiwai@suse.de> wrote:
>
> On Wed, 26 Jun 2019 23:22:19 +0200,
> Evan Green wrote:
> >
> > The widget_mutex was introduced to serialize callers to
> > hda_widget_sysfs_{re}init. However, its protection of the sysfs widget array
> > is incomplete. For example, it is acquired around the call to
> > hda_widget_sysfs_reinit(), which actually creates the new array, but isn't
> > still acquired when codec->num_nodes and codec->start_nid is updated. So
> > the lock ensures one thread sets up the new array at a time, but doesn't
> > ensure which thread's value will end up in codec->num_nodes. If a larger
> > num_nodes wins but a smaller array was set up, the next call to
> > refresh_widgets() will touch free memory as it iterates over codec->num_nodes
> > that aren't there.
> >
> > The widget_lock really protects both the tree as well as codec->num_nodes,
> > start_nid, and end_nid, so make sure it's held across that update. It should
> > also be held during snd_hdac_get_sub_nodes(), so that a very old read from that
> > function doesn't end up clobbering a later update.
>
> OK, right, this fix is needed no matter whether to take my other
> change to skip hda_widget_sysfs_init() call in
> hda_widget_sysfs_reinit().
>
> However...
>
> > While in there, move the exit mutex call inside the function. This moves the
> > mutex closer to the data structure it protects and removes a requirement of
> > acquiring the somewhat internal widget_lock before calling sysfs_exit.
>
> ... this doesn't look better from consistency POV.  The whole code in
> hdac_sysfs.c doesn't take any lock in itself.  The protection is
> supposed to be done in the caller side.  So, let's keep as is now.

Ok.

>
> Also...
>
> >       codec->num_nodes = nums;
> >       codec->start_nid = start_nid;
> >       codec->end_nid = start_nid + nums;
> > +     mutex_unlock(&codec->widget_lock);
> >       return 0;
> > +
> > +unlock:
> > +     mutex_unlock(&codec->widget_lock);
> > +     return err;
>
> There is no need of two mutex_unlock() here.  They can be unified,
>
>         codec->num_nodes = nums;
>         codec->start_nid = start_nid;
>         codec->end_nid = start_nid + nums;
>   unlock:
>         mutex_unlock(&codec->widget_lock);
>         return err;
>
> Could you refresh this and resubmit?

Sure, will do. Thanks for taking a look.
