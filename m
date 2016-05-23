From: Petr Kulhavy <petr@barix.com>
Subject: [PATCH v3 0/2] ASoC: wm8985: add support for WM8758
Date: Mon, 23 May 2016 16:11:23 +0200
Message-ID: <1464012685-1142-1-git-send-email-petr@barix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f52.google.com (mail-wm0-f52.google.com [74.125.82.52])
 by alsa0.perex.cz (Postfix) with ESMTP id 29A42265A7B
 for <alsa-devel@alsa-project.org>; Mon, 23 May 2016 16:11:34 +0200 (CEST)
Received: by mail-wm0-f52.google.com with SMTP id n129so73799479wmn.1
 for <alsa-devel@alsa-project.org>; Mon, 23 May 2016 07:11:34 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lgirdwood@gmail.com, broonie@kernel.org, ckeepax@opensource.wolfsonmicro.com
Cc: Petr Kulhavy <petr@barix.com>, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, plamen@barix.com
List-Id: alsa-devel@alsa-project.org

The WM8758 chip is almost identical to WM8985 with the difference that it
doesn't feature the AUX input. This patch set adds the WM8758 support 
into the WM8985 driver.

Changes in v3: 
* merge the wm8985_xxx_snd_controls into wm8985_common_snd_controls and wm8985_specific_snd_controls
  in order to reduce the number of structures
  use the static initialization in snd_soc_codec_driver for the common part
