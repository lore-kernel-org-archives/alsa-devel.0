From: Giuliano Pochini <pochini@shiny.it>
Subject: Re: [RFC] Echoaudio driver
Date: Sat, 25 Sep 2004 20:16:09 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040925201609.53a0fea0.pochini@shiny.it>
References: <s5h6566zhlq.wl@alsa2.suse.de>
	<XFMail.20040923102231.pochini@shiny.it>
	<s5h7jqlxnnp.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h7jqlxnnp.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thu, 23 Sep 2004 12:52:42 +0200
Takashi Iwai <tiwai@suse.de> wrote:

> > The overall structure of the driver is about the same of the
> > au88x0 driver (I took it as model).
>
> Well, I don't like the current implementation of au88x0 drivers, too
> ;)  As a result, you got bunch of ifdefs in the code.

Yep. Some of them are unavoidable because the cards have very different
capabilities.


> In the case of au88x0, it was hard to merge because they use different
> addresses in each chip, while echo boards seem to have the same
> register offsets, right?

They have only 4 registers and most of the data is passed through a "comm
page", which is a single page in system ram that the DSP accesses via bus
mastering. Both the real registers and the stuff in the comm page have fixed
offsets, but a lot of constants are different and each cards requires its
own functions to do a lot of things (the code is in Echo_<card>Dsp files).


> But I don't insist on this rewrite if you prefer keeping this, of course.

I'm undecided yet on how to rearrange it.


> BTW, let's kill SWAP32/SWAP16 macro.  They are always le16_to_cpu()
> and le32_to_cpu() regardless of endianness.

I did it to translate the code quickly. It's already gone.


> Also, checking of sizeof(dma_addr_t) is not correct.  You should check
> that the value itself is in 32bit, not the variable type.

Ah, it's another peice of code. The PCI is limited at 32bits anyway. The
kernel should not return out of range addresses, unless there is an IOMMU
that remaps them AFAIK. I'll remove that check.


> At least, all functions and variables should have the same style.
> The combination of HowLooksThis and how_looks_that is ugly, IMO.

I'm changing everything to the alsa style, because changing the whole alsa
to ThisStyle is a way too long work :))
(almost done btw)


> >  If you're talking about the
> > *eg thing, well, it's not a problem at all moving the EchoGals
> > structure inside chip_t and passing it to the lowlevel
> > functions in place of &eg just like au88x0 does. That would
> > also allow some cleanup and maybe tighter locking.
>
> Having a common struct as a super calss is ok.

Done.


> To be noted, it's not recommended to
> include such binary data into the kernel tree, especially if it's
> avoidable easily.  (I see you already started coding
> request_firmware().)

The firmware is also quite big...


--
Giuliano.


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
