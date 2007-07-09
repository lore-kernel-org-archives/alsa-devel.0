From: "Aaron \"Caustik\" Robinson" <caustik@gmail.com>
Subject: Re: dmix and sounds less than 64kb
Date: Mon, 9 Jul 2007 12:40:22 -0700
Message-ID: <61e8390b0707091240i657f82ev306ac851759c791f@mail.gmail.com>
References: <61e8390b0707062028t63c913eeg1ab5a40f830af597@mail.gmail.com>
	<s5hir8tvrvt.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mu-out-0910.google.com (mu-out-0910.google.com [209.85.134.188])
	by alsa0.perex.cz (Postfix) with ESMTP id C464E1038B5
	for <alsa-devel@alsa-project.org>;
	Mon,  9 Jul 2007 21:40:25 +0200 (CEST)
Received: by mu-out-0910.google.com with SMTP id w8so820322mue
	for <alsa-devel@alsa-project.org>; Mon, 09 Jul 2007 12:40:22 -0700 (PDT)
In-Reply-To: <s5hir8tvrvt.wl%tiwai@suse.de>
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

We actually dumped the pcm data as it was arriving to the driver (via the
trigger start and irq functions), and it was corrupted at that point. Also I
have dumped the pcm data after it has been mixed by the dmix plugin, and it
is fine there as well.

On 7/9/07, Takashi Iwai <tiwai@suse.de> wrote:
>
> At Fri, 6 Jul 2007 20:28:13 -0700,
> Aaron "Caustik" Robinson wrote:
> >
> > We have been having one heck of a time tracking down the cause of some
> ALSA
> > audio playback issues.
> >
> > It appears that any time we play a very short sound (<64kb), either the
> > sound doesn't play at all, or only a fragment of it plays. We haven't
> had
> > much luck finding a solution to this issue, then I found this thread on
> the
> > history of this email group:
> >
> >
> http://mailman.alsa-project.org/pipermail/alsa-devel/2007-April/000526.html
> >
> > Our problem is pretty much exactly like his issues relating to <64k
> sounds.
> >
> > My question is - has anybody else run into this problem? To the OP of
> the
> > above thread, if you're still listening - did you ever find a solution
> to
> > your problem? I'd be very interested to hear any help you can provide.
>
> It works fine with my systems, so the problem should be pretty
> driver-specific...
>
>
> Takashi
>
