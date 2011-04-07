From: "Guido Trentalancia" <guido@trentalancia.com>
Subject: [PATCH] snd_hda_codec_realtek: enable configurable
	support for ALC271
Date: Thu, 07 Apr 2011 19:49:49 +0200
Message-ID: <201104071749.p37Hnn3M008926@vivaldi51.register.it>
Reply-To: Guido Trentalancia <guido@trentalancia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hostingsmtp.register.it (hostingsmtp08.register.it
	[81.88.50.249]) by alsa0.perex.cz (Postfix) with ESMTP id D4908103800
	for <alsa-devel@alsa-project.org>;
	Thu,  7 Apr 2011 19:49:53 +0200 (CEST)
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
List-Id: alsa-devel@alsa-project.org

This patch enables configurable support in the Realtek HD Audio driver for the ALC271 type commonly found on some Acer laptops.

It is then possible to enable such support by passing the "model=acer" parameter at boot-time. Without such parameter the driver would fall back to BIOS auto-probing and in many cases that would result in the internal microphone not working.

--- linux-2.6.38.2-original/sound/pci/hda/patch_realtek.c	2011-04-07 17:56:25.053046707 +0200
+++ linux-2.6.38.2/sound/pci/hda/patch_realtek.c	2011-04-07 19:03:00.975706888 +0200
@@ -15028,6 +15028,7 @@ static const char * const alc269_models[
 	[ALC269_DMIC]			= "laptop-dmic",
 	[ALC269_FUJITSU]		= "fujitsu",
 	[ALC269_LIFEBOOK]		= "lifebook",
+	[ALC271_ACER]			= "acer",
 	[ALC269_AUTO]			= "auto",
 };
