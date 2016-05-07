From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH v4 0/6] ASoC: fsl_ssi: Fixing various
 channel slips and bad samples insertions
Date: Sat, 7 May 2016 16:16:56 -0700
Message-ID: <20160507231656.GA6348@Asurada>
References: <1462277640-20052-1-git-send-email-arnaud.mouiche@invoxia.com>
 <CAOMZO5A7bD7kAc1vz2eZqgqcV1WAEV+-D=UFw3ptQf43C7kROw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf0-f195.google.com (mail-pf0-f195.google.com
 [209.85.192.195])
 by alsa0.perex.cz (Postfix) with ESMTP id 6B89A26043A
 for <alsa-devel@alsa-project.org>; Sun,  8 May 2016 01:17:03 +0200 (CEST)
Received: by mail-pf0-f195.google.com with SMTP id y7so13055608pfb.0
 for <alsa-devel@alsa-project.org>; Sat, 07 May 2016 16:17:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAOMZO5A7bD7kAc1vz2eZqgqcV1WAEV+-D=UFw3ptQf43C7kROw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Timur Tabi <timur@tabi.org>, Xiubo Li <Xiubo.Lee@gmail.com>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Caleb Crome <caleb@crome.org>, Mark Brown <broonie@kernel.org>, Arnaud Mouiche <arnaud.mouiche@invoxia.com>
List-Id: alsa-devel@alsa-project.org

On Sat, May 07, 2016 at 07:56:41PM -0300, Fabio Estevam wrote:
> Hi Nicolin,
> 
> On Tue, May 3, 2016 at 9:13 AM, Arnaud Mouiche
> <arnaud.mouiche@invoxia.com> wrote:
> 
> > Arnaud Mouiche (6):
> >   ASoC: fsl_ssi: Real hardware channels max number is 32
> >   ASoC: fsl_ssi: The IPG/5 limitation concerns the bitclk, not the
> >     sysclk.
> >   ASoC: fsl_ssi: Save a dev reference for dev_err() purpose.
> >   ASoC: fsl_ssi: Fix samples being dropped at Playback startup
> >   ASoC: fsl_ssi: Fix channel slipping in Playback at startup
> >   ASoC: fsl_ssi: Fix channel slipping on capture (or playback) restart
> >     in full duplex.
> 
> Are you happy with this version?

I think I've already acked at v3. But anyway,

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
