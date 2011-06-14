From: Daniel Mack <zonque@gmail.com>
Subject: ASoC: Patches for an STA32X and WM8782
Date: Tue, 14 Jun 2011 21:27:04 +0200
Message-ID: <1308079626-31239-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.bugwerft.de (unknown [212.112.241.193])
	by alsa0.perex.cz (Postfix) with ESMTP id A24E524569
	for <alsa-devel@alsa-project.org>;
	Tue, 14 Jun 2011 21:28:02 +0200 (CEST)
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
Cc: broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

Hi,

I'm sending two patches to support the ST STA32x codec and the WM8782 ADC.
The code was originally written by Johannes Stezenbach for 2.6.36.

As the ASoC internals changed quite a bit due to the multi-component
reconstruction, I took care for the code transition to make these drivers
compatible to more recent versions. If there's anything left to care for
in these drivers, please let me know.


Daniel


[PATCH 1/2] ALSA: ASoC: add STA32X codec driver
[PATCH 2/2] ALSA: ASoC: add WM8782 ADC Codec Driver
