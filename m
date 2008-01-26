From: "Jerone Young" <jerone@gmail.com>
Subject: Re: [PATCH] Add missing additional verbs for SPDIF
	with AD1984 & thinkpad
Date: Sat, 26 Jan 2008 13:17:25 -0600
Message-ID: <9f50a7a00801261117x1036f3f7m945cd6cb97e08c40@mail.gmail.com>
References: <9f50a7a00801251804t37834229td1f6768c95563c8@mail.gmail.com>
	<s5hprvp0xfn.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.159])
	by alsa0.perex.cz (Postfix) with ESMTP id C18E7103919
	for <alsa-devel@alsa-project.org>; Sat, 26 Jan 2008 20:17:26 +0100 (CET)
Received: by fg-out-1718.google.com with SMTP id l27so986418fgb.44
	for <alsa-devel@alsa-project.org>; Sat, 26 Jan 2008 11:17:26 -0800 (PST)
In-Reply-To: <s5hprvp0xfn.wl%tiwai@suse.de>
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

Yeah this isn't needed.

On Jan 26, 2008 3:05 AM, Takashi Iwai <tiwai@suse.de> wrote:
> At Fri, 25 Jan 2008 20:04:40 -0600,
> Jerone Young wrote:
> >
> > Additional verbs are missing for IEC958 code for the AD1984 in
> > thinkpads. This is identical to the verbs in AD19884. I missed these
> > in my patch last month.
> >
> > Signed-off-by: Jerone Young <jerone@gmail.com>
>
> Are you sure that you need this?  ad1984_thinkpad_init_verbs is the
> *additional* verbs to ad1884_init_verbs.  The same sequence is already
> found in ad1884_init_verbs, so it looks just doubled.
>
>
> Takashi
>
> >
> > diff -r dcc1b9d533d3 alsa-kernel/pci/hda/patch_analog.c
> > --- a/alsa-kernel/pci/hda/patch_analog.c      Fri Jan 25 19:49:19 2008 -0600
> > +++ b/alsa-kernel/pci/hda/patch_analog.c      Fri Jan 25 19:51:05 2008 -0600
> > @@ -3188,6 +3188,9 @@ static struct hda_verb ad1984_thinkpad_i
> >       {0x20, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(4)},
> >       /* enable EAPD bit */
> >       {0x12, AC_VERB_SET_EAPD_BTLENABLE, 0x02},
> > +     /* SPDIF output selector */
> > +     {0x02, AC_VERB_SET_CONNECT_SEL, 0x0}, /* PCM */
> > +     {0x1b, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE | 0x27}, /* 0dB */
> >  };
> >
> >  /* Digial MIC ADC NID 0x05 + 0x06 */
> > _______________________________________________
> > Alsa-devel mailing list
> > Alsa-devel@alsa-project.org
> > http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> >
>
