From: Chris Rorvick <chris@rorvick.com>
Subject: Re: [PATCH 10/16] ALSA: line6: Drop voodoo workarounds
Date: Mon, 26 Jan 2015 21:58:49 -0600
Message-ID: <CAEUsAPZ+6UQj64M-xWP2Hp+4YhQPQq2spB44s161kZCG-S1onQ@mail.gmail.com>
References: <1422033203-23254-1-git-send-email-tiwai@suse.de>
 <1422033203-23254-11-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qc0-f178.google.com (mail-qc0-f178.google.com
 [209.85.216.178])
 by alsa0.perex.cz (Postfix) with ESMTP id 90F9A260557
 for <alsa-devel@alsa-project.org>; Tue, 27 Jan 2015 04:58:50 +0100 (CET)
Received: by mail-qc0-f178.google.com with SMTP id b13so10437557qcw.9
 for <alsa-devel@alsa-project.org>; Mon, 26 Jan 2015 19:58:49 -0800 (PST)
In-Reply-To: <1422033203-23254-11-git-send-email-tiwai@suse.de>
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
Cc: Stefan Hajnoczi <stefanha@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Jan 23, 2015 at 11:13 AM, Takashi Iwai <tiwai@suse.de> wrote:
> If the problem still really remains, we should fix it instead of
> papering over it like this...

FWIW, the commit from the original repository was made in 2007.  So if
the bug is still there, it's an old one.

commit 1e32d598dcf290e5c131a58231c13bfd25812810
Author: fdemski <fdemski@87a33c3d-1c25-0410-a0e4-a977fe0255b3>
Date:   Mon Jul 16 23:51:55 2007 +0000

    bug found and fixed -- maybe some alsa specifics -- did not crosscheck
    substream->private_data seems not to be filled in hw_param function
