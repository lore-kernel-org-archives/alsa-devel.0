From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [PATCH v2] Fix forward/rewind support in iec958
	plugin
Date: Fri, 25 Apr 2014 07:02:20 +0800
Message-ID: <CAN8cciadq+=36DcMufwDD=M5=0EAdnkUxPv8b9Ga5JHWqg1-Hg@mail.gmail.com>
References: <5358F356.3020701@canonical.com>
 <1398350406-10347-1-git-send-email-patrakov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qg0-f42.google.com (mail-qg0-f42.google.com
 [209.85.192.42])
 by alsa0.perex.cz (Postfix) with ESMTP id 6508426530B
 for <alsa-devel@alsa-project.org>; Fri, 25 Apr 2014 01:02:21 +0200 (CEST)
Received: by mail-qg0-f42.google.com with SMTP id i50so3347692qgf.1
 for <alsa-devel@alsa-project.org>; Thu, 24 Apr 2014 16:02:20 -0700 (PDT)
In-Reply-To: <1398350406-10347-1-git-send-email-patrakov@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Alexander E. Patrakov" <patrakov@gmail.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

>
> When forwarding or rewinding, the frame counter was not updated. This
> could result in corrupted channel status words or misplaced Z-type
> preamble.

Do you mean it is the responsibility for a52 and dca plugin to return the
SAFE value returned by snd_pcm_rewindable and snd_pcm_forwardable since
they enocde the audio and padding zeros and write to IEC958 ?

>
> +static snd_pcm_sframes_t snd_pcm_iec958_rewind(snd_pcm_t *pcm,
snd_pcm_uframes_t frames)
> +{
> +       unsigned int counter_decrement;
> +       snd_pcm_iec958_t *iec = pcm->private_data;
> +       snd_pcm_sframes_t result = snd_pcm_plugin_rewind(pcm, frames);
> +       if (result <= 0)
> +               return result;
> +
> +       counter_decrement = result % 192;
> +       iec->counter += 192 - counter_decrement;
> +       iec->counter %= 192;
> +       return result;
> +}
> +
> +static snd_pcm_sframes_t snd_pcm_iec958_forward(snd_pcm_t *pcm,
snd_pcm_uframes_t frames)
> +
> +{
> +       unsigned int counter_increment;
> +       snd_pcm_iec958_t *iec = pcm->private_data;
> +       snd_pcm_sframes_t result = snd_pcm_plugin_rewind(pcm, frames);
> +       if (result <= 0)
> +               return result;
> +
> +       counter_increment = result % 192;
> +       iec->counter += counter_increment;
> +       iec->counter %= 192;
> +       return result;
> +}
> +
