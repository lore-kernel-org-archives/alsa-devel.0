From: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Subject: Re: [RFC/RFT PATCH] ALSA: hda - hdmi: Add ATI/AMD
	multi-channel audio support
Date: Fri, 27 Sep 2013 12:19:03 +0200
Message-ID: <CACna6rzfMw46kw36d2A_JvMjujnCWOYZOJLtT7dDDvU6P5vh+A@mail.gmail.com>
References: <1379872233-32210-1-git-send-email-anssi.hannula@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-we0-f169.google.com (mail-we0-f169.google.com
 [74.125.82.169])
 by alsa0.perex.cz (Postfix) with ESMTP id F1734265062
 for <alsa-devel@alsa-project.org>; Fri, 27 Sep 2013 12:19:05 +0200 (CEST)
Received: by mail-we0-f169.google.com with SMTP id t60so2469033wes.14
 for <alsa-devel@alsa-project.org>; Fri, 27 Sep 2013 03:19:03 -0700 (PDT)
In-Reply-To: <1379872233-32210-1-git-send-email-anssi.hannula@iki.fi>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Anssi Hannula <anssi.hannula@iki.fi>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, =?UTF-8?Q?Peter_Fr=C3=BChberger?= <fritsch@xbmc.org>
List-Id: alsa-devel@alsa-project.org

2013/9/22 Anssi Hannula <anssi.hannula@iki.fi>:
> +       pos = 20;
> +       for (i = 1; i <= 14; i++) {

What about using HDMI_AUDIO_CODING_TYPE_PCM and HDMI_AUDIO_CODING_TYPE_WMA_PRO?


> +               if (i == 13) /* not handled by ATI/AMD */
> +                       continue;

Replace 13 with HDMI_AUDIO_CODING_TYPE_DST and add
HDMI_AUDIO_CODING_TYPE_DSD (it's not used/reserved too).


> +               snd_hda_codec_write(codec, nid, 0, ATI_VERB_SET_AUDIO_DESCRIPTOR, i << 3);
> +               ati_sad = snd_hda_codec_read(codec, nid, 0, ATI_VERB_GET_AUDIO_DESCRIPTOR, 0);

Now I understand why I couldn't RE that. I didn't know I have to write
something to the ATI_VERB_SET_AUDIO_DESCRIPTOR.


> +               if (i == 1 && ati_sad & 0xff000000 && (ati_sad & 0xff00) != (ati_sad & 0xff000000) >> 16) {

Don't you get a warning about lacking brackets around
ati_sad & 0xff000000
?
Please replace magic "1" with HDMI_AUDIO_CODING_TYPE_PCM.
