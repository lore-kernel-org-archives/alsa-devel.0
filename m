From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: [ANNOUNCE] Sound Open Firmware
Date: Wed, 19 Oct 2016 11:25:05 +0100
Message-ID: <1476872705.11707.20.camel@loki>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 142562666D3
 for <alsa-devel@alsa-project.org>; Wed, 19 Oct 2016 12:25:45 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org


Sound Open Firmware is an open source, platform/architecture independent
audio firmware and SDK intended for the Linux and open source
communities.

The intention of SOF is to provide an open audio firmware infrastructure
and SDK with the following features :-

 o Optimised for the Linux kernel and userspace.
 o Provide features not found in proprietary firmwares.
 o Allow easier integration with audio hardware.
 o Foster innovation in userspace to support audio processing features.
 o Fully open source firmware and SDK. 

SOF currently supports the xtensa audio DSP architecture found in many
modern devices. Platform support currently consists of the Intel
Baytrail and Cherrytrail platforms (e.g. devices like the Minnowboard
Max, UP board, Asus T100, etc).

The firmware is modular and abstracts the architecture/platform layers
like the Linux kernel, so can be ported to other DSP architectures or
target platforms.

The SDK provides a compiler, emulator and image builder tools. No other
tools are needed to build and run the firmware.

More information can be found here on the developer wiki :-

http://alsa-project.org/main/index.php/Firmware

Mailing list (subscribers only) is here :-

http://alsa-project.org/mailman/listinfo/sound-open-firmware

Thanks

Liam
