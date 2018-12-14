From: Josh Boyer <jwboyer@kernel.org>
Subject: Re: [GIT PULL] Additional firmware files for CA0132 HD-audio codec
Date: Fri, 14 Dec 2018 07:54:50 -0500
Message-ID: <CA+5PVA7BNyoFK8CDxr+oDA7Von201qFxejbsEQi+CgeOo0xzxA@mail.gmail.com>
References: <20181010174923.GA29921@connor-Z97X-Gaming-7> <s5hmur3pzg2.wl-tiwai@suse.de>
 <CA+5PVA5xQvz+NftESMLUNY=5vR+A1x76sL64eXCR-KPqi6G+gg@mail.gmail.com>
 <CAM8Agx38RCN5xUPwV-YP0JyMtxNj9tveou4fHCDK1zyvE0a+Tg@mail.gmail.com>
 <CAM8Agx1VK3QNV52RmiSsrD8042oFRKZg-w6WFa7SPfebVa4hQQ@mail.gmail.com> <CAM8Agx2KYOZK97J7yiM9JvNF1bxiAKNtA_YDegtLMVAYiWKEXQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAM8Agx2KYOZK97J7yiM9JvNF1bxiAKNtA_YDegtLMVAYiWKEXQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Connor McAdams <conmanx360@gmail.com>
Cc: jwboyer@kernel.org, Takashi Iwai <tiwai@suse.de>, Linux Firmware <linux-firmware@kernel.org>, alsa-devel@alsa-project.org, "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Fri, Nov 9, 2018 at 2:49 PM Connor McAdams <conmanx360@gmail.com> wrote:
>
> Okay... So, my contact at Creative gave me an email as the 'sign-off
> party' for firmware submission. As far as I'm aware, sign-offs also
> need names attached, correct? So I'll ask for that. However, they
> still want me to send it.
>
> Will that be okay? Would you be more comfortable if I get you in
> contact with someone at Creative,Josh?

It is common for someone to sign-off on a patch, but have someone else
send it.  Having their Signed-off-by: <person> in the commit log is
OK.

josh

>
> I apologize for being kind of difficult, I'm doing what I can. Let me
> know what I need to do, and I'll do my best.
>
> Thanks,
> Connor.
> On Sun, Nov 4, 2018 at 1:00 AM Connor McAdams <conmanx360@gmail.com> wrote:
> >
> > Okay, just got a response from the guy at Creative. He said they'll
> > try to sort it out this week. Just a heads up. :)
> > On Wed, Oct 24, 2018 at 12:22 PM Connor McAdams <conmanx360@gmail.com> wrote:
> > >
> > > Understood. I will see what I can do. I already had them contact
> > > Takashi, but I will ask if they're willing to give a sign-off. If
> > > they're having trouble, is it okay to have them contact you Josh?
> > >
> > > Let me know.
> > > On Wed, Oct 24, 2018 at 9:44 AM Josh Boyer <jwboyer@kernel.org> wrote:
> > > >
> > > > On Wed, Oct 24, 2018 at 3:37 AM Takashi Iwai <tiwai@suse.de> wrote:
> > > > >
> > > > > On Wed, 10 Oct 2018 19:49:23 +0200,
> > > > > Connor McAdams wrote:
> > > > > >
> > > > > > The following changes since commit c6b6265d718d118e28e1ce8f91769aa886b54c94:
> > > > > >
> > > > > >   Merge tag 'iwlwifi-fw-2018-10-03' of git://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/linux-firmware (2018-10-08 09:23:53 -0400)
> > > > > >
> > > > > > are available in the git repository at:
> > > > > >
> > > > > >   git@github.com:Conmanx360/linux-firmware.git
> > > > > >
> > > > > > for you to fetch changes up to cd8899323352e772c5989230f35b1c494e0ab196:
> > > > > >
> > > > > >   linux-firmware: Add new firmware for Creative CA0132 HD-Audio Codec (2018-10-09 14:41:12 -0400)
> > > > > >
> > > > > > ----------------------------------------------------------------
> > > > > > These are additional firmware files for CA0132 based sound cards.
> > > > > >
> > > > > > Creative has given me permission through email to send these to the
> > > > > > linux-firmware repository under the same license as the previous ca0132
> > > > > > firmware. I asked my contact if they would sign-off on it, but they said
> > > > > > to go ahead and submit it and that if there was any issue to contact
> > > > > > them.
> > > > > >
> > > > > > If you need to contact them, or if there's more info needed, let me know
> > > > > > and I can get see what I can do.
> > > >
> > > > I'd really like to see a Sign-off from someone at Creative.  It's not
> > > > that I don't trust your word that they agreed to it, but we have
> > > > nothing to go back and verify they actually agreed to allow this to be
> > > > redistributable, etc.
> > > >
> > > > josh
> > > >
> > > > > > ----------------------------------------------------------------
> > > > > > Connor McAdams (1):
> > > > > >       linux-firmware: Add new firmware for Creative CA0132 HD-Audio Codec
> > > > > >
> > > > > >  WHENCE            |   2 ++
> > > > > >  ctefx-desktop.bin | Bin 0 -> 655856 bytes
> > > > > >  ctefx-r3di.bin    | Bin 0 -> 655816 bytes
> > > > > >  3 files changed, 2 insertions(+)
> > > > > >  create mode 100644 ctefx-desktop.bin
> > > > > >  create mode 100644 ctefx-r3di.bin
> > > > >
> > > > > Please can anyone take a look at this pull request?
> > > > >
> > > > > It's mandatory for the CA0132-based cards that are now supported
> > > > > better in the upstream kernel tree.
> > > > >
> > > > >
> > > > > Thanks!
> > > > >
> > > > > Takashi
