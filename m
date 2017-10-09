From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH] opl3: Fix a possible sleep-in-atomic bug
 in snd_opl3_find_patch
Date: Mon, 9 Oct 2017 08:32:48 +0200
Message-ID: <5146a06e-0199-3d03-b4d6-9a4f71e4c4af@ladisch.de>
References: <1507516527-4173-1-git-send-email-baijiaju1990@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from webclient5.webclient5.de (webclient5.webclient5.de
 [136.243.32.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 238DF266CE2
 for <alsa-devel@alsa-project.org>; Mon,  9 Oct 2017 08:32:47 +0200 (CEST)
In-Reply-To: <1507516527-4173-1-git-send-email-baijiaju1990@163.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jia-Ju Bai <baijiaju1990@163.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.com, o-takashi@sakamocchi.jp, fabf@skynet.be, elfring@users.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Jia-Ju Bai wrote:
> The driver may sleep under a spinlock, and the function call path is:
> snd_opl3_note_on (acquire the spinlock)
>   snd_opl3_find_patch
>     kzalloc(GFP_KERNEL) --> may sleep

This call path is not possible because create_patch is not set.


Regards,
Clemens
