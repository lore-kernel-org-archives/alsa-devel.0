From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: Re: [PATCH v2] ASoC: rt286: fix headphone click/crack
 noise on Dell XPS 9343 I2S mode
Date: Fri, 17 Mar 2017 02:41:04 +0000
Message-ID: <CAAd53p6rqb9EFfFMC8EgYXdr86NLTD7BYRbwMM_xvUgUQFwKSg@mail.gmail.com>
References: <20170316083951.11247-1-kai.heng.feng@canonical.com>
 <20170316140946.kikw2rjinafu6qo5@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f177.google.com (mail-yw0-f177.google.com
 [209.85.161.177])
 by alsa0.perex.cz (Postfix) with ESMTP id BC8D12668CC
 for <alsa-devel@alsa-project.org>; Fri, 17 Mar 2017 03:41:16 +0100 (CET)
Received: by mail-yw0-f177.google.com with SMTP id v198so45235505ywc.2
 for <alsa-devel@alsa-project.org>; Thu, 16 Mar 2017 19:41:15 -0700 (PDT)
In-Reply-To: <20170316140946.kikw2rjinafu6qo5@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: oder_chiou@realtek.com, bardliao@realtek.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, Mar 16, 2017 at 10:09 PM Mark Brown <broonie@kernel.org> wrote:

> On Thu, Mar 16, 2017 at 04:39:51PM +0800, Kai-Heng Feng wrote:
>
> > +     switch (event) {
> > +     case SND_SOC_DAPM_PRE_PMD:
> > +     case SND_SOC_DAPM_POST_PMD:
> > +     case SND_SOC_DAPM_POST_PMU:
> > +             snd_soc_write(codec, RT286_SET_AMP_GAIN_HPO, AMP_OUT_MUTE);
> > +             break;
> > +     case SND_SOC_DAPM_PRE_PMU:
> > +             snd_soc_write(codec, RT286_SET_AMP_GAIN_HPO,
> AMP_OUT_UNMUTE);
> > +             break;
>
> After power up we mute the amplifier?  That's worthy of a comment...
>
> > +     rt286->is_dell_dino = dmi_check_system(dmi_dell_dino) ? true :
> false;
> > +
>
> Just directly assign the boolean value, the ternery operator is just
> making thins harder to read here.
>

Should I make the int implicitly convert to bool or use '!!' operator?
