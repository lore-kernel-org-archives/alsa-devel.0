From: noman pouigt <variksla@gmail.com>
Subject: Bug in 3.10 alsa routing?
Date: Sat, 13 Aug 2016 11:39:22 -0700
Message-ID: <CAES_P+9SAvzrquMHm1kVsK7Dm__R_2LRmAohV7LmQcJCZyZgog@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f177.google.com (mail-yw0-f177.google.com
 [209.85.161.177])
 by alsa0.perex.cz (Postfix) with ESMTP id C7CEF265FED
 for <alsa-devel@alsa-project.org>; Sat, 13 Aug 2016 20:39:23 +0200 (CEST)
Received: by mail-yw0-f177.google.com with SMTP id r9so8889351ywg.0
 for <alsa-devel@alsa-project.org>; Sat, 13 Aug 2016 11:39:23 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@kernel.org" <broonie@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

Hello folks,

I am working on enabling a new alsa codec driver and
I am stuck with this below routing problem.

SND_SOC_DAPM_AIF_OUT("AIF1TX1",)

        { "AIF3RX1", NULL, "AIF3 Playback" },
        { "AIF1TX1 Input 1", NULL, "AIF3RX1" },
        { "AIF1TX1", AIF1TX1, "AIF1TX1 Input 1" },
        { "AIF1TX1", AIF1TX2, "AIF1TX1 Input 1" },
        { "AIF1 Capture", NULL, "AIF1TX1" },

AIF3 Playback and AIF1 Capture is stream name of AIF3
and AIF1 dai respectively.

After setting the paths using mixer command and triggering
AIF3 playback dai, I see that it is not powering AIF3 Playback widget.

After debugging I found the problem to be that ALSA core searches
for physically connected or active widget path before it
can power on the widget. So I think the codec developer wanted
me start the AIF1 capturing to turn on the whole path. However in our
system we just want to connect AIF3RX1 to AIF1TX1.

So i changed to below and now it is powering on the AIF3 Playback widget.
SND_SOC_DAPM_OUTPUT("DUMMY_NODE"),
       // { "AIF1 Capture", NULL, "AIF1TX1" },
       { "DUMMY_NODE", NULL, "AIF1TX1" },

Is ALSA core working as designed as I am using 3.11?

Thanks,
Variksla
