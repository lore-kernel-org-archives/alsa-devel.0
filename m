From: "Krzysztof Helt" <krzysztof.h1@gmail.com>
Subject: Re: [PATCH] ad1838/cs4231 -- fix MCE timeout upon
	initial load
Date: Tue, 11 Sep 2007 10:56:50 +0200
Message-ID: <8c74410a0709110156q2fccdf99o358a9fd27103dbc3@mail.gmail.com>
References: <46E58D01.9080809@gmail.com>
	<20070910234034.a052c957.krzysztof.h1@gmail.com>
	<46E5BA6F.9070408@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0910.google.com (rv-out-0910.google.com [209.85.198.191])
	by alsa0.perex.cz (Postfix) with ESMTP id A734E1038CE
	for <alsa-devel@alsa-project.org>;
	Tue, 11 Sep 2007 10:56:51 +0200 (CEST)
Received: by rv-out-0910.google.com with SMTP id k20so1214760rvb
	for <alsa-devel@alsa-project.org>; Tue, 11 Sep 2007 01:56:50 -0700 (PDT)
In-Reply-To: <46E5BA6F.9070408@gmail.com>
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
To: Rene Herman <rene.herman@gmail.com>
Cc: ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 9/10/07, Rene Herman <rene.herman@gmail.com> wrote:
> On 09/10/2007 11:40 PM, Krzysztof Helt wrote:
>
> > On Mon, 10 Sep 2007 20:29:21 +0200
> > Rene Herman <rene.herman@gmail.com> wrote:
> >> Thanks to Krysztof Helt for pinpointing this problem.
> >>
> >
> > Please change it to Krzysztof Helt
>
> Oh, very sorry.
>
> >> diff --git a/sound/isa/cs423x/cs4231_lib.c b/sound/isa/cs423x/cs4231_lib.c
> >> index 914d77b..9e8e0f1 100644
> >> --- a/sound/isa/cs423x/cs4231_lib.c
> >> +++ b/sound/isa/cs423x/cs4231_lib.c
> >> @@ -346,16 +346,14 @@ void snd_cs4231_mce_down(struct snd_cs4231 *chip)
> >>      }
> >>      snd_cs4231_busy_wait(chip);
> >>
> >> -    /* calibration process */
> >> -
> >
> > The snd_cs4231_busy_wait(chip) is not needed any more here.
>
> I believe it is. I glanced over the CS4232 datasheet (note how cs4232 uses
> snd-cs4332-lib) and it adds a point 4 (see page 53):
>
> * Wait until 80h NOT returned
>

I think it is not needed to way for it with this 1ms delay.

Anyway, do you care to change this long snd_cs4231_busy_wait(chip) to
the snd_cs4231_wait(chip) used in other functions to wait for ready
bit?

I suppose the comment and code:

 /* huh.. looks like this sequence is proper for CS4231A chip (GUS MAX) */
    for (timeout = 5; timeout > 0; timeout--)
        cs4231_inb(chip, CS4231P(REGSEL));


was needed to fix what we fixed (delay checking bits until they are
set). My aim is to completely eliminate snd_cs4231_busy_wait() and
replace it with just snd_cs4231_wait().

Regards,
Krzysztof
