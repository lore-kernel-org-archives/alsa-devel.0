From: "Christopher K." <c.krooss@gmail.com>
Subject: Conexant CX20588 breakage in Kernel 3.9
Date: Fri, 3 May 2013 15:51:20 +0200
Message-ID: <CAHQjNr9J_tUH4BBp6-gwPC-L5h-FLBvQo80RpR7KFbk6yy_ffQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-la0-f48.google.com (mail-la0-f48.google.com
 [209.85.215.48])
 by alsa0.perex.cz (Postfix) with ESMTP id 1DA6726163E
 for <alsa-devel@alsa-project.org>; Fri,  3 May 2013 15:51:21 +0200 (CEST)
Received: by mail-la0-f48.google.com with SMTP id eg20so1521784lab.21
 for <alsa-devel@alsa-project.org>; Fri, 03 May 2013 06:51:20 -0700 (PDT)
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

Kernel 3.9 breaks audio on internal speakers for the Conexant CX20588.
EAPD is disabled for Node 0x1d. Enabling in hda_analyzer works fine.

Someone already postet on
https://bugs.launchpad.net/ubuntu/+source/alsa-driver/+bug/1173618

Is this the right place to report this bug?

Regards,
Chris
