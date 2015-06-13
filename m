From: Mathias Krause <minipli@googlemail.com>
Subject: [PATCH 0/4] ASoC: constification patches
Date: Sat, 13 Jun 2015 14:25:12 +0200
Message-ID: <1434198316-8400-1-git-send-email-minipli@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f182.google.com (mail-wi0-f182.google.com
 [209.85.212.182])
 by alsa0.perex.cz (Postfix) with ESMTP id 6F7322604EA
 for <alsa-devel@alsa-project.org>; Sat, 13 Jun 2015 14:25:27 +0200 (CEST)
Received: by wifx6 with SMTP id x6so37081728wif.0
 for <alsa-devel@alsa-project.org>; Sat, 13 Jun 2015 05:25:27 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mathias Krause <minipli@googlemail.com>, Len Brown <lenb@kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi Liam, Mark,

this series constifies a few variables in the SoC code that are only
read, namely struct reg_default and struct acpi_device_id.

Please apply!


Mathias Krause (4):
  ASoC: max98090: Constify ACPI device ids and register map
  ASoC: rt5640: Constify ACPI device ids and register map
  ASoC: rt5670: Constify ACPI device ids and register map
  ASoC: intel: Constify ACPI device ids

 sound/soc/codecs/max98090.c       |    4 ++--
 sound/soc/codecs/rt5640.c         |    5 ++---
 sound/soc/codecs/rt5670.c         |    5 ++---
 sound/soc/intel/common/sst-acpi.c |    2 +-
 4 files changed, 7 insertions(+), 9 deletions(-)

-- 
1.7.10.4
