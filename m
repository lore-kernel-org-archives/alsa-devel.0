From: Ryan <ryanphilips19@googlemail.com>
Subject: audio playback
Date: Fri, 20 Nov 2015 20:54:02 +0530
Message-ID: <CANMsd01RoJqmzS1ML5HsBgonJVPR93ksG7W0CcQWrj9F+FD8dg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ig0-f172.google.com (mail-ig0-f172.google.com
 [209.85.213.172])
 by alsa0.perex.cz (Postfix) with ESMTP id 9A08C260710
 for <alsa-devel@alsa-project.org>; Fri, 20 Nov 2015 16:24:03 +0100 (CET)
Received: by igbxm8 with SMTP id xm8so14156891igb.1
 for <alsa-devel@alsa-project.org>; Fri, 20 Nov 2015 07:24:02 -0800 (PST)
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

I want to play Linux Audio during kernel bootup as quickly as possible
after board bootup to indicate that board has powered on. I cant wait
until the filesystem is mounted.

I believe this is possible. has anyone tried it? can you provide some
pointers on how to do it?

Where do i need to fill the buffer. is there any specific call i can
make as soon as audio is initialised?


Thanks.
ryan
