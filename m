From: Lennart Poettering <mznyfn@0pointer.de>
Subject: Re: Guide to Linux Sound APIs
Date: Thu, 25 Sep 2008 21:40:28 +0200
Message-ID: <20080925194028.GB26113@tango.0pointer.de>
References: <20080924224833.GA8280@tango.0pointer.de>
	<s5h3ajotttn.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id A5CC224450
	for <alsa-devel@alsa-project.org>;
	Thu, 25 Sep 2008 21:40:28 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5h3ajotttn.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, 25.09.08 12:15, Takashi Iwai (tiwai@suse.de) wrote:

> > I'd be very thankful for comments, especially from you Takashi and
> > Jaroslav since it contains quite some details about the "safe" subset
> > of the ALSA API!
> 
> Thanks for pushing this up.  I enjoyed this reading a lot, especially
> about many DONTS that reminds me of your past screams.

Thanks!

> Anyway, I'd like to mark async stuff as obsolete in a future version.
> This is a broken design, and should rest in piece.
> Meanwhile, I'm not in favor of adding deprecated link warning.  A
> compile warning is fine, but link warning is way too annoying.  And
> there are programs right now using async, we are responsible to keep
> them running as they are.

You are aware that the linking warnings are only shown during build-time --
not during runtime when dynamic linking happens. So basically the
difference between compiler and linker warnings are not that big. Link
time warnings just appear a little bit later during build time than
compile time warnings.

The big advantage of linker warnings is that you can add arbitrary
warning strings when a symbol is used. Doing that with just the compiler is
impossible to my knowledge.

I.e. just define this:

#ifdef __GNUC__
#define WARN_REFERENCE(sym, msg)                     \
    __asm__(".section .gnu.warning." #sym);          \
    __asm__(".asciz \"" msg "\"");                   \
    __asm__(".previous")
#else
#define WARN_REFERENCE(sym, msg)
#endif

And then put a line like this next to the implementations of the symbols
you want to warn the developer about:

WARN_REFERENCE(snd_async_add_pcm_handler, "Please do not use async handlers anymore. For more details, read http://mailman.alsa-project.org/pipermail/alsa-devel/2008-May/008030.html");

or

WARN_REFERENCE(snd_pcm_sw_params_set_xfer_align, "You are using snd_pcm_sw_params_set_xfer_align() which is obsolete and a NOP. You may safely remove it from your sources.");

and so on.

And everytime someone builds a piece of software that uses a symbol
like this he gets are very clear explanation what is going and what he
should be fixing. The end user won't see anything about this.

Does that sound acceptable to you?

Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net         ICQ# 11060553
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
