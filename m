From: VDR User <user.vdr@gmail.com>
Subject: How is /proc/asound/cardX/eld#Y.Z generated?
Date: Tue, 6 Oct 2015 21:21:57 -0700
Message-ID: <CAA7C2qgKYOubj737m0eAkVew9PqS-UKg0MQgxSGebxVfgHboHg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ig0-f182.google.com (mail-ig0-f182.google.com
 [209.85.213.182])
 by alsa0.perex.cz (Postfix) with ESMTP id 386272608ED
 for <alsa-devel@alsa-project.org>; Wed,  7 Oct 2015 06:21:59 +0200 (CEST)
Received: by igbkq10 with SMTP id kq10so100143249igb.0
 for <alsa-devel@alsa-project.org>; Tue, 06 Oct 2015 21:21:58 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "mailing list: alsa-dev" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi. I was wondering if someone can tell me how exactly the eld files
are generated. Additionally, if they can be overridden somehow. The
reason is if I start x while my tv is turned on, the eld reports only
stereo audio capability for hdmi even though the tv is plugged into my
surround receiver. I don't care what the tv reports, my surround
receiver is 7.1 so I always want the eld to reflect my -actual- audio
channel setup.

Thanks.
