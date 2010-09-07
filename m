From: Arnaud Patard (Rtp) <arnaud.patard@rtp-net.org>
Subject: [patch 0/3] ASoC: t5325 audio support
Date: Tue, 07 Sep 2010 09:01:27 +0200
Message-ID: <20100907070127.305740006@rtp-net.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lechat.rtp-net.org (lechat.rtp-net.org [88.191.19.38])
	by alsa0.perex.cz (Postfix) with ESMTP id BD46324406
	for <alsa-devel@alsa-project.org>;
	Tue,  7 Sep 2010 09:12:08 +0200 (CEST)
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Martin Michlmayr <tbm@cyrius.com>, Saeed Bishara <saeed@marvell.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org



Hi,

This patchset is the first try to get merged audio support for HP t5325 
thinclient. This board is using a ALC5621 so the major part of this series 
is made of the ALC5623 driver. It's supporting ALC5621/22/23 but has been
tested only with a ALC5621.


Arnaud
