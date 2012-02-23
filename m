From: javier Martin <javier.martin@vista-silicon.com>
Subject: [Q] ASoC: What's the real meaning of
	SND_SOC_DAIFMT_NB_NF?
Date: Thu, 23 Feb 2012 13:40:40 +0100
Message-ID: <CACKLOr1sDSEFCiAsRO-vKrk7f+r=_Ex9irog1NKDmXn7LJFCDw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lpp01m010-f51.google.com (mail-lpp01m010-f51.google.com
	[209.85.215.51]) by alsa0.perex.cz (Postfix) with ESMTP id E382124417
	for <alsa-devel@alsa-project.org>; Thu, 23 Feb 2012 13:40:42 +0100 (CET)
Received: by lago2 with SMTP id o2so533287lag.38
	for <alsa-devel@alsa-project.org>; Thu, 23 Feb 2012 04:40:41 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Hi,
I am trying to configure a DAI interface between a i.MX27 SSI and a
wm8974 codec.

The definition of SND_SOC_DAIFMT_NB_NF specifies 'normal' bit clock
and frame for the specified format.
http://lxr.linux.no/#linux+v3.2.7/include/sound/soc-dai.h#L48

As I wasn't sure about the meaning of 'normal'  I've dug into the code
of some platforms to see what they do. What I've found, however, is
that it doesn't seem to be an agreement about it.

Let me expose some examples:

1. Frame clock is active High:

i.MX: http://lxr.linux.no/#linux+v3.2.7/sound/soc/imx/imx-ssi.c#L131 +
MCIMX27RM.pdf (p 1606)    (default)
PXA:  http://lxr.linux.no/#linux+v3.2.7/sound/soc/pxa/pxa-ssp.c#L498
pxa-ssp.c + PXA3xx_DM_Vol_IV.pdf (p 332)  (not default)

2. Frame clock is active Low:

OMAP: http://lxr.linux.no/#linux+v3.2.7/sound/soc/omap/omap-mcbsp.c#L478
+ sprugn4h.pdf (p 3165) (not default)

Some chips like s6000 seem to provide a more original use for this flag:

http://lxr.linux.no/#linux+v3.2.7/sound/soc/s6000/s6000-i2s.c#L255

Similar behavior has been found for bit clock.

ALso, it seems that there is no possibility to specify different
configurations for RX and TX parts.

-- 
Javier Martin
Vista Silicon S.L.
CDTUC - FASE C - Oficina S-345
Avda de los Castros s/n
39005- Santander. Cantabria. Spain
+34 942 25 32 60
www.vista-silicon.com
