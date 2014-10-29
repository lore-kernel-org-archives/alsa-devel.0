From: Dmitry Lavnikevich <d.lavnikevich@sam-solutions.com>
Subject: [PATCH v5 0/3] Add Phytec pbab01 audio support
Date: Wed, 29 Oct 2014 16:47:01 +0300
Message-ID: <1414590424-25585-1-git-send-email-d.lavnikevich@sam-solutions.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: shawn.guo@freescale.com, kernel@pengutronix.de, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.de
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

By mistake previous patchset versions was sent as in-reply-to to
previous patchset versions, so they may have been lost among other
mails.

One of pathces was already applied by Mark Brown, here is 3 patches
implementing audio support on Phytec phyFLEX-i.MX6 boards.

This patchset version only renames audio card name to
OnboardTLV320AIC3007 (on request from Phytec).

Patches are based on branch for-next of
git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git
