From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Using snd_pcm_set_params() on a capture handle
Date: Tue, 27 Oct 2015 13:01:31 +0800
Message-ID: <CAN8ccibdWBchsc7qnwbzDPD9hSx5sAspJiPPubEWstZKYWBaOQ@mail.gmail.com>
References: <20151025174442.b318e489f0568566a4b82908@mega-nerd.com>
 <CAN8ccibw4HrMp7RZYQpsSYRFc02=0pOXBj+XwCj4eUueLAfcpA@mail.gmail.com>
 <20151027070059.7b2ad05e164ea10341e62f99@mega-nerd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f41.google.com (mail-oi0-f41.google.com
 [209.85.218.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 54E01265CB8
 for <alsa-devel@alsa-project.org>; Tue, 27 Oct 2015 06:01:33 +0100 (CET)
Received: by oifu63 with SMTP id u63so71062671oif.2
 for <alsa-devel@alsa-project.org>; Mon, 26 Oct 2015 22:01:32 -0700 (PDT)
In-Reply-To: <20151027070059.7b2ad05e164ea10341e62f99@mega-nerd.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

>
> > Do your sound card driver support 0.5 second buffer?
>
> If it doesn't, it should return an error instead of just not working.

The application have to use snd_pcm_get_params after calling
snd_pcmset_params

snd_pcm_get_params ( snd_pcm_t * pcm,
snd_pcm_uframes_t * buffer_size,
snd_pcm_uframes_t * period_size
)

Get the transfer size parameters in a simple way.
