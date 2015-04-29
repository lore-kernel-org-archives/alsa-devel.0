From: Andy Ng <andreas2025@gmail.com>
Subject: Alsa triggering methods
Date: Wed, 29 Apr 2015 16:24:09 +0100
Message-ID: <CAAVaN8wvo4Aq_ij1K_Nt2Jnc6qO8XDsd5X2hvsFKSAzQhbts2A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ie0-f172.google.com (mail-ie0-f172.google.com
 [209.85.223.172])
 by alsa0.perex.cz (Postfix) with ESMTP id A534E2605D2
 for <alsa-devel@alsa-project.org>; Wed, 29 Apr 2015 17:24:10 +0200 (CEST)
Received: by iejt8 with SMTP id t8so44936581iej.2
 for <alsa-devel@alsa-project.org>; Wed, 29 Apr 2015 08:24:09 -0700 (PDT)
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

Hi,

I am working on a ALSA card driver that handles a DSP instance. The
problem I have is that the triggering mechanism in ALSA to start a PCM
has the interrupts disabled, and my dsp framework is actually
acknowledging the start trigger with an event after 50 microseconds
time that I can't handle because the IRQs are disabled.

Is there any way when the trigger mechanism goes down to the card to
be able to handle any acknowledgements what will happen within a sort
period of time.

I have seen bespoke triggering method but not sure if everyone is using it.

Any ideas would be helpful.

Best regards,
Andreas
