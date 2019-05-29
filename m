From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 1/5] lightnvm: Fix uninitialized pointer in nvm_remove_tgt()
Date: Wed, 29 May 2019 10:12:45 +0200
Message-ID: <CAMuHMdVtM9NWSXbWE=XKOt3fiQdjWaDvLiYdXbbri-buDn7jpg@mail.gmail.com>
References: <20190528142424.19626-1-geert@linux-m68k.org> <20190528142424.19626-2-geert@linux-m68k.org>
 <4b666e32-04b6-228a-691d-0745fa48a57f@lightnvm.io>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4b666e32-04b6-228a-691d-0745fa48a57f@lightnvm.io>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>
Cc: Igor Konopko <igor.j.konopko@intel.com>, David Howells <dhowells@redhat.com>, "Mohit P . Tahiliani" <tahiliani@nitk.edu.in>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, Eran Ben Elisha <eranbe@mellanox.com>, Jiri Pirko <jiri@mellanox.com>, "David S . Miller" <davem@davemloft.net>, Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, Clemens Ladisch <clemens@ladisch.de>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Joe Perches <joe@perches.com>, Arnd Bergmann <arnd@arndb.de>, Dan Carpenter <dan.carpenter@oracle.com>, linux-block@vger.kernel.org, netdev <netdev@vger.kernel.org>, linux-afs@lists.infradead.org, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Linux Kernel Mailing List <linux-kernel@vg>
List-Id: alsa-devel@alsa-project.org

Hi Matias,

On Wed, May 29, 2019 at 10:08 AM Matias Bjørling <mb@lightnvm.io> wrote:
> On 5/28/19 4:24 PM, Geert Uytterhoeven wrote:
> > With gcc 4.1:
> >
> >      drivers/lightnvm/core.c: In function ‘nvm_remove_tgt’:
> >      drivers/lightnvm/core.c:510: warning: ‘t’ is used uninitialized in this function
> >
> > Indeed, if no NVM devices have been registered, t will be an
> > uninitialized pointer, and may be dereferenced later.  A call to
> > nvm_remove_tgt() can be triggered from userspace by issuing the
> > NVM_DEV_REMOVE ioctl on the lightnvm control device.
> >
> > Fix this by preinitializing t to NULL.
> >
> > Fixes: 843f2edbdde085b4 ("lightnvm: do not remove instance under global lock")
> > Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > ---
> >   drivers/lightnvm/core.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
> > index 0df7454832efe082..aa017f48eb8c588c 100644
> > --- a/drivers/lightnvm/core.c
> > +++ b/drivers/lightnvm/core.c
> > @@ -492,7 +492,7 @@ static void __nvm_remove_target(struct nvm_target *t, bool graceful)
> >    */
> >   static int nvm_remove_tgt(struct nvm_ioctl_remove *remove)
> >   {
> > -     struct nvm_target *t;
> > +     struct nvm_target *t = NULL;
> >       struct nvm_dev *dev;
> >
> >       down_read(&nvm_lock);
> >
>
> Thanks Geert. Would you like me to carry the patch?

Yes please. Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
