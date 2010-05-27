From: apatard@mandriva.com
Subject: [patch 0/6] kirkwood openrd client audio support - v4
Date: Thu, 27 May 2010 14:57:37 +0200
Message-ID: <20100527125737.524554667@mandriva.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from jules.rtp-net.org (sat78-1-82-232-42-61.fbx.proxad.net
	[82.232.42.61]) by alsa0.perex.cz (Postfix) with ESMTP id B8930103A41
	for <alsa-devel@alsa-project.org>;
	Thu, 27 May 2010 15:03:44 +0200 (CEST)
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
Cc: nico@fluxnic.net, broonie@opensource.wolfsonmicro.com, saeed@marvell.com, tbm@cyrius.com, linux-arm-kernel@lists.infradead.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org


Hi,

This patchset is an other try to get merged openrd audio support mainline.
The main change is going back to using kirkwood instead of orion, as the 
only orion having i2s is not merged mainline (if I got it right).
I've also fixed the lastests comments on the cs42l51 codec patch.

Arnaud

Changes :
- changed back from orion to kirkwood
- removed cs42l51 adc input register initialisation
- moved the DAPM event macro to soc-dapm
- fixed cs42l51_set_dai_fmt() master/slave check
- removed cs42l51 startup message
- use snd_soc_update_bits() in cs42l51_pdn_event()
