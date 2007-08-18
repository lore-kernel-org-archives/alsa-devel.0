From: Zig <zig@icmelectrics.com>
Subject: Re:
	=?utf-8?q?snd-hda-intel=2C=09AD_1988b=3A_SPDIF_outpu?=
	=?utf-8?q?t_not_working_correctly=2C=09volume_low_for_analog_outpu?=
	=?utf-8?q?t?=
Date: Sat, 18 Aug 2007 14:31:35 +0000 (UTC)
Message-ID: <loom.20070818T162601-634@post.gmane.org>
References: <200707170832.01976.ml_alsa@mortal-soul.de>
	<200707200829.03682.ml_alsa@mortal-soul.de>
	<s5hd4ynnq44.wl%tiwai@suse.de>
	<200707232258.24771.ml_alsa@mortal-soul.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by alsa0.perex.cz (Postfix) with ESMTP id 6232A245FF
	for <alsa-devel@alsa-project.org>;
	Sat, 18 Aug 2007 16:35:06 +0200 (CEST)
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1IMPOI-0007Cj-Hh
	for alsa-devel@alsa-project.org; Sat, 18 Aug 2007 16:35:02 +0200
Received: from 203-59-197-231.dyn.iinet.net.au ([203.59.197.231])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Sat, 18 Aug 2007 16:35:02 +0200
Received: from zig by 203-59-197-231.dyn.iinet.net.au with local (Gmexim 0.1
	(Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Sat, 18 Aug 2007 16:35:02 +0200
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

Matthias Dahl <ml_alsa <at> mortal-soul.de> writes:

> 
> --- patch_analog.c.orig 2007-07-23 22:44:25.000000000 +0200
> +++ patch_analog.c      2007-07-23 22:45:15.000000000 +0200
>  <at>  <at>  -2037,12 +2037,8  <at>  <at> 
>  static struct hda_verb ad1988_spdif_init_verbs[] = {
>         /* SPDIF out sel */
>         {0x02, AC_VERB_SET_CONNECT_SEL, 0x0}, /* PCM */
> -       {0x0b, AC_VERB_SET_CONNECT_SEL, 0x0}, /* ADC1 */
> -       {0x1d, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},
> -       {0x1d, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(1)},
>         /* SPDIF out pin */
>         {0x1b, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE | 0x27}, /* 0dB */
> -       {0x1b, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0) | 0x17}, /* 0dB */
> 
>         { }
>  };

> 

I had similar issues, however patching the file as shown above caused no audio
output at all on the SPDIF unless it was in AC3 passthrough mode.  Instead I
edited my patch_analog.c file as follows:

static struct hda_verb ad1988_spdif_init_verbs[] = {
        /* SPDIF out sel */
        {0x02, AC_VERB_SET_CONNECT_SEL, 0x0}, /* PCM */
//      {0x0b, AC_VERB_SET_CONNECT_SEL, 0x0}, /* ADC1 */
        {0x1d, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},
        {0x1d, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(1)},
        /* SPDIF out pin */
        {0x1b, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE | 0x17}, /* 0dB */
//      {0x1b, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0) | 0x17}, /* 0dB */

        { }
};

Once I compiled it this was, the noise on the SPDIF output was gone, and
everything functioned correctly.

It does seem my original issue was related to the PCM audio being outputted at
48kHz instead of 44.1kHz?  Thats what my sony amplifier seemed to think anyhow.

Thanks for your original patch, really I don't know what I'm doing with this
thing, and made a lucky guess for my purposes.
