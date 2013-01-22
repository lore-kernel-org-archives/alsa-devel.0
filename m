From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [PATCH 11/12] ALSA: hda - Add amix NID to AD codecs
Date: Tue, 22 Jan 2013 20:57:47 +0800
Message-ID: <CAN8cciYv0n3siYA8v8W9ypadkhbNdz8KmsSEscbejZjPi33Zxg@mail.gmail.com>
References: <1358784377-26102-1-git-send-email-tiwai@suse.de>
 <1358784377-26102-12-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ia0-f174.google.com (mail-ia0-f174.google.com
 [209.85.210.174])
 by alsa0.perex.cz (Postfix) with ESMTP id 7C1FC261717
 for <alsa-devel@alsa-project.org>; Tue, 22 Jan 2013 13:57:49 +0100 (CET)
Received: by mail-ia0-f174.google.com with SMTP id o25so3209934iad.19
 for <alsa-devel@alsa-project.org>; Tue, 22 Jan 2013 04:57:48 -0800 (PST)
In-Reply-To: <1358784377-26102-12-git-send-email-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

> The aamix NIDs are also missing for AD codecs.  All AD codecs seem to
> have a (more or less) working aamix widget.
>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---

> @@ -4632,7 +4636,7 @@ static int ad1882_parse_auto_config(struct
hda_codec *codec)
>  {
>         struct ad198x_spec *spec = codec->spec;
>
> -       spec->beep_dev_nid = 0x10;
> +       spec->beep_dev_nid = 0x20;
>         set_beep_amp(spec, 0x10, 0, HDA_OUTPUT);
>         return ad198x_parse_auto_config(codec);
>  }

Seem typo in aamix nid
