From: Herton Ronaldo Krzesinski <herton@mandriva.com.br>
Subject: Re: [Fwd: Re: Code relsease to alsa.]
Date: Thu, 24 Jan 2008 13:07:31 -0200
Message-ID: <200801241307.32699.herton@mandriva.com.br>
References: <1200932071.30379.41.camel@razman.gruemaster.com>
	<3FCB0D64-6192-4E16-B4DC-4EFC6734AB4C@linuxant.com>
	<s5hir1l9aga.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from perninha.conectiva.com.br (perninha.conectiva.com.br
	[200.140.247.100])
	by alsa0.perex.cz (Postfix) with ESMTP id 65C4524362
	for <alsa-devel@alsa-project.org>; Thu, 24 Jan 2008 16:07:43 +0100 (CET)
In-Reply-To: <s5hir1l9aga.wl%tiwai@suse.de>
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
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>, Claudio Matsuoka <cmatsuoka@gmail.com>, "Linuxant support (Jonathan)" <support@linuxant.com>, Marc Boucher <marc@linuxant.com>, Philippe Paravicini <philippe@paravicini.com>
List-Id: alsa-devel@alsa-project.org

Em Tuesday 22 January 2008 12:55:17 Takashi Iwai escreveu:
> At Mon, 21 Jan 2008 13:48:20 -0500,
>
> Marc Boucher wrote:
> > Hi Takashi,
> >
> > Here's the sign-off:
> >
> > Signed-off-by: Marc Boucher <marc@linuxant.com>
>
> Thanks!
>
> > Do you have any specific comments about the code itself?
>
> I have now applied some parts of your patch to HG tree, namely,
>
> - laptop model fixes for Cxt5045
> - clean up of Cxt5047 verbs
> - add missing input elements for cxt5047 test model
> - a workaround in power-state change
> - afg and mfg fields in codec preset
> - ratelimit to timeout messages
>
> I modified the above a bit, mainly for fixing coding issues.
> So, be careful to rebase your patch again.
>
> The rest, the addition of cxt5051 and the HSF modem are pending.
>
> I checked the patch and found some problems in cxt5051 code:
>
> - the ADC stream may be unswitched even if you plug/unplug the docking
>   station when the PCM is being opened
> - basically the capture switch has no role
> - judging the difference of capture prepare/cleanup via the number of
>   adc
>
> The patch below is my revised version with some cleanups.
> Can someone test with the top of the very latest HG tree (at least
> changeset 5753)?

Hi, I tested in the HP laptop model we have here. The patch works very well, I 
only noticed two things:

- The PCM slider in alsamixer doesn't have any effect on volume, Master slide 
does.
- In HP laptop model here Docking Mic binds to the external mic and Internal 
Mic to the builtin mic (it's the only two items in this laptop, External Mic 
doesn't really exist, I can create another model only for the laptop here to 
omit External Mic and rename Docking Mic to External Mic, but it's not 
something important anyway). I noticed just something strange in the automute 
of the mic inputs: if the volume is not zero for Docking Mic, it doesn't 
automute Internal Mic, I can capture from both inputs, but if I mute Docking 
Mic (=0), and plug the mic in Docking Mic, it mutes Internal Mic.

I tested other things like Headphone automute and it's ok. Thanks to all.

>
> About HSF modem, let me clarify.  The HSF modem patch can't be applied
> as is to the kernel tree.  The purpose of this patch is exactly to
> bind with a binary-only object.  And, as everybody knows, binary-only
> objects are refused in the kernel upstream in general, so there is
> no reason to apply it.
>
> Oh, I also didn't apply the addition of wallclock and lpos.  These are
> basically fine to add but there is no user except for HSF.  The lpos
> callback can be replaced with the normal PCM position read, I guess.
>
> The exit callback is also not applied.  Why is this needed?  Doesn't
> it work if you call from free callback?
>

-- 
[]'s
Herton
