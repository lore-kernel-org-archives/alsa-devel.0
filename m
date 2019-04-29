From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 20/26] compat_ioctl: remove translation for sound ioctls
Date: Mon, 29 Apr 2019 14:43:18 +0200
Message-ID: <CAK8P3a1CbQsyTBykXkZv-35M_zQx97aOubtZD2YuzyPV94+4=w@mail.gmail.com>
References: <20190416202013.4034148-1-arnd@arndb.de> <20190416202839.248216-1-arnd@arndb.de>
 <s5hk1fthx9u.wl-tiwai@suse.de> <s5hv9yxjnp4.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5hv9yxjnp4.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Vinod Koul <vkoul@kernel.org>, linux-um@lists.infradead.org, y2038 Mailman List <y2038@lists.linaro.org>, Jaroslav Kysela <perex@perex.cz>, Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Apr 29, 2019 at 9:05 AM Takashi Iwai <tiwai@suse.de> wrote:
>
> On Wed, 17 Apr 2019 10:05:33 +0200, Takashi Iwai wrote:
> >
> > On Tue, 16 Apr 2019 22:28:05 +0200, Arnd Bergmann wrote:
> > > The compat_ioctl list contains one comment about SNDCTL_DSP_MAPINBUF and
> > > SNDCTL_DSP_MAPOUTBUF, which actually would need a translation handler
> > > if implemented. However, the native implementation just returns -EINVAL,
> > > so we don't care.
> > >
> > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> >
> > This looks like a really nice cleanup.  Thanks!
> >
> > Reviewed-by: Takashi Iwai <tiwai@suse.de>
>
> Is this supposed to be taken via sound git tree, or would you apply
> over yours?  I'm fine in either way.

I was hoping that Al could pick up the entire series to avoid the merge
conflicts, but then we had some more discussion about the earlier
patches in the series and he did another version of those.

Al, what is your current plan for the compat-ioctl removal series?
Are you working on a combined series, or should I resend a
subset of my patches to you?

       Arnd
