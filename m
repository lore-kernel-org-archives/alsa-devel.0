From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [PATCH] ALSA: hda - Don't be too specific for
 conflicting boost ctl names
Date: Thu, 19 Dec 2013 17:54:40 +0800
Message-ID: <CAN8cciYYsBFAZz_b-met4j9K=bBdfbxxq+bGvPsiAxTq828qPw@mail.gmail.com>
References: <1387388362-1005-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ig0-f177.google.com (mail-ig0-f177.google.com
 [209.85.213.177])
 by alsa0.perex.cz (Postfix) with ESMTP id 7BEB4261A8F
 for <alsa-devel@alsa-project.org>; Thu, 19 Dec 2013 10:54:41 +0100 (CET)
Received: by mail-ig0-f177.google.com with SMTP id uy17so3541916igb.4
 for <alsa-devel@alsa-project.org>; Thu, 19 Dec 2013 01:54:40 -0800 (PST)
In-Reply-To: <1387388362-1005-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

When a boost control influences on multiple input paths, we shouldn't
> pick up the name string specific to one input but rather choose a more
> generic name.  A problem seen often is that a single mic boost
> controls both internal and external mics although the driver picks up
> the very first name randomly like "Internal Mic Boost".  This should
> have been "Mic Boost", instead.
>
> This patch tries to correct that behavior: when a boost control is
> available, check whether it conflicts with other inputs.  If it does,
> use a common string ("Mic", "Line") as long as possible, or take a
> generic name "Input".
>
> +

>                 /* create a boost control */
> +               if (!conflict) {
> +                       pfx = spec->input_labels[idx];
> +                       idx = spec->input_label_idxs[idx];
> +               } else {
> +                       pfx = input_type_labels[type];
> +                       idx = input_type_idxs[type]++;
> +               }
> +
>                 snprintf(boost_label, sizeof(boost_label),
> -                        "%s Boost Volume", spec->input_labels[idx]);
> -               if (!add_control(spec, HDA_CTL_WIDGET_VOL, boost_label,
> -                                spec->input_label_idxs[idx], val))
> +                        "%s Boost Volume", pfx);
>

should "Boost Volume" change to "Boost Capture Volume" if loopback path not
exist ?

                 if (spec->mixer_nid)
                           "Boost Volume"
