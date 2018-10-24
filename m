From: Connor McAdams <conmanx360@gmail.com>
Subject: Re: [GIT PULL] Additional firmware files for CA0132
	HD-audio codec
Date: Wed, 24 Oct 2018 12:22:13 -0400
Message-ID: <CAM8Agx38RCN5xUPwV-YP0JyMtxNj9tveou4fHCDK1zyvE0a+Tg@mail.gmail.com>
References: <20181010174923.GA29921@connor-Z97X-Gaming-7>
 <s5hmur3pzg2.wl-tiwai@suse.de>
 <CA+5PVA5xQvz+NftESMLUNY=5vR+A1x76sL64eXCR-KPqi6G+gg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-it1-f195.google.com (mail-it1-f195.google.com
 [209.85.166.195])
 by alsa0.perex.cz (Postfix) with ESMTP id 51FB3267546
 for <alsa-devel@alsa-project.org>; Wed, 24 Oct 2018 18:22:27 +0200 (CEST)
Received: by mail-it1-f195.google.com with SMTP id h14-v6so949585itf.1
 for <alsa-devel@alsa-project.org>; Wed, 24 Oct 2018 09:22:27 -0700 (PDT)
In-Reply-To: <CA+5PVA5xQvz+NftESMLUNY=5vR+A1x76sL64eXCR-KPqi6G+gg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: jwboyer@kernel.org
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, linux-firmware@kernel.org
List-Id: alsa-devel@alsa-project.org

Understood. I will see what I can do. I already had them contact
Takashi, but I will ask if they're willing to give a sign-off. If
they're having trouble, is it okay to have them contact you Josh?

Let me know.
On Wed, Oct 24, 2018 at 9:44 AM Josh Boyer <jwboyer@kernel.org> wrote:
>
> On Wed, Oct 24, 2018 at 3:37 AM Takashi Iwai <tiwai@suse.de> wrote:
> >
> > On Wed, 10 Oct 2018 19:49:23 +0200,
> > Connor McAdams wrote:
> > >
> > > The following changes since commit c6b6265d718d118e28e1ce8f91769aa886b54c94:
> > >
> > >   Merge tag 'iwlwifi-fw-2018-10-03' of git://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/linux-firmware (2018-10-08 09:23:53 -0400)
> > >
> > > are available in the git repository at:
> > >
> > >   git@github.com:Conmanx360/linux-firmware.git
> > >
> > > for you to fetch changes up to cd8899323352e772c5989230f35b1c494e0ab196:
> > >
> > >   linux-firmware: Add new firmware for Creative CA0132 HD-Audio Codec (2018-10-09 14:41:12 -0400)
> > >
> > > ----------------------------------------------------------------
> > > These are additional firmware files for CA0132 based sound cards.
> > >
> > > Creative has given me permission through email to send these to the
> > > linux-firmware repository under the same license as the previous ca0132
> > > firmware. I asked my contact if they would sign-off on it, but they said
> > > to go ahead and submit it and that if there was any issue to contact
> > > them.
> > >
> > > If you need to contact them, or if there's more info needed, let me know
> > > and I can get see what I can do.
>
> I'd really like to see a Sign-off from someone at Creative.  It's not
> that I don't trust your word that they agreed to it, but we have
> nothing to go back and verify they actually agreed to allow this to be
> redistributable, etc.
>
> josh
>
> > > ----------------------------------------------------------------
> > > Connor McAdams (1):
> > >       linux-firmware: Add new firmware for Creative CA0132 HD-Audio Codec
> > >
> > >  WHENCE            |   2 ++
> > >  ctefx-desktop.bin | Bin 0 -> 655856 bytes
> > >  ctefx-r3di.bin    | Bin 0 -> 655816 bytes
> > >  3 files changed, 2 insertions(+)
> > >  create mode 100644 ctefx-desktop.bin
> > >  create mode 100644 ctefx-r3di.bin
> >
> > Please can anyone take a look at this pull request?
> >
> > It's mandatory for the CA0132-based cards that are now supported
> > better in the upstream kernel tree.
> >
> >
> > Thanks!
> >
> > Takashi
