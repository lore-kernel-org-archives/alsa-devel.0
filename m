From: "Adrian McMenamin" <adrianmcmenamin@gmail.com>
Subject: Re: submitting a patch against the ALSA repos
Date: Fri, 18 May 2007 11:21:14 +0100
Message-ID: <92a12cdb0705180321u37cefc86va5cbc4b933177d35@mail.gmail.com>
References: <92a12cdb0705180216k4bb70a64x7da9c03313220623@mail.gmail.com>
	<s5hfy5ue8uc.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.224])
	by alsa0.perex.cz (Postfix) with ESMTP id 13491244E1
	for <alsa-devel@alsa-project.org>;
	Fri, 18 May 2007 12:21:15 +0200 (CEST)
Received: by nz-out-0506.google.com with SMTP id l8so1174017nzf
	for <alsa-devel@alsa-project.org>; Fri, 18 May 2007 03:21:15 -0700 (PDT)
In-Reply-To: <s5hfy5ue8uc.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 18/05/07, Takashi Iwai <tiwai@suse.de> wrote:
> At Fri, 18 May 2007 10:16:26 +0100,
> Adrian McMenamin wrote:
> >
> > I have submitted my patch against the 2.6.21 kernel tree but I dare
> > say I need to actually submit it against the alsa repos.
>
> If you submit a patch to a new driver, it should be against the very
> latest ALSA tree, which is basically based on the latest mm tree
> (2.6.22-rc*-mm*) and planned to be merged into the next kernel
> (2.6.23).
>
> Is there any difference between 2.6.21 and 22 regarding SH arch
> specific things?  At least, there is no difference regarding the sound
> infrastructure.


None that I am aware of, I'll post a patch against that tree later
today just to be sure though.

>
> > I have a few questions:
> >
> > 1. Which set of sources do I patch - I assume alsa-driver - is that right?
>
...
>
> If the driver is still in the early development stage and not intended
> to be merged to the upstream kernel, we can keep it in alsa-driver
> tree.



Yes, I think it can go upstream.
>
...
>
> > 3. This is a new architecture - there are no other SuperH drivers in
> > alsa (afaik) - how do I add a new architecture? My memory is that when
> > I tried this a year ago it was a bit of a nightmare.
>
> Yeah, it's not too easy.  First, we'd need to add the architecture
> check and the corresponding options in configure script.
> I'll take care of it.
>


More than happy for you to do that.
