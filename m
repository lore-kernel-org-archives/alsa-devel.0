From: Timur Tabi <timur@freescale.com>
Subject: [PATCH 0/2] ASoC drivers for the Freescale MPC8610 SoC
Date: Thu, 10 Jan 2008 16:44:23 -0600
Message-ID: <12000050651235-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	by alsa0.perex.cz (Postfix) with ESMTP id E893624717
	for <alsa-devel@alsa-project.org>; Thu, 10 Jan 2008 23:44:32 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: grant.likely@secretlab.ca, jonsmirl@gmail.com, david@gibson.dropbear.id.au, olof@lixom.net, alsa-devel@alsa-project.org, linuxppc-dev@ozlabs.org
List-Id: alsa-devel@alsa-project.org


These patches add ALSA SoC device drivers for the Freescale MPC8610 SoC
and the MPC8610-HPCD reference board.

The first patch updates some files in arch/powerpc and booting-without-of.txt.

The second patch adds the new audio driver files to sound/soc.

Both must be applied in order to avoid a build break.
