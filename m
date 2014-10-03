From: Dmitry Lavnikevich <d.lavnikevich@sam-solutions.com>
Subject: [PATCH v4 0/4] Add Phytec pbab01 audio support
Date: Fri, 3 Oct 2014 16:18:52 +0300
Message-ID: <1412342336-25700-1-git-send-email-d.lavnikevich@sam-solutions.com>
References: <1410854903-26419-1-git-send-email-d.lavnikevich@sam-solutions.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1410854903-26419-1-git-send-email-d.lavnikevich@sam-solutions.com>
Sender: linux-kernel-owner@vger.kernel.org
To: shawn.guo@freescale.com, kernel@pengutronix.de, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.de
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

New phyFLEX board audio patchset version.

Small changes made since last version:

- removed unnecessary 'regulator-always-on' in fixed regulators dts
  description;
- removed 'fsl,mode = "i2s-slave"' from ssi2 node in dts since it was
  already removed from fsl-ssi driver.

Based on branch for-next from
git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git
