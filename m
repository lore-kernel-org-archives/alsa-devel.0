From: Chas Leichner <chas@google.com>
Subject: Clock Rate Clock Rate Adjustment API
Date: Thu, 3 Dec 2015 16:32:41 -0800
Message-ID: <CAA=k9AufXDhGO1v9qezdi7sWyz713nPhskB4r4Wttf269uaiKg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vk0-f50.google.com (mail-vk0-f50.google.com
 [209.85.213.50])
 by alsa0.perex.cz (Postfix) with ESMTP id B5F9D26061B
 for <alsa-devel@alsa-project.org>; Fri,  4 Dec 2015 01:33:22 +0100 (CET)
Received: by vkay187 with SMTP id y187so56277346vka.3
 for <alsa-devel@alsa-project.org>; Thu, 03 Dec 2015 16:33:21 -0800 (PST)
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
Cc: tiwai@suse.de, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

I would like to be able to make small adjustments the playback clock rate
of a PCM device as it is playing in order to accurately synchronize music
playback across several computers. Looking at the kernel source, this
functionality has been previously implemented in both the aloop driver and
ST's uniperif driver where the clock rate adjustment was exposed to the
user space as a control element.

Although the control interface can be used to communicate this information,
the naming and properties of the clock adjustment controls don't appear to
be standardized or documented and I don't see anything related to clock
rate adjustment in Documentation/sound/alsa/ControlNames.txt.

In order to make a standardized interface, do you think it makes more sense
to standardize on a clock rate adjustment control or introduce a new
interface other than the control interface because the control interface is
only for mixer controls rather than arbitrary runtime changes to the driver?

Regards,
Chas
