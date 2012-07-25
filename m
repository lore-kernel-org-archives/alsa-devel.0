From: Daniel Mack <zonque@gmail.com>
Subject: Clock generators in ASoC setups
Date: Wed, 25 Jul 2012 10:18:24 +0200
Message-ID: <500FABD0.4040001@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-we0-f179.google.com (mail-we0-f179.google.com
 [74.125.82.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 6433A265DAE
 for <alsa-devel@alsa-project.org>; Wed, 25 Jul 2012 10:18:25 +0200 (CEST)
Received: by weyx10 with SMTP id x10so291275wey.38
 for <alsa-devel@alsa-project.org>; Wed, 25 Jul 2012 01:18:27 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi Mark and Liam,

some board I'm working on feature chips (connected via I2C) that are in
charge of generating clocks for both the CPU DAI and the codecs.
Previously, I configured them manually in platform specific code, but I
wonder if there's a better, more generic way to get the job done,
especially with regards to DT driven boards?


Thanks,
Daniel
