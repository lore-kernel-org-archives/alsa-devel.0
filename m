From: Simon Ho <simon.ho.cnxt@gmail.com>
Subject: Re: [PATCH v2 0/2] ASoC: add driver support for
	Conexant CX2092X DSP
Date: Tue, 21 Feb 2017 21:13:00 +0800
Message-ID: <20170221131300.GA8463@GMAIL.COM>
References: <cover.1487595577.git.simon.ho@conexant.com>
 <s5hd1ecoz48.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qk0-f195.google.com (mail-qk0-f195.google.com
 [209.85.220.195])
 by alsa0.perex.cz (Postfix) with ESMTP id 7D8442666EA
 for <alsa-devel@alsa-project.org>; Tue, 21 Feb 2017 14:13:05 +0100 (CET)
Received: by mail-qk0-f195.google.com with SMTP id n127so7270134qkf.2
 for <alsa-devel@alsa-project.org>; Tue, 21 Feb 2017 05:13:05 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <s5hd1ecoz48.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Simon Ho <simon.ho@conexant.com>, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Tue, Feb 21, 2017 at 07:07:51AM +0100, Takashi Iwai wrote:
> On Tue, 21 Feb 2017 02:01:50 +0100,
> <simon.ho.cnxt@gmail.com> wrote:
> > 
> > From: Simon Ho <simon.ho@conexant.com>
> > 
> > This patch adds support for Conexant CX20921/CX20924 I2S AUDIO DSP
> > 
> > The CX2092X devices are designed for virtual assisant application need to
> > be always open, listening for users to summon it. There is no any power
> > saving mode support on this device. The processed voice data will be sent
> > to automatic speech recognition (ASR) application for further processing.
> 
> Such an information should be rather added to the patch description
> itself, too.  Otherwise it'll be lost after merged to git tree.
> 
> 
> thanks,
> 
> Takashi
> 

Thanks for input, I added above information to patch description.

Thanks,

Simon

> > 
> > Simon Ho (2):
> >   doc: cx2092x: Add DT bingings doc for CX2092X DSP
> >   ASoC: Add driver support fro Conexant CX2092X DSP
> > 
> >  .../devicetree/bindings/sound/cnxt,cx2092x.txt     |  29 ++
> >  sound/soc/codecs/Kconfig                           |  17 +
> >  sound/soc/codecs/Makefile                          |   6 +
> >  sound/soc/codecs/cx2092x-i2c.c                     |  54 +++
> >  sound/soc/codecs/cx2092x-spi.c                     |  57 +++
> >  sound/soc/codecs/cx2092x.c                         | 411 +++++++++++++++++++++
> >  sound/soc/codecs/cx2092x.h                         |  26 ++
> >  7 files changed, 600 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/sound/cnxt,cx2092x.txt
> >  create mode 100644 sound/soc/codecs/cx2092x-i2c.c
> >  create mode 100644 sound/soc/codecs/cx2092x-spi.c
> >  create mode 100644 sound/soc/codecs/cx2092x.c
> >  create mode 100644 sound/soc/codecs/cx2092x.h
> > 
> > -- 
> > 2.7.4
> > 
> > 
