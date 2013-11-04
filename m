From: Guido Aulisi <guido.aulisi@gmail.com>
Subject: Crash in snd-usb-usx2y
Date: Mon, 4 Nov 2013 16:20:21 +0100
Message-ID: <CAEw7SVFGyiNOx-J2Rcb91NSyj22zYO4PfqXh5zDABMbXgELzTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oa0-f45.google.com (mail-oa0-f45.google.com
 [209.85.219.45])
 by alsa0.perex.cz (Postfix) with ESMTP id 7B16D2625F7
 for <alsa-devel@alsa-project.org>; Mon,  4 Nov 2013 16:20:24 +0100 (CET)
Received: by mail-oa0-f45.google.com with SMTP id i4so7204858oah.4
 for <alsa-devel@alsa-project.org>; Mon, 04 Nov 2013 07:20:22 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

HI all,
I had a crash in usx2y module with my TAscam US-122, starting Jack.
I think that commit a9d14bc0b188a822 in linux kernel (ALSA:
snd-usb-usx2y: remove bogus frame checks) exposed some other bug.
I only have a screenshot of my laptop, I don't know if I can attach it
to alsa-devel.

Kernel is fedora 3.11.6-200.fc19.x86_64.
Panic was fatal exception in interrupt.
RIP [<ffffffffa06817aa>] i_usX2Y_urb_complete+0xaa/0x660 [snd_usb_usx2y]

Guido Aulisi
