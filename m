From: "Andrew Paprocki" <andrew@ishiboo.com>
Subject: Re: [PATCH] hda_proc - Add output of Vref,
	additional pcaps, and proccaps to proc output
Date: Thu, 17 Jan 2008 22:58:08 -0500
Message-ID: <76366b180801171958q410c705ds3a7b8e197a670a52@mail.gmail.com>
References: <8a9218bae32f110a1ca2.1200581166@am2>
	<s5hbq7ke6e5.wl%tiwai@suse.de>
	<1200589860.5011.88.camel@razman.gruemaster.com>
	<s5h3aswe5de.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0910.google.com (rv-out-0910.google.com [209.85.198.184])
	by alsa0.perex.cz (Postfix) with ESMTP id B9313247BA
	for <alsa-devel@alsa-project.org>; Fri, 18 Jan 2008 04:58:11 +0100 (CET)
Received: by rv-out-0910.google.com with SMTP id k20so621229rvb.32
	for <alsa-devel@alsa-project.org>; Thu, 17 Jan 2008 19:58:08 -0800 (PST)
In-Reply-To: <s5h3aswe5de.wl%tiwai@suse.de>
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
Cc: Claudio Matsuoka <cmatsuoka@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I should have known this would happen since the graph tool was just
announced! :) I would gladly help keep the tool up to date, but I
think Claudio is fine with handling it right now:

> Change the format as needed, as long as it is unambiguous and contains
> all the necessary information we'll keep the tool up to date.

If/when the tool is merged into the alsa tree, it would make more
sense for anyone submitting a patch to /proc output to verify and
patch the tool if needed.

If anything needs modification for easier parsing by the tool, it is
very easy to do and I'm willing to help. I would apply this (and any
future /proc enhancements) and if Claudio's tool can be made simpler
by changing the output format, it should be requested and anyone can
help make the patch.

Thanks,
-Andrew

On Jan 17, 2008 12:20 PM, Takashi Iwai <tiwai@suse.de> wrote:
> At Thu, 17 Jan 2008 09:11:00 -0800,
> Tobin Davis wrote:
> >
> > On Thu, 2008-01-17 at 17:58 +0100, Takashi Iwai wrote:
> >
> >     At Thu, 17 Jan 2008 09:46:06 -0400,
> >     Andrew Paprocki wrote:
> >     >
> >     > This adds additional pincaps which were not previously output. Also, Vref
> >     > capabilities are output per-pin along with the current Vref pinctl setting
> >     > if the NID supports Vref. Also added: processing widgets and proccaps, as
> >     > well as processing coefficient and coefficient index from the Realtek Define
> >     > Registers per the ALC883 datasheet.
> >     >
> >     > Signed-off-by: Andrew Paprocki <andrew@ishiboo.com>
> >
> >     Did you check whether this doesn't break Claudio's codecgraph parser?
> >     If it's OK, I'd like to apply it, of course...
> >
> >     Takashi
> >
> > You're kidding, right?  Adding more details about a codec is more useful at this
> > point than making sure a non-essential script (that can be easily modified)
> > isn't broken.
>
> Well, now we have some parser program, then it's the high time to
> think about the proc output consistent in a certain level.  So far,
> it's just written to be readable for human being.  But, now we'd need
> to make it also easily readable by dumb programs, too.
