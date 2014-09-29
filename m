From: "Allen M." <ase1592@gmail.com>
Subject: [BUG] Bad decibel data on C-Media USB sound card
Date: Mon, 29 Sep 2014 07:19:05 -0500
Message-ID: <CAPMSj_GXkHE6L8+X6niN2q2OSJ0_N4Rv=CYS4cGOv2cVz9WZNw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yk0-f171.google.com (mail-yk0-f171.google.com
 [209.85.160.171])
 by alsa0.perex.cz (Postfix) with ESMTP id E83942605FE
 for <alsa-devel@alsa-project.org>; Mon, 29 Sep 2014 14:19:06 +0200 (CEST)
Received: by mail-yk0-f171.google.com with SMTP id 79so5379117ykr.2
 for <alsa-devel@alsa-project.org>; Mon, 29 Sep 2014 05:19:05 -0700 (PDT)
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

Clemens Ladisch wrote:
>What is the value of the "Headphone Playback Volume" mixer control
>(as shown by "amixer contents") above and below this threshold?

using "amixer --device hw:Set contents"
36% yields "values=8,8"
34% yields "values=0,0"

interestingly, using "alsamixer" shows that while (default) reports 36%,
the C-media device reports 3%
