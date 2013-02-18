From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: HDA regression on Fujitsu S7020 laptop (ALC260
	codec)
Date: Mon, 18 Feb 2013 20:58:28 +0800
Message-ID: <CAN8cciawuZ7byQ89OY9x48_0wY60KwWX5YoyEnPrRU0NzLe0Wg@mail.gmail.com>
References: <20130113043936.GA8822@marvin.atrad.com.au>
 <s5h8v7xjw4f.wl%tiwai@suse.de>
 <20130210114707.GA26574@marvin.atrad.com.au>
 <s5hzjzbql3a.wl%tiwai@suse.de>
 <20130216112505.GE4164@marvin.atrad.com.au>
 <s5h8v6ncpcp.wl%tiwai@suse.de>
 <20130217125316.GA25824@marvin.atrad.com.au>
 <s5h1ucedgge.wl%tiwai@suse.de> <s5hzjz2c1ui.wl%tiwai@suse.de>
 <s5h7gm6huq5.wl%tiwai@suse.de>
 <20130218125003.GC14697@marvin.atrad.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ia0-f170.google.com (mail-ia0-f170.google.com
 [209.85.210.170])
 by alsa0.perex.cz (Postfix) with ESMTP id 2ECDD264F07
 for <alsa-devel@alsa-project.org>; Mon, 18 Feb 2013 13:58:29 +0100 (CET)
Received: by mail-ia0-f170.google.com with SMTP id k20so5182953iak.15
 for <alsa-devel@alsa-project.org>; Mon, 18 Feb 2013 04:58:28 -0800 (PST)
In-Reply-To: <20130218125003.GC14697@marvin.atrad.com.au>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jonathan Woithe <jwoithe@just42.net>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, peter.golden@btinternet.com
List-Id: alsa-devel@alsa-project.org

>
> > > To confirm the behaviour: the "Headphone Jack Mode" control appears in
> > > 3.8.0-rc5+ but a corresponding control for the mic/line-in jack does
not.
> >
> > Ah, I see.  This doesn't appear as default.  You need to pass a hint
> > string in the firmware patch file.  See a brief description in
> > Documentation/sound/alsa/HD-Audio.txt.
>
> Right.  I'll take a look at this documentation.  I must say that it
strikes
> me as a little odd that input jacks don't have a mode control by default.
 I
> would have expected that such controls would be desired by enough people
to
> justify having them appear by default without each user having to mess
> around with firmware patch files and the like.
>
> I assume the magic knob is add_in_jack_modes.
>
> Is there any reason why alc260_fixup_fsc_s7020() couldn't set
> spec->gen.add_in_jack_modes to 1 in the HDA_FIXUP_ACT_PRE_PROBE phase much
> like it already sets add_out_jack_modes?

Is it possible to add spec->gen.add_in_jack_modes automatically when
automic is disabled and there is no line in jack
