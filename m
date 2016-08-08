From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 04/39] ALSA: seq: copy ioctl data from user
 space to kernel stack
Date: Mon, 8 Aug 2016 22:46:21 +0900
Message-ID: <838f45da-5503-7d26-0db5-a05edfe148c0@sakamocchi.jp>
References: <1470563355-18368-1-git-send-email-o-takashi@sakamocchi.jp>
 <1470563355-18368-5-git-send-email-o-takashi@sakamocchi.jp>
 <c647ef16-f993-6c29-b8f0-18337ea32d4d@ladisch.de>
 <57A7451B.4050102@sakamocchi.jp> <s5htwevohvk.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id 5E2EE266BFB
 for <alsa-devel@alsa-project.org>; Mon,  8 Aug 2016 15:46:28 +0200 (CEST)
In-Reply-To: <s5htwevohvk.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

On Aug 8 2016 16:10, Takashi Iwai wrote:
>> _IOC_SIZE macro pick up 13 or 14 bits (architecture-dependent) in ioctl
>> command, which represents the size of argument. In my patch, the size of
>> 'union ioctl_arg' is 188 (x86/x32) or 192 (x86_64) and there's enough
>> rest of the size field. So we can pick up the size from ioctl command by
>> the macro because the size represents the maximum bytes of argument for
>> all of sequencer ioctls.
> 
> It's not only about the size.  It contains the r/w bits, so you can
> avoid the unnecessary user-copy calls, too.

SET_QUEUE_CLIENT ioctl command is defined as 'W', while a corresponding
function writes to userspace. This is unavoidable bug.


Regards

Takashi Sakamoto
