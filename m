From: yuvaraj r <yuvaraj.tr@gmail.com>
Subject: DAPM widget power off
Date: Thu, 18 Apr 2013 12:32:07 +0530
Message-ID: <CAK=eu+d7DTESE3YGCKfA-BZiT0AGVPUUV8iu0FbM1tiC+MRzZg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vc0-f180.google.com (mail-vc0-f180.google.com
 [209.85.220.180])
 by alsa0.perex.cz (Postfix) with ESMTP id A0B63265E16
 for <alsa-devel@alsa-project.org>; Thu, 18 Apr 2013 09:02:08 +0200 (CEST)
Received: by mail-vc0-f180.google.com with SMTP id m16so2125447vca.11
 for <alsa-devel@alsa-project.org>; Thu, 18 Apr 2013 00:02:07 -0700 (PDT)
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

Hi All,

I have two different dais

1. Hifi Multimedia

2.  Voice call dai

Before opening voice call dai. I closed Hifi stream. After 5 sec Voice call
 stream dapm widget got powered off automatically. I am assuming that
stream close event of Multimedia causing problem.

What will issue in my cause.

Thanks
Yuvaraj
