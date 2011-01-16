From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Card driver: device or resource busy
Date: Sun, 16 Jan 2011 09:13:29 +0800
Message-ID: <AANLkTikWa6DgGBE5rrq2LEuXbC7gdZVcV-XOaBLHq3DZ@mail.gmail.com>
References: <12d8ae03d3b.-1810748071142587921.-87582792196928800@zoho.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 7864124432
	for <alsa-devel@alsa-project.org>; Sun, 16 Jan 2011 02:13:30 +0100 (CET)
Received: by eyg24 with SMTP id 24so1985961eyg.38
	for <alsa-devel@alsa-project.org>; Sat, 15 Jan 2011 17:13:30 -0800 (PST)
In-Reply-To: <12d8ae03d3b.-1810748071142587921.-87582792196928800@zoho.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2011/1/16 torsten.schenk <torsten.schenk@zoho.com>

> Hello,
>
> I'm currently developing a driver for a card. PCM playback works so far, I
> just encountered some playback issues when firefox (flash) and another alsa
> client wanted to play back at the same time. I figured out that the
> difference between my driver and existing ones is, that my driver only
> allows one client and others multiple. I get a "Device or resource busy"
> when I play back two times the same file (also different ones of course)
> with mplayer f.ex.
>

if your sound card 's DSP can mix more than one audio stream, you need to
specify the number of playback streams in snd_pcm_new()

 int snd_pcm_new(struct snd_card *card, const char *id, int device,
        int playback_count, int capture_count,
        struct snd_pcm **rpcm);

otherwise you will need to use a sound server or dmix for software mixing
