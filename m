From: Stephen Warren <swarren@nvidia.com>
Subject: [PATCH v3 0/4] Tegra: Harmony: Add internal speaker
	support
Date: Thu, 20 Jan 2011 13:52:07 -0700
Message-ID: <1295556731-25165-1-git-send-email-swarren@nvidia.com>
References: <1295393859-3396-1-git-send-email-swarren@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 3B082243EF
	for <alsa-devel@alsa-project.org>; Thu, 20 Jan 2011 21:52:21 +0100 (CET)
In-Reply-To: <1295393859-3396-1-git-send-email-swarren@wwwdotorg.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
Cc: linux-tegra@vger.kernel.org, alsa-devel@alsa-project.org, Stephen Warren <swarren@nvidia.com>
List-Id: alsa-devel@alsa-project.org

Harmony has headers on the board for an internal speaker and internal mic.
This patch series adds various infra-structure, and enables usage of the
internal speaker.

The patch series includes both changes to code within the ASoC
subsystem and Tegra subsystem, the latter provided only for context when
reading the ASoC changes. Would you prefer I separated these so that the
ASoC maintainers can grab a whole series and apply it, rather than just
a subset of the patches?

While patch 2 is physically located in the Tegra subsystem, I'd
consider it part of the ASoC driver. Can such a change be checked into
the ASoC tree? This new header file will be required to build to ASoC driver
once the following patches are in. I was considering placing this in
include/sound, following the example of various codecs, but it doesn't seem
a good idea to pollute that directory with platform-specific files. The
current location for the file follows the example of s3c24xx/simtec. Perhaps
it should be in sound/soc/tegra?

Changelog:

* v3:
  * Reverted change to WM8903_GPIO_NO_CONFIG
  * Program WM8903_GP1_FN_MASK in direction_{input,output}
  * Simplify harmony_event_int_spk
  * Didn't remove GPIO entries from harmony_wm8903_pdata, since this
    also sets up all the other fields to 0 too.

Stephen Warren (4):
  ASoC: WM8903: Expose GPIOs through gpiolib
  ARM: tegra: Add Harmony sound platform data type
  ARM: tegra: Platform data fixes for ASoC driver updates
  ASoC: tegra: Harmony: Support the internal speaker

 arch/arm/mach-tegra/board-harmony.c              |   31 ++++++
 arch/arm/mach-tegra/gpio-names.h                 |    2 +
 arch/arm/mach-tegra/include/mach/harmony_audio.h |   19 ++++
 include/sound/wm8903.h                           |   20 ++++-
 sound/soc/codecs/wm8903.c                        |  126 +++++++++++++++++++++-
 sound/soc/tegra/harmony.c                        |   87 +++++++++++++--
 6 files changed, 272 insertions(+), 13 deletions(-)
 create mode 100644 arch/arm/mach-tegra/include/mach/harmony_audio.h
