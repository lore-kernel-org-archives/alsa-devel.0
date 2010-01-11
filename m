From: javier Martin <javier.martin@vista-silicon.com>
Subject: Re: [PATCH 4/4] ASoC: Flag the i.MX SSI driver as
	using symmetric rates
Date: Mon, 11 Jan 2010 12:39:13 +0100
Message-ID: <eedb5541001110339s6c7af715g2c95c65ab1028898@mail.gmail.com>
References: <1262967598-4096-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1262967598-4096-4-git-send-email-broonie@opensource.wolfsonmicro.com>
	<20100111112047.GT6923@pengutronix.de>
	<20100111113631.GE3440@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f223.google.com (mail-ew0-f223.google.com
	[209.85.219.223])
	by alsa0.perex.cz (Postfix) with ESMTP id 84CDA2458D
	for <alsa-devel@alsa-project.org>; Mon, 11 Jan 2010 12:39:14 +0100 (CET)
Received: by ewy23 with SMTP id 23so8660848ewy.4
	for <alsa-devel@alsa-project.org>; Mon, 11 Jan 2010 03:39:14 -0800 (PST)
In-Reply-To: <20100111113631.GE3440@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Timur Tabi <timur@freescale.com>, Sascha Hauer <s.hauer@pengutronix.de>, alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

2010/1/11 Mark Brown <broonie@opensource.wolfsonmicro.com>

> On Mon, Jan 11, 2010 at 12:20:47PM +0100, Sascha Hauer wrote:
>
> > Why this limitation? I can successfully record with 16000Hz while
> > playing at 48000Hz on my PCM037 board. What is missing in the driver to
> > 'officially' support asymmetric rates?
>
> At least some of the driver was unconditionally setting both TX and RX
> configuration simultaneously, though looking again hw_params() is OK.
> I'll drop the patch.  Like I say, I've never actually seen the driver
> working - even when configured as the master it doesn't seem to do any
> DMA (well, FIQs).
>

However,
I think it would be a good idea to add an optional flag to activate
symmetric rate.
Understanding it as TX and RX SSI sections sharing the same CLKs.
This is necessary for some codecs like wm8974 to work because they can only
provide
one BCLK and FCLK for both directions.

Moreover I don't want to make this requirement blocking.


-- 
Javier Martin
Vista Silicon S.L.
CDTUC - FASE C - Oficina S-345
Avda de los Castros s/n
39005- Santander. Cantabria. Spain
+34 942 25 32 60
www.vista-silicon.com
