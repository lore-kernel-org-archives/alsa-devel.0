From: Kimmo Saarela <kimmo.saarela@gmail.com>
Subject: About kernel tlv320aic32x4 driver
Date: Thu, 18 Jun 2015 11:31:02 +0300
Message-ID: <CADSg6VifxRVSfStc6C032sGyoX-gJMrTUyCJGToyBHijx8wS7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-la0-f42.google.com (mail-la0-f42.google.com
 [209.85.215.42])
 by alsa0.perex.cz (Postfix) with ESMTP id C12C5260563
 for <alsa-devel@alsa-project.org>; Thu, 18 Jun 2015 10:31:02 +0200 (CEST)
Received: by laka10 with SMTP id a10so49821697lak.0
 for <alsa-devel@alsa-project.org>; Thu, 18 Jun 2015 01:31:02 -0700 (PDT)
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
Cc: Javier Martin <javier.martin@vista-silicon.com>
List-Id: alsa-devel@alsa-project.org

I have some patches to that driver and recently I ported those changes to
reasonably fresh kernel (4.1-rc7).

There are some changes that are bit distractible to current workings of the
driver. (mixer settings related)

Current mainline driver does nothing to connect unused inputs to common
mode (datasheet states that that shall be done) and in our testing that had
big impact on recorded audio quality.

I've added OF bindings that check which inputs to connect and where and
then connect unused inputs to common.

Should I just post my patches here or should I first test them against some
other kernel version?

 - Kimmo S.
