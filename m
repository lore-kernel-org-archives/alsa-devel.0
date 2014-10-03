From: "Allen M." <ase1592@gmail.com>
Subject: [BUG] Bad decibel data on C-Media USB sound card
Date: Fri, 3 Oct 2014 10:48:56 -0500
Message-ID: <CAPMSj_E+=DMbTq_sC0YEzZ3N+YGg98X4U-7UW6JZ_TYB4XN+Ug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yk0-f171.google.com (mail-yk0-f171.google.com
 [209.85.160.171])
 by alsa0.perex.cz (Postfix) with ESMTP id 1613E260490
 for <alsa-devel@alsa-project.org>; Fri,  3 Oct 2014 17:48:57 +0200 (CEST)
Received: by mail-yk0-f171.google.com with SMTP id 79so428052ykr.30
 for <alsa-devel@alsa-project.org>; Fri, 03 Oct 2014 08:48:57 -0700 (PDT)
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

>Did you use mono or stereo in playback and capture?

mono


>Did your capture volume /boost set to 0dB?

yes


>Do your sound card support the sampling rate ?

Yes


>Refer to the datasheet and your alsamixertest result , the card seem not
>has fixed gain for each step

http://www.steila.com/USB4IO/CMedia/CM119.pdf
Card is using C-Media CM119.
Datasheet seems to show 38 volume control steps?
Should the steps be 38 instead of 151? Or are these values unrelated?


>Are you using version 48.11?

Yes
