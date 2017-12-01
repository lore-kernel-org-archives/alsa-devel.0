From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH v4 2/2] ASoC: fsl_ssi: add 20-bit sample
 format for AC'97 and use it for capture
Date: Thu, 30 Nov 2017 17:29:35 -0800
Message-ID: <20171201012934.GA32588@Asurada-Nvidia>
References: <5dfa7813-385e-d9c7-84e0-12cf1f7d3a5f@maciej.szmigiero.name>
 <20171130072357.GA992@Asurada>
 <ba46e597-6ae7-5fb4-40b3-bb2a5e08066a@maciej.szmigiero.name>
 <20171130235335.GA26530@Asurada-Nvidia>
 <aaedc37a-1536-462f-515e-19c6cb711e4f@maciej.szmigiero.name>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf0-f177.google.com (mail-pf0-f177.google.com
 [209.85.192.177])
 by alsa0.perex.cz (Postfix) with ESMTP id 3C3AA266DF0
 for <alsa-devel@alsa-project.org>; Fri,  1 Dec 2017 02:29:39 +0100 (CET)
Received: by mail-pf0-f177.google.com with SMTP id j28so3921181pfk.8
 for <alsa-devel@alsa-project.org>; Thu, 30 Nov 2017 17:29:39 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <aaedc37a-1536-462f-515e-19c6cb711e4f@maciej.szmigiero.name>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: alsa-devel@alsa-project.org, Takashi Sakamoto <o-takashi@sakamocchi.jp>, Timur Tabi <timur@tabi.org>, Xiubo Li <Xiubo.Lee@gmail.com>, linux-kernel <linux-kernel@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

On Fri, Dec 01, 2017 at 02:02:29AM +0100, Maciej S. Szmigiero wrote:

> > I will clean up the driver a bit and I think the change would be
> > highly related to AC97 code. So I'll later need you review/test.

> From my perspective it would be great if the whole cleanup was in one
> series, so the whole testing doesn't need to be repeated per patch
> (it involves a lot of manual work).

Understood.

> >> Regarding a sample rate in AC'97 mode its effective value isn't really
> >> controlled by the CPU (that is, SSI), but by a CODEC since it is
> >> the CODEC which tells the CPU when it should send a next sample for
> >> playback and when a next capture sample is ready.
> >> There are no problems if they are different (as long as the CODEC
> >> supports this, naturally, but it's up to its driver to restrict the
> >> sample rate space accordingly).
> > 
> > It's because CODEC drives the bit clock and framesync clock, isn't
> > it? 
> 
> Strictly speaking, the frame sync is driven by the controller (SSI),
> but it is simply the CODEC-provided bit clock divided by 256.
> And the CODEC-provided bit clock is fixed at 12.288MHz by the AC'97
> specs.
> 
> But every frame from CODEC also has 'TAG' bits which tell the
> controller whether this frame contains valid capture samples or not.
> If the capture sample rate currently programmed in CODEC is less
> than 48kHz (the frame rate) it simply means that some of incoming
> frames will contain 'TAG' bits indicating that these frames do not
> contain valid capture samples (for example, if the capture rate is
> 24kHz then only half of the frames, on average, will be marked by CODEC
> as containing valid capture samples).
> 
> The situation with playback is similar: the frame from CODEC also has
> 'SLOTREQ' bits which tell the controller if it should send playback
> samples (and which) in the next frame - for example, if the playback
> rate is 24kHz then in half of the frames, on average, the CODEC will
> request playback samples.
> 
> Hope it is clear now.

Thanks for the explain. It's clear now.

Nicolin
