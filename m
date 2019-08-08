From: "Sridharan, Ranjani" <ranjani.sridharan@intel.com>
Subject: Re: [PATCH] ASoC: Intel: boards: Add Cometlake machine
 driver support
Date: Thu, 8 Aug 2019 12:22:17 -0700
Message-ID: <CAFQqKeX7C9BZ+bn5T8mJKy6+3y0GDOCCt+OxePpT6GCN-PqpfA@mail.gmail.com>
References: <1565251120-13082-1-git-send-email-mac.chiang@intel.com>
 <CAFQqKeXO5XHTrgTvXDRtqPDZZNrb24GB9ps3L=7WYadW0nYuKA@mail.gmail.com>
 <555a5469-a49b-92fa-cf8a-d379c2f46b05@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com
 [IPv6:2607:f8b0:4864:20::b42])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AD31DF803F3
 for <alsa-devel@alsa-project.org>; Thu,  8 Aug 2019 21:22:30 +0200 (CEST)
Received: by mail-yb1-xb42.google.com with SMTP id q203so3393912ybg.11
 for <alsa-devel@alsa-project.org>; Thu, 08 Aug 2019 12:22:30 -0700 (PDT)
In-Reply-To: <555a5469-a49b-92fa-cf8a-d379c2f46b05@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: "M R, Sathya Prakash" <sathya.prakash.m.r@intel.com>, Chiang Mac <mac.chiang@intel.com>, Mark Brown <broonie@kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Bard Liao <bard.liao@intel.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Aug 8, 2019 at 12:15 PM Pierre-Louis Bossart <
pierre-louis.bossart@linux.intel.com> wrote:

>
> >     +       } else if (soc_intel_is_cml()) {
> >     +               unsigned int i;
> >     +
> >     + broxton_audio_card.name <http://broxton_audio_card.name> =
> >     "cmlda7219max";
> >     +
> >     +               for (i = 0; i < ARRAY_SIZE(broxton_dais); i++) {
> >     +                       /* MAXIM_CODEC is connected to SSP1. */
> >     +                       if (!strcmp(broxton_dais[i].codecs->dai_name,
> >     +                                       BXT_MAXIM_CODEC_DAI)) {
> >     +                               broxton_dais[i].id = 1;
> >     +                               broxton_dais[i].name = "SSP1-Codec";
> >     +                               broxton_dais[i].cpus->dai_name =
> >     "SSP1 Pin";
> >     +                       }
> >     +                       /* DIALOG_CODEC is connected to SSP0 */
> >     +                       else if
> >     (!strcmp(broxton_dais[i].codecs->dai_name,
> >     +                                       BXT_DIALOG_CODEC_DAI)) {
> >     +                               broxton_dais[i].id = 0;
> >     +                               broxton_dais[i].name = "SSP0-Codec";
> >     +                               broxton_dais[i].cpus->dai_name =
> >     "SSP0 Pin";
> >     +                       }
> >     +               }
> >              }
> >
> > Would it be possible to keep the ID's unchanged? Its quite confusing
> > with so many platforms reusing the machine driver so it would help if
> > the changes are minimal.
> > I understand why you want to change the ID's but it would be simpler to
> > just use the existing ID's in topology I think.
>
> Ranjani, just to avoid confusion here, what 'ID' are you referring to?


> I can see that in the existing GLK code (copied below) the .id field is
> not touched, only the name and dai_name are changed, is this what you
> were hinting at?
>
Yes, Pierre. The DAI link ID's as defined in broxton_dais[]. I guess Mac's
intention was to keep them ordered for by SSP port numbers but it is not
really necessary to do that. The ID in the topology can be changed to match
the ID in the machine driver.

Thanks,
Ranjani

>
>         if (soc_intel_is_glk()) {
>                 unsigned int i;
>
>                 broxton_audio_card.name = "glkda7219max";
>                 /* Fixup the SSP entries for geminilake */
>                 for (i = 0; i < ARRAY_SIZE(broxton_dais); i++) {
>                         /* MAXIM_CODEC is connected to SSP1. */
>                         if (!strcmp(broxton_dais[i].codecs->dai_name,
>                                     BXT_MAXIM_CODEC_DAI)) {
>                                 broxton_dais[i].name = "SSP1-Codec";
>                                 broxton_dais[i].cpus->dai_name = "SSP1
> Pin";
>                         }
>                         /* DIALOG_CODE is connected to SSP2 */
>                         else if (!strcmp(broxton_dais[i].codecs->dai_name,
>                                          BXT_DIALOG_CODEC_DAI)) {
>                                 broxton_dais[i].name = "SSP2-Codec";
>                                 broxton_dais[i].cpus->dai_name = "SSP2
> Pin";
>                         }
>                 }
>         }
>
>
