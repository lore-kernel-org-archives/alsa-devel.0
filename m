From: Tim Barnette <tim.barnette@gmail.com>
Subject: Re: [Fwd: HP DV4 1155 SE - No Sound through
	speakers...]
Date: Wed, 4 Feb 2009 21:46:47 -0500
Message-ID: <b71cdde20902041846v529fcdeau8da911c39b52f94e@mail.gmail.com>
References: <4983FE7A.1040201@wanadoo.fr> <4989C9E6.7070902@wanadoo.fr>
	<s5h1vue86ys.wl%tiwai@suse.de>
	<200902041540.46137.herton@mandriva.com.br>
	<s5hd4dxsu1n.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.181])
	by alsa0.perex.cz (Postfix) with ESMTP id 54DB724475
	for <alsa-devel@alsa-project.org>; Thu,  5 Feb 2009 03:46:49 +0100 (CET)
Received: by wa-out-1112.google.com with SMTP id v27so7594wah.16
	for <alsa-devel@alsa-project.org>; Wed, 04 Feb 2009 18:46:47 -0800 (PST)
In-Reply-To: <s5hd4dxsu1n.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, =?ISO-8859-1?Q?Jean=2DPierre_Andr=E9?= <jean-pierre.andre@wanadoo.fr>, Herton Ronaldo Krzesinski <herton@mandriva.com.br>
List-Id: alsa-devel@alsa-project.org

Thanks, Takashi. Please let us know what you discover.

On Wed, Feb 4, 2009 at 5:42 PM, Takashi Iwai <tiwai@suse.de> wrote:

> At Wed, 4 Feb 2009 15:40:45 -0200,
> Herton Ronaldo Krzesinski wrote:
> >
> > Em Quarta-feira 04 Fevereiro 2009, =E0s 15:09:15, Takashi Iwai escreveu:
> > > At Wed, 04 Feb 2009 18:01:26 +0100,
> > >
> > > Jean-Pierre Andr=E9 wrote:
> > > > Hi Herton,
> > > >
> > > > I have identified why applying your patch broke the sound worse on =
my
> > > > computer, by reverting each individual modification until the sound
> > > > comes back. It has not brought overall improvements for me, but this
> > > > might help you getting it right.
> > >
> > > Oh well.
> > >
> > > Herton, could you rebase the patch against the latest sound tree?
> > > The patch rejects awfully, so hard to test...
> >
> > I've done now the rebased/splitted patches, was slow at
> verifying/reviewing
> > things but I think it's now good. In my previous patch to me I saw that
> was
> > doing some uneeded things, also was better to reuse patch_stac92hd71bxx
> > instead of splitting 4port/5port support/differences away. I removed the
> pin
> > configs for HP models too, it may be wrong/uneeded or cause problems li=
ke
> in
> > this case. Find attached now three patches with splitted
> fixes/enhancements,
> > but nothing that will help with the problem here unfortunately, I thoug=
ht
> the
> > previous patch with pin configs could help.
>
> Thanks!  I'll check and review these tomorrow.
>
>
> Takashi
>
