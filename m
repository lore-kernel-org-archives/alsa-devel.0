From: Petr Kulhavy <petr@barix.com>
Subject: [PATCH v2 0/2] ASoC: wm8985: add support for WM8758
Date: Tue, 17 May 2016 14:48:52 +0200
Message-ID: <1463489334-17549-1-git-send-email-petr@barix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f49.google.com (mail-wm0-f49.google.com [74.125.82.49])
 by alsa0.perex.cz (Postfix) with ESMTP id 9D2B72607C8
 for <alsa-devel@alsa-project.org>; Tue, 17 May 2016 14:49:06 +0200 (CEST)
Received: by mail-wm0-f49.google.com with SMTP id n129so138921225wmn.1
 for <alsa-devel@alsa-project.org>; Tue, 17 May 2016 05:49:06 -0700 (PDT)
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
Cc: Petr Kulhavy <petr@barix.com>, alsa-devel@alsa-project.org, plamen@barix.com
List-Id: alsa-devel@alsa-project.org

The WM8758 chip is almost identical to WM8985 with the difference that it
doesn't feature the AUX input. This patch set adds the WM8758 support 
into the WM8985 driver.

Changes in v2: 
* use chip type enum instead of chip structure
* do not copy the complete controls, widget, routes but only the differences and
  add widgets dynamically using add_widgets()
