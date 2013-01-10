From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [PATCH 7/8] ALSA: hda - Add generic parser support
 to Analog Device codec driver
Date: Thu, 10 Jan 2013 14:48:06 +0800
Message-ID: <CAN8cciaY3Mo8u9LeC9Q-Mdqzg54jy0tw413Lyd7jK==WMLRfRA@mail.gmail.com>
References: <1357645849-8181-1-git-send-email-tiwai@suse.de>
 <1357645849-8181-8-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ie0-f180.google.com (mail-ie0-f180.google.com
 [209.85.223.180])
 by alsa0.perex.cz (Postfix) with ESMTP id 4F26D2607C3
 for <alsa-devel@alsa-project.org>; Thu, 10 Jan 2013 07:48:08 +0100 (CET)
Received: by mail-ie0-f180.google.com with SMTP id c10so270893ieb.25
 for <alsa-devel@alsa-project.org>; Wed, 09 Jan 2013 22:48:07 -0800 (PST)
In-Reply-To: <1357645849-8181-8-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, pbrigade@nxltech.net, robbat2@gentoo.org, r.kreis@uni-bremen.de, basinilya@gmail.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

>
> This patch adds the support for the generic auto-parser to AD codec
> driver.  For AD1988, the old code is replaced simply with the new
> generic parser.  For other codecs, new model "auto" is added and
> directed to use the generic parser.
>
> No fixup codes have been implemented yet as of now.  Eventually we'd
> replace each static quirk with the generic parser + fixup

Do the dac allocation of generic of parser really fit for adi codec  since
DAC0 of most ad198x codecs is for port-A headphone while the first DAC of
realtek is for front line out ?

> -static inline hda_nid_t ad1988_idx_to_dac(struct hda_codec *codec, int
idx)
> -{
> -       static const hda_nid_t idx_to_dac[8] = {
> -               /* A     B     C     D     E     F     G     H */
> -               0x03, 0x06, 0x05, 0x04, 0x0a, 0x06, 0x05, 0x0a
> -       };
