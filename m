From: Anatol Pomozov <anatol.pomozov@gmail.com>
Subject: Configuring I2S2 bus as a path to speaker
Date: Thu, 11 Sep 2014 21:25:40 -0700
Message-ID: <CAOMFOmV8OsFdLaKqs8k-ha6JonMRpGM+2FxnndQmoUCZtwz2Uw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vc0-f177.google.com (mail-vc0-f177.google.com
 [209.85.220.177])
 by alsa0.perex.cz (Postfix) with ESMTP id 763FA2656E2
 for <alsa-devel@alsa-project.org>; Fri, 12 Sep 2014 06:25:41 +0200 (CEST)
Received: by mail-vc0-f177.google.com with SMTP id la4so166524vcb.8
 for <alsa-devel@alsa-project.org>; Thu, 11 Sep 2014 21:25:40 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi

I am working on a board that has following configuration:

[SoC] <== I2S1 ==> [RT5677 Codec] <== I2S2 ==> [Speaker Amp]

The right part is the interesting one. Traditionally I2S is used to
connect to SoC, but in my case it is used to connect Speaker. Is there
any board that has similar configuration?

How to configure I2S2? *Where* and when such configuration should be done?
