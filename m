From: Wu Fengguang <fengguang.wu@intel.com>
Subject: [PATCH 00/11] Intel HDMI fixes
Date: Sun, 15 Nov 2009 19:32:19 +0800
Message-ID: <20091115113219.606666087@intel.com>
Content-Type: multipart/mixed; boundary="===============4546480941533150739=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by alsa0.perex.cz (Postfix) with ESMTP id 9E50924155
	for <alsa-devel@alsa-project.org>; Sun, 15 Nov 2009 12:46:15 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Wu Fengguang <fengguang.wu@intel.com>, Shane W <shane-alsa@csy.ca>, =?UTF-8?q?David=20H=C3=A4rdeman?= <david@hardeman.nu>
List-Id: alsa-devel@alsa-project.org

--===============4546480941533150739==

Hi Takashi,

Here is some Intel HDMI fixes, most of them are inspired/written by
David Härdeman (Big thanks!).

- fix audio infoframe size
- sticky infoframe/stream id/channel count to
  - not disturb (David's) fragile devices
  - avoid the first 0.5s audio samples be losted
- avoid losing presence info during
  - module reloading (by querying the pin sense status)
  - power off (by disabling it)

Thanks,
Fengguang



--===============4546480941533150739==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============4546480941533150739==--
