From: Ivailo <xakepa10@gmail.com>
Subject: udev rules prefix
Date: Wed, 13 Nov 2013 20:36:48 +0000
Message-ID: <CABdmW1cQmesQfC2Kwt4CBOJzrVGBdaC2m2KFb4XeQZYhJAzfMQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pb0-f46.google.com (mail-pb0-f46.google.com
 [209.85.160.46])
 by alsa0.perex.cz (Postfix) with ESMTP id 3CC79260795
 for <alsa-devel@alsa-project.org>; Wed, 13 Nov 2013 21:36:50 +0100 (CET)
Received: by mail-pb0-f46.google.com with SMTP id un15so950412pbc.5
 for <alsa-devel@alsa-project.org>; Wed, 13 Nov 2013 12:36:49 -0800 (PST)
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

Hello,

the default prefix for alsa-utils is /usr however the udev rules directory
is /lib/udev/rules.d thus on setups with separate partition for /usr the
binaries, from /usr/bin and /usr/sbin, will likely not be available during
the boot process and the udev rule will fail to restore the state.

I suggest that the udev rules directory follows the prefix or append /usr
to it to resolve this.

Cheers!
