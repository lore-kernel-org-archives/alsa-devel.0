From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: Re: [PATCH 0/7] ALSA: Fine-tuning for several function
 implementations
Date: Tue, 14 Nov 2017 12:48:40 +0100
Message-ID: <882a7baa-7c23-c60c-076f-73daa1753531@users.sourceforge.net>
References: <f2404d64-27c8-4afa-b893-fc72601c0136@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.15.3])
 by alsa0.perex.cz (Postfix) with ESMTP id 87C71266AF8
 for <alsa-devel@alsa-project.org>; Tue, 14 Nov 2017 12:48:53 +0100 (CET)
In-Reply-To: <f2404d64-27c8-4afa-b893-fc72601c0136@users.sourceforge.net>
Content-Language: en-GB
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>, Jaroslav Kysela <perex@perex.cz>, Martin Koegler <martin.koegler@chello.at>, Takashi Iwai <tiwai@suse.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

> Date: Tue, 24 Jan 2017 11:02:34 +0100
> 
> Some update suggestions were taken into account
> from static source code analysis.
> 
> Markus Elfring (7):
>   seq: Delete unnecessary checks in snd_seq_ioctl_query_subs()
>   seq: Delete unnecessary checks in snd_seq_ioctl_get_subscription()
>   seq: Delete unnecessary checks in snd_seq_ioctl_unsubscribe_port()
>   seq: Delete unnecessary checks in snd_seq_ioctl_subscribe_port()
>   seq: Adjust 16 function calls together with a variable assignment
>   dmasound_core: Move two assignments for the variable "ret" in state_open()
>   dmasound_core: Adjust six function calls together with a variable assignment
> 
>  sound/core/seq/seq_clientmgr.c     | 163 ++++++++++++++++++++-----------------
>  sound/oss/dmasound/dmasound_core.c |  33 +++++---
>  2 files changed, 109 insertions(+), 87 deletions(-)

Are these update suggestions worth for another look?
https://lkml.org/lkml/2017/1/24/292

Regards,
Markus
