From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [PATCH 04/20] ALSA: hda - Allow aamix as a capture
	source
Date: Mon, 11 Feb 2013 20:53:13 +0800
Message-ID: <CAN8cciZEvioerkpWmLZrOA9GMJmM8VMihoS3TVCQpE2-Z6GcqQ@mail.gmail.com>
References: <1358247947-13992-1-git-send-email-tiwai@suse.de>
 <1358247947-13992-5-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ie0-f175.google.com (mail-ie0-f175.google.com
 [209.85.223.175])
 by alsa0.perex.cz (Postfix) with ESMTP id D037C2616DB
 for <alsa-devel@alsa-project.org>; Mon, 11 Feb 2013 13:53:14 +0100 (CET)
Received: by mail-ie0-f175.google.com with SMTP id c12so7423978ieb.20
 for <alsa-devel@alsa-project.org>; Mon, 11 Feb 2013 04:53:13 -0800 (PST)
In-Reply-To: <1358247947-13992-5-git-send-email-tiwai@suse.de>
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

2013/1/15 Takashi Iwai <tiwai@suse.de>:
> Since some codecs can choose the aamix as a capture source, we should
> support it as well.  When spec->add_stereo_mix_input flag is set, the
> parser checks the availability of aamix as the input source, and adds
> the paths automatically when possible.

> +       if (mixer && spec->add_stereo_mix_input) {
> +               err = parse_capture_source(codec, mixer, num_adcs,
> +                                          "Stereo Mix", 0);
> +               if (err < 0)
> +                       return err;
>         }


Can this feature enabled automatically if auto mic is not enabled ?

since this feature cannot be enabled when auto mic is enabled

-       if (mixer && spec->add_stereo_mix_input) {
+       if (mixer && !spec->auto_mic) {
