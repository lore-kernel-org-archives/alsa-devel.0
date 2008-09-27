From: "Richard Zhao" <linuxzsc@gmail.com>
Subject: Re: [PATCH 1/1] ALSA: ASoC: Fix wrong param when call
	snd_soc_test_bits
Date: Sun, 28 Sep 2008 07:27:27 +0800
Message-ID: <4e090d470809271627t587270a0x3724b5b08b89a247@mail.gmail.com>
References: <1222519396-6916-1-git-send-email-linuxzsc@gmail.com>
	<20080927163300.GA3225@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.177])
	by alsa0.perex.cz (Postfix) with ESMTP id CC36B2414C
	for <alsa-devel@alsa-project.org>;
	Sun, 28 Sep 2008 01:27:28 +0200 (CEST)
Received: by wa-out-1112.google.com with SMTP id l35so1550067waf.16
	for <alsa-devel@alsa-project.org>; Sat, 27 Sep 2008 16:27:27 -0700 (PDT)
In-Reply-To: <20080927163300.GA3225@sirena.org.uk>
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
To: Richard Zhao <linuxzsc@gmail.com>, patch@alsa-project.org, liam.girdwood@wolfsonmicro.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Mark,
Without the patch, value of val is the value of the enumerated control
(mux), so dapm_mux_update_power didn't go wrong. But snd_soc_test_bits
need the bitmask value, so I changed the original variable name "val"
to "mux" and add a new variable "val" which means bitmask value. So
the meaning of val and mux is unified with that in
dapm_mux_update_power.
Though you can't find "if (!snd_soc_test_bits(widget->codec, e->reg,
mask, val))" in the patch, it's what I want to fix.

Thanks
Richard

2008/9/28 Mark Brown <broonie@opensource.wolfsonmicro.com>
>
> On Sat, Sep 27, 2008 at 08:43:16PM +0800, Richard Zhao wrote:
>
> > Fix wrong param when call snd_soc_test_bits in function dapm_mux_update_power.
>
> So...  This patch doesn't actually do what the changelog entry here
> says: the arguments to snd_soc_test_bits() remain the same before and
> after your change.
>
> > -             if (!path->name || ! e->texts[val])
> > +             if (!path->name || !e->texts[mux])
> >                       continue;
>
> What this is actually doing is changing the enum text examined to be
> indexed by mux (the value of the enumerated control) rather than val
> (the bitmask in the register).  This looks like a good change but I want
> to double check with a test system.
