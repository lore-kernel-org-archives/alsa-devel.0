From: anish singh <anish198519851985@gmail.com>
Subject: ALSA device list:NULL problem
Date: Sat, 9 Nov 2013 02:07:20 -0800
Message-ID: <CAK7N6vpdMnX11-HgyhKyKrO0nyTwPrY4sJC-2kettP_sDRAE=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-we0-f176.google.com (mail-we0-f176.google.com
 [74.125.82.176])
 by alsa0.perex.cz (Postfix) with ESMTP id DB1292607C8
 for <alsa-devel@alsa-project.org>; Sat,  9 Nov 2013 11:07:20 +0100 (CET)
Received: by mail-we0-f176.google.com with SMTP id w62so2901318wes.35
 for <alsa-devel@alsa-project.org>; Sat, 09 Nov 2013 02:07:20 -0800 (PST)
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

EPROBE_DEFER has come into picture and it
delays the probe detection to complete until all the
resources required for the device is detected.

This however causes a minor problem which I am
sure some people in this alsa devel mailing list would
have noticed.If the probe keeps on deferring then we
notice below kernel message:

ALSA device list:
     No soundcards found.

Is it deliberate or can I hack up some code to make
it work?As obviously that message is there for a
purpose.
