From: Alastair Bridgewater <alastair.bridgewater@gmail.com>
Subject: Re: [PATCH 4/6] ALSA: hda/ca0132: Don't test for
	QUIRK_NONE
Date: Fri, 15 Jun 2018 23:11:53 -0400
Message-ID: <CAEcYz2S18SDUeuZ8LDq6gO5xcyNKjMd=ctEn9dhgTGxB_dZQGg@mail.gmail.com>
References: <20180616015620.26663-1-alastair.bridgewater@gmail.com>
 <20180616015620.26663-5-alastair.bridgewater@gmail.com>
 <CAM8Agx12RSbcd1-N0cQ96GtznbmmFWH=FCJCCaHyvynhX8_d5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-it0-f67.google.com (mail-it0-f67.google.com
 [209.85.214.67])
 by alsa0.perex.cz (Postfix) with ESMTP id 7AC75267614
 for <alsa-devel@alsa-project.org>; Sat, 16 Jun 2018 05:11:55 +0200 (CEST)
Received: by mail-it0-f67.google.com with SMTP id l6-v6so5352866iti.2
 for <alsa-devel@alsa-project.org>; Fri, 15 Jun 2018 20:11:55 -0700 (PDT)
In-Reply-To: <CAM8Agx12RSbcd1-N0cQ96GtznbmmFWH=FCJCCaHyvynhX8_d5A@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Connor McAdams <conmanx360@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

My inconvenience from the R3Di/SBZ changes has been minor at worst.

Actually, the timing on this has been very good.  Finding the R3Di
patches and QemuHDADump two weeks ago, just as I was starting to look
again into trying to improve sound support on my M17x R4 was a
pleasant surprise.  Yes, there are rough edges, but they're the sort
of thing that should get caught by careful code review or from testing
various -rc kernels.  And you'll get better at this if you keep at it.

Speaking of rough edges, QUIRK_SBZ and QUIRK_R3DI have code paths that
use both ca0132_alt_select_in() (from ca0132_init() and the input
source control) and ca0132_select_mic() (from amic_callback(), tied to
a jack detect).  I'm fairly certain that this is wrong.

On Fri, Jun 15, 2018 at 10:20 PM, Connor McAdams <conmanx360@gmail.com>
wrote:

> Good call. Please understand that I'm fairly new to all of this, so
> mistakes like this are more due to being ignorant than anything else.
> I was afraid certain things may end up broken by my changes, and I
> hope it didn't inconvenience you.
>
> On Fri, Jun 15, 2018 at 9:56 PM, Alastair Bridgewater
> <alastair.bridgewater@gmail.com> wrote:
> > QUIRK_NONE is, quite explicitly, the default case.  The entire
> > point of a quirks system is to allow "programming by difference"
> > from a given base case, which requires that merely defining a new
> > quirk for some piece of hardware should not change the behavior of
> > the driver for that hardware.  In turn, this means that testing
> > for QUIRK_NONE explicitly is a violation of that implicit contract.
> >
> > Change a test for QUIRK_NONE and QUIRK_ALIENWARE to default, and
> > add a test for QUIRK_SBZ to disable the default behavior in that
> > instance.
> >
> > Signed-off-by: Alastair Bridgewater <alastair.bridgewater@gmail.com>
> >
> > diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
> > index ca7375e48138..71487b82eef5 100644
> > --- a/sound/pci/hda/patch_ca0132.c
> > +++ b/sound/pci/hda/patch_ca0132.c
> > @@ -7237,8 +7237,9 @@ static int ca0132_init(struct hda_codec *codec)
> >         case QUIRK_R3DI:
> >                 r3di_setup_defaults(codec);
> >                 break;
> > -       case QUIRK_NONE:
> > -       case QUIRK_ALIENWARE:
> > +       case QUIRK_SBZ:
> > +               break;
> > +       default:
> >                 ca0132_setup_defaults(codec);
> >                 ca0132_init_analog_mic2(codec);
> >                 ca0132_init_dmic(codec);
> > --
> > 2.16.1
> >
> > _______________________________________________
> > Alsa-devel mailing list
> > Alsa-devel@alsa-project.org
> > http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
