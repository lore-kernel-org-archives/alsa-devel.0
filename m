From: javier Martin <javier.martin@vista-silicon.com>
Subject: ASoC: Patches for Freescale MXC SoCs (SSI,
	DMA and 	machine).
Date: Tue, 4 Aug 2009 17:17:47 +0200
Message-ID: <eedb5540908040817g15c981f8ye8aac6d4b253317f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f223.google.com (mail-ew0-f223.google.com
	[209.85.219.223])
	by alsa0.perex.cz (Postfix) with ESMTP id 306F424404
	for <alsa-devel@alsa-project.org>;
	Tue,  4 Aug 2009 17:17:48 +0200 (CEST)
Received: by ewy23 with SMTP id 23so563551ewy.32
	for <alsa-devel@alsa-project.org>; Tue, 04 Aug 2009 08:17:47 -0700 (PDT)
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Here comes a series of three patches which currently add audio support
for MX1x and MX2x platforms.

It has been tested in our custom Visstrim_m10 board based on an i.MX27
processor.

All patches are based on stable 2.6.30 kernel and each patch applies
over the previous one.

[alsa-devel] [PATCH 1/3] ASoC: add DMA platform driver for MX1x and MX2x
[alsa-devel] [PATCH 2/3] ASoC: add DAI platform ssi driver for MXC
[alsa-devel] [PATCH 3/3] ASoC: add machine driver for i.mx27_visstrim_m10 board

-- 
Javier Martin
Vista Silicon S.L.
Universidad de Cantabria
CDTUC - FASE C - Oficina S-345
Avda de los Castros s/n
39005- Santander. Cantabria. Spain
+34 942 25 32 60
www.vista-silicon.com
