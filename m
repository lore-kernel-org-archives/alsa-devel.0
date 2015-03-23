From: Sebastian Wicki <gandro@gmx.net>
Subject: Re: [PATCH] ALSA: hda - Add dock support for Thinkpad
 T450s (17aa:5036)
Date: Mon, 23 Mar 2015 17:19:06 +0100
Message-ID: <CAKWPkRCrJSb_Abt53534YT_nbbyiEKCNA9NVCj9WAqspwrwdTg@mail.gmail.com>
References: <1427119767-5249-1-git-send-email-gandro@gmx.net>
 <s5h1tkf4sn9.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 by alsa0.perex.cz (Postfix) with ESMTP id 03060260421
 for <alsa-devel@alsa-project.org>; Mon, 23 Mar 2015 17:19:26 +0100 (CET)
Received: from mail-wg0-f45.google.com ([74.125.82.45]) by mail.gmx.com
 (mrgmx101) with ESMTPSA (Nemesis) id 0MGWR2-1YeQfe2w9g-00DKeB for
 <alsa-devel@alsa-project.org>; Mon, 23 Mar 2015 17:19:26 +0100
Received: by wgdm6 with SMTP id m6so150153623wgd.2
 for <alsa-devel@alsa-project.org>; Mon, 23 Mar 2015 09:19:26 -0700 (PDT)
In-Reply-To: <s5h1tkf4sn9.wl-tiwai@suse.de>
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

2015-03-23 16:53 GMT+01:00 Takashi Iwai <tiwai@suse.de>:
> The list is sorted by vendor/system id numbers, so could you rearrange
> the patch to insert the entry at the right place?

Oh, sorry I did not catch that, will resubmit. Btw I suspect that the other
Broadwell Thinkpads (i.e. X250) will need the same quirk. They also have the
same dock connector, but I do not have their system id numbers.
