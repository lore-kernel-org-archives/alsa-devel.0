From: Paul Pawlowski <mrarmdev@gmail.com>
Subject: What to do when a device clears the buffer in the
	start trigger?
Date: Wed, 31 Jul 2019 19:48:13 +0200
Message-ID: <CAKSqxP_po3DRQvhqb-VrwD_NitzSRa0a+28NNA8SajUaZN+qbQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A5FADF80214
 for <alsa-devel@alsa-project.org>; Wed, 31 Jul 2019 19:48:25 +0200 (CEST)
Received: by mail-ed1-x533.google.com with SMTP id k8so66454935edr.11
 for <alsa-devel@alsa-project.org>; Wed, 31 Jul 2019 10:48:25 -0700 (PDT)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello,
I have a device which clears the DMA buffer when I command it to start the
playback. How can this be workarounded?

I found the SNDRV_PCM_INFO_DOUBLE flag, but it doesn't seem that it changes
alsa/alsa-lib behaviour. I wasn't able to find any drivers which shared
this quirk.
I'd like to avoid double buffering if possible, as once the stream is
actually started it's not required.

Thank you,
Paul Pawlowski
