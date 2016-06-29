From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH 2/2] ASoC: fsl_ssi: Fix number of words per
 frame for I2S-slave mode
Date: Wed, 29 Jun 2016 11:26:10 -0700
Message-ID: <20160629182609.GA17986@Asurada-Nvidia>
References: <1466830762-31646-1-git-send-email-shc_work@mail.ru>
 <1467143972.433375523@f318.i.mail.ru>
 <20160628220641.GB378@Asurada-Nvidia>
 <1467186721.688218396@f75.i.mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf0-f196.google.com (mail-pf0-f196.google.com
 [209.85.192.196])
 by alsa0.perex.cz (Postfix) with ESMTP id 146162668B0
 for <alsa-devel@alsa-project.org>; Wed, 29 Jun 2016 20:26:15 +0200 (CEST)
Received: by mail-pf0-f196.google.com with SMTP id i123so5118336pfg.3
 for <alsa-devel@alsa-project.org>; Wed, 29 Jun 2016 11:26:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1467186721.688218396@f75.i.mail.ru>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alexander Shiyan <shc_work@mail.ru>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, Timur Tabi <timur@tabi.org>, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Jun 29, 2016 at 10:52:01AM +0300, Alexander Shiyan wrote:

> >your failed case. Could you please tell me what were the FSclk,
> >BITclk and size of your case?
 
> Here is my oscillograms with/without patch:
> Bclk=12 MHz, sound is just a "cat /dev/urandom > /dev/dsp", i.e. FS=8 KHz, MONO.
> Upper (yellow) line is TXDATA, Lower (blue) is FS.
> 
> Measurement without patch: https://cloud.mail.ru/public/Rcsv/xr88V5Sa1
> Measurement with patch: https://cloud.mail.ru/public/NCwn/DQnzioQEL

Thanks for the reply. So in the case without patch, it looks like
SSI just sent the data ignoring the slot size right?
