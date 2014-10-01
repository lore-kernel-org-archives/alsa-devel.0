From: "Allen M." <ase1592@gmail.com>
Subject: [BUG] Bad decibel data on C-Media USB sound card
Date: Wed, 1 Oct 2014 18:18:24 -0500
Message-ID: <CAPMSj_H=voAxLzACtVkAzVxsA_QQf0rSE3qSjGVqTUO9c7d-=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yk0-f182.google.com (mail-yk0-f182.google.com
 [209.85.160.182])
 by alsa0.perex.cz (Postfix) with ESMTP id EFFE12604F2
 for <alsa-devel@alsa-project.org>; Thu,  2 Oct 2014 01:18:25 +0200 (CEST)
Received: by mail-yk0-f182.google.com with SMTP id 131so515142ykp.41
 for <alsa-devel@alsa-project.org>; Wed, 01 Oct 2014 16:18:24 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Raymond Yau wrote:

>Does this number of steps remain the same when your starting volume are
not at 151?
>Your value 77 seem quite different from  alsamixertest

recording a sine wave with an amplitude of 1 in Audacity at step 151 shows
that the recorded
value is amplitude 0.885. Does this indicates some loss? The loopback cable
I am using
is 2 meters in length, is the resistance of the cable is too high?
