From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/2] caiaq/NativeInstruments: input
	handling fixes
Date: Wed, 21 Nov 2007 11:38:28 -0500
Message-ID: <d120d5000711210838j6a6f2418tb4ecdceb63073f6a@mail.gmail.com>
References: <20071120133528.GB4425@buzzloop.caiaq.de>
	<s5hd4u3j51s.wl%tiwai@suse.de>
	<d120d5000711210534t75887c73labdb17eea0cefb88@mail.gmail.com>
	<s5hr6ijwxxn.wl%tiwai@suse.de> <s5habp7wrg4.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.190])
	by alsa0.perex.cz (Postfix) with ESMTP id 86E5124C57
	for <Alsa-devel@alsa-project.org>; Wed, 21 Nov 2007 17:38:29 +0100 (CET)
Received: by nf-out-0910.google.com with SMTP id b21so2027768nfd
	for <Alsa-devel@alsa-project.org>; Wed, 21 Nov 2007 08:38:28 -0800 (PST)
In-Reply-To: <s5habp7wrg4.wl%tiwai@suse.de>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Nov 21, 2007 10:26 AM, Takashi Iwai <tiwai@suse.de> wrote:
> At Wed, 21 Nov 2007 14:05:56 +0100,
> I wrote:
> >
> > At Wed, 21 Nov 2007 08:34:33 -0500,
> > Dmitry Torokhov wrote:
> > >
> > > On Nov 21, 2007 4:55 AM, Takashi Iwai <tiwai@suse.de> wrote:
> > > > At Tue, 20 Nov 2007 14:35:28 +0100,
> > > > Daniel Mack wrote:
> > > > >
> > > > > Hi,
> > > > >
> > > > > I'm re-posting a patch from Dmitry Torokhov which cleans up some input
> > > > > layer related things. It hasn't made its way to any repository yet but
> > >
> > > Yes, I am being slow lately, sorry.
> > >
> > > > > my subsequent patch needs it as dependency. I Cc'ed Dmitry to avoid
> > > > > confusion.
> > > >
> > > > Dmitry, will this patch go to 2.6.24 from your tree?
> > > >
> > > > If it's a 2.6.25 material,
> > >
> > > Yes, it is .25 material.
> > >
> > > > then I'd like to put it rather to ALSA
> > > > tree together with Daniel's another patch.
> > >
> > > Thet would be great. The only reason I offered to send through my tree
> > > is that I did not see any response from you guys... I actually prefer
> > > not to touch code outside of drivers/input.
> >
> > Well, I didn't apply it just because I thought you prefer pushing it
> > to 2.6.24 :)  If it's for 25, no problem to put to ALSA tree.
>
> Now it's on ALSA HG tree.  I fixed two tiny coding issues
> checkpatch.pl reported.
>

Thank you.

> > > BTW, attached is a small Kconfig patchs for caiaq. Probably good for .24.
> >
> > OK, will add this, too.
>
> Applied this, too.
>

Great, thank you Takashi.

-- 
Dmitry
