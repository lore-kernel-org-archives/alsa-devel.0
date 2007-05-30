From: "Nobin Mathew" <nobin.mathew@gmail.com>
Subject: Re: Power management state flow in ALSA
Date: Wed, 30 May 2007 15:36:33 +0530
Message-ID: <8d6898730705300306g3f32f5e8yad6770a4eee1851a@mail.gmail.com>
References: <8d6898730705292322w2dbf2a2fu4761370c4cc7ea16@mail.gmail.com>
	<s5h8xb6hbzd.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.179])
	by alsa0.perex.cz (Postfix) with ESMTP id E180824446
	for <alsa-devel@alsa-project.org>;
	Wed, 30 May 2007 12:06:34 +0200 (CEST)
Received: by wa-out-1112.google.com with SMTP id n7so1100334wag
	for <alsa-devel@alsa-project.org>; Wed, 30 May 2007 03:06:33 -0700 (PDT)
In-Reply-To: <s5h8xb6hbzd.wl%tiwai@suse.de>
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

In suspend () the application is dead (freezed state) before ALSA
driver suspend() is called, so in this there is no way application
will get to know the SUSPENDED state of driver.


In resume () ALSA driver resume () (changes the state of driver) is
called first and then applications are activated.

So how the application will get to know the SUSPENDED state of driver
through syscall.No syscall () from ALSA apps(freezed) is happening
during the SUSPENDED duration of ALSA driver.

Am i going wrong ?



On 5/30/07, Takashi Iwai <tiwai@suse.de> wrote:
> At Wed, 30 May 2007 11:52:31 +0530,
> Nobin Mathew wrote:
> >
> > I am having a doubt regarding ALSA power management.
> >
> > My understanding of APM suspend() is like this.
> >
> > Freeze the ALSA apps
> >
> > Call ALSA driver suspend ()
> >
> > in the ALSA suspend() function it saves the current state of substream
> > and changes the state of substream to SUSPENDED.
> >
> > My understanding of APM resume() is like this
> >
> > Call ALSA driver resume ()
> >
> > Activate the ALSA apps
> >
> > In ALSA resume function it restores the saved state of substream.
> >
> >
> > So my question is when ALSA app will get to know the SUSPENDED state
> > of substream.???
>
> When issuing any syscalls.  Then you'll get ESTRPIPE error, which
> indicitaes the stream is in the SUSPEND state.
>
>
> Takashi
>
