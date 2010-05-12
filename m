From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [RFC] disabling ALSA period interrupts
Date: Wed, 12 May 2010 15:00:23 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1005121452230.6856@eeebox2.perex-int.cz>
References: <h2l6160a5131004291538w6c7891fbn2db3425846aefd60@mail.gmail.com>
	<20100507232516.GB16910@tango.0pointer.de>
	<s2r6160a5131005072012o24609ce9q421ed2def04e4728@mail.gmail.com>
	<AANLkTimUaGy7NirNI78duHwGe3V72s_1eUiby_Rb_dRq@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id CEB21243FD
	for <alsa-devel@alsa-project.org>;
	Wed, 12 May 2010 15:00:23 +0200 (CEST)
In-Reply-To: <AANLkTimUaGy7NirNI78duHwGe3V72s_1eUiby_Rb_dRq@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: pl bossart <bossart.nospam@gmail.com>
Cc: General PulseAudio Discussion <pulseaudio-discuss@mail.0pointer.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, 11 May 2010, pl bossart wrote:

> Here's a proposal for an alsa-lib modification to allow applications
> to disable interrupts (if the hardware can do so).

Please, use tabs for block indention for alsa-lib.

> I used the flag field in hw_params, this looked like a good candidate
> to convey this information needed by the driver. I don't really like
> adding two new routines, but I don't think there's any other way.
> Still 2 points to be worked out:
> - I couldn't figure out how to make these two new symbols known to
> PulseAudio. Somehow there's a missing symbol that prevents PA modules
> from loading, not sure where it needs to be declare

Are you sure that you're using new libraries? 'ldd' and 'nm' tools will 
help you to determine what's wrong with symbols.

> - I thought I could make use of the same flag on the driver side, but
> the code in pcm_native.c makes a peculiar use of hw_params->flag. It
> looks like this field is used as an internal variable.
>
> for (k = 0; k < constrs->rules_num; k++) {
> 			struct snd_pcm_hw_rule *r = &constrs->rules[k];
> 			unsigned int d;
> 			int doit = 0;
> 			if (r->cond && !(r->cond & params->flags))
> 				continue;

Ignore this. I don't know about any place where r->cond is used (!= 0) in 
the current ALSA driver, so eating one more bit from params->flags is OK.
Just put the kernel asound.h in sync with library asound.h.

 						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
